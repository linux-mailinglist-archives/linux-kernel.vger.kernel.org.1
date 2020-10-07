Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0830286679
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgJGSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbgJGSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p5JHnvclYDLHKHB4GAf0Q2qFX9EM0QTp+UrXTsO6WlI=;
        b=YmZW/IcHTXONliJdaXVwX0027U716fYOEuR2g1AAKY34vIMmpeNdsG4byaE6mFaWCbpjgU
        ccXxBOTiWNu/UgYxzqstkv5kOqVezyQ3+jRKHb0v1NWORZavpUQ9hr4yEY3kEAoQlbA9XJ
        yGv9p0zI9qQx4MYiPszUVAcioOvUDYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-OWTDjFJJNlG1aVzf61JSmQ-1; Wed, 07 Oct 2020 14:05:07 -0400
X-MC-Unique: OWTDjFJJNlG1aVzf61JSmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52C38027E1;
        Wed,  7 Oct 2020 18:05:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C595D9DD;
        Wed,  7 Oct 2020 18:04:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 6A339417D683; Wed,  7 Oct 2020 15:04:33 -0300 (-03)
Message-ID: <20201007180229.765691166@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 07 Oct 2020 15:01:53 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/2] nohz: change signal tick dependency to wakeup CPUs of member tasks
References: <20201007180151.623061463@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than waking up all nohz_full CPUs on the system, only wakeup 
the target CPUs of member threads of the signal.

Reduces interruptions to nohz_full CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -398,7 +398,15 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
  */
 void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
 {
-	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
+	int prev;
+
+	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
+	if (!prev) {
+		rcu_read_lock();
+		for_each_thread(sig, t)
+			tick_nohz_kick_task(t);
+		rcu_read_unlock();
+	}
 }
 
 void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bit)



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A202A1B46
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJaXjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 19:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgJaXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 19:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604187539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfjj2i+lRTULmpt4pHrhXtceCQTpoP61j9MmBbGDZM0=;
        b=LJ68B1Myl/bNyZs4Lz6R5XtA0Z5+LiSOi7QMojPJjrJ9SCAaScq+CMvFemFg4bZ+S04c9O
        QsNTRvkncLhFSMHu2jwHslkJzw3ZW8WoUnwSi89tMZqPKnAqb7+ez6gxGTm3DX4FWkVLru
        gZdoLa8Ka2OBv5MmZ3q/syAt0awaXQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-2ELeOtvoPlawpUFIiXPPRQ-1; Sat, 31 Oct 2020 19:38:54 -0400
X-MC-Unique: 2ELeOtvoPlawpUFIiXPPRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 832D01074647;
        Sat, 31 Oct 2020 23:38:53 +0000 (UTC)
Received: from ovpn-112-12.rdu2.redhat.com (ovpn-112-12.rdu2.redhat.com [10.10.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB18375121;
        Sat, 31 Oct 2020 23:38:52 +0000 (UTC)
Message-ID: <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
From:   Qian Cai <cai@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 31 Oct 2020 19:38:52 -0400
In-Reply-To: <20201031183725.GA9529@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
         <20201031183725.GA9529@osiris>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-31 at 19:37 +0100, Heiko Carstens wrote:
> On Wed, Oct 28, 2020 at 02:27:42PM -0400, Qian Cai wrote:
> > The call to rcu_cpu_starting() in smp_init_secondary() is not early
> > enough in the CPU-hotplug onlining process, which results in lockdep
> > splats as follows:
> > 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > 
> >  other info that might help us debug this:
> > 
> >  RCU used illegally from offline CPU!
> >  rcu_scheduler_active = 1, debug_locks = 1
> >  no locks held by swapper/1/0.
> > 
> >  Call Trace:
> >  show_stack+0x158/0x1f0
> >  dump_stack+0x1f2/0x238
> >  __lock_acquire+0x2640/0x4dd0
> >  lock_acquire+0x3a8/0xd08
> >  _raw_spin_lock_irqsave+0xc0/0xf0
> >  clockevents_register_device+0xa8/0x528
> >  init_cpu_timer+0x33e/0x468
> >  smp_init_secondary+0x11a/0x328
> >  smp_start_secondary+0x82/0x88
> > 
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the smp_init_secondary() function. Note that the
> > raw_smp_processor_id() is required in order to avoid calling into
> > lockdep before RCU has declared the CPU to be watched for readers.
> > 
> > Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > Signed-off-by: Qian Cai <cai@redhat.com>
> > ---
> >  arch/s390/kernel/smp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Could you provide the config you used? I'm wondering why I can't
> reproduce this even though I have lot's of debug options enabled.
https://cailca.coding.net/public/linux/mm/git/files/master/s390.config

Essentially, I believe it requires CONFIG_PROVE_RCU_LIST=y. Also, it occurs to
me that this only starts to happen after the commit mentioned in the above link.


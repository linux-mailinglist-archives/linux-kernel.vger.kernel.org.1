Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553E02D2C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgLHNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgLHNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607435198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PgDVMF6zomYKlcivF1VhzvM1BcYHrc98uBdNjH1KPmA=;
        b=ONSjP6ZiAerlYnrkCVYt2QcpmBEhwvDdga3ggkFH8Di4fPfhSaPV/AIZqt08NfLedahqxe
        k6ojsrgZXvr1USPC1kLjgM9iMUJqCbs10Z6Mt2aGY1cclFoWOeIfAZbo1pLPRgi3yvkQR7
        XLuDadPH+W2GdIALJvLro4Y8+aBz3Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-ThVQy7QoOOyTS3-OJpnwLg-1; Tue, 08 Dec 2020 08:46:35 -0500
X-MC-Unique: ThVQy7QoOOyTS3-OJpnwLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F57CC287;
        Tue,  8 Dec 2020 13:46:33 +0000 (UTC)
Received: from ovpn-114-102.rdu2.redhat.com (ovpn-114-102.rdu2.redhat.com [10.10.114.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86AAA6E519;
        Tue,  8 Dec 2020 13:46:24 +0000 (UTC)
Message-ID: <589c684a04b4e91e99b22409c614baea35dc93ad.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Tue, 08 Dec 2020 08:46:23 -0500
In-Reply-To: <jhjsg8hto03.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
         <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com>
         <jhjsg8hto03.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-07 at 19:27 +0000, Valentin Schneider wrote:
> Ok, can reproduce this on a TX2 on next-20201207. I didn't use your config,
> I oldconfig'd my distro config and only modified it to CONFIG_PREEMPT_NONE.
> Interestingly the BUG happens on CPU127 here too...

I think that number is totally random. For example, on this x86, it could happen
for CPU8 or CPU111.


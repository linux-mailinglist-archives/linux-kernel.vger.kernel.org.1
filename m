Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18DD2CC10C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgLBPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728509AbgLBPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606923423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw9C2pIBkb46imqaOeqQcBQrINKPfV8SYykjuGj6PxI=;
        b=AQol1xHLTElAiU2w1JOL0xE4u6QCV2mQ6btFYqaposb9xjot+BjVr9RvkzBEMJDNzf5G9Y
        nrkMsYTkM/19zwICOxVMiKs4QoaivZduK8+lZ+4A+KhQ0L6jhco84FTR2CSebRpnaZBhpp
        +PKUdGFCeLL45g83RMK0TAidlepbsA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-IfRnQ6GXMkmomM3kViRYzg-1; Wed, 02 Dec 2020 10:37:00 -0500
X-MC-Unique: IfRnQ6GXMkmomM3kViRYzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86947805727;
        Wed,  2 Dec 2020 15:36:59 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49CB319C47;
        Wed,  2 Dec 2020 15:36:58 +0000 (UTC)
Date:   Wed, 2 Dec 2020 16:36:56 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201202153656.GC2231584@localhost>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
 <20201202150725.GA2231584@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202150725.GA2231584@localhost>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:07:28PM +0100, Miroslav Lichvar wrote:
> On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:
> > Something like the completely untested below should make this reliable
> > and only needs to retry when the work is running late (busy machine),
> > but the wakeup will be on time or at max 1 jiffie off when high
> > resolution timers are not available or disabled.
> 
> It seems to work nicely. In my test most of the updates succeeded on
> the first attempt hitting the right tick, the rest succeeding on the
> second attempt. Only when the clock was set to run 10% faster, it
> needed few more attempts to converge to the target time.

I noticed an observable change wrt adjtimex() calls though. It seems
it now reschedules the RTC update, i.e. there can be more than one
update per 11 minutes. Was this intended?

> @@ -629,7 +618,7 @@ void ntp_notify_cmos_timer(void)
>  
>         if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
>             IS_ENABLED(CONFIG_RTC_SYSTOHC))
> -               queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
> +               queue_work(system_power_efficient_wq, &sync_work);
>  }

-- 
Miroslav Lichvar


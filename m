Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818DA2D10DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgLGMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607345275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYipuZr0KAd/BhmaUO/qQb5XFs2sYSqccrlAuXRJ48w=;
        b=fK33hkBouGZDbClF2qdS850Yu/ZugCcF/WIQUt4pgTF5qjozHuuc/UtufdwCQPX3x82hmC
        +z4x1C9L74ezVt7+eoy6Sara19mToB70CcER8POjrYKaLmXbLpJ2cs7vhUTXosGOYOBqmu
        Ee614Ptp4+Udmd0ErE4L+j8Nvx99/ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552--CPdcpaQPRy3huS1qcWC0g-1; Mon, 07 Dec 2020 07:47:53 -0500
X-MC-Unique: -CPdcpaQPRy3huS1qcWC0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C665A809DC3;
        Mon,  7 Dec 2020 12:47:51 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FBCA5D6B1;
        Mon,  7 Dec 2020 12:47:49 +0000 (UTC)
Date:   Mon, 7 Dec 2020 13:47:49 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 5/8] ntp: Make the RTC synchronization more reliable
Message-ID: <20201207124749.GH2352378@localhost>
References: <20201206214613.444124194@linutronix.de>
 <20201206220542.062910520@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206220542.062910520@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:46:18PM +0100, Thomas Gleixner wrote:
> Switch it to an hrtimer instead which schedules the actual update work. The
> hrtimer will expire precisely (max 1 jiffie delay when high resolution
> timers are not available). The actual scheduling delay of the work is the
> same as before.

It works well in my tests.

> This becomes now:
> 
>      if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
>      	queue_work(system_power_efficient_wq, &sync_work, 0);
> 
> which is racy when the hrtimer has expired and the work is currently
> executed and has not yet managed to rearm the hrtimer.
> 
> Not a big problem as it just schedules work for nothing.

No more unexpected updates of the RTC observed.

Tested-by: Miroslav Lichvar <mlichvar@redhat.com>

Thanks,

-- 
Miroslav Lichvar


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69022A416C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKCKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:15:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:60068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgKCKPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:15:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604398517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=gxl6UrgUka1LZn4LDJZ1QkMxr+7IymDRgsTPhk9KCpI=;
        b=RqyOPtG4XInzVOUVFzRB9rYeH3W811AgkRMHbhzpOqmNQin+m+1J7SY1mwScla2INQGUKF
        KXrtJLfXVAG8SZpxXVoNeD4CLQ11HZeV2Rmiv2aSpqH4d+8gvPjk5qH6dg11ZTzZy/z0xf
        mxVE/AApY2HSVeHSab/nWf3gQspDn6c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18532ABCC;
        Tue,  3 Nov 2020 10:15:17 +0000 (UTC)
Date:   Tue, 3 Nov 2020 11:15:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Santosh Sivaraj <santosh@fossix.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        bala24@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] kernel/watchdog: Fix watchdog_allowed_mask not
 used warning
Message-ID: <20201103101516.GM20201@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <214be993-96ec-82b0-b841-c80f7e7faefb@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-03 10:55:11, Christophe Leroy wrote:
> 
> 
> Le 03/11/2020 à 10:32, Santosh Sivaraj a écrit :
> > Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.
> > 
> > Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> 
> I think maybe you should add a Fixes: tag (Towards https://github.com/linuxppc/linux/commit/7feeb9cd ?)
> 
> And copy Thomas (tglx)

And also Andrew that usually take patches in this area.

Finally, you should add my Reviewed-by that I provided for the first
resend. Sigh, I have missed that the important people were not in CC.

Best Regards,
Petr

> Christophe
> 
> > ---
> > 
> > Original patch is here:
> > https://lore.kernel.org/lkml/20190807014417.9418-1-santosh@fossix.org/
> > 
> > A similar patch was also sent by Balamuruhan and reviewed by Petr.
> > https://lkml.org/lkml/2020/8/20/1030
> > 
> >   kernel/watchdog.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 5abb5b22ad13..71109065bd8e 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -44,8 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
> >   int __read_mostly watchdog_thresh = 10;
> >   static int __read_mostly nmi_watchdog_available;
> > -static struct cpumask watchdog_allowed_mask __read_mostly;
> > -
> >   struct cpumask watchdog_cpumask __read_mostly;
> >   unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
> > @@ -162,6 +160,8 @@ static void lockup_detector_update_enable(void)
> >   int __read_mostly sysctl_softlockup_all_cpu_backtrace;
> >   #endif
> > +static struct cpumask watchdog_allowed_mask __read_mostly;
> > +
> >   /* Global variables, exported for sysctl */
> >   unsigned int __read_mostly softlockup_panic =
> >   			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
> > 

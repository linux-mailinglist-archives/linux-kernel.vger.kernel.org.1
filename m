Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B902AED63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKKJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgKKJWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:22:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605086565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a27vum1VtFbYiFmccOKY6XawNUF/koRf7itth8cSa18=;
        b=RgwYhPqOrnIY83TzE0rZF7B6NszJ6Q6gHFWDpXf0R95d3GwgNpgeopPOGx0M0iiNPZsw3M
        5uL1eSo4rITfu+a40DVJV2h8APpiMQRci9SPpFb9ISPFrKZehZtCfXDnlFoHjdRsaz3iZR
        b3H+aQ3ZlUM5H8OhR3kYw6Y71P2Msdo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31176B141;
        Wed, 11 Nov 2020 09:22:45 +0000 (UTC)
Date:   Wed, 11 Nov 2020 10:22:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3] reboot: allow to specify reboot mode via sysfs
Message-ID: <20201111092239.GF20201@alley>
References: <20201109164538.18934-1-mcroce@linux.microsoft.com>
 <20201110145834.GE20201@alley>
 <CAFnufp3xfBCwodEmD-sSM7sRWdEv3iDbyBcjYKP_tL70yc+gtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp3xfBCwodEmD-sSM7sRWdEv3iDbyBcjYKP_tL70yc+gtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-10 18:36:05, Matteo Croce wrote:
> On Tue, Nov 10, 2020 at 3:58 PM Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2020-11-09 17:45:38, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > > +What:                /sys/kernel/reboot/force
> > > +Date:                November 2020
> > > +KernelVersion:       5.11
> > > +Contact:     Matteo Croce <mcroce@microsoft.com>
> > > +Description: Force an immediate reboot.
> >
> > This makes me feel like that the kernel will reboot
> > immediately when you write "1". It would deserve a better
> > explanation that would make it clear, something like:
> >
> > Description:    Use forced reboot that does not contact the init system.
> >
> 
> Description: Don't wait for any other CPUs on reboot and avoid
> anything that could hang.

Sound good to me. I see that Andrew already queued the updated patch
with my Reviewed-by so all is OK.

Best Regards,
Petr

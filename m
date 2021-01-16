Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC082F8D41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbhAPMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:11:54 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40595 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:11:54 -0500
Received: by mail-wm1-f53.google.com with SMTP id r4so9814009wmh.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7H0fvmXiskQPeDj6HjFg//R8x/xZr5JEnTtaCWu2i8=;
        b=HuzJ0ZrwjUNFLJsELZ6D80Clqi4HkCnDwbYpej+kXFpEvWX1Ktv+igRfpxYE1wawh2
         UdO7SjAox/RKclpnG48qOP3LmXjPt+nYojjLzlJgeQezOnQR1RyVrigNPLU4rbLu2t2d
         33awUsgYSHL0mL45+Jg2YL+EZlvyfADiFQyx0n0Jw2tra+LcKDs/rvVruNAbR918/6hr
         Or6ioRE55bm2ur6JyarKfC5zvxAEZaSLfgdVnE0MfgZmsMRLBGyzlzp2FAc8wx99DuUI
         0nHMr3fJY4ayHlSXzGLab7aC4Hn4DjbfefQhJEYbEbWrOYalhBsp6rsbDWUprQKwMAs3
         PaHA==
X-Gm-Message-State: AOAM531aO4TMgxdkbdc83E11yBTIupyMr5mb34bdaICsOz0b5QRl4pgG
        FPSgauW3FdGET/i/IUJvXzQ=
X-Google-Smtp-Source: ABdhPJwC7xKVq3pQPUqh4JzOG+b8tGtayQhqhSvpnzhdVTWU/u2IYU5KxbLXNEjiUFYwZ2gwpsgKDQ==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr8808979wmq.93.1610799071437;
        Sat, 16 Jan 2021 04:11:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g194sm15934714wme.39.2021.01.16.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 04:11:11 -0800 (PST)
Date:   Sat, 16 Jan 2021 12:11:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        tyhicks@linux.microsoft.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] fTPM: make sure TEE is initialized before fTPM
Message-ID: <20210116121109.xenpxbobni4glecg@liuwe-devbox-debian-v2>
References: <20210116001301.16861-1-wei.liu@kernel.org>
 <b9d69278-9f69-041f-9cef-58584eac435c@infradead.org>
 <20210116115529.oq2k2qpgyawngcqn@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116115529.oq2k2qpgyawngcqn@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 11:55:29AM +0000, Wei Liu wrote:
> On Fri, Jan 15, 2021 at 04:49:57PM -0800, Randy Dunlap wrote:
> > Hi,
> > 
> > On 1/15/21 4:12 PM, Wei Liu wrote:
> > > For built-in drivers, the order of initialization function invocation is
> > > determined by their link order.
> > > 
> > > The original code linked TPM drivers before TEE driver when they were
> > > both built in. That caused fTPM's initialization to be deferred to a
> > > worker thread instead of running on PID 1.
> > > 
> > > That is problematic because IMA's initialization routine, which runs on
> > > PID 1 as a late initcall, needs to have access to the default TPM
> > > instance. If fTPM's initialization is deferred, IMA will not be able to
> > > get hold of a TPM instance in time.
> > > 
> > > Fix this by modifying Makefile to make sure TEE is initialized before
> > > fTPM when they are both built in.
> > > 
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > >  drivers/Makefile | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > index fd11b9ac4cc3..45ea5ec9d0fd 100644
> > > --- a/drivers/Makefile
> > > +++ b/drivers/Makefile
> > > @@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
> > >  obj-$(CONFIG_FPGA)		+= fpga/
> > >  obj-$(CONFIG_FSI)		+= fsi/
> > >  obj-$(CONFIG_TEE)		+= tee/
> > > +
> > > +# TPM drivers must come after TEE, otherwise fTPM initialization will be
> > > +# deferred, which causes IMA to not get a TPM device in time
> > > +obj-$(CONFIG_TCG_TPM)		+= char/tpm/
> > > +
> > >  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> > >  obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
> > >  obj-$(CONFIG_SIOX)		+= siox/
> > > 
> > 
> > As I suspected and then tested, since you did not remove the other build
> > of char/tpm/, this ends up with multiple definition linker errors (below).
> 
> Oops, I didn't commit the hunk that removed the line in char/Makefile.
> 
> But I will hold off sending out v2 until the following discussion is
> settled.
> 
> > 
> > I would think that instead of depending on Makefile order you should use different
> > initcall levels as needed. Depending on Makefile order is what we did 15 years ago.
> > 
> 
> No, not really. The same trick was used in 2014 (1bacc894c227).
> 
> Both TEE and TPM are just drivers. I think they belong to the same level
> (at the moment device_initcall).  Looking at the list of levels, I'm not
> sure how I can move TEE to a different level.
> 
> Out of the seven levels, which one would you suggest I use for which
> driver?

A bit more random thought.

Moving one driver to a different level is not the solution either. What
if there is a dependency chain in the future in which more than 2
drivers are involved? Do we invent more levels or abuse levels that
aren't supposed to be used by device drivers?

The proper solution to me is to somehow sort the initcalls with their
dependencies in mind. The requires quite a bit of engineering
(integrating depmod into kernel build?). Given that there are only a few
cases, I don't think effort would be worth it.

Wei.

> 
> Wei.

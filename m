Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C853B2CCA3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgLBXDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLBXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:03:46 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A4C061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:03:05 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i199so436447qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ePhzjfdwG9pWLhP9yjM1Ii8dmnBB9jfsh6D13e1UvSw=;
        b=dY2766SK5U3b70YHyiO3eGIt04TiP5vo3QE54q8MG8ELXk4zHIJ+MUexrXzMmCp8GG
         Ql+D5P1prpm+xNFbpVaxnCGsuFalkuAJc3MGVVm/fPRlahOWvGmgnyOHRyKVoRyjc1uf
         Y8O4mJru/2xWl5bd9+tIdGrZ1kdrD4oVPU1Vo/98U4TscWcfSbSDDplUfrowB1ReuYHf
         X0HG0izxRA2kRXA7Xztgj9oDM8rK2Tnz93xtgx0n+ROIU6HUeaH4IqtpSvS7L8ylNQlx
         7U1pP94VsIoa7Q4E1Ey+wh2Mv5jgimkjtmH7KUNUgadxxl8zNxfD+LdPq+l2fqqFTU6k
         RfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ePhzjfdwG9pWLhP9yjM1Ii8dmnBB9jfsh6D13e1UvSw=;
        b=JXXJMMcHmzMyEKl7I5nPJtF8f3uPmFP2Gewi7m/WYbkGKf5LNCeAlh+dQJRVa1Bubb
         teXDWGklzNr/9GoEUoatPsRf2YIwZjr2gJ38KJmpF8A1MrJepwZUkOer7gn9bX+/lbdM
         ULmeCL2UsHkbir2IzSH/61rtvPU0rBQ4OwXTj8Q410bLRdikV3HThFFnKzsiRArMnMm+
         O6LMsYLh7NcNpbtzV0p7e/QtW9i5BbHelEALzXOPv9IoTktky7OcBclPPtBfBxgUWAWE
         BObepE8oel2RapqMSgf5JCrueaxtgBUcrbeXS5J0bobdaZfo8ZoaaIgJ57k3Io/SPkfL
         NLHQ==
X-Gm-Message-State: AOAM531K+eah4mudmA/1b3P5RWNGH7FKYqh3lWgAhz9szU8kvpAmCWDB
        scDALi49n2qs0iLwHtk5TFwxIQ==
X-Google-Smtp-Source: ABdhPJwn/GLTJSYYVqZiOENv4Nommzo/Qe/sEMGUJ9a2itIE4/Ss9mPsR6NWV8M4g8RTmXJ/YDkrMQ==
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr57633qkg.421.1606950185031;
        Wed, 02 Dec 2020 15:03:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o125sm116809qke.56.2020.12.02.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:03:04 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkb9L-005Eim-A9; Wed, 02 Dec 2020 19:03:03 -0400
Date:   Wed, 2 Dec 2020 19:03:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201202230303.GO5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
 <20201202162723.GJ5487@ziepe.ca>
 <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
 <20201202205418.GN5487@ziepe.ca>
 <874kl3eu8p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kl3eu8p.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:08:38PM +0100, Thomas Gleixner wrote:
> >
> > arch/x86/kernel/kvmclock.c:     x86_platform.set_wallclock = kvm_set_wallclock;
> > arch/x86/kernel/x86_init.c:             x86_platform.set_wallclock = set_rtc_noop;
> > arch/x86/xen/time.c:            x86_platform.set_wallclock = xen_set_wallclock;
> > arch/x86/xen/time.c:    x86_platform.set_wallclock = xen_set_wallclock;
> >   All returns -ENODEV/EINVAL
> 
> You forgot to stare at the .get_wallclock() functions. That's the more
> interesting part, i.e. what's behind read_persistent_clock64().

Small steps! I was only looking at deleting the legacy
CONFIG_GENERIC_CMOS_UPDATE from x86 which only controls the
update_persistent_clock64()

Yes, there is a similar redundancy with rtclib on the
read_persistant_clock side, and that does looks much further..

> > arch/x86/kernel/x86_init.c:     .set_wallclock                  = mach_set_rtc_mmss,
> >   This is already rtclib under drivers/rtc/rtc-mc146818-lib.c
> 
> That's the shared library function for setting the darn thing.

Yes, but if a PNP entry is present then rtc-cmos will load and call
that function through the rtclib path instead of the
update_persistent_clock64() path

Jason

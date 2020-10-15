Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5228EE21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgJOIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgJOIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:03:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77914C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:03:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e23so2150131wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JeD/PZuPdhoZksxwF3qbmvZCPoyUNVOL4ytJnfR+4ro=;
        b=eIbVuymXgFgySc13nrj17X/fdRbvmyAr4Iz8LSq11GY8WciSPDqJe9t0H0BHtGcB0N
         jCMjloEA26av6VVHoB0/2rbb7H/hLjaaC1RKetux1x3N7WjJrcGVmIY4BtIB6BcxoD+n
         +PutmbSdslXDr/Z2QKbWa71X+KRxs5Zt/+uRbEVLeJEv3EsTYVuOBwLkEdVSbehpCngc
         K7SZPT8NvEsUntjAxjr6ifN/VEcEcnq9AF8ZXSwOTyiwJBqnrTr67zBVS/wCBJfFUPT3
         N82N3aTXi6L/sDB4l0XMt3vju/+yxVNPQCbSX1QYnNketZaHkI6pa40V/P1VD2GAIivQ
         QErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeD/PZuPdhoZksxwF3qbmvZCPoyUNVOL4ytJnfR+4ro=;
        b=Gxq7qcPAcbGvNRjW+Lbp8ok604S/wnMQDirhGtlo4Y0+r2d3cXYPJqwHLjm4UGTBnv
         sipBRXSAHm/h57LL4feT6gBbB7cpHyedr7M/5v+kHiXaoFGeYvPXvVC1jxr57xLkbUts
         bfFMDC8xIrEbK24XlB30b/3XqMfsT9JYCyHEZ6G3Ewj4N587tkIj6ZpcOKEITNInt+fG
         BdtMKRB5JQrnHcKj3ZcpLjgQGzaoYzPUtn3YhkTN+7oQZ9WOcFilrLHVGdm9hKj9wi9V
         TNQ7ETwGUyWJmToNFYDLiud7VhsfrwmkqejjY2czbDWG+Og5e/68sAjNAaJeCsRIbQEO
         lYXg==
X-Gm-Message-State: AOAM5322VMMjVUl607/hRQ6uNgjxDC5vT7sERrMBWadgbGUpF5Sl7xKW
        6qGoBMmj/Iw6c3OzqYYq+6I=
X-Google-Smtp-Source: ABdhPJwp4WCvWTTlehWKhL1Zd3WDtb+BWHK5gCqttJo/4+iNRsr527oj4dM4QNpO83e8Q0wzS7rduw==
X-Received: by 2002:a1c:6488:: with SMTP id y130mr2611854wmb.94.1602748983223;
        Thu, 15 Oct 2020 01:03:03 -0700 (PDT)
Received: from alley (176-114-240-43.rychlydrat.cz. [176.114.240.43])
        by smtp.gmail.com with ESMTPSA id 67sm3232231wmb.31.2020.10.15.01.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 01:03:02 -0700 (PDT)
From:   Petr Mladek <mladek.petr@gmail.com>
X-Google-Original-From: Petr Mladek <pmladek@suse.com>
Date:   Thu, 15 Oct 2020 10:03:00 +0200
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
Message-ID: <20201015080300.GE13775@alley>
References: <20201012144916.GB10602@alley>
 <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
 <49292e1a-7e46-b078-d15d-fb2f406317db@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49292e1a-7e46-b078-d15d-fb2f406317db@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-10-14 16:58:27, Rasmus Villemoes wrote:
> On 14/10/2020 16.16, Geert Uytterhoeven wrote:
> > Hi Petr,
> > 
> > On Mon, Oct 12, 2020 at 4:50 PM Petr Mladek <pmladek@suse.com> wrote:
> >> - Fully lockless ringbuffer implementation, including the support for
> >>   continuous lines. It will allow to store and read messages in any
> >>   situation wihtout the risk of deadlocks and without the need
> >>   of temporary per-CPU buffers.
> > 
> >     linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old
> > vmlinux.lockless_ringbuffer
> >     add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
> >     Function                                     old     new   delta
> >     _printk_rb_static_infos                        -  180224 +180224
> >     _printk_rb_static_descs                        -   24576  +24576
> >     [...]
> > 
> > Seriously?!? Or am I being misled by the tools?
> > 
> >     linux-m68k-atari_defconfig$ size vmlinux.old vmlinux.lockless_ringbuffer
> >        text    data     bss     dec     hex filename
> >     3559108 941716 177772 4678596 4763c4 vmlinux.old
> >     3563922 1152496 175276 4891694 4aa42e vmlinux.lockless_ringbuffer
> > 
> > Apparently not...
> 
> Hm, that's quite a lot. And the only reason the buffers don't live
> entirely in .bss is because a few of their entries have non-zero
> initializers.
> 
> Perhaps one could add a .init.text.initialize_static_data section of
> function pointers, with the _DEFINE_PRINTKRB macro growing something like
> 
> static void __init __initialize_printkrb_##name(void) { \
>   _##name##_descs[_DESCS_COUNT(descbits) - 1] = ...; \
>   _##name##_infos[0] = ...; \
>   _##name##_infos[_DESCS_COUNT(descbits) - 1] = ...; \
> } \
> static_data_initializer(__initialize_printkrb_##name);
> 
> with static_data_initalizer being the obvious yoga for putting a
> function pointer in the .init.text.initialize_static_data section. Then
> very early in start_kernel(), probably first thing, iterate that section
> and call all the functions. But maybe that's not even early enough?

A solution might be to initialize the buffer during the first
printk() call. We could make sure that it is done in
setup_log_buf() at latest. It is called when only one CPU is
running so it should be safe. The only problem might be NMI.

Best Regards,
Petr

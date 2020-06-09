Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C131F3FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgFIP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:58:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F0C05BD1E;
        Tue,  9 Jun 2020 08:58:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p5so20812189ile.6;
        Tue, 09 Jun 2020 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTmR8DDTbpuRLrg4Dxe54sTFIEfxL4/fHVrG5Q0Qecc=;
        b=AB6ptOdnB5z9Lot4ciWyiYuE6HGmWmbIwdMI2v9p37RW9vIGnX/vnPMfTcceN8kysj
         UeJRlrLlFtiLLa7ZUCBXFTB2if6niO5aciWexn6lLt74ARj+tvU7J0a6CMOm0N9Old5M
         0nNC/R75byfQkSBdHR0mO6oZN/MWIenirMnIZZZhA0Ku37cS/9VNeowWKVBSEFX/O7L1
         rUIuP1MX3QyEoJOP33FebN6F3wNj4C1hyz+NirfswshNJwyJG8B2m/ifCXWECX8DJl/1
         HOPF2UlCgfmOR8x4cXZOO6fbDlugUqovL3TaiN7r6LMrsSBhN4WbBcqbXTE3gf6CvMbn
         /WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTmR8DDTbpuRLrg4Dxe54sTFIEfxL4/fHVrG5Q0Qecc=;
        b=B4kVUhDIEajpOOOWeLHWi92vT5hwS0L1+Qm4GcukHi/jRJd8udJw5D/F5hZCMFqYhW
         /wjbDZvcK7/ahbPX0mLDlWCNu4Msq5RIy17rP92Iv7GU0A54UU6AqQqJ3iV0Ka3Ljf0X
         yEnzuOKTvSUPAGbXIjK9GNb0RMggkV7Z1/x3PHk4c6ZfMA5bz16XAMpL6QSwMokZHO24
         nUSYJyuzmzExcspuwucVGIaeZ+w2XBbtGy8oeXYVbJBTD2AZ2EMge9Zg68gQVGC/BOqQ
         RnL++o0quXYf21szb+AkKdu7ZaaXoIU7u69L8kPeMUye1kM9aAvsg84rFVbRil3n+qB7
         xaFQ==
X-Gm-Message-State: AOAM533OzL8eqMEPa1P4S/X+s7ZHGqm0HUYlcne5l5lfrd9+6HF64H4v
        vq8IlDhZ3PLtOu1DSzqVzm4ebjWsjaiuV0cWFhg=
X-Google-Smtp-Source: ABdhPJxux6g3vaB/cZUTBdsI/fsNLkF6h3A6gvPaXzdAi095druL3kMv7nH5YKpHBp3ajTNuv4JMpDOTRu2EDD2z9o8=
X-Received: by 2002:a92:ad02:: with SMTP id w2mr18619302ilh.184.1591718321670;
 Tue, 09 Jun 2020 08:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 9 Jun 2020 23:58:05 +0800
Message-ID: <CAL9mu0+hmyYGrTeHhvOhPHLm3nSWTt5waAr9e6Lzrdqxp5x5iQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use 'arm_nommu_dma_ops' to handle dma memroy if
 device offer consistent dma memory region
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de, hch@lst.de
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

This is the patchset. for your reference.

thanks,

On Mon, Jun 8, 2020 at 4:30 PM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
> when do mmap on /dev/fb0, we will get -6 error on cortex-m3/m4 or armv7m
> platform without cache support, this is caused by following reason:
>
> on armv7m platform, if no cache support, we will use dma direct mapping,
> but, this is not support on !MMU hardware, just return '-ENXIO' error
>
> so, add use_reserved_mem() for these armv7m hardware but no-cache support.
> eg, stm32f429/stm32f469.
>
> verified on stm32f469-disco board, mmap frambuffer to userspace.
>
> dillon min (2):
>   ARM: dts: stm32: Setup 4M bytes reserved memory for mmap
>   arm-nommu: Add use_reserved_mem() to check if device support reserved
>     memory
>
>  arch/arm/boot/dts/stm32f469-disco.dts | 14 ++++++++++++++
>  arch/arm/mm/dma-mapping-nommu.c       | 28 +++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>

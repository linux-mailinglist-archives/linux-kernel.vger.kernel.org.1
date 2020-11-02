Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300412A28C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgKBLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:09:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C2C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:09:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x7so14104394wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VNKBzuaah0h5Gb4hoIVZS3da51nQlrhYLCe3rboP11A=;
        b=SFTaJqUZtfkkrRI+Q9PY7VNO+a17R1kSjOtcGWcaK+CHErqUB/F2Sa3e/th8FMVcft
         TmgOCOTjq94XbgaUawLyPonyp5k6zXmfsTXV2c5U2H+oduVvMBHQfZoavcR4nCSVOAxY
         e9miCE9Iipq2MYWzeP+MDbIykjcYJY+WAAjOiKwHs2xr6UcrxbOO0I4ouSqA68j46mYC
         azb5mdF9wHULmZ2Cz6u54K2cSvx11STFdyPcDl9bInHXHq70Q98O+NKEk1Fq5YRZnsyK
         jacisaqaE9vTEUxs00HqwMo7MjuVoK8RkPC2yy5gcPU41D7lRiAA0z6d6utzoX9PXCjd
         w/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VNKBzuaah0h5Gb4hoIVZS3da51nQlrhYLCe3rboP11A=;
        b=IirRacX0UQcMjKfy87RSgE0fICBHO6GV1fQzKnTj6bpIN43bZR6eQpdoXmi5i0y1uq
         Yxkjj1ONiEYHF2rsiKsq998OMU10bOyPG/cXXlbVjUd8Q3f6vCKcgKFC6U0J488ACZdS
         qxtv88S1J4HDpNCauRujJDgem69ROjH5JmZFXR3rTk6mR359VnkDraQErFph6luOyCHN
         fViCW/QsYdDaRycSvV7reFvwsLJx2C7TOh8+MnIDB1++KR9HHpG8KkelIIb/pYzgv2GW
         iUtbKAbHwimatYiOD0vStdA8tSdLCtoQKOZUzVNLQjgOYhfYA5tYPGNkMuqOHbIW5V4m
         njPg==
X-Gm-Message-State: AOAM531kDmG4gbFsiSmbcluI2MZM1TdIWzuOlF00REI29G2zefb4/2X2
        N1KAaIrsmv+/nWeGuIXPDKIRMg==
X-Google-Smtp-Source: ABdhPJxNCPU3ugtaw5SbDq9bRqIQsbfrQpZvvzXXHChVJFEpTyYgy/+pQ1unhh72pfJOI5cuZzTiTw==
X-Received: by 2002:adf:df91:: with SMTP id z17mr18923542wrl.379.1604315359142;
        Mon, 02 Nov 2020 03:09:19 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id y185sm14706772wmb.29.2020.11.02.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:09:18 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:09:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] Fonts: font_acorn_8x8: Replace discarded const
 qualifier
Message-ID: <20201102110916.GK4127@dell>
References: <20201030181822.570402-1-lee.jones@linaro.org>
 <CAKMK7uFN31B0WNoY5P0hizLCVxVkaFkcYjhgYVo1c2W+1d7jxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uFN31B0WNoY5P0hizLCVxVkaFkcYjhgYVo1c2W+1d7jxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Daniel Vetter wrote:

> On Fri, Oct 30, 2020 at 7:18 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Commit 09e5b3fd5672 ("Fonts: Support FONT_EXTRA_WORDS macros for
> > built-in fonts") introduced the following error when building
> > rpc_defconfig (only this build appears to be affected):
> >
> >  `acorndata_8x8' referenced in section `.text' of arch/arm/boot/compressed/ll_char_wr.o:
> >     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
> >  `acorndata_8x8' referenced in section `.data.rel.ro' of arch/arm/boot/compressed/font.o:
> >     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
> >  make[3]: *** [/scratch/linux/arch/arm/boot/compressed/Makefile:191: arch/arm/boot/compressed/vmlinux] Error 1
> >  make[2]: *** [/scratch/linux/arch/arm/boot/Makefile:61: arch/arm/boot/compressed/vmlinux] Error 2
> >  make[1]: *** [/scratch/linux/arch/arm/Makefile:317: zImage] Error 2
> >
> > The .data section is discarded at link time.  Reinstating
> > acorndata_8x8 as const ensures it is still available after linking.
> >
> > Cc: <stable@vger.kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Shouldn't we add the const to all of them, for consistency?

The thought did cross my mind.  However, I do not see any further
issues which need addressing.  Nor do I have any visibility into what
issues may be caused by doing so.  The only thing I know for sure is
that this patch fixes the compile error pertained to in the commit
message, and I'd like for this fix to be as atomic as possible, as
it's designed to be routed through the Stable/LTS trees.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

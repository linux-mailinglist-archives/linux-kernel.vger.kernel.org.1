Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557232B8D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKSIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKSIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:32:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45505C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:32:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so5549286wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l/6bVpIvOCq/GrVdlyeJSm66Y2GHJD5vt1P0y0W4pG4=;
        b=IQ8FPGf5l7RQbuG6WaahVa6AVuFn3ngdqxMvPIi6QGd3zmMxYkREuclOZScPCJisYP
         bK5z484RN41BobujVMXhDX77w5DDM10YbrHV+2Ma6rIkAo2AwKZeVZWOsK6JEe5iNebG
         LYh7wFwcNmChIS//5GRBcXwH0Vp2ZwXdcBEllP4KUy2Q0BdH6vWx+E+Zt48rDALgVSPb
         f+dqJeDy2hfRPE3PIduTLwiay8RqTVJ974NZS++mYjgPALeQOTgi1Iazm+b/0Aw9fA1B
         mssxAP2RY4q78jiNjCtfz2Df7fThTP+0oxbVJxBO6XUbgxyNWUlngrpi/xpadNNWxWwk
         sgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l/6bVpIvOCq/GrVdlyeJSm66Y2GHJD5vt1P0y0W4pG4=;
        b=hUAGVOlyj2y+IOb0RIj0RjFSeL4cv5AnLvOpMgdiqAVQmLrQB9kUfwLqRreCT4plye
         ZhSpJrK0kAOGfJsZUiejhuD+IituPaskYXoFT7XmyE68xZOrxjt0hMb7ATreWaV5izif
         rk3SEb9rNEEHefKJP1DXwFgpkcnzxc95xqiPpbK82r/NyevPQ4+E1qQdaiJsI6oo+Aah
         uE/pM7aZuAsSuRn0L1B8GwthxrCnDGMR5Y7C7NWjJFFMODMnTXCKPiPalv26UmWFz1y4
         Nixdz1ktLwUJT6Lbam5PCsyXdt379499pt1dcNBKel5XowKDvFyFmzAJIke9Ohy00w9e
         omIQ==
X-Gm-Message-State: AOAM530dJ13vg/dOkmXF3NRaJY7GLYLUusPz5PK7nlZ3BymGDE73gLo/
        yB11XQxuiVFjCzuSqgNEiFLRErhkmj3lS62k
X-Google-Smtp-Source: ABdhPJx0aYn5xPc970ccTRivsMpKH1dfpyqW+axDLPt0cOvuXhfmYYwkMnr9akMSgkktkjVepe5QMQ==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr8728367wrn.126.1605774738911;
        Thu, 19 Nov 2020 00:32:18 -0800 (PST)
Received: from dell ([91.110.221.241])
        by smtp.gmail.com with ESMTPSA id f17sm8224995wmh.10.2020.11.19.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:32:18 -0800 (PST)
Date:   Thu, 19 Nov 2020 08:32:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
Message-ID: <20201119083213.GV1869941@dell>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
 <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
 <20201117123741.GH1869941@dell>
 <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
 <20201117160501.GJ1869941@dell>
 <CAK8P3a3mPQzDr3gzdKAoWKLVKDzysfTvJuFNKR7FM7NWLZ0dDg@mail.gmail.com>
 <42e50578-c122-e23b-f21f-c4723d008333@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42e50578-c122-e23b-f21f-c4723d008333@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020, Matthias Brugger wrote:

> 
> 
> On 17/11/2020 17:40, Arnd Bergmann wrote:
> > On Tue, Nov 17, 2020 at 5:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 17 Nov 2020, Matthias Brugger wrote:
> > > > On 17/11/2020 13:37, Lee Jones wrote:
> > > > > On Tue, 17 Nov 2020, Matthias Brugger wrote:
> > > > 
> > > > If you want to go the route for me rebasing my tree on top of for-mfd-next
> > > > then I'd like to have at least a stable tag, so that it will be easier to
> > > > provide the pull-request later on. Would that be a compromise?
> > > 
> > > I don't usually provide immutable branches/tags unless I'm sharing
> > > topic branches for other maintainers to pick-up, in order to avoid
> > > merge conflicts.
> > 
> > I think that's what Matthias is planning to do though. If he wants
> > to send me a Mediatek specific branch for the soc tree, it needs to
> > be based on a stable commit in the mtd tree to avoid duplicating
> > the commit.
> > 
> 
> Exactly, I'm the maintainer of MediaTek SoCs and I would need to pull this
> patch into my tree to be able to accept the series I mentioned [1]. Can you
> provide me a stable tag/branch, against just that patch or against your
> whole tree?

Oh, I see.  I thought you wanted to develop on top of it.  Apologies.

PR to follow (I'll reply directly to the patch).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

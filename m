Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB327AA89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1JTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1JTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:19:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:19:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so311598wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1haW60taygJ6jTLVcJ5r9wm6QQcrinGVZPwdmvPaa1A=;
        b=ncvVmU2gut7REtqBxaqawSMFv94Pq8q0IM9HfGPly8dL2fOPPXFimDxdIuCkjv7wew
         5DWa/gOauJ2hUAowvgSv233iiderzIKXPhZGu9Ckmo+dZt3Su9qj6tm/dYTFgjS49fIn
         8xn/nHb6iEqJKyAXPCewvxS5hBE6yr+GBpb56hk8a5McLIiwOML0zMvTWQQvDRMFUlPz
         BbPiLcT2wTKVWkDJKsU3DPGb3DwanZCKjZIdno6BNWyhazNLt6exjITHce2j6mR9mCeJ
         uyt7CIBg1NH1iSCgnH+3W660aICaiB4yka315eDWWl0STMqjd//fvOZ/oBq4oPfawl07
         y2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1haW60taygJ6jTLVcJ5r9wm6QQcrinGVZPwdmvPaa1A=;
        b=YSVBGVEDRE3I4PXKlsUHvLp6xWAIQ1ZwdGG7lmQ5fUxq157hVxswNi8nNT/W6H9dhS
         yOVMi4cy0HHflQ+cX6Wp9nNWyyZHeZD9u8w87tjC65OkxAEHN7vuIi2fVv5ModuD4QZ8
         NZC6mLhnF7PRd5dC6i8NqKYNinSt39PWNhfeCeB9WVhMRpjQ5GiYkllvVdWViOPUINnE
         G4QH2veeX4ayTXpxlo9EvjsJCXR92h+habnOvw6wOlitI5YoshfvSMMVY6ocM/RY4TwN
         yEHP/nN6WqShucS4d34yWGJAH/Qy8iJWKYGpWPl14tAkcUcTqcLISgcPGaCZErkTbD1h
         pwpw==
X-Gm-Message-State: AOAM533rMdfqgEj/OBGwxnrJViOauX3NRqw0mdglf48z9E2qba4khLm3
        818OrsgK+p2qG/gQwhqXrV2wt9gTKflazw==
X-Google-Smtp-Source: ABdhPJwb8v1oiZEjkqhSH2uf990iNNE+K9XSifXRtCgEF2CZB/Hl35fDAw2za6CoH4eiFVsUieNVrg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr567744wma.141.1601284792209;
        Mon, 28 Sep 2020 02:19:52 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id v4sm378805wml.46.2020.09.28.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:19:51 -0700 (PDT)
Date:   Mon, 28 Sep 2020 10:19:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com
Subject: Re: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
Message-ID: <20200928091949.GC4637@dell>
References: <20200903160237.932818-1-maz@kernel.org>
 <20200924123936.GJ4678@dell>
 <04fac15b-8866-efe4-1047-b20713f5200f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04fac15b-8866-efe4-1047-b20713f5200f@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020, Suman Anna wrote:

> On 9/24/20 7:39 AM, Lee Jones wrote:
> > On Thu, 03 Sep 2020, Marc Zyngier wrote:
> > 
> >> The name allocated for the regmap_config structure is freed
> >> pretty early, right after the registration of the MMIO region.
> >>
> >> Unfortunately, that doesn't follow the life cycle that debugfs
> >> expects, as it can access the name field long after the free
> >> has occured.
> >>
> >> Move the free on the error path, and keep it forever otherwise.
> >>
> >> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> ---
> >>  drivers/mfd/syscon.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Fixed the spelling mistake and applied, thanks.
> > 
> 
> Marc,
> Can you recheck the behavior once on the latest master to see if this patch is
> still needed? I see a new patch within the regmap core that is dealing with the
> delayed debugfs registration name. This follows the similar design logic I
> suggested on your initial submission [1].
> 
> Please see commit 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string
> for debugfs init delays") in mainline.
> 
> Lee,
> I haven't seen this patch in -next yet, so maybe worthwhile to hold it a little
> longer.

It's already applied.

If the lines become superfluous please submit a subsequent patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

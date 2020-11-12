Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639352B0655
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgKLNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgKLNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:22:29 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34732C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:22:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so5987718wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e7pBgBavWmbh88zcXl/zlYhiEN/3DVez/GFf+X/Rer4=;
        b=IrAl/NxVVTV1qdet4SUrnEtA0m3lNbiKHYEeuFpfH4n3CWgwZOQCFLriH0Mw+vEUjz
         l1l8iPqimV2fV5XFyGIUCgrllfodI3RC/eWT8ykCEnPGN2cSRxqhujLBwo2xZhxi1WF3
         dzl2R/Z97LcvPNTqz1J/BajwPJ0eAOYLPI+CMP6iCv8iZT7IE+F8L3Fo2pOaMd3zLA8C
         tDQmxvDqekI20g1Q92mmcCZZC5tNVLE9ME2yhnYmii7/bE9DLouMp8ngVX3u8bUPDhGb
         OBJhq+aZuaOQWGCEAd90iHJV8Vu3MjxoI7m2SghJ4afdnbFqhRPzbS7xGC/jl+zTee7D
         kbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e7pBgBavWmbh88zcXl/zlYhiEN/3DVez/GFf+X/Rer4=;
        b=B/LaccpCk6ZsXmkeQEsrQSh0JflwtptOsFf9Sl1djbum1MnW4spvzRAmODHrtLWD08
         BbYfeG5j1ByQgBNwTkb825a0ymSWDhYv6/lyXDmHfCVnj8XltdDQOep3z6j1ySMbC5T7
         QDGTtAYuQLsXUPVvapjXCs3enozMRmxsIVDCWuTMfKrvxV01Yzolj+neuvgCJ4j68e6o
         Dw2eYY9aelxMznnBSrKWopgsBcx8QdOD6OvSd4xMjQAreKHkiFvagBkB6f9GuZfsVAY9
         D6R6HVk4M3cxR1U1b8A6neWiOfyuvbWPxd3Gq9RnU5nWTqP6kLjzS6ixw10U0mDH3gh3
         iNbQ==
X-Gm-Message-State: AOAM531R6OiYRmu1+hvTn1YVa/G5Efq4qb/eMdivJQrP2ur4McPDqbzp
        nPkK7a4sv5ZIQQen/0ivzIqbYA==
X-Google-Smtp-Source: ABdhPJwkg72DshracLWbmJBfGLTYAfMiRyOd6R2eNdOb6G5GA4JF8KLUpn154NbisRXDlMYBfEID8A==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr33030337wrb.132.1605187346974;
        Thu, 12 Nov 2020 05:22:26 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t17sm6440829wmi.3.2020.11.12.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:22:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:22:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 05/25] soc: rockchip: io-domain: Remove incorrect and
 incomplete comment header
Message-ID: <20201112132224.GJ1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-6-lee.jones@linaro.org>
 <20201112103344.GF1997862@dell>
 <40131312.rmDrfLbc3i@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40131312.rmDrfLbc3i@diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Heiko Stübner wrote:

> Am Donnerstag, 12. November 2020, 11:33:44 CET schrieb Lee Jones:
> > On Tue, 03 Nov 2020, Lee Jones wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> > > 
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: linux-rockchip@lists.infradead.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/soc/rockchip/io-domain.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > > index eece97f97ef8f..d13d2d497720b 100644
> > > --- a/drivers/soc/rockchip/io-domain.c
> > > +++ b/drivers/soc/rockchip/io-domain.c
> > > @@ -53,9 +53,6 @@
> > >  
> > >  struct rockchip_iodomain;
> > >  
> > > -/**
> > > - * @supplies: voltage settings matching the register bits.
> > > - */
> > >  struct rockchip_iodomain_soc_data {
> > >  	int grf_offset;
> > >  	const char *supply_names[MAX_SUPPLIES];
> > 
> > Any idea who will pick this up?
> 
> me :-)

Well, that's certainly a start. :)

What are your plans?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

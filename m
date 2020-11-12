Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF92B06EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKLNsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKLNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:48:03 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D3C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:48:02 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so5311972wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1tbEiFf3A3FJTw3Dwkaz00LQ7f5DUN60HnF7WkHWr1k=;
        b=qmBYxFH4Ly0Mk4J6ZundTvylOZyxcFSYt7pn6I5HS8UphxxI4tQYlzc1GTvTY+lnRF
         9JAQZGFAJFDdOLxjf0tiB7MdS4lNMfu0nVsSLGsuWAWW9WQeTg89YqjcujVkv3vgUgjo
         mQ+hzOXIU6W1xmRA1oqUv3/HamZpdPJ+t3WhZTd1RfVzkxgAF4/xU0hnQB1XluM+WLNN
         +WlwQWLVmaDixyKZBsG/uev5Ad3SYf2B4Xd9E/MBz201x5bCaBrHL+JYNtuMn24PVNUP
         6Oikr3FB5N5Hj4a2AnqD4+Fb2O+Rjqj3v7h8QdUTmMRLqmodndjNLlnK0EZ2aHBLdjOB
         U17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1tbEiFf3A3FJTw3Dwkaz00LQ7f5DUN60HnF7WkHWr1k=;
        b=hDIQJuUQepy4JdpPJ5DbPfc+cwZmh4ZpC8g2nuImFCBtB92tEmhcM6afS/vcuRHjZ3
         sr+s+Sa/ETjQOkRz1vVthuktOlZaKd1/6dS+CUiA8GzvuW5VimSaGW1HOddQCneLv13G
         VNx0MCi0r4EqWGM/qPYRNMAf03I3xpL19//c4kCJtG/jy7mIrI1bqMVeBIIQ/FnZjlhL
         2AsgtmoGf2fc90C4wwBzeJyWFjdnBVAlgIj8GpVVDTy5LsLsXJKJnvMXHpT8xrMpnWlJ
         ugGn+ofrXD0dlFhYhPhyFnp3w2X3UPOr4Eors0WQDJsb8HaznNObiMqIOWZA3U8NaPEC
         mQsw==
X-Gm-Message-State: AOAM531LSCiiF2deoDYjsGunUlHN8J/867zTX76tgATLOjLWN/Bhi59l
        Hz2eXvn8a3bzHTu6KOEasrP+pg==
X-Google-Smtp-Source: ABdhPJzyzG5VzyN78q8AphzAInBKduxb4a7K6b/2OTvpBDlCNThbNozfWU2e2Qae4qd8FcYtQFlbdA==
X-Received: by 2002:a1c:c286:: with SMTP id s128mr9765284wmf.88.1605188881687;
        Thu, 12 Nov 2020 05:48:01 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id g66sm6577232wmg.37.2020.11.12.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:48:00 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:47:59 +0000
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
Message-ID: <20201112134759.GL1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <2215873.HjEmSL4Tfo@diego>
 <20201112132828.GK1997862@dell>
 <5334671.Lg3upMlxu3@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5334671.Lg3upMlxu3@diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Heiko Stübner wrote:

> Am Donnerstag, 12. November 2020, 14:28:28 CET schrieb Lee Jones:
> > On Thu, 12 Nov 2020, Heiko Stübner wrote:
> > 
> > > Am Donnerstag, 12. November 2020, 14:22:24 CET schrieb Lee Jones:
> > > > On Thu, 12 Nov 2020, Heiko Stübner wrote:
> > > > 
> > > > > Am Donnerstag, 12. November 2020, 11:33:44 CET schrieb Lee Jones:
> > > > > > On Tue, 03 Nov 2020, Lee Jones wrote:
> > > > > > 
> > > > > > > Fixes the following W=1 kernel build warning(s):
> > > > > > > 
> > > > > > >  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> > > > > > > 
> > > > > > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > > > > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > > > Cc: Doug Anderson <dianders@chromium.org>
> > > > > > > Cc: linux-rockchip@lists.infradead.org
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/soc/rockchip/io-domain.c | 3 ---
> > > > > > >  1 file changed, 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > > > > > > index eece97f97ef8f..d13d2d497720b 100644
> > > > > > > --- a/drivers/soc/rockchip/io-domain.c
> > > > > > > +++ b/drivers/soc/rockchip/io-domain.c
> > > > > > > @@ -53,9 +53,6 @@
> > > > > > >  
> > > > > > >  struct rockchip_iodomain;
> > > > > > >  
> > > > > > > -/**
> > > > > > > - * @supplies: voltage settings matching the register bits.
> > > > > > > - */
> > > > > > >  struct rockchip_iodomain_soc_data {
> > > > > > >  	int grf_offset;
> > > > > > >  	const char *supply_names[MAX_SUPPLIES];
> > > > > > 
> > > > > > Any idea who will pick this up?
> > > > > 
> > > > > me :-)
> > > > 
> > > > Well, that's certainly a start. :)
> > > > 
> > > > What are your plans?
> > > 
> > > the usual, my rockchip-tree -> armsoc driver branch -> torvalds -> 5.11 ;-)
> > 
> > Sorry, the ambiguity was my fault.
> > 
> > When do you plan on hoovering it up?
> 
> sorry should've written that directly ... I already did this "morning":
> 
> http://lore.kernel.org/r/160517975455.81506.16289432612279089945.b4-ty@sntech.de

Ah, perfect.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

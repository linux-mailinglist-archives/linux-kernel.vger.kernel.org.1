Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9A2B0671
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgKLN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgKLN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:28:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C2EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:28:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h62so5516035wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DKFGKs2xFbhbYJY6iHo3vK6PaFJgcL7PWGvvAZgASeA=;
        b=AYZjBHlyliS7Ymssitl0ZrRCQwLbagKctseFoCZMVTZYsnM5VmcZqeyTnrIRnIUKFp
         JyByvj31/nsiPt2UUsPVXOU+aPEXLvpTaihace8LfTZnv9tmibK9bB7PHvhYlB0FLLuE
         WXG25GyT6kWteaPMVw0mM6T5U1R7tdIYpds/C6PStlXvXKcP82rwjEN8Y1y8lrktHiJI
         9RzfRDmZNDDKJsUtvSqN9KC1uX8e6gEgKx43QNwx8zjPIXh6lFm7zKzNEthVZl8hEoza
         mus1SV6qrgU6yqNlJ5ylLy6GA4qUeHJ9pDHehi/ybjEVvUG+1PzUNmiH+wAb0HCkaSCO
         G8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DKFGKs2xFbhbYJY6iHo3vK6PaFJgcL7PWGvvAZgASeA=;
        b=HMBeDSUQdqsjpbBKcJUKW4SwIu5fVxwJkdvZBAjZXwHAS86d5KzG/O/Oi9NgpZ44yJ
         8KW7w1EluqbBjbnr0KV4U4hHiZxnQNSTZDulZVtHXROVHeyK8Jgw/mqP2Ye70Z2+8f47
         HQgvJOHIQY6nQtPOp2Kif73QUdkFgpAVCWHchRBsPAI6dTuO57WpqkNizqroQ00mCaLV
         6heQtzi8o6VNwccG6uH2e0nHUhereTGThSEGiEyj07mh6f4L2OTf5+Us/F3VxBwIBYMV
         f5MoQ4jNRuqOtB03ecgV+IRwN9OecgG8eviWacLP1nsFPpjgMXCQiYlYLHDcZrPCbldc
         37ew==
X-Gm-Message-State: AOAM532gDEl4V5IMMtUXrxhkG/sDXJBLBf27QNzhvpQdb0lMiLqKasXu
        KpiEY53r0Ms/CgzPuZbcZKh4ZQ==
X-Google-Smtp-Source: ABdhPJx9+9Zc/sobhlN/21jqgd6N2DrW+DWihpuemtsepdNTDhJLhJ/5gHtNFCUUQGYlqagI6xolEw==
X-Received: by 2002:a1c:8150:: with SMTP id c77mr10167726wmd.26.1605187710531;
        Thu, 12 Nov 2020 05:28:30 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id w10sm7088635wra.34.2020.11.12.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:28:29 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:28:28 +0000
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
Message-ID: <20201112132828.GK1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <40131312.rmDrfLbc3i@diego>
 <20201112132224.GJ1997862@dell>
 <2215873.HjEmSL4Tfo@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2215873.HjEmSL4Tfo@diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020, Heiko Stübner wrote:

> Am Donnerstag, 12. November 2020, 14:22:24 CET schrieb Lee Jones:
> > On Thu, 12 Nov 2020, Heiko Stübner wrote:
> > 
> > > Am Donnerstag, 12. November 2020, 11:33:44 CET schrieb Lee Jones:
> > > > On Tue, 03 Nov 2020, Lee Jones wrote:
> > > > 
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> > > > > 
> > > > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > Cc: Doug Anderson <dianders@chromium.org>
> > > > > Cc: linux-rockchip@lists.infradead.org
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/soc/rockchip/io-domain.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > > > > index eece97f97ef8f..d13d2d497720b 100644
> > > > > --- a/drivers/soc/rockchip/io-domain.c
> > > > > +++ b/drivers/soc/rockchip/io-domain.c
> > > > > @@ -53,9 +53,6 @@
> > > > >  
> > > > >  struct rockchip_iodomain;
> > > > >  
> > > > > -/**
> > > > > - * @supplies: voltage settings matching the register bits.
> > > > > - */
> > > > >  struct rockchip_iodomain_soc_data {
> > > > >  	int grf_offset;
> > > > >  	const char *supply_names[MAX_SUPPLIES];
> > > > 
> > > > Any idea who will pick this up?
> > > 
> > > me :-)
> > 
> > Well, that's certainly a start. :)
> > 
> > What are your plans?
> 
> the usual, my rockchip-tree -> armsoc driver branch -> torvalds -> 5.11 ;-)

Sorry, the ambiguity was my fault.

When do you plan on hoovering it up?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

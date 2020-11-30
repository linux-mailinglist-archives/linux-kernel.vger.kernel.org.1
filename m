Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0437D2C7DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 06:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgK3FSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 00:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgK3FSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 00:18:43 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0925C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 21:17:57 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so9381992pga.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BbTDpDm3f89nkzTVi3kY5uGn7woGZ/aMuJTX2Dh6PM=;
        b=bFDymy6vHkU5vJi079frEm1lFEpNrzwFsX2cIjAY/AYMc8qikoVM9TB4QQTIuk93+a
         hxitx1+LJh2TzRFTy14clEsPWdXzluaSKxaXWF1pbwbzxZehtbI84ByGYIEkbaYuQevd
         cBjIpx0ryPsUZ4vpkCKVrX9J9q/27KYaDuCbp2us6rbsNgtQBGvl0RWi1GKXCcPRACPI
         VcjwuBM6rVVI49gTa6QeXB8UurGOX9gNIBlS8PI9EAeUj+y4DSih/R+Sqbsnfk/8arM4
         yHvPHSFxW2+3J8ISFPeiRi5Bwcu8Txl4AewJKtWUiNYlLdg2XWBa6XwVU+p7pC00CxRZ
         KQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+BbTDpDm3f89nkzTVi3kY5uGn7woGZ/aMuJTX2Dh6PM=;
        b=hD/6OxojGQyurhmNFg7slqo19p3wXPvw2xbpdNtkljFpb1vCbU9ivTsv4hAeURDxnt
         y2A3lwo2thhVrDRtdK2oKaHyjhHWT5YPqZ3v5mh1FOV/xflY4ff1ItNoHkYd4NLbINFE
         wN51KjQhHh6rXm152wi3CtfzZeAqzeQFmZtgnlMdttSiwH8bC6P/oXZU561leWhSp3ny
         +lwyJVD6vR8Jr8nuBHaDFosXVkKZSUEM3wH0rjZPuLiRw5iVr7oOCEmyIb8jlkfXeyEo
         YFZZZ2MgoHeWH33McED+ADqt46KpzkjZL/2DVagQi6dqgjNWLQZdZiB2dxVz+9ydu/Gm
         1z6g==
X-Gm-Message-State: AOAM532pIVK5zy7Uxt7V7BJDGQVVQhptUww67D3uk06Ow0e/30dAo0BC
        pYmv3VGgrCXXlojak9XbEogvsg==
X-Google-Smtp-Source: ABdhPJy4VyVNymKB7h2J3jpfsDYnjaQZruHEakwphr0+p1YbN+yH9TX6txf6YxcbSyOw0SfeV+uFuQ==
X-Received: by 2002:a63:6507:: with SMTP id z7mr16267842pgb.86.1606713477346;
        Sun, 29 Nov 2020 21:17:57 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id a25sm15227879pfg.138.2020.11.29.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 21:17:56 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:17:52 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 08/27] mmc: sdhci: add a kernel configuration
 for enabling UHS-II support
Message-ID: <20201130051752.GA48535@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-9-takahiro.akashi@linaro.org>
 <98a9d355-80fe-ad48-e5c4-552e88e1c499@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a9d355-80fe-ad48-e5c4-552e88e1c499@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:14:36AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> > in the following commits to indicate UHS-II specific code in sdhci
> > controllers.
> 
> This patch needs to be combined with a patch that actually uses the config.

Earlier is better. So the patch #10/27 would be the best.

-Takahiro Akashi

> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 31481c9fcc2e..5ca9ac03db40 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> >  
> >  	  This is the case for the Nintendo Wii SDHCI.
> >  
> > +config MMC_SDHCI_UHS2
> > +	tristate "UHS2 support on SDHCI controller"
> > +	depends on MMC_SDHCI
> > +	help
> > +	  This option is selected by SDHCI controller drivers that want to
> > +	  support UHS2-capable devices.
> > +
> > +	  If you have a controller with this feature, say Y or M here.
> > +
> >  config MMC_SDHCI_PCI
> >  	tristate "SDHCI support on PCI bus"
> >  	depends on MMC_SDHCI && PCI
> > 
> 

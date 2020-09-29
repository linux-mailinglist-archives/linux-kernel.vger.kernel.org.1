Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792F527D59C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgI2SRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgI2SRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:17:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84597C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:17:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so5401168pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ryJBLPTda+9/HnHPC1FJ42KvIGwTgN32I9Cgw34tfzQ=;
        b=WAV7G0W9JyfR6qwCZmNQyryplAPsfDbC4m9rrojYBmfC2BvYm1k1P4m9evtOUzbEN0
         pI6ci3BGuKmE8A63nJNRw/phJ1Cw9Xmp8s2eGWErGbkfiQBqmr7MruCrLxGWFzyFKgGd
         x46BnZMASPXgPh0tWPbeZH+PbVhZgsDZGowVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryJBLPTda+9/HnHPC1FJ42KvIGwTgN32I9Cgw34tfzQ=;
        b=GwlkJi6jPrncwCIOASAYv+EqT3m774Xm99lnjKFBpoGASt4ldyjXe/woL0XcEHmOHZ
         frrtMxJFWnyGe/wbxx3jeU+BJHGqZTAw8FhyqmWYaUpT68pc3D6ML/STWiuOX+ngkR5j
         mgMJK2treypUvhMKVRZIENH2ajOMlb5djSyfAYrUi8jCDxVN5wIJFVnckbjdx+ZeCmpm
         9TvYBXh+rbBDsVwz4ExJRoTaymC3eh8hlMkqiBTPcEgjeTpQmfu9QRkds+xW11rI9dg0
         CgZpH6NADP4yhX01U91hN++tuj9Iq4NssfIrTMD0FAc9JxDy4jXAaPTiQxemL1MD5vRu
         k4JA==
X-Gm-Message-State: AOAM533SbEdaWHi6BHcfc6B5ucB9Tr+QBj2icenPsLM3nJyp1531o92B
        vk5/yk328K+gDbXAXhqLDOSoyg==
X-Google-Smtp-Source: ABdhPJyTHcKPGR42VRdz9E76O936nMlyAOhqoqKKzD+F50tcGFJS4la+9ZyvF6AEDlrdJAJTtlBVGA==
X-Received: by 2002:a05:6a00:1702:b029:142:2501:34d7 with SMTP id h2-20020a056a001702b0290142250134d7mr5299071pfc.48.1601403467849;
        Tue, 29 Sep 2020 11:17:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id y3sm6535643pfb.18.2020.09.29.11.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 11:17:47 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:17:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 1/5] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <20200929181745.GB1621304@google.com>
References: <1601376452-31839-1-git-send-email-sanm@codeaurora.org>
 <1601376452-31839-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1601376452-31839-2-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:17:28PM +0530, Sandeep Maheswaram wrote:
> Avoiding phy powerdown in host mode so that it can be wake up by devices.
> Added hs_phy_flags and ss_phy_flags to check connection status and
> set phy mode and configure interrupts.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/usb/dwc3/core.c | 14 +++-----------
>  drivers/usb/dwc3/core.h |  3 +++
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 385262f..c32ed10 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1663,10 +1663,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> -			dwc3_core_exit(dwc);
> -			break;
> -		}
>  
>  		/* Let controller to suspend HSPHY before PHY driver suspends */
>  		if (dwc->dis_u2_susphy_quirk ||
> @@ -1724,13 +1720,9 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> -			ret = dwc3_core_init_for_resume(dwc);
> -			if (ret)
> -				return ret;
> -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> -			break;
> -		}
> +
> +		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> +
>  		/* Restore GUSB2PHYCFG bits that were modified in suspend */
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>  		if (dwc->dis_u2_susphy_quirk)
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 83b6c87..cd385a8 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1096,6 +1096,9 @@ struct dwc3 {
>  
>  	bool			phys_ready;
>  
> +	unsigned int            hs_phy_flags;
> +	unsigned int            ss_phy_flags;
> +

It doesn't seem ss_phy_flags is really needed, it is only used
in dwc3_set_phy_speed_flags(), a local variable could be used
instead.

The 'flags' are passed as 'mode' to phy_set_mode(), I think it
would be clearer to reflect that in the name, i.e. 'hs_phy_mode'
instead of 'hs_phy_flags'.

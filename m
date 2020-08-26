Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58632537BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZTA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHZTAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:00:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86CC061574;
        Wed, 26 Aug 2020 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JTeiHpI9co8/sk3zm+dbWTU5RH8x8HjRlmbdmUsEWAA=; b=vh8X+msp/Vupas3v7jeX+S7Px9
        13YwPPFGaulusQHlWXot74+cIamxFiSmgBkVDynnN9eUJ1KqDz568hVwY4lGG0aQXbGJk80T7fyGn
        Be3o2tN+yw2Ls1zLNSBINNMHhXkr/6/lIuIpzoBxQwa75CsHRtj3WcSmhWLLQmosxoQSAzcZAIgud
        KpN7FOHfFrdwxQ7rlq5ZXftd3UVCor+VZLAmreVxJehHWlQm8WzGrjBlf3EqrpmhYUPGPVCUuaHpu
        dwyn4Qie2tm+UGPXu8RfioxupN9HsyZE8zyuiVEWWfZOSUvMy3JOpgtAKgIlPIML5va8BSom1GFS+
        AvBT8paA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kB0fD-0008WJ-28; Wed, 26 Aug 2020 19:00:51 +0000
Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
To:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b7054ec-1b20-0bbc-3cf2-53a32f6fb52d@infradead.org>
Date:   Wed, 26 Aug 2020 12:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 11:44 AM, Manish Narani wrote:
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 7a2304565a73..416063ee9d05 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -139,4 +139,12 @@ config USB_DWC3_QCOM
>  	  for peripheral mode support.
>  	  Say 'Y' or 'M' if you have one such device.
>  
> +config USB_DWC3_XILINX
> +       tristate "Xilinx Platforms"
> +       depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> +       default USB_DWC3
> +       help
> +         Support Xilinx SoCs with DesignWare Core USB3 IP.
> +	 Say 'Y' or 'M' if you have one such device.
> +
>  endif

Indent help text (2 lines) with one tab + 2 spaces, please,
according to Documentation/process/coding-style.rst.

thanks.

-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC32C611E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgK0IrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgK0IrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:47:06 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF87C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:47:04 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so4862127edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KTIE/o2jqyJK/X2ANcj9bq/vRkfEkTjPjTuCUPnDKmQ=;
        b=GTtZEpuCOCbokJFTWkicqW3cdywyhTN9eFHadwfnQerDW1A1VUdq+emk8XGiFZGzaq
         gCILcPDLBbCU+ot7IEsIBXcRBMchzFmE6xIVg+M/A3hmHNk8vb7w9XJmVP1QJA5tbCw3
         PzKAiqlgHJOqOWYPEYHKHryUuToZHGoz57j9APS9Gehjkf7dud6cgY4x1MxSIHWYBkbJ
         pXGwlbIVwR9DdpYbKcxc8rcHPk8+lBU/2SEZoXz859UtSJsid5/tfXSQGlZf5SPR9Yup
         71vQtYtgNEqmhAru/526AkpobfQz6urmARw+Fw914f9+3tXCZHmH/7Yka7EZ4z03YeaF
         gslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTIE/o2jqyJK/X2ANcj9bq/vRkfEkTjPjTuCUPnDKmQ=;
        b=mmnQdoYxXA+MYOlvS33F4AWn+t1Ex4m8iWq/9TepXZOciw/yJ4big+ZvtnKgVW5BG2
         PBLKwWajJ2U/LBYITcdSn+xI6nmUlYEs0k93EHUqySSd/IBB3YkIPtdl1yp8KgAufTl9
         YqnTZHKxYBQRoPsmxGnW/ah06RiToV4tnOLvwU2IVg+3R9Gsi09xdEeqg3lYJuC/o0S9
         lQ3nzkI5NsC9oLcdlNKpQY/IB82FdWa3ZQqHbxe6aOFW8P9d8Y2ZDbka4D/E5jLNz/0O
         r0+3w8P97UTICiS4to28pNvCVPisSnNgnpy2zwXTQRbYM63mQuBDcw36IgL4F7dYi4HK
         Ybkw==
X-Gm-Message-State: AOAM532oY5D/MqdDUFDxuaKsDs456oxe0YkW9hpdW7Q7yaPGuAjFFreV
        1HAt2JeIfFY5sKUbDQAXcBcBcOoms+AoeA==
X-Google-Smtp-Source: ABdhPJzabDabRbKX1EuahGQ3sbSFhVj8hJwlVyypR58ke6Yox3kacVGTBvia26Wq5M0GRPvdmloQKw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr6444384edl.380.1606466823262;
        Fri, 27 Nov 2020 00:47:03 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cw26sm4514208ejb.47.2020.11.27.00.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:47:02 -0800 (PST)
Subject: Re: [PATCH 1/2] phy: rockchip: set pulldown for strobe line in dts
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20201127033359.32725-1-chris.ruehl@gtsys.com.hk>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <ae0e9ff1-bb88-fd76-fdc5-2ddbf3c18b87@gmail.com>
Date:   Fri, 27 Nov 2020 09:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201127033359.32725-1-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Before a new property "enable-strobe-pulldown" is introduced in the code
a change to the documents must be made in a separate patch.
(rockchip-emmc-phy.txt)

./scripts/checkpatch.pl --strict <patch1> <patch2>

On 11/27/20 4:33 AM, Chris Ruehl wrote:
> This patch add support to set the internal pulldown via dt property
> and allow simplify the board design for the trace from emmc-phy to
> the eMMC chipset.
> Default to not set the pull-down.
> 
> This patch was inspired from the 4.4 tree of the
> Rockchip SDK, where it is enabled unconditional.
> The patch had been tested with our rk3399 customized board.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
> index 2dc19ddd120f..d9bc45828f74 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -67,6 +67,10 @@
>  #define PHYCTRL_OTAPDLYENA_SHIFT	0xb
>  #define PHYCTRL_OTAPDLYSEL_MASK		0xf
>  #define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
> +#define PHYCTRL_REN_STRB_DISABLE	0x0

> +#define PHYCTRL_REN_STRB_ENABLE	0x1
> +#define PHYCTRL_REN_STRB_MASK	0x1
> +#define PHYCTRL_REN_STRB_SHIFT	0x9

align with extra TAB ?
check TAB size

>  
>  #define PHYCTRL_IS_CALDONE(x) \
>  	((((x) >> PHYCTRL_CALDONE_SHIFT) & \
> @@ -80,6 +84,7 @@ struct rockchip_emmc_phy {
>  	struct regmap	*reg_base;
>  	struct clk	*emmcclk;
>  	unsigned int drive_impedance;
> +	unsigned int enable_strobe_pulldown;
>  };
>  
>  static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
> @@ -295,6 +300,13 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_MASK,
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>  
> +	/* Internal pull-down for strobe line */
> +	regmap_write(rk_phy->reg_base,

> +			rk_phy->reg_offset + GRF_EMMCPHY_CON2,

CHECK: Alignment should match open parenthesis
#49: FILE: drivers/phy/rockchip/phy-rockchip-emmc.c:305:
+	regmap_write(rk_phy->reg_base,
+			rk_phy->reg_offset + GRF_EMMCPHY_CON2,

> +			HIWORD_UPDATE(rk_phy->enable_strobe_pulldown,
> +				PHYCTRL_REN_STRB_MASK,
> +				PHYCTRL_REN_STRB_SHIFT));

CHECK: Alignment should match open parenthesis
#51: FILE: drivers/phy/rockchip/phy-rockchip-emmc.c:307:
+			HIWORD_UPDATE(rk_phy->enable_strobe_pulldown,
+				PHYCTRL_REN_STRB_MASK,

> +
>  	/* Power up emmc phy analog blocks */
>  	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
>  }
> @@ -359,10 +371,14 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
>  	rk_phy->reg_offset = reg_offset;
>  	rk_phy->reg_base = grf;
>  	rk_phy->drive_impedance = PHYCTRL_DR_50OHM;
> +	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
>  
>  	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
>  		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
>  
> +	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
> +		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
> +
>  	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
>  	if (IS_ERR(generic_phy)) {
>  		dev_err(dev, "failed to create PHY\n");
> 


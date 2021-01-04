Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDC2E9C70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhADR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:58:38 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43878 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:58:37 -0500
Received: by mail-wr1-f47.google.com with SMTP id y17so33062381wrr.10;
        Mon, 04 Jan 2021 09:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmPJ5e8163PgKunBmAEVCaIgenQTVsMEK+0mRPRp5Oo=;
        b=J2OxTIl4jIJBOEyER19fOn9fyQsLsoUeBrrr3mgJYOnQTQsrBhr2+96LcNpUk9GEsq
         5JbmwrAxwSJGIvdBu6HVJA+5I63br4dk38h/zeTGs1xtaTTambXKP0piTTsN4beoBuhz
         J78djAhFMEAUHpQ/hEn7fgGRZH51wvFild5w2qtR0CVdXiJlIjqobmsND5uPKGmXwL+O
         VXREUObCQsMCR5fG+IE25WtPJKJftvWwkMBc4y2gMp6ey3wIjK2z27E9RSZhbCdZU2Rp
         0vpnVHTTcwAmKO+bDnoIC5jHyD20l6N/algD3f6cwcbDpMOS/nfzXk7fBYis7OOcfj8l
         TkPQ==
X-Gm-Message-State: AOAM532xxPSIlXDTgRXHnMT46yC8uCSzKRTbus/sxu3o/f5m9iHTyN9e
        j+GUz11pdMRbGG2TrR587D0=
X-Google-Smtp-Source: ABdhPJzSbBiG6yBgeDFASe3i6iURF8LEVVlmw6HGlrGuP2TSCXicp3GgFHrudVHFeaRLgBJYraNNyg==
X-Received: by 2002:adf:e990:: with SMTP id h16mr83166214wrm.307.1609783075625;
        Mon, 04 Jan 2021 09:57:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b127sm65635wmc.45.2021.01.04.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 09:57:54 -0800 (PST)
Date:   Mon, 4 Jan 2021 18:57:53 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini
 Development Kits
Message-ID: <20210104175753.GA25954@kozik-lap>
References: <1609781807-15096-1-git-send-email-tharvey@gateworks.com>
 <1609781807-15096-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1609781807-15096-2-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:36:47AM -0800, Tim Harvey wrote:
> The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> kits consisting of a GW700x SoM and a Baseboard. Future SoM's such
> as the GW701x will create additional combinations.
> 
> The GW700x SoM contains:
>  - i.MX 8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
>  - GbE PHY connected to the i.MX 8M Mini FEC
>  - Power Management IC
> 
> The GW71xx Baseboard contains:
>  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 1x RJ45 GbE (i.MX 8M Mini FEC)
>  - I/O connector with 1x-SPI/1x-I2C/1x-UART/4x-GPIO signals
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - 1x USB 2.0 Front Panel connector
>  - wide range power supply
> 
> The GW72xx Baseboard contains:
>  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-control, RS485, RS422
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> The GW73xx Baseboard contains:
>  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-control, RS485, RS422
>  - WiFi/BT
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v5:
>  - fixed typo/grammar in commit log (s/controll/control s/comprised/consisting/)
>  - removed underscore from remaining node names
>  - removed blank line in hoggrp
>  - removed unused assigned-clocks and assigned-clock-rates node from usdhc nodes
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


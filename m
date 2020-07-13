Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8021D541
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgGMLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 07:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMLue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:50:34 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD72E206F4;
        Mon, 13 Jul 2020 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594641034;
        bh=A3xNlAR4ygLcLPhZ8CqcVOYL8/NUwzBP6NZpl/Tp4u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfolvZ7+TGYVruQAoIFKZCUfG+gpQhUeSzsfUiO0LKQ50+ttQOzy7nM/i8+GM8slt
         Wd6XoVU+vvy8FwpYP/+0VLUCHMZzDQ5W5uIwi1BKG8SZdBkmPfA1fAlc5r+Ha2E83v
         hVvC/2gfPufpfKEMWKrDApXiPgOCc1dQ9bDMZ9kQ=
Date:   Mon, 13 Jul 2020 19:50:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx6qdl-gw: add Gateworks System Controller
 support
Message-ID: <20200713115028.GO15718@dragon>
References: <1592497149-22526-1-git-send-email-tharvey@gateworks.com>
 <1592937347-12962-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592937347-12962-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:35:47AM -0700, Tim Harvey wrote:
> Add Gateworks System Controller support to Gateworks Ventana boards:
> - add dt bindings for GSC mfd driver and hwmon driver for ADC's and
>   fan controllers.
> - add dt bindings for gpio-keys driver for push-button and interrupt events
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

It causes DTC warnings like below.

../arch/arm/boot/dts/imx6qdl-gw5912.dtsi:248.4-17: Warning (reg_format): /soc/bus@2100000/i2c@21a0000/gsc@20/fan-controller@a:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 0)
arch/arm/boot/dts/imx6dl-gw5912.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-gw5912.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-gw5912.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm/boot/dts/imx6qdl-gw5912.dtsi:244.20-249.5: Warning (avoid_default_addr_size): /soc/bus@2100000/i2c@21a0000/gsc@20/fan-controller@a: Relying on default #address-cells value

Patch dropped.

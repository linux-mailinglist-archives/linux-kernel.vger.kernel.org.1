Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD02C92E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgK3Xnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:43:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58712 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgK3Xnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:43:43 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kjsD9-009b1o-Vw; Tue, 01 Dec 2020 00:03:59 +0100
Date:   Tue, 1 Dec 2020 00:03:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH v2] ARM: dts: mvebu: Add device tree for ATL-x530 Board
Message-ID: <20201130230359.GH2073444@lunn.ch>
References: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:35:07AM +1300, Aryan Srivastava wrote:
> Add device tree file for x530 board. This has an Armada 385 SoC. Has
> NAND-flash for user storage and SPI for booting. Covers majority of x530
> and GS980MX variants.

Hi Aryan

What exactly does that mean, it covers most variants?

I'm just wondering if this should be a .dtsi file, and then each
variant has a .dts file specific to it? Or is the hardware itself the
same, and only the software varies between the variants?

      Andrew

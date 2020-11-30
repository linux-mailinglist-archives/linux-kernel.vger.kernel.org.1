Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CD2C7D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 05:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgK3Ez6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 23:55:58 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:46109 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgK3Ez5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 23:55:57 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 53F52440281;
        Mon, 30 Nov 2020 06:55:13 +0200 (IST)
References: <20201130025410.6669-1-aryan.srivastava@alliedtelesis.co.nz>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: mvebu: Add device tree for ATL-x530 Board
In-reply-to: <20201130025410.6669-1-aryan.srivastava@alliedtelesis.co.nz>
Date:   Mon, 30 Nov 2020 06:55:13 +0200
Message-ID: <87h7p7e95a.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aryan,

[ Dropped Jason's bouncing address from Cc ]

On Mon, Nov 30 2020, Aryan Srivastava wrote:
> Add device tree file for x530 board. This has an Armada 385 SoC. Has
> NAND-flash for user storage and SPI for booting. Covers majority of x530
> and GS980MX variants.
>
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/arm/boot/dts/armada-385-atl-x530.dts | 235 ++++++++++++++++++++++

You need to add this .dts to Makefile for it to build with the rest.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8C23217B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG2P0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 11:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2P0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:26:51 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6CF20809;
        Wed, 29 Jul 2020 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596036411;
        bh=FWwtNBSwhGrxS3G1Pkb3UzjmEygkFwEGVorAw8uBw2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YuX7Bt5KnWUEjuvOCOdbseEnj/NTHy0HPxwGBzOnFV5+nta+ZFbB085rzSfDSTOL
         z9NNOuG27/Qyhnz0SFuX3Q7KKCOjLsd9RZiNYiTHfh3o4s3t+v+SngfsWznKs3X2TX
         m1Lv8t52bnuS9Z+d1cTUkBzzMAorcoHKNDQ34kL8=
Date:   Wed, 29 Jul 2020 23:26:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        arnd@arndb.de, peng.fan@nxp.com, abel.vesa@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V7 0/6] Support building i.MX ARMv8 platforms clock
 driver as module
Message-ID: <20200729152634.GA26850@dragon>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:48:31PM +0800, Anson Huang wrote:
> Nowdays, there are more and more requirements of building SoC specific drivers as
> modules, such as Android GKI (generic kernel image), this patch set supports building
> i.MX ARMv8 SoCs clock drivers as modules,
> 
> The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to make the build
> options aligned, the reason why i.MX ARMv7 platforms clock driver do NOT support
> module build and COMPILE_TEST is because, some drivers like i.MX GPT timer driver
> depends on clock driver to be ready before it, GPT driver uses TIMER_OF_DECLARE(),
> while i.MX6/7 clock drivers use CLK_OF_DECLARE(), and GPT driver is critical for
> i.MX6/7 platforms kernel boot up, so GPT driver needs to be changed to support
> loadable clock driver first, then the i.MX6/7 clock drivers can support loadable
> module, this will be done later.
> 
> Changes since V6:
> 	- improve patch #6's subject and move it to be first patch of this series.
> 
> Anson Huang (6):
>   clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31
>     bits
>   clk: composite: Export clk_hw_register_composite()
>   clk: imx: Support building i.MX common clock driver as module
>   clk: imx: Add clock configuration for ARMv7 platforms
>   clk: imx8m: Support module build
>   clk: imx8qxp: Support building i.MX8QXP clock driver as module

Acked-by: Shawn Guo <shawnguo@kernel.org>

Stephen,

I had sent v5.9 material off my hand to you, so please pick this up
directly if it looks good to you.  Thanks!

Shawn

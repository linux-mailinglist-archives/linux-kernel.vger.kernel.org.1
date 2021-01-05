Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544022EA37E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbhAEC4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbhAEC4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:56:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF5C22581;
        Tue,  5 Jan 2021 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609815374;
        bh=3OWuMLKh9HSTyPne8PTtwAUU/g56o9RHORFLwfJqKtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyyfep+LwoHdopYtws6s/jz7ynjZ1GghNHum2AjuxtoVBJJDXS2qu6kDoHtcTA3va
         KO15pf8OwNnu/70w14eXHvVR+nwRBAfPhbLiF079BOBQ/4lYFHRMm9+40OST+1Hf7/
         m1VEmdaZzNKvO8DwmrdBPo7dpHcpCNqeKeikanbAamcE/+/S3WoeBQewx2LowplG+2
         kp2ykAaR0rymrLbrCeiOPD7oLjC7GWVnWXzDcelkbNn1VNEJ1eALXDTGYvwFaADhq4
         dKGaLmc2pkBpVP/7k2QFpLTgCzlVaoTAEeAIgfiHH2wAc8Lfr7jQGeIV4vtazIjaZB
         AoazaQ9CRXBuw==
Date:   Tue, 5 Jan 2021 10:56:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: Re: [PATCH v2 0/4] Add some clocks support for i.MX8qxp
 DC0/MIPI-LVDS subsystems
Message-ID: <20210105025607.GI4142@dragon>
References: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:33:35PM +0800, Liu Ying wrote:
> This patch set adds some SCU clocks support for i.MX8qxp DC0/MIPI-LVDS
> subsystems.
> 
> With this patch set, some basic clocks for i.MX8qxp LVDS displays can be got
> by drivers.
> 
> v1->v2:
> * Drop LPCG clocks as they can be registered directly in an in-tree new
>   DT binding way.
> * Add DC0 bypass clocks support.
> * Correct the way to register DC0 display clocks.
> * Trivial tweak.
> 
> Liu Ying (4):
>   clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 PLL clocks
>   clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 bypass clocks
>   clk: imx: clk-imx8qxp: Register DC0 display clocks with imx_clk_scu2()
>   clk: imx: clk-imx8qxp: Add some SCU clocks support for MIPI-LVDS
>     subsystems

Applied all, thanks.

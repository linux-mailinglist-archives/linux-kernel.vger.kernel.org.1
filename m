Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF325736E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgHaF5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 01:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaF5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:57:46 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C1B20719;
        Mon, 31 Aug 2020 05:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598853466;
        bh=XIOU28tJX7CV1eyusWssnat55LJrWoBdGa2JlqOB5fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRCNkkSGjc3YwJ36of9NJ6sv63hIVdU2Gawj1uS+GzuvCrPaMgTrb/1SgscXP9EN2
         uWzNlNGsO9Rd+8ctnUG08cJ76jRWAOANJZbcLNr6Cm4E+jznE/8wsQI75M3Uo1LuWn
         fT0llKP/zvpsDTVykQOUTb9DRml/nuITv/lLLp9o=
Date:   Mon, 31 Aug 2020 13:57:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: Add missing
 clock-cells to PMIC
Message-ID: <20200831055739.GM4488@dragon>
References: <20200828192228.23060-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828192228.23060-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 09:22:28PM +0200, Krzysztof Kozlowski wrote:
> The PMIC node can be a clock provider (for its 32 kHz clock) and authors
> of imx8mq-librem5-devkit.dts apparently wanted this because they added
> input clock and clock-output-names.
> 
> Add necessary clock-cells to the PMIC node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.

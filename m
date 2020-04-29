Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1545D1BD1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 04:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD2CBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 22:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2CBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:01:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639AB20731;
        Wed, 29 Apr 2020 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588125660;
        bh=607TfLr7Ei75EXNZgLh0M4pFPfnTu/5m48GVom9BDOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3+f0cS73Vh+jljPOthiezXpV2M5yL6EX4sCz/mhDl5jdwssD32hhNQBUqbzTlX+9
         2A9B1a6DMR7PbGOZlif6zhCVmO69lT9ObocOP/TVd55LBKp04HHY23tNQibCQUaz7S
         ZrPCHqqiKqgIaTV5kprQklZgirbozAvv1ENC6HSE=
Date:   Wed, 29 Apr 2020 10:00:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 06/13] clk: imx: pll14xx: Add the device as argument
 when registering
Message-ID: <20200429020053.GE32592@dragon>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-7-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586937773-5836-7-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:02:46AM +0300, Abel Vesa wrote:
> In order to allow runtime PM, the device needs to be passed on
> to the register function. Audiomix clock controller, used on
> i.MX8MP and future platforms, registers a pll14xx and has runtime
> PM support.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Applied, thanks.

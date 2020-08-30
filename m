Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9A256C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgH3GxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 02:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3GxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 02:53:10 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9ABC2076D;
        Sun, 30 Aug 2020 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598770390;
        bh=hBZ6RdesmiE6ifrKMiMuYfbR77l9JTcrlAqse8LYc2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMyWtRoUuieA/AWIhGJf6M7Xrm4MC+B82hYgZFfTcrCpA2npnqKC2w+kxhcy7fLUP
         Wp3NwVuRBnZ31arT9pmzqOOdUhd4oE3Plui1BbXNsYHnBpsog+3OGwsFXPzL43wcIk
         33yf2XzlE352o+7TJkDw456VeQqYcyMZZ4iB8liA=
Date:   Sun, 30 Aug 2020 14:53:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: imx8mm-evk: Replace deprecated phy reset
 properties
Message-ID: <20200830065304.GF32096@dragon>
References: <20200823111508.1165-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823111508.1165-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 01:15:04PM +0200, Krzysztof Kozlowski wrote:
> Use preferred properties of phy node instead of deprecated
> phy-reset-gpios (and others).  This avoids copying deprecated code into
> future DTSes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied all, thanks.

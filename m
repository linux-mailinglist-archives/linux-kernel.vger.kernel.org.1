Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6323425E5E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIEHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 03:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:02:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF1F206B5;
        Sat,  5 Sep 2020 07:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599289360;
        bh=Q03gpUTD+ItXovuZ926XLppjFN6H1ht+Re/yp7B5QUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPf+9cD5I+h2On16GS2JVIPaPk4fZ1KJ1oZlkeBRSOsy4x+6Z4frnHVhjy1fwd1mI
         DwNf1yybGDoo2p0l9qjxAbSf5a6fvYD49o4P+WrSS6skk6rmGzsxq1uDDtsrqdOD2D
         PY41YJAU64vrj12Rvot7r5nHKNzr8Qszq5p5VF4A=
Date:   Sat, 5 Sep 2020 15:01:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        Anson.Huang@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 RESEND] ARM64: dts: imx8mp: correct sdma1 clk setting
Message-ID: <20200905070140.GH9261@dragon>
References: <1598955709-28688-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598955709-28688-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:21:49PM +0800, Robin Gong wrote:
> Correct sdma1 ahb clk, otherwise wrong 1:1 clk ratio will be chosed so
> that sdma1 function broken. sdma1 should use 1:2 clk, while sdma2/3 use
> 1:1.
> 
> Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.

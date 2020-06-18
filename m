Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AF1FEBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgFRG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 02:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgFRG5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:57:52 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBF620773;
        Thu, 18 Jun 2020 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592463472;
        bh=V5h1ejD6zUH6DYDa9BdWTgrkpCRixg6+jUSZc62MYfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DvkZ8wYEHQ6FGF1CS1rNq4FEhJewogILEGXdb75uB0zHeiauhDwqJOny+VjTwS+8
         OapYJqYyXMSL+Bg4sJ32WuWXu7/k97O/ZzWj4CXKQtkXeeoGSzResmt3ApeWRTSL8A
         LuQrO4j0vgfhcYXgmToWdLqXrEP4SGkehe/Irp9Y=
Date:   Thu, 18 Jun 2020 14:57:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: imx8m: dtb aliases update
Message-ID: <20200618065738.GB30139@dragon>
References: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:02:42AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Minor patchset to update device tree aliases
> 
> Peng Fan (4):
>   arm64: dts: imx8mq: Add mmc aliases
>   arm64: dts: imx8mq: Add ethernet alias
>   arm64: dts: imx8mm: sort the aliases
>   arm64: dts: imx8mp: add i2c aliases

Applied all, thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5728124FDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHXMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 08:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHXMpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:45:18 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB1420706;
        Mon, 24 Aug 2020 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598273117;
        bh=/KfMRm6jGsTf1RXT4ToFJFZgTqfUXupjTq8C8PBvOaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfyZKvSoF/+lCrsp8s9fIzJCpYrfCZdKdIMD/qts1wAqUJeb1WlvPzfKFlOAfYgRp
         kM/SWn5SsOwes33/65BCivVoVz4zLSDk8PXWRHHhNph4xWPOMg4sKJ0/KJjDt/nXaw
         3Vmk7Wi741ER8bfK5d/DeMDg1WkZakJV6PIbz6Lk=
Date:   Mon, 24 Aug 2020 20:45:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, andrew@lunn.ch,
        philippe.schenker@toradex.com, linux@rempel-privat.de,
        davem@davemloft.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidjoshuasim@gmail.com
Subject: Re: [PATCH v2] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for
 ksz9031 phy
Message-ID: <20200824124505.GD12776@dragon>
References: <20200823022505.196825-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823022505.196825-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 07:25:05PM -0700, Chris Healy wrote:
> From: Chris Healy <cphealy@gmail.com>
> 
> Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
> KSZ9031 PHY") the networking is broken on the imx7d-zii-rmu2 board.
> 
> The end result is that network receive behaviour is marginal with lots of
> RX CRC errors experienced and NFS frequently failing.
> 
> Quoting the explanation from Andrew Lunn in commit 0672d22a19244 
> ("ARM: dts: imx: Fix the AR803X phy-mode"):
>    
> "The problem here is, all the DTs were broken since day 0. However,
> because the PHY driver was also broken, nobody noticed and it
> worked. Now that the PHY driver has been fixed, all the bugs in the
> DTs now become an issue"
> 
> Fix it by switching to phy-mode = "rgmii-id".
> 
> Fixes: bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.

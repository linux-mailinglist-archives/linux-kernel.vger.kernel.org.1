Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646C62EA2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbhAEBqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbhAEBqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:46:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65399207A9;
        Tue,  5 Jan 2021 01:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609811136;
        bh=dQb0PM6HIot0BJ8lBe737qkac5FaVyzYLFJKrobBIgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VL9bQQkIcp7vBNftnZCPdQxhXe76MOdFH/W/FFmhEWK7EcKTv+b5Pux/z2xqO3dZ0
         jA7Rl5gLg3uh+aWSP4RAHjRKWl4pgiUatQjBdj2rVF1QPnQKKRE8tv47df+xXNK2wH
         dSIO2JhEEKtsi38zkxXWX5f5y5ht9ejr1u3ABwqoNjjbCRWEJ8VWHbE6txjwTpPJ7t
         Kk0JTi/vd6Fwu/sb2rDBWTYYrD3j2VShd3h2YZ9+Tado8SK9htRWWAYtFKKOLKXclb
         jseUOU8rq4qTUEqcslytw2KJSqFiSxziA/lR2acFZuKmo8Snl+c2439j0Jyvuv33cv
         JMq7H2K/Ld68Q==
Date:   Tue, 5 Jan 2021 09:45:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     linux@rasmusvillemoes.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [v4 02/11] arm64: dts: ls1043a: add DT node for external
 interrupt lines
Message-ID: <20210105014529.GF4142@dragon>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
 <20201130101515.27431-2-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130101515.27431-2-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:15:06PM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add device-tree node for external interrupt lines IRQ0-IRQ11.
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Applied 2 ~ 10, thanks.

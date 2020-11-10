Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E22AC9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgKJAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJAnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:43:14 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C560206B2;
        Tue, 10 Nov 2020 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604968993;
        bh=XzHqem6m80AX6MllQ3e0gvbk8NrE3OGIHym50PRLyUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rap6hVqxoaZI0xxcxRw2jKeRqpIvEo7WML0wGwryOSKcZQ32KQJU9ngA259feEESX
         2g8FegSQycZ/7GcOPxgeBYBcYqbFFcpLBFbEYXfVOs3N+iirFeLFTyihRkn/gRLctu
         596couw/vJiVkUSh1ZKNUX3vzBmrhwo7A5p7DCZw=
Date:   Tue, 10 Nov 2020 08:43:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 0/3] mainline add Altesco I6P board
Message-ID: <20201110004307.GG31601@dragon>
References: <20201030140029.22329-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030140029.22329-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 03:00:26PM +0100, Oleksij Rempel wrote:
> changes v2:
> - rebase against
>   git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
> - remove spaces
> - use Co-developed-by instead of Co-Developed-by 
> 
> Oleksij Rempel (3):
>   dt-bindings: vendor-prefixes: Add an entry for Altus-Escon-Company
>   dt-bindings: arm: fsl: add Altesco I6P board
>   ARM: dts: add Altesco I6P board

Applied all, thanks.

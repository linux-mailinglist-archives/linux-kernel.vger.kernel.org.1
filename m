Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC062A1CE1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKAJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgKAJaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:30:11 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363BF20870;
        Sun,  1 Nov 2020 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604223010;
        bh=DRp7JFM4g9rdPQxJu7Q0QedJyADW31/v6h+dHd1Vw9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqNl7aClMmyAJ0uEBnYR9c2u4yTwl+CijI2q1A+lA5xo3ltCXoFYrYkVO8HLZGz8J
         jBeLLZ1IMn0e/ktMR3TYOffqu/5BiFVbiMTtbTCOp1mbgQe3G6CJKDYSxcbh5sS1Pc
         7bi9xtWXmwrat2UabNKqFr0crVNjBHy9Qo2/35m4=
Date:   Sun, 1 Nov 2020 17:30:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mm-beacon-som: Fix whitespace issue
Message-ID: <20201101093005.GQ31601@dragon>
References: <20201031123114.708158-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031123114.708158-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 07:31:14AM -0500, Adam Ford wrote:
> The pinmux subnodes are indented too much.  This patch does nothing
> more than remove an extra tab.  There are no functional changes.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.

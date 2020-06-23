Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95525204A75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgFWHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbgFWHEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:04:14 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F9C20724;
        Tue, 23 Jun 2020 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592895854;
        bh=dPvfCWFShgcNQ8ZHwNO6ankWGEu47Wr+NvSNZcPK7fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8lWmtQ/X8MxUYf/jPoPB8o1uw/EiKLrDK98FMYHkqFbAImzFcToA8G0rufRvFRkY
         j0Tiuen2QOBZpgzGab7oYTcxh5yhy3S+ySSuqC40lNAwrntfp1/ovg9nMTSvxDBWFA
         VjlSUkb6PxtZmNIYcWmUzV9DrrgHFDoQAERXTu5M=
Date:   Tue, 23 Jun 2020 15:03:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sll: Make ssi node name same as other
 platforms
Message-ID: <20200623070158.GT30139@dragon>
References: <1591094690-30514-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591094690-30514-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 06:44:50PM +0800, Shengjiu Wang wrote:
> In imx6sll.dtsi, the ssi node name is different with other
> platforms (imx6qdl, imx6sl, imx6sx), but the
> sound/soc/fsl/fsl-asoc-card.c machine driver needs to check
> ssi node name for audmux configuration, then different ssi
> node name causes issue on imx6sll platform.
> 
> So we change ssi node name to make all platforms have same
> name.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881D1205002
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgFWLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 07:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgFWLH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:07:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8059D2072E;
        Tue, 23 Jun 2020 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910446;
        bh=zsfKB1wuRE9SSXUBbFLTHKmSLXW6nA+V2ztTFC7lHs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY2qDnfEkRWh64fvJQJyDv79ltuupggMNAkE7iNBNsaD+7RGnhEkx1cYdXSH5F06H
         uZdZqJ8knVOiE20AX92B+EGOEmmP2bNOmgUtDJ0l3UyezYAgoFVvCk1mjBI8PPeioy
         09TfWUJ/d5RJW5ngA/MMsrpbsKOnex4ffkufF9a8=
Date:   Tue, 23 Jun 2020 19:07:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 0/3] arm64: dts: imx8qxp: dtb aliases fix/update
Message-ID: <20200623110720.GY30139@dragon>
References: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:49:51PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Fix order in patch 2/3, no other changes
> 
> Minor patchset to fix and update alias for i.MX8QXP
> 
> Peng Fan (3):
>   arm64: dts: imx8qxp: add alias for lsio MU
>   arm64: dts: imx8qxp: add i2c aliases
>   arm64: dts: imx8qxp: Add ethernet alias

Applied, thanks.

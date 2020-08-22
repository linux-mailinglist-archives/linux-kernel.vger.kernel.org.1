Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E734F24E751
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHVML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 08:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgHVMLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:11:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D192072D;
        Sat, 22 Aug 2020 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598098283;
        bh=Rmwj8j/pac59JIQtuGiaHYfye1VdNBzCXR1+q7FatQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2MgQA/JH/ZcwNHHPE2fCfow7B+Xo4GzFoO/gnM4b+mKYRmnc1J032j9nOrH5vJlf
         sxbos4AB/GUQdiPhPHhK3Ap2t9TpH/dcVIC2ZKp3vLlHjNEilkQVklMjcV6bje5S2X
         y2ZQ0ec0B8Ez8AT673DIGINh/yI7DG7LAIaLXi7Q=
Date:   Sat, 22 Aug 2020 20:11:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] ARM: dts: imx27: Change nand node name to
 nand-controller
Message-ID: <20200822121117.GG27575@dragon>
References: <1596114246-26579-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596114246-26579-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:04:05PM +0800, Anson Huang wrote:
> Change i.MX27 nand node name from "nand" to "nand-controller" to
> be compliant with yaml schema, it requires the nodename to be
> "nand-controller".
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A621CFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 08:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgGMGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 02:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMGs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:48:56 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE58F20720;
        Mon, 13 Jul 2020 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594622936;
        bh=WWEEuVhlr2nW3XjCI9KWOEj+kLW17f+JdDGC2Rl8byI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btl/Tp+izk7mtTssyKlrQDvxZIBkan5DgFkSatsaRXKuQGxSbrbsqfIqtCgfNW20F
         zZjx3bwL8cB7VNTxMWuQgKnbEkJo7lU/ch2HJji90PU1nDYSnRMc8YT6OUSaLtNzAu
         kBG1U39LzQonJRP9b1CqWA4eDPNUINYz3SdyaFPM=
Date:   Mon, 13 Jul 2020 14:48:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl: only enable pcie in the pcie dts file
Message-ID: <20200713064851.GH12113@dragon>
References: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594025081-2353-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:44:41PM +0800, Richard Zhu wrote:
> Since iMX6Q/DL PCIe has the PM limitation (ERR005723 "PCIe PCIe does
> not support L2 Power Down").
> System suspend/resume would be broken by PCIe, if PCIe is enabled.
> Only enable PCIe in the xxx-pcie.dts files to avoid the brokens when
> other xxx.dtb files are used on sabresd and sabreauto boards.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/Makefile                  |  4 ++++
>  arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts | 12 ++++++++++++
>  arch/arm/boot/dts/imx6dl-sabresd-pcie.dts   | 12 ++++++++++++
>  arch/arm/boot/dts/imx6q-sabreauto-pcie.dts  | 12 ++++++++++++
>  arch/arm/boot/dts/imx6q-sabresd-pcie.dts    | 12 ++++++++++++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |  4 ----
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi      |  1 -
>  7 files changed, 52 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-pcie.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabresd-pcie.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-pcie.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-sabresd-pcie.dts

No.  There are hundreds of boards based on i.MX6Q/DL.  We are not going
to maintain a -pcie.dts for every single one of them.

Shawn

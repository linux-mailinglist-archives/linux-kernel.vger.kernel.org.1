Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57889267D46
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 04:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIMCes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 22:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgIMCep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 22:34:45 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEB120731;
        Sun, 13 Sep 2020 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599964485;
        bh=2ymwe7/Fe4Zy8Lkjoq3IVYD2XyRVCNjvHlvDPFnhmnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDe4hkjvpxKAbZE1bKFpNvnqUgS7lLooLYDkt/kFtf2Mw/+033743RTY+ZW3wwST/
         5WL0poYf/lJiTyzV2/QnedpiZ9c9Lk1VLAU979555lxhtVTyUb0yXTSM6vfEoFZMb+
         MlO2KrVG1IiVLyKryfsSAvEQ6R9ZbUDHZih3fQUc=
Date:   Sun, 13 Sep 2020 10:34:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 8/8] arm64: dts: imx8mm-var-som-symphony: Drop unused
 gpioledgrp
Message-ID: <20200913023431.GI25109@dragon>
References: <20200908150241.5771-1-krzk@kernel.org>
 <20200908150241.5771-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908150241.5771-8-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:02:41PM +0200, Krzysztof Kozlowski wrote:
> The gpioledgrp in iomux is not used, so it can be dropped.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.

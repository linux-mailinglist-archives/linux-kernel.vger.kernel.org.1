Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111512A3733
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKBXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKBXeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:34:09 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9AF2231B;
        Mon,  2 Nov 2020 23:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604360048;
        bh=69PEj21L4HDtC3TaZvhLQr+eaBUOJDTOMttCm7jiI6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaxFKdXH1NFk1U++jbr7td08uj8fkTktKElkj7p+ViB/HOazv04vbCEZZDvoEs3oU
         LmNKnrVPvTmDfq7gw8u7EiV1UHWt3OcJNM/ZxFtKZLEXSpX+P9ajWOJJAFZba4bx05
         Da0MLOVt2MQFYdV+eutJV0oroz+cNpRG4bH7xpbk=
Date:   Tue, 3 Nov 2020 07:34:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v5 00/11] arm64: dts: layerscape: update MAC nodes with
 PHY information
Message-ID: <20201102233403.GU31601@dragon>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 01:35:44PM +0200, Ioana Ciornei wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> This patch set aims to add the necessary DTS nodes to complete the
> MAC/PCS/PHY representation on DPAA2 devices. The external MDIO bus nodes
> and the PHYs found on them are added, along with the PCS MDIO internal
> buses and their PCS PHYs. Also, links to these PHYs are added from the
> DPMAC node.
> 
> Changes in v2:
>  - documented the dpmac node into a new yaml entry
>  - dropped the '0x' from some unit addresses
> 
> Changes in v3:
>  - renamed dpmac@x into ethernet@x
>  - renamed the new documentation file to use the same name as the
>    compatible
>  - marked additionalProperties as false
>  - added a reference to ethernet-controller.yaml
>  - added a new patch to document 10gbase-r - 2/11
> 
> Changes in v4:
>  - move the phy-connection-type attribute to the ethernet node in 7,8/11
>  - remove the interrupts description from 8/11 since I plan to properly
>    add all interrupt lines for all platforms
> 
> Changes in v5:
>  - renamed all PHY nodes to ethernet-phy@x
>  - added some empty lines between nodes
>  - used the reg as the unit address
> 
> Ioana Ciornei (11):
>   dt-bindings: net: add the DPAA2 MAC DTS definition
>   dt-bindings: net: add the 10gbase-r connection type
>   arm64: dts: ls1088a: add external MDIO device nodes
>   arm64: dts: ls1088ardb: add QSGMII PHY nodes
>   arm64: dts: ls1088ardb: add necessary DTS nodes for DPMAC2
>   arm64: dts: ls208xa: add the external MDIO nodes
>   arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
>   arm64: dts: ls2088ardb: add PHY nodes for the AQR405 PHYs
>   arm64: dts: ls208xa: add PCS MDIO and PCS PHY nodes
>   arm64: dts: lx2160a: add PCS MDIO and PCS PHY nodes
>   arm64: dts: lx2160ardb: add nodes for the AQR107 PHYs

Applied all, thanks.

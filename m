Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA82A1C9B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgKAHhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgKAHhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:37:32 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A71206D5;
        Sun,  1 Nov 2020 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604216252;
        bh=DyPS0bOUj+YyESGAVMKQ/XszhEt/WQKfVudjqHKLe5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBD7t228qdX2gjxlP9yMo4dsS2JYsePdMQVxNOujEQVpAbGXhRrjkR1vXtpNBopHj
         UQ/SgjEna8WbSkPuD8Ab0sun0KRxbG3vpg4qhQTWVllysE8hyn317PtvfI/wZ8dYF9
         9+NKI0AcUNPCKK65u80mdRu4RmQNvsvYGZ4zukxw=
Date:   Sun, 1 Nov 2020 15:37:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/29] arm64: dts: layerscape: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20201101073726.GE31601@dragon>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-28-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-28-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:57PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Applied, thanks.

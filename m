Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC5280C33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbgJBCD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:03:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40256 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBCD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:03:29 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA7EF528;
        Fri,  2 Oct 2020 04:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1601604206;
        bh=Ife6AOKSz1yLDqr0XawviHdGiWNIv1jH0uvLYdRZtlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lasWYSqLneJlsXBLxscVGuOD/XNXH+Abh0TitNhRJdc+M9p4lK/eXlP0MKvND++Wn
         XrdLdEpD/heMImgxZdenzPuJIKjICNVTNi3EuqkF+CATSwJsAunxYECt/ycxVt72I7
         T6Vc+Dow77WLuyfYJ+Sg6TmH/3RQKPRftsiLb528=
Date:   Fri, 2 Oct 2020 05:02:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: zynqmp: Fix pcie ranges description
Message-ID: <20201002020249.GU3722@pendragon.ideasonboard.com>
References: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, Sep 29, 2020 at 01:43:22PM +0200, Michal Simek wrote:
> DT schema is checking tuples which should be properly separated. The patch
> is doing this separation to avoid the following warning:
> ..yaml: axi: pcie@fd0e0000:ranges: [[33554432, 0, 3758096384, 0,
> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0]] is not valid under
> any of the given schemas (Possible causes of the failure):
> ...dt.yaml: axi: pcie@fd0e0000:ranges: True was expected
> ...dt.yaml: axi: pcie@fd0e0000:ranges:0: [33554432, 0, 3758096384, 0,
> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0] is too long

I would keep the error message unwrapped as it's a bit confusing to
read, even if it exceeds the normal 72 columns limit of commit messaged.

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> I have seen one conversation about it but don't have link which I can point
> to.
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 771f60e0346d..98073f3223e5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -542,8 +542,8 @@ pcie: pcie@fd0e0000 {
>  			      <0x0 0xfd480000 0x0 0x1000>,
>  			      <0x80 0x00000000 0x0 0x1000000>;
>  			reg-names = "breg", "pcireg", "cfg";
> -			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000	/* non-prefetchable memory */
> -				  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
> +			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000>,/* non-prefetchable memory */
> +				 <0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
>  			bus-range = <0x00 0xff>;
>  			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
>  			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,

-- 
Regards,

Laurent Pinchart

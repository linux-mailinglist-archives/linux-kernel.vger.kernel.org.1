Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB012D07BB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgLFWsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFWsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:48:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D294C0613D0;
        Sun,  6 Dec 2020 14:48:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1AF448D;
        Sun,  6 Dec 2020 23:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607294884;
        bh=xq8dcGBIMN0c01Fzq1DYzE032CxJv/A/y/fqv3/oRVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/ULXzUBn5t42KqfLazUcnwcePwOQxlJV4Kcd54Joaqpe8nrosYQk25hNRlveBtca
         c6SEEkFH8EzVNRqVcsvAtjoCSIU4QvtQeZbkas7zQsIxHmPw5v/PImDhi9zA1Eoilw
         ZyIXjRyMaiPr2TSu4HAraATbx70F3XRhLmLRs4Bo=
Date:   Mon, 7 Dec 2020 00:48:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/12] arm64: dts: zynqmp: Add label for zynqmp_ipi
Message-ID: <X81forerb/QuXB2U@pendragon.ideasonboard.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
 <272e23e0123f02c559bfa4ada9de73eb197aced8.1606917949.git.michal.simek@xilinx.com>
 <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 12:46:56AM +0200, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
> > Add label which is used by bootloader for adding bootloader specific flag.
> > 
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > 
> > U-Boot needs to add u-boot,dm-pre-reloc; property
> 
> I'm not entirely sure what best practice rules are in this area, but
> shouldn't U-Boot locate the node by name instead of label ?

And regardless of what mechanism is used, it should be documented in the
bindings.

> > ---
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index 4fa820f78d76..8e9b54b5e70c 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -99,7 +99,7 @@ opp03 {
> >  		};
> >  	};
> >  
> > -	zynqmp_ipi {
> > +	zynqmp_ipi: zynqmp_ipi {
> >  		compatible = "xlnx,zynqmp-ipi-mailbox";
> >  		interrupt-parent = <&gic>;
> >  		interrupts = <0 35 4>;

-- 
Regards,

Laurent Pinchart

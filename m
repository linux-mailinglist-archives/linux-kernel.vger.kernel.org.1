Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9DD2D1D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgLGWQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgLGWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:16:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF64C061749;
        Mon,  7 Dec 2020 14:16:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5102F8D;
        Mon,  7 Dec 2020 23:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607379365;
        bh=5blhwtDoYN23LG+fh5NNUoMJLOyVAgOlj1w0ADmswhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9WALohEgNsUC52o5HaiLYrh30DKknuS2lfaMbSPcZzF4bJIL35SmZnYxGOIO5eT7
         llQ7FP25BzxgJlOPxzppADiXTKmFf/iC/eQieQx8XmiePGRb86KI2VUBahLCLMfG+f
         pKvl7ZVTpbeTamlHWb/Nr+4h/dSe2tt85MqEQcl4=
Date:   Tue, 8 Dec 2020 00:16:02 +0200
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
Message-ID: <X86poiQSzv5Uva1r@pendragon.ideasonboard.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
 <272e23e0123f02c559bfa4ada9de73eb197aced8.1606917949.git.michal.simek@xilinx.com>
 <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
 <99008851-6c12-3acc-6530-25af08429ff5@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99008851-6c12-3acc-6530-25af08429ff5@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Dec 07, 2020 at 10:39:25AM +0100, Michal Simek wrote:
> On 06. 12. 20 23:46, Laurent Pinchart wrote:
> > On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
> >> Add label which is used by bootloader for adding bootloader specific flag.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> U-Boot needs to add u-boot,dm-pre-reloc; property
> > 
> > I'm not entirely sure what best practice rules are in this area, but
> > shouldn't U-Boot locate the node by name instead of label ?
> 
> Labels are not listed in dt binding and there are two approaches how to
> reference nodes. Via full path with node name or via labels.
> I do normally use labels which are much simple.

Note that labels require the DTB to be compiled with the -@ option,
otherwise they're not present in the binary.

> And also if you take a look how dtb looks like (convert back to dts) you
> can see that for example aliases are using full path (just &label) but
> clocks/gic which is the part of <> is handled via phandles as numbers.
> 
> And labels names can vary and shouldn't be the part of binding doc as
> far as I know. But I can be wrong of course.

The DT bindings should document the interface with the operating system,
and if applicable, the boot loader. If the boot loader requires a
particular label, then it becomes part of the ABI, and I think it should
be documented in the bindings.

-- 
Regards,

Laurent Pinchart

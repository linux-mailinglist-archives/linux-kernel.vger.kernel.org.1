Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B12FF7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbhAUWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbhAUWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:30:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F9C06174A;
        Thu, 21 Jan 2021 14:29:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78ECF50E;
        Thu, 21 Jan 2021 23:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611268169;
        bh=bSpsB6iz35fpcRamCYl6FESXLSgAPyQnt/ONPb0XVR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzSbXgjIq0gMeq5GoIgz737IVoY3jMy839L7SJo+VjITuzzFWGvHFXyi989Nj5y8+
         uPx4iYyo6wP/vjx3b8CJp83GEb47dqEFDHYxBy+lOAxmSMMGDapf9ALgnwsKMRLYm5
         vpLAm2py/mSCZoCQYTh/D71qwqNxY+dFLyw2XDaE=
Date:   Fri, 22 Jan 2021 00:29:11 +0200
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
Message-ID: <YAoAN3JF27zWnjn5@pendragon.ideasonboard.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
 <272e23e0123f02c559bfa4ada9de73eb197aced8.1606917949.git.michal.simek@xilinx.com>
 <X81fXtxvsc7KE7cK@pendragon.ideasonboard.com>
 <99008851-6c12-3acc-6530-25af08429ff5@xilinx.com>
 <X86poiQSzv5Uva1r@pendragon.ideasonboard.com>
 <4010c2d4-bee1-827b-1079-1f1bbf1f10d1@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4010c2d4-bee1-827b-1079-1f1bbf1f10d1@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

I've just realized I forgot to reply to this e-mail, sorry.

On Tue, Dec 08, 2020 at 08:26:41AM +0100, Michal Simek wrote:
> On 07. 12. 20 23:16, Laurent Pinchart wrote:
> > On Mon, Dec 07, 2020 at 10:39:25AM +0100, Michal Simek wrote:
> >> On 06. 12. 20 23:46, Laurent Pinchart wrote:
> >>> On Wed, Dec 02, 2020 at 03:06:05PM +0100, Michal Simek wrote:
> >>>> Add label which is used by bootloader for adding bootloader specific flag.
> >>>>
> >>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>>> ---
> >>>>
> >>>> U-Boot needs to add u-boot,dm-pre-reloc; property
> >>>
> >>> I'm not entirely sure what best practice rules are in this area, but
> >>> shouldn't U-Boot locate the node by name instead of label ?
> >>
> >> Labels are not listed in dt binding and there are two approaches how to
> >> reference nodes. Via full path with node name or via labels.
> >> I do normally use labels which are much simple.
> > 
> > Note that labels require the DTB to be compiled with the -@ option,
> > otherwise they're not present in the binary.
> 
> U-Boot is using different concept. You can see that there are a lot of
> -u-boot.dtsi files in dts folders. These are automatically included to
> DTS before DTC is called. It means you don't need to build overlay to
> get merged.
> 
> >> And also if you take a look how dtb looks like (convert back to dts) you
> >> can see that for example aliases are using full path (just &label) but
> >> clocks/gic which is the part of <> is handled via phandles as numbers.
> >>
> >> And labels names can vary and shouldn't be the part of binding doc as
> >> far as I know. But I can be wrong of course.
> > 
> > The DT bindings should document the interface with the operating system,
> > and if applicable, the boot loader. If the boot loader requires a
> > particular label, then it becomes part of the ABI, and I think it should
> > be documented in the bindings.
> 
> We have been discussing with Rob some month ago but didn't have a time
> to do step further. Just keep it short Rob was ok to keep bootloader
> binding inside Linux repo.

I think that makes sense, DT bindings are meant to be OS-agnostic, so
boot loader requirements should be documented there.

> There is no hardcoding for a particular name. There is just a need to
> have any label. U-Boot needs to have one property(e.g.
> u-boot,dm-pre-reloc;) just to do early allocation.
> The name is just reference and none is really looking for it. It is just
> a way how to include it in much easier way.

Just to make sure I understand this issue correctly, does this mean that
you need to reference the node in a *-u-boot.dtsi file, and want a label
to do so ? The label name needs to be the same in the base file (taken
from the Linux source tree) and the *-u-boot.dtsi file (in the U-Boot
source tree) in that case. Isn't it the role of DT bindings to document
such requirements ?

-- 
Regards,

Laurent Pinchart

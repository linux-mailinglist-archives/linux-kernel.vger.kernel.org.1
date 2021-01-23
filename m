Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192E3017B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAWSnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:43:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A7C06174A;
        Sat, 23 Jan 2021 10:42:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36C9B4FB;
        Sat, 23 Jan 2021 19:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611427367;
        bh=W2pDXraJ4uax2rWMnZAIrwBwRlIuxMsEVFuamq4Yngk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmAq63tKt0HQ2TF3W2uSd31/posqBe/CKjbVL/aTiosiVmm4HDYTVPdlar/oqfyY+
         ypkvSmTiVzKsuNcH+FQLZqSAbPm6hEkblgQH6fsY2uYeqdvBbgi4/i6DxUbo8wYA6y
         hV5WlYp+6TduGE28rkP+aXt1L0FgLjDft2/CKixM=
Date:   Sat, 23 Jan 2021 20:42:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Biao Huang <biao.huang@mediatek.com>
Subject: Re: [RFC v1] clk: core: support clocks that need to be enabled
 during re-parent
Message-ID: <YAxuE8un+nznqtSx@pendragon.ideasonboard.com>
References: <1560138293-4163-1-git-send-email-weiyi.lu@mediatek.com>
 <20190625221415.B0DC22086D@mail.kernel.org>
 <1561511122.24282.10.camel@mtksdaap41>
 <20190626035246.4591A20659@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626035246.4591A20659@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jun 25, 2019 at 08:52:45PM -0700, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-06-25 18:05:22)
> > On Tue, 2019-06-25 at 15:14 -0700, Stephen Boyd wrote:
> > > Quoting Weiyi Lu (2019-06-09 20:44:53)
> > > > When using property assigned-clock-parents to assign parent clocks,
> > > > core clocks might still be disabled during re-parent.
> > > > Add flag 'CLK_OPS_CORE_ENABLE' for those clocks must be enabled
> > > > during re-parent.
> > > > 
> > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > 
> > > Can you further describe the scenario where this is a problem? Is it
> > > some sort of clk that is enabled by default out of the bootloader and is
> > > then configured to have an 'assigned-clock-parents' property to change
> > > the parent, but that clk needs to be "enabled" so that the framework
> > > turns on the parents for the parent switch?
> > 
> > When driver is built as module(.ko) and install at runtime after the
> > whole initialization stage. Clk might already be turned off before
> > configuring by assigned-clock-parents. For such clock design that need
> > to have clock enabled during re-parent, the configuration of
> > assigned-clock-parents might be failed. That's the problem we have now.
> 
> Great. Please put this sort of information in the commit text.
> 
> > Do you have any suggestion for such usage of clocks? Many thanks.
> 
> Ok, and in this case somehow CLK_OPS_PARENT_ENABLE flag doesn't work? Is
> that because the clk itself doesn't do anything unless it's enabled?  I
> seem to recall that we usually work around this by caching the state of
> the clk parents or frequencies and then when the clk prepare or enable
> op is called we actually write the hardware to change the state. There
> are some qcom clks like this and we basically just use the hardware
> itself to cache the state of the clk while it hasn't actually changed to
> be at that rate, because the clk is not enabled yet.

I'm trying to move the fix to the clock driver itself. Do you have any
pointer to such a clock that I can use as an example ?

> The main concern is that we're having to turn on clks to make things
> work, when it would be best to not turn on clks just so that register
> writes actually make a difference to what the hardware does.

I agree, it's best not to turn the clock on if we can avoid it.

-- 
Regards,

Laurent Pinchart

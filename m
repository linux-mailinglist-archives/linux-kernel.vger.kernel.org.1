Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3A24F07E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHWXSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 19:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgHWXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:18:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B6C061573;
        Sun, 23 Aug 2020 16:17:59 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A436279;
        Mon, 24 Aug 2020 01:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598224676;
        bh=5pNVaxdIH2zklieYTCrcATi7SEHr44vYPcKJt9zZAqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxrdpSIncsK7SqIusa7ueSzkfiflhHGkJDYNSGu6BlfSrEIj6iPb5P6E74uL2HJUf
         j07c4xhbbMghXdxzf9ap0czkBscavCYTkThGloDytYBZJsvhZxFxKBJSyzTe8yQJr5
         2kIPV+bULEXPuH/3EIUbDD8IOo1Gc/Bil1AETxKQ=
Date:   Mon, 24 Aug 2020 02:17:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     Kenneth Sloat <ksloat@designlinxhs.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: dt-bindings: display: xlnx: mixer: Inconsistent pixel format
 terminology in dt docs
Message-ID: <20200823231737.GM6002@pendragon.ideasonboard.com>
References: <1ac0eeed-7455-b0a3-a3e4-4501ae3129df@designlinxhs.com>
 <20200820233817.GA508@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820233817.GA508@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 20, 2020 at 04:38:18PM -0700, Hyun Kwon wrote:
> On Thursday, August 20, 2020 2:18 PM, Kenneth Sloat write:
> > Hello,
> > 
> > The Xilinx Video mixer IP uses the DRM fourcc string as a device tree binding in
> > order to describe the format for a specific DRM layer/plane. Currently, in the
> > device tree doc in
> > "Documentation/devicetree/bindings/dma/xilinx/xilinx_frmbuf.txt" there is a list
> > called "VIDEO FORMATS" with a table containing "Mixer IP Format" and
> > associated "Driver supported Format String" (fourcc). In general, this table is not
> > helpful, because "Mixer IP Format" does not match the Xilinx IP datasheet
> > terminology for formats but rather some other commonly used nomenclature.
> > This is also inconsistent from other Xilinx dts binding docs which specify the
> > actual correct IP name and at times list other format nomenclature where
> > helpful (i.e. xilinx_frmbuf.txt)
> > 
> > My suggestion is to remove the current "Mixer IP Format" strings in the doc and
> > replace them with the actual IP names in the datasheet (which also match those
> > used in Xilinx's Vivado FPGA tool). Otherwise, the programmer must cross
> > reference other dts documentation or the code in order to figure these out. I am
> > happy to provide a patch for this but wanted to throw out the suggestion first.

Are you talking about the "Video Format" column in table 2-8 of PG243 ?
Those values seem good to me.

Documentation/devicetree/bindings/media/xilinx/video.txt also defines a
xlnx,video-format property that uses the values from UG934 for the AXI
streaming interface.

> I agree. The bindings should be in sync with datasheet and not rely on
> software definitions. Since the driver is only in Xilinx vendor tree,
> please send directly to git@xilinx.com.

-- 
Regards,

Laurent Pinchart

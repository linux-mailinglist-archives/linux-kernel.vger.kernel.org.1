Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C924215B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 22:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHKUkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 16:40:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33466 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:40:41 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8DA8A9A8;
        Tue, 11 Aug 2020 22:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597178438;
        bh=fBtWiY90WEtks1wYjy4x/pgIM6iFN5zcWTXLdLVWDhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcxrVn0e5nDySsG2O+/rBkfEOsRXVUSP9QeeHHSZ8iJyfsbz6tJMMu3XyIBY64kzC
         Ph3dJr5MGNIRtFDKL0vbq+NYwE2aFFP+qwxSuJRPeN9LgNfaFm7UfqcAQMo1YrLmVo
         tkDVjg1T6P+PtHFy1IzaFR8T319G57usMsddelFw=
Date:   Tue, 11 Aug 2020 23:40:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>
Cc:     hyun.kwon@xilinx.com, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        sandipk@xilinx.com, vgannava@xilinx.com
Subject: Re: [RFC PATCH V2 0/2] Add Xilinx DSI TX driver
Message-ID: <20200811204024.GC17446@pendragon.ideasonboard.com>
References: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GVRao,

Thank you for the patches.

On Tue, Aug 11, 2020 at 06:16:15AM +0530, Venkateshwar Rao Gannavarapu wrote:
> Xilinx DSI-TX subsytem consists of DSI controller core, AXI crossbar
> and D-PHY as sub blocks. DSI TX subsystem driver supports multiple lanes
> upto 4, RGB color formats, video mode and command modes.
> 
> DSI-TX driver is implemented as an encoder driver, as it going to be
> the final node in display pipeline. Xilinx doesn't support any converter
> logic to make this as bridge driver. Xilinx doesn't have such
> use cases where end node can't be an encoder like DSI-TX. And Xilinx
> encoder drivers represents a subsystem where individual blocks can't be
> used with external components / encoders.
> 
> Venkateshwar Rao Gannavarapu (2):
>   dt-bindings: display: xlnx: dsi: This add a DT binding for Xilinx DSI
>     TX     subsystem.
>   drm: xlnx: dsi: driver for Xilinx DSI TX subsystem
> 
>  .../devicetree/bindings/display/xlnx/xlnx,dsi.yaml | 147 +++++
>  drivers/gpu/drm/xlnx/Kconfig                       |  11 +
>  drivers/gpu/drm/xlnx/Makefile                      |   2 +
>  drivers/gpu/drm/xlnx/xlnx_dsi.c                    | 701 +++++++++++++++++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.yaml
>  create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c
> 
> --
> 1.8.3.1
> 
> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you
> are not the intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message and any
> attachments immediately.

Unrelated to the technical contents of this series, this footer makes no
sense for upstream submissions. It's actually a legal issue, and I know
several maintainers who would delete the e-mails without even looking at
them due to this (Greg KH has stated this publicly before for instance).

I assume this is added by the mail server, but it would be good if
someone could get in touch with the IT department to see how this can be
dropped for patches sent to mailing lists. There's no specific urgency,
it can be a background task.

-- 
Regards,

Laurent Pinchart

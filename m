Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83002907CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409444AbgJPOzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:55:05 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:58468 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394635AbgJPOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:55:05 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1161B80752;
        Fri, 16 Oct 2020 16:55:01 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:55:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/2] drm/adi: axi-hdmi-tx: Add support for AXI HDMI TX IP
 core
Message-ID: <20201016145500.GA1325536@ravnborg.org>
References: <20201005141226.180655-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005141226.180655-1-bogdan.togorean@analog.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=gAnH3GRIAAAA:8 a=6SQYn8MF9XToLfwsykcA:9
        a=CjuIK1q_8ugA:10 a=oVHKYsEdi7-vN-J5QA_j:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan

On Mon, Oct 05, 2020 at 05:12:08PM +0300, Bogdan Togorean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> The AXI HDMI HDL driver is the driver for the HDL graphics core which is
> used on various FPGA designs. It's mostly used to interface with the
> ADV7511 driver on some Zynq boards (e.g. ZC702 & ZedBoard).
> 
> Link: https://wiki.analog.com/resources/tools-software/linux-drivers/drm/hdl-axi-hdmi
> Link: https://wiki.analog.com/resources/fpga/docs/axi_hdmi_tx

Thanks for submitting the driver - a few high level comments after
browsing the driver:

- Use drmm_mode_config_init() to utilize new cleanup
- Look at other uses of drm_driver - there is macros that makes this
  much simpler / smaller
- Use devm_drm_dev_alloc() to allocate axi_hdmi_tx_private
  To do so embed drm_device in axi_hdmi_tx_private - which is the way to
  do it today
- Do not use ddev->dev_private, it is deprecated
- Use dev_err_probe() when you risk to see a PROBE_DEFER
- In all include blocks sort the include alphabetically
- Use the new interface to drm_bridge_attach() - where display driver
  creates the connector
- See if the Kconfig selects can be trimmed - the framebuffer releated
  selects looks wrong (others get it wrong too)
- Check if you can use the simple encoder - see
  drm_simple_encoder_init()

If this is a simple one plane, one crtc display driver then it should
use the drm_simple_* support. Or the changelog should explain why not.

We want the drivers as simple as we can - and they shall use as much of
the helper infrastructure as they can.

We continue to develop the helper infrastructure so it is expected that
there is some lacking behind as is the case here.

        Sam



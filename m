Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CAA290C17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410448AbgJPTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:08:26 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42884 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbgJPTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:08:26 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5C98180623;
        Fri, 16 Oct 2020 21:08:22 +0200 (CEST)
Date:   Fri, 16 Oct 2020 21:08:21 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        zhang.lyra@gmail.com
Subject: Re: [PATCH RFC v7 0/6] Add Unisoc's drm kms module
Message-ID: <20201016190821.GC1345100@ravnborg.org>
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=Bk4yDtxpmw7rSWEHNH8A:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

> v7:
> 1. Fix DTC unit name warnings
> 2. Fix the problem of maintainers
> 3. Call drmm_mode_config_init to mode config init
> 4. Embed drm_device in sprd_drm and use devm_drm_dev_alloc
> 5. Replace DRM_XXX with drm_xxx on KMS module, but not suitable for other subsystems
> 6. Remove plane_update stuff, dpu handles all the HW update in crtc->atomic_flush
> 7. Dsi&Dphy Code structure adjustment, all move to "sprd/"

I can see some of my feedback from last round of review is not
addressed. There were makefile fixes and then I asked for a high-level
intro.

Can you please revisit last round of review feedback to check what was
missed.

	Sam


> 
> Kevin Tang (6):
>   dt-bindings: display: add Unisoc's drm master bindings
>   drm/sprd: add Unisoc's drm kms master
>   dt-bindings: display: add Unisoc's dpu bindings
>   drm/sprd: add Unisoc's drm display controller driver
>   dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
>   drm/sprd: add Unisoc's drm mipi dsi&dphy driver
> 
>  .../display/sprd/sprd,display-subsystem.yaml       |   39 +
>  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml    |   83 ++
>  .../display/sprd/sprd,sharkl3-dsi-host.yaml        |   98 ++
>  .../display/sprd/sprd,sharkl3-dsi-phy.yaml         |   75 +
>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/sprd/Kconfig                       |   13 +
>  drivers/gpu/drm/sprd/Makefile                      |   12 +
>  drivers/gpu/drm/sprd/dpu_r2p0.c                    |  636 +++++++++
>  drivers/gpu/drm/sprd/dw_dsi_ctrl.c                 |  792 +++++++++++
>  drivers/gpu/drm/sprd/dw_dsi_ctrl.h                 | 1475 ++++++++++++++++++++
>  drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.c             |  276 ++++
>  drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.h             |   34 +
>  drivers/gpu/drm/sprd/megacores_pll.c               |  315 +++++
>  drivers/gpu/drm/sprd/megacores_pll.h               |  146 ++
>  drivers/gpu/drm/sprd/sprd_dphy.c                   |  335 +++++
>  drivers/gpu/drm/sprd/sprd_dphy.h                   |   39 +
>  drivers/gpu/drm/sprd/sprd_dpu.c                    |  501 +++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h                    |  217 +++
>  drivers/gpu/drm/sprd/sprd_drm.c                    |  263 ++++
>  drivers/gpu/drm/sprd/sprd_drm.h                    |   20 +
>  drivers/gpu/drm/sprd/sprd_dsi.c                    | 1102 +++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dsi.h                    |  105 ++
>  23 files changed, 6579 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-phy.yaml
>  create mode 100644 drivers/gpu/drm/sprd/Kconfig
>  create mode 100644 drivers/gpu/drm/sprd/Makefile
>  create mode 100644 drivers/gpu/drm/sprd/dpu_r2p0.c
>  create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl.c
>  create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl.h
>  create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.c
>  create mode 100644 drivers/gpu/drm/sprd/dw_dsi_ctrl_ppi.h
>  create mode 100644 drivers/gpu/drm/sprd/megacores_pll.c
>  create mode 100644 drivers/gpu/drm/sprd/megacores_pll.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dphy.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
>  create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

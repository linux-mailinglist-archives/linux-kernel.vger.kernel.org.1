Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8C247DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 07:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRFML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 01:12:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21319 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726306AbgHRFMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:12:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597727528; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=QEpAK5HZ7+g6gftbWDmNJEcQN1FcIZyBjsQxMDU4dBY=; b=ejLS8wcNgivLjN0CfjmDU1RU/uJ5iHyh4BnZUay9XA0aAOV8Qh0lN0jGyljVargLkWHenIrG
 QZD5WD+rrKj+g2F/GQTV7h+KiMs/xuP8XQ0mxTXqbKuYZnS+FybuzUwuhxukpWcIwQxynHHI
 CGgZwe5g8Cq2L52ZTC+d+VtqFTs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f3b6327cbcd42bdee1e663c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 05:12:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A5DFC43391; Tue, 18 Aug 2020 05:12:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from linuxdisplay-lab-04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tanmay)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34B26C433C6;
        Tue, 18 Aug 2020 05:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34B26C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tanmay@codeaurora.org
From:   Tanmay Shah <tanmay@codeaurora.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, robdclark@gmail.com
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
Subject: [PATCH v11 0/5] Add support for DisplayPort driver on SnapDragon
Date:   Mon, 17 Aug 2020 22:11:32 -0700
Message-Id: <20200818051137.21478-1-tanmay@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add Display-Port driver on SnapDragon/msm hardware.
This series also contains device-tree bindings for msm DP driver.
It also contains Makefile and Kconfig changes to compile msm DP driver.

The block diagram of DP driver is shown below:


                 +-------------+
                 |DRM FRAMEWORK|
                 +------+------+
                        |
                   +----v----+
                   | DP DRM  |
                   +----+----+
                        |
                   +----v----+
     +------------+|   DP    +----------++------+
     +        +---+| DISPLAY |+---+      |      |
     |        +    +-+-----+-+    |      |      |
     |        |      |     |      |      |      |
     |        |      |     |      |      |      |
     |        |      |     |      |      |      |
     v        v      v     v      v      v      v
 +------+ +------+ +---+ +----+ +----+ +---+ +-----+
 |  DP  | |  DP  | |DP | | DP | | DP | |DP | | DP  |
 |PARSER| | HPD  | |AUX| |LINK| |CTRL| |PHY| |POWER|
 +--+---+ +---+--+ +---+ +----+ +--+-+ +-+-+ +-----+
    |                              |     |
 +--v---+                         +v-----v+
 |DEVICE|                         |  DP   |
 | TREE |                         |CATALOG|
 +------+                         +---+---+
                                      |
                                  +---v----+
                                  |CTRL/PHY|
                                  |   HW   |
                                  +--------+

Changes in v7:

- Modify cover letter description and fix title.
- Introduce dp-controller.yaml for common bindings across SOC
- Rename dp-sc7180.yaml to dp-controller-sc7180.yaml for SC7180 bindings
- Rename compatible string to qcom,sc7180-dp
- Add assigned-clocks and assigned-clock-parents properties in bindings
- Remove redundant code from driver
- Extend series to include HPD detection logic

Changes in v8:

- Add MDSS AHB clock in bindings 
- Replace mode->vrefresh use with drm_mode_vrefresh API
- Remove redundant aux config code from parser and aux module
- Assign default max lanes if data-lanes property is not available
- Fix use-after-free during DP driver remove
- Unregister hardware clocks during driver cleanup

Changes in v9:

- Drop YAML bindings change from the series
- Use assigne-clock-parents property and remove clk_set_parent use from code
- Access register address space without name
- Fix DP register dump utility
- Disable DP clocks after vsync generated
- Avoid 64-bit modulo operation
- Drop any unused code and fix function proptotyes to avoid W=1 warnings
- Drop DRM_MSM_DP_10NM_PLL config as only 10nm PLL is available

Changes in v10:

- Fix help description of Kconfig entry

Changes in v11:

- Fix "stream_pixel" string parsing
- Limit 10nm PLL functions' scope

Chandan Uddaraju (4):
  dt-bindings: msm/dp: add bindings of DP/DP-PLL driver for Snapdragon
  drm: add constant N value in helper file
  drm/msm/dp: add displayPort driver support
  drm/msm/dp: add support for DP PLL driver

Jeykumar Sankaran (1):
  drm/msm/dpu: add display port support in DPU

Tanmay Shah (1):
  drm/msm/dp: Add Display Port HPD feature

 drivers/gpu/drm/i915/display/intel_display.c  |    2 +-
 drivers/gpu/drm/msm/Kconfig                   |    9 +
 drivers/gpu/drm/msm/Makefile                  |   14 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   27 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |    8 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   83 +-
 drivers/gpu/drm/msm/dp/dp_aux.c               |  510 +++++
 drivers/gpu/drm/msm/dp/dp_aux.h               |   29 +
 drivers/gpu/drm/msm/dp/dp_catalog.c           | 1030 ++++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h           |  104 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c              | 1693 +++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h              |   35 +
 drivers/gpu/drm/msm/dp/dp_display.c           | 1017 ++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h           |   31 +
 drivers/gpu/drm/msm/dp/dp_drm.c               |  168 ++
 drivers/gpu/drm/msm/dp/dp_drm.h               |   18 +
 drivers/gpu/drm/msm/dp/dp_hpd.c               |   69 +
 drivers/gpu/drm/msm/dp/dp_hpd.h               |   79 +
 drivers/gpu/drm/msm/dp/dp_link.c              | 1214 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_link.h              |  132 ++
 drivers/gpu/drm/msm/dp/dp_panel.c             |  486 +++++
 drivers/gpu/drm/msm/dp/dp_panel.h             |   95 +
 drivers/gpu/drm/msm/dp/dp_parser.c            |  267 +++
 drivers/gpu/drm/msm/dp/dp_parser.h            |  138 ++
 drivers/gpu/drm/msm/dp/dp_pll.c               |   99 +
 drivers/gpu/drm/msm/dp/dp_pll.h               |   61 +
 drivers/gpu/drm/msm/dp/dp_pll_10nm.c          |  930 +++++++++
 drivers/gpu/drm/msm/dp/dp_pll_private.h       |   89 +
 drivers/gpu/drm/msm/dp/dp_power.c             |  373 ++++
 drivers/gpu/drm/msm/dp/dp_power.h             |  103 +
 drivers/gpu/drm/msm/dp/dp_reg.h               |  517 +++++
 drivers/gpu/drm/msm/msm_drv.c                 |    2 +
 drivers/gpu/drm/msm/msm_drv.h                 |   59 +-
 include/drm/drm_dp_helper.h                   |    1 +
 34 files changed, 9473 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/dp/dp_aux.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_aux.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_catalog.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_catalog.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_ctrl.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_ctrl.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_display.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_display.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_drm.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_drm.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hpd.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_link.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_link.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_panel.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_panel.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_parser.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_parser.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_pll.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_pll.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_pll_10nm.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_pll_private.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_power.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_power.h
 create mode 100644 drivers/gpu/drm/msm/dp/dp_reg.h


base-commit: 62975d27d647a40c58d3b96c29b911fc4f33c310
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


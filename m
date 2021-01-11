Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350E72F1EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbhAKTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbhAKTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE329C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so255115wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PECDtmeFRTTbINpo1MBoxeyYk3sK6YMNX5ISdYlRSfY=;
        b=bEP+YEmqCeDN3RyNe6EivxTw/yjX7MVFIrNcAawNmgxyS0evh90c8B23+z33XT1SNe
         CG6s6PcQvz60ZI6zOkh0SPduCuUXuwbzu4781tlmRDvvTUjgQwPyf+d3/fuFjHNe1gdq
         jrq8YrTUAJ/B2Hfog0n0OrhJ9qhJ4tHTew2TeqHVLFy4Zb0qiA9FM0FVvopLPi9PRL2e
         HU4P2AkKZXbx2ojbWO5LEmQP4S6ZT3jhdMXSBHU/tcvJuZH1K/L0gG5oE+WFDXxIHSpP
         PZQ4zZzlseVjhtcdgVDxmNrW1hmgeOvAx+ubJgF4isRsuJ1GOMGXrAsde/7Zl9qUquic
         xREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PECDtmeFRTTbINpo1MBoxeyYk3sK6YMNX5ISdYlRSfY=;
        b=jSKLhTviepfQi/RwOaVa9KjxfO80uIr4Mm71cl0XywlKE/rCcoTdRo0MJYUspcB6No
         +NbTt09qqtTJ8KuOn2tytAxpDM6SeLZW0di8keqXQKgLBcnNMdusJigbgxXxrwwDnyHL
         LabKK80K0kYRg5LXMP3uMKBNDt/zQ/bQoTzzBKPlxVmviQ3jP7t3/8wtpKcFzvnc7LXM
         3fZWIMFIkmU9CwpWn+Tn4C6LYv7objDFfXPab+RUdTYuNTwpsryPBw5dYG32XdBxadnr
         O9L9DIR65cpATqZdoO0Uh+1JvXdesFgIhlZ2zV7mgiM08iqCqnncF/SUe2VZjl8pFBHZ
         hmHQ==
X-Gm-Message-State: AOAM532H7SGfB2Hm2Z+ejSRtK39uMF/OdQVUYD+K/4ESIakMLysXyElk
        Lffx2B8+9fJkT014bU5dzW3hbQ==
X-Google-Smtp-Source: ABdhPJxjofujK1MYN201ahii9IuZL5GFpIteWPNIpWPJ1RVAHK4iaqUKUikzOi6JRd0GzRb/ggmMuw==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr292835wmj.52.1610392770402;
        Mon, 11 Jan 2021 11:19:30 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
        Aric Cyr <aric.cyr@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH 00/40] [Set 12] Rid W=1 warnings from GPU
Date:   Mon, 11 Jan 2021 19:18:46 +0000
Message-Id: <20210111191926.3688443-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (40):
  drm/amd/display/dc/dce/dce_aux: Mark 'dce_aux_transfer_raw' as
    __maybe_unused
  drm/amd/display/dc/dce/dce_link_encoder: Remove unused variable
    'value0'
  drm/amd/display/dc/gpio/hw_ddc: Remove unused variable 'reg2'
  drm/amd/display/dc/dce/dce_opp: Demote non-compliant kernel-doc
    headers
  drm/amd/display/dc/dce/dce_transform: Demote kernel-doc abuse
  drm/amd/display/dc/gpio/diagnostics/hw_translate_diag: Include our own
    header containing prototypes
  drm/amd/display/dc/irq/irq_service: Make local function static
  drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Fix struct
    declared inside parameter list error
  drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Include our own
    header containing prototypes
  drm/amd/display/dc/dce120/dce120_hw_sequencer: Encompass defines in
    same clause as their use
  drm/amd/display/dc/dce120/dce120_timing_generator:
  drm/amd/display/dc/dce120/Makefile: Ignore -Woverride-init warning
  drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the
    stack to the heap
  drm/amd/display/dc/calcs/dce_calcs: Remove some large variables from
    the stack
  drm/amd/display/dc/dce120/dce120_resource: Staticify local functions
  drm/amd/display/dc/dce120/dce120_timing_generator: Demote
    non-kerneldoc headers
  drm/amd/display/dc/dce/dce_aux: Remove duplicate line causing 'field
    overwritten' issue
  drm/amd/display/dc/dce112/Makefile: Ignore -Woverride-init warning
  drm/amd/display/dc/dce/dce_opp: Remove duplicate entries causing
    'field overwritten' issues
  drm/amd/display/dc/dce110/dce110_timing_generator: Remove unused
    variable 'value_crtc_vtotal'
  drm/amd/display/dc/dce110/dce110_compressor: Remove unused function
    'dce110_get_required_compressed_surfacesize
  drm/amd/display/dc/dce110/dce110_hw_sequencer: Demote non-conformant
    kernel-doc header
  drm/amd/display/dc/dce110/dce110_mem_input_v: Make local functions
    static
  drm/amd/pm/swsmu/smu11/vangogh_ppt: Make local function
    'vangogh_clk_dpm_is_enabled' static
  drm/amd/display/dc/dce120/dce120_timing_generator: Remove unused
    function 'dce120_timing_generator_get_position'
  drm/amd/display/dc/dce110/dce110_timing_generator: Demote kernel-doc
    abuses to standard function headers
  drm/amd/display/dc/dce110/dce110_compressor: Strip out unused function
    'controller_id_to_index'
  drm/amd/display/dc/calcs/dce_calcs: Demote non-conformant kernel-doc
    function headers
  drm/amd/display/dc/dce112/dce112_resource: Make local functions and
    ones called by reference static
  drm/amd/display/dc/dce110/dce110_timing_generator_v: Demote kernel-doc
    abuse and line up comments
  drm/amd/display/dc/dce110/dce110_mem_input_v: Include our own header,
    containing prototypes
  drm/amd/display/dc/dce110/Makefile: Ignore -Woverride-init warning
  drm/amd/display/dc/dce110/dce110_resource: Make local functions
    invoked by reference static
  drm/amd/display/dc/dce110/dce110_transform_v: Demote kernel-doc abuse
  drm/amd/display/dc/dce60/dce60_timing_generator: Make
    'dce60_configure_crc' invoked by reference static
  drm/amd/display/dc/dce100/dce100_resource: Make local functions and
    ones called by reference static
  drm/amd/display/dc/dce60/dce60_resource: Make local functions static
  drm/amd/display/dc/dce80/dce80_resource: Make local functions static
  drm/amd/display/dc/core/dc_surface: Demote kernel-doc abuse
  drm/amd/display/dc/core/dc_stream: Demote non-conformant kernel-doc
    headers

 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 1141 +++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    5 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |    1 -
 .../drm/amd/display/dc/dce/dce_link_encoder.c |    3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   16 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h  |    2 -
 .../drm/amd/display/dc/dce/dce_transform.c    |    2 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   16 +-
 .../gpu/drm/amd/display/dc/dce110/Makefile    |    2 +
 .../amd/display/dc/dce110/dce110_compressor.c |   55 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |    2 +-
 .../display/dc/dce110/dce110_mem_input_v.c    |   17 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   16 +-
 .../dc/dce110/dce110_timing_generator.c       |   76 +-
 .../dc/dce110/dce110_timing_generator_v.c     |   19 +-
 .../display/dc/dce110/dce110_transform_v.c    |   19 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |    2 +
 .../amd/display/dc/dce112/dce112_resource.c   |   16 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |    2 +
 .../display/dc/dce120/dce120_hw_sequencer.c   |    2 +-
 .../amd/display/dc/dce120/dce120_resource.c   |    6 +-
 .../dc/dce120/dce120_timing_generator.c       |   99 +-
 .../drm/amd/display/dc/dce60/dce60_resource.c |   16 +-
 .../display/dc/dce60/dce60_timing_generator.c |    4 +-
 .../drm/amd/display/dc/dce80/dce80_resource.c |   16 +-
 .../dc/gpio/diagnostics/hw_factory_diag.c     |    1 +
 .../dc/gpio/diagnostics/hw_factory_diag.h     |    2 +
 .../dc/gpio/diagnostics/hw_translate_diag.c   |    1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |    7 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    4 +-
 33 files changed, 746 insertions(+), 830 deletions(-)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Josip Pavic <Josip.Pavic@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: Tony Cheng <Tony.Cheng@amd.com>
Cc: Xiaojian Du <Xiaojian.Du@amd.com>
-- 
2.25.1


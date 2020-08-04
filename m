Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2B23C07E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHDUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:07:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:07:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so32394997ljn.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3azTrGP+LhHvSC09M4k8Vw28GxxV8PL/Fmjx/psKnVE=;
        b=KD3U4/FABUKWR1juhGbVRQ1Y/MC22u+FfGKWnvS2okLXEIMhyY8rJYmqIWpChTclgK
         odWpgxAEob6xjlmB8BrGY+z5JzGAt4USWspVBigQLML5OEhzjUpFl/uH8M3gZ1+xE9qE
         HTsT3dAeJMYYrq2dqC4Ucq0DxpwzlZZUhLzp+0L4fmP5RLUjGR+sYsMPwAXiNbFoNK7V
         1jBmby/vCggXOMFr5DilaagPTwqRsvRpQ0M/YhcxaMxRPaxU4qu705/FOo16JVV98CKv
         +Hncxu27XUQ5LRoaAy8NDMQ/73OgqbafNmuXJe8LKUG3QU4bB2p3IE1kqSlbITTpu1fG
         g/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3azTrGP+LhHvSC09M4k8Vw28GxxV8PL/Fmjx/psKnVE=;
        b=jKP9wK0jOLdGZkV58UM9qdD6UvzxBt5tE6U4c7QOcgGLn4ZX7BkMWO679z7qkHvQZ2
         IMUjETHr+09pkeOCyssk/2t3JQpDq7ghDLfugLMpLnRlMg2w013p6MkhYgAi2nI+BWrj
         nynFUC7m4lA7tTgviqVBep31aesH5GB88b2As3HPzsgE9ARKva+39Cq8Rfc0tfgCg4z9
         uElaZ0J3zcrPXnOym5EMPpvxU9V1Klx44ZVBCc7N/ZDwbj8ZHV852oAxEJ7iwEmfYATR
         AH5VYkC9lI+O8oa8jdZarp3euB7cpNcJvVneEklnDJtx/tndXUwtjYRcVNPTTBKr9B0w
         4pYQ==
X-Gm-Message-State: AOAM531PtDZ2p7KqEAyh02gCdooqoIQP75tIsAMQumWcMtRAUgnnmAgY
        JWar4ztoWqk/oK6EINiB6uU=
X-Google-Smtp-Source: ABdhPJy3AsPNQaIKiToyk18pBgh3WPFP2MudjbtbKX6Ce/AOCPL8HID0YU1jQ5OnAZqwhLBdXlUuog==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr11882263ljg.406.1596571625718;
        Tue, 04 Aug 2020 13:07:05 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g21sm3080020ljh.103.2020.08.04.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:07:05 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drm/amd/display: Constify static resource_funcs
Date:   Tue,  4 Aug 2020 22:06:52 +0200
Message-Id: <20200804200655.30495-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of instances of resource_funcs that are never
modified to allow the compiler to put it in read-only memory.

The other drivers in drivers/gpu/drm/amd/display/dc already have
these as const.

Rikard Falkeborn (3):
  drm/amd/display: Constify dcn20_res_pool_funcs
  drm/amd/display: Constify dcn21_res_pool_funcs
  drm/amd/display: Constify dcn30_res_pool_funcs

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.28.0


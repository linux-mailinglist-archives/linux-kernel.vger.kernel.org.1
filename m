Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB126C828
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgIPSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgIPS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:27:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ABCC0D942F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:01:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so7323977wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIu707qF3XC1wFSQ0JUGDpXqJcRkuCHBFIGNuiyznGk=;
        b=wijQmT9vsB6ZR+aWtfyqwpoZM80cItkpJVGHdMlmCQTeVLozm9Yboz64+dfnBsTDcb
         AQ05GRsBvv1zgg0nM+bVTnixJiEzOdxwjzDEWmRryfrOMR6vKJyM7TlG5B44gUPpkhYB
         cKkzrNChnol0O+vHwKZWC3u3pSpHaY1ytGp+4nMeT2bttuoRS2JN0lmVucAKbZ9mIDK9
         5lJJE0y6YIa/olkfyVVqXwQzQfCSyRzHaXYhTbRiYSQ1yT9l9KlUiYWgrq5vFr9bh4wr
         XmtQyuq7zY7Y59xieNCJKTY0ID76DPAvj4pRWxeyxFu1LbPWGBhJXQXR/0llRYDZiEuq
         5SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FIu707qF3XC1wFSQ0JUGDpXqJcRkuCHBFIGNuiyznGk=;
        b=X946CENa6vrVaxQgwYvOxeWB3oz1iM9TCMacTXiMkj6+cVnBVEcdVeDzz3b0i3GKvL
         ZnI+S/xab8eouhe0dRLsrB6gmfH2mJE/wLJPZUZwiv9M600lhnAxKJLo2CdR1746RqWm
         phqQc9NHXHkszUcwPRac6CI34OqmaAYtbLlT9vhOrD/7h7JuSqO6Q9fPSdcX4a7fR54l
         Bi+8E498W4UrQDvNG8azT70AUkGyW3fyZi8Ik+SABeT/c9b/6gmPgZoSf150skyrnPuK
         U2EcxEp8vqGcchVdz5FTB6IX49tnIxoRZAVwXjPBP0KjyjyVYiaymMfOwxKbjGbBbK8V
         4pdQ==
X-Gm-Message-State: AOAM530DNkR1fQcBBSvJi7mqp9OJF77UDRFdbSRyKPSC1GLCuexSHMWU
        f62n/gGsxT4DuyscyxS2fazzqQ==
X-Google-Smtp-Source: ABdhPJx8Y/UqOEW6k23Aim2WVavTxhbpjN+oKkic+uEsOX4V6GEuQI6WasgaF8S7gi1dWVdYZ6QyyQ==
X-Received: by 2002:adf:9e41:: with SMTP id v1mr29697264wre.60.1600268512806;
        Wed, 16 Sep 2020 08:01:52 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id m3sm33275243wrs.83.2020.09.16.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:01:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] drm/panfrost: add Amlogic integration quirks
Date:   Wed, 16 Sep 2020 17:01:44 +0200
Message-Id: <20200916150147.25753-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T820, G31 & G52 GPUs integrated by Amlogic in the respective GXM, G12A/SM1 & G12B
SoCs needs a quirk in the PWR registers at the GPU reset time.

This serie adds the necessary quirks for the Amlogic integrated GPUs only.

Changes since v1 at [1]:
- removed the BROKEN_SH quirk after [2] was sent by robin
- rebased on top of [3] by steven and moved the vendor quirk in the proper quirk function
- added PWR_KEY unlock definition, and cleaned definition

[1] https://lkml.kernel.org/r/20200908151853.4837-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/cover.1600213517.git.robin.murphy@arm.com
[3] https://lkml.kernel.org/r/20200909122957.51667-1-steven.price@arm.com

Neil Armstrong (3):
  drm/panfrost: add support for vendor quirk
  drm/panfrost: add amlogic reset quirk callback
  drm/panfrost: add Amlogic GPU integration quirks

 drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 11 +++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 15 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
 drivers/gpu/drm/panfrost/panfrost_regs.h   |  4 ++++
 5 files changed, 35 insertions(+)

-- 
2.22.0


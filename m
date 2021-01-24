Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB2301CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAXPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhAXPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:09:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FBC06174A;
        Sun, 24 Jan 2021 07:08:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m187so8392633wme.2;
        Sun, 24 Jan 2021 07:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7mf2JB6YFkZrTT9eOh8fpRwRlqBA16q//wOPgh3f9w=;
        b=LNH33GfYNRs4v32KhZGrq2haAa6pCHeZg293Ea8BzUSeu2hwzylO0rlVHWGCqMZ/j3
         EPUluEZFI/6Q4dDGV1e0U8E/QhIAPMAdnK6Z/Daj3EVB2ehlkPtaNr5FRPCO2daceX0p
         lkqMZwQpYcM49zfxfMHsSXEzNi0F7FXuAnefhkBt3ZEs0JaT9jRTX9TN40TV+/r+z704
         14wYxuNXoiRSuUkhRNufVbulq7pnCmclSKmNZq5Hi06oilzz4fZq1z/FpdOHbQcCVMG1
         OwplXYHCQA+OgtjC0r47gZmpYpcAD14rUFMhRBJpE2W4ICz+D9ljxCUtBm7Y/ujvX45y
         eL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+7mf2JB6YFkZrTT9eOh8fpRwRlqBA16q//wOPgh3f9w=;
        b=GPUg3ul2att9MPIC1Q8GG8kEv+zGsWxB4mbu4JgXQ6P7BHqE7c9NfY4CZEYS7HBHuS
         gO8QpVV0uG3EWs61B3jBA8iyXNHoJoWb+BQtsjM3Ml+07Ug12oVt6S2AyrEXC0p0rVq2
         RfrxPRr02FSMRNTOS3lIz09/30o/rZPqXtSsV7DQJXSYb4d61UddanvQB0LKvuxvHzGO
         QCJwNas5gkyiMTFqzUVQMuCauMHELChEPgS2KBM7b+xievDEDGXGgONarUuuXYdCNjgT
         8MShSL6LnyshFq/aKF2Zm48jvxAQkZREWmBGD6f5/aWuH4QAyB8mrS4rztkO7yG3cD9O
         e4GA==
X-Gm-Message-State: AOAM533pqaRJeksb5IvD/e51pjuhJQ9jLz5IN/hbroIn9jKZj9XcjEgZ
        U9DAchkbhIETHyB85UdDPvU=
X-Google-Smtp-Source: ABdhPJyAmReBbU3ln/hSsIhpgah/YIgPZ86g83LwMM0taGgJ5gMNjLPV5MPbFmcE8OLbiKpTQw1LeA==
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr2999987wmn.100.1611500925353;
        Sun, 24 Jan 2021 07:08:45 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700e58e9e649f9020b2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:e58e:9e64:9f90:20b2])
        by smtp.gmail.com with ESMTPSA id m18sm244608wrx.17.2021.01.24.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 07:08:44 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Sun, 24 Jan 2021 16:08:32 +0100
Message-Id: <20210124150835.1522899-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch set adds the support of the Lontium lt8912 MIPI to HDMI
bridge in the kernel.

It's only support the video part, not the audio part yet
since I don't have the datasheet of this component.
I get the current i2c configuration from Digi and
Boundary drivers.
Developed using the DB_DSIHD board from BoundaryDevices.

Thanks,
Adrien Grassein

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912
  drm/bridge: Introduce LT8912 DSI to HDMI bridge

 .../display/bridge/lontium,lt8912.yaml        |  92 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912.c       | 749 ++++++++++++++++++
 5 files changed, 862 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912.c

-- 
2.25.1


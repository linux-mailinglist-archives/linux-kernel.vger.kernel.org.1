Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C892F63CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbhANPJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbhANPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:09:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771FFC061574;
        Thu, 14 Jan 2021 07:08:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o10so131529wmc.1;
        Thu, 14 Jan 2021 07:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMHpOkpp/Tlyt5zGDdDWC3Ym3fdf3CvDPYvzDLefiAI=;
        b=WRR0pBlL0cOgw4KU8ANiLKeNTJt/3Kjg6yLJr3g2qWuDMQu+bjuW84W31EgVeajhyA
         zjc9bBneUQAXDGhRyW6JN5x/GZwaEsxa2pASlY+9P9KXYOwa0jFSi9rOaVFI83Xjq3AM
         NeeKqPok1SffXneiGrCo2eNrOutSEP08ogoScpYyRoqEqNwgrTDrsCcWqWjzCMbTFnm/
         ZyfACEvwbHBQhgNvgCrdN3Q5OFYScgpGEdDS1c23PawTXlXCBBWwqb5Ht+CwTy6VPivO
         3hKCDa5RRQm0h7kPlI+p4I+OPfMzEShVjfbuiz3BShkTZyW4HsuyNcyHjMzQyqSUttJq
         IpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMHpOkpp/Tlyt5zGDdDWC3Ym3fdf3CvDPYvzDLefiAI=;
        b=pXh4q9pPwiYT9RNCALDUPhm/5j0JdKynviSNUcdJ4Vu68GN8pB/TU6MNN1q8u0azHa
         oXdPZFoG71AEJl3wbqFnb6S+U0eGu0N2NL43XtDahEN8jyjnN1eIGxHAomPXiyo8O2t7
         9TS3ZxlKkqVAgXvJoJgGFbbl7FmlT3alJ6yCqIUibjTx7S8oYkn2vXmmUY2uHGGP50BV
         Z86cn4teC7QA8ELTM/383TfYSmn0NaSfRi0tEdB1UJWtu9vRfJBtc1lAa8djnUWAVG0n
         1sa/5WPTQ+naVP/I1jvzdaclttRSsSbkLQEaIT8y+HCL1+Tf7+Q1lb9j38ydwM3dyTiU
         vZnw==
X-Gm-Message-State: AOAM530Qq6uWpSiVGCMw4/malDy6Py7zn2o+271INOq/jkCdEk6oBaHe
        r3JuB0YSk2HO8wfqdGHoIhjOLcz8dnB6Vg==
X-Google-Smtp-Source: ABdhPJwW+Urj2LKjTq8gGTX8kpHTJlVQcqKpCcoC/wiyDyFknCT6TKWGXXKgNiYFxlthKhpBa1hCWw==
X-Received: by 2002:a1c:b682:: with SMTP id g124mr4456735wmf.10.1610636922790;
        Thu, 14 Jan 2021 07:08:42 -0800 (PST)
Received: from xws.localdomain (pd9e5aa30.dip0.t-ipconnect.de. [217.229.170.48])
        by smtp.gmail.com with ESMTPSA id i11sm8193986wmq.10.2021.01.14.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:08:42 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Fix kernel-doc references
Date:   Thu, 14 Jan 2021 16:08:26 +0100
Message-Id: <20210114150826.19109-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, ssh_rtl_rx_start() and ssh_rtl_tx_start() functions, do not exist
and have been consolidated into ssh_rtl_start(). Nevertheless,
kernel-doc references the former functions. Replace those references
with references to ssh_rtl_start().

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Note: This patch does not change the kernel doc at the ssh_rtl_start()
itself, as there is already another patch for it:

  "platform/surface: aggregator: fix a kernel-doc markup"
  https://lore.kernel.org/patchwork/patch/1364953/

---
 drivers/platform/surface/aggregator/ssh_request_layer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index bb1c862411a2..4fbe58265e31 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -1004,9 +1004,8 @@ int ssh_request_init(struct ssh_request *rqst, enum ssam_request_flags flags,
  *
  * Initializes the given request transport layer and associated packet
  * transport layer. Transmitter and receiver threads must be started
- * separately via ssh_rtl_tx_start() and ssh_rtl_rx_start(), after the
- * request-layer has been initialized and the lower-level serial device layer
- * has been set up.
+ * separately via ssh_rtl_start(), after the request-layer has been
+ * initialized and the lower-level serial device layer has been set up.
  *
  * Return: Returns zero on success and a nonzero error code on failure.
  */
-- 
2.30.0


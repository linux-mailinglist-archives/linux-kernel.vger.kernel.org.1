Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B592F7480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbhAOIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:40:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B9C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 00:39:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i5so5590295pgo.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 00:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdUo99yy+lDCOxyAfmzMI+HeO6P2enB582eqYiApOdk=;
        b=jSw9LxUKrUj2kbaPKLxS/gYrb3WsayE4NlYAoSvB4z6jelQawNh9zMdwNe30Z7TR9P
         g8lvFUwxNcfhEwbCgXlgatuE89YY4DVEjoyUbW1Q6vGEs0y1wNEO2knLMKuXfUE20YNW
         pq/OeXTiHQ4YDhLdCAGOKxarz+gWkZ/Obok3alDL3ykM5p6IidOpdsj8rMMgolA3ooX5
         5THgYnv7cJ9aPbh7w9xcZiLEyA82nF8q8bRiGdXDZkYZ2E82dIMOKujStRjuw3HNGAAK
         TPQDcf4yZ99Qu08Iox8qtJIQ6PmTcDChsuaCRCjmJ6Y2Dg0sBXhnirAqTCLE49cbovq3
         wizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdUo99yy+lDCOxyAfmzMI+HeO6P2enB582eqYiApOdk=;
        b=clRjPxd/aKpCTh6wLUm4QtrZFg3kPJAuTcG4RjLz8/ml2OdixTwpCUmPoHsuF5+Vib
         Zf2NsI4+EGGnMlK5MsI1ixdmI9BJ/V7ekwG57E78ikoHuSf/EFdZxCbca7/dTtTzQeab
         fporNGycX/ZesOoJadeLYCo7Of2r727m55xsvrwuOj8L0Chvp/aiNWVwAjoSeNiHGa33
         U3ZKXSHKaOaoR6gLjEeUvgxnRvEI6Ap07UO3U2yDNbX7Dy5myYpjc6OiRs0PTNcdLsBa
         2j5DSglVoqXu96U2dy8YcPy9Xhw07Icw1lCKvg/ESm1odeFmBkGyTbn9W+xcJfXEqb7Q
         2shg==
X-Gm-Message-State: AOAM532SjtevxxqwrFddFA8/VB6wE3kGz8F7ZwVKmiH9zjaD/9nTHvRH
        DCJikVWSssNIs4+WvtpW6sI=
X-Google-Smtp-Source: ABdhPJx5/dfGixRN8PJ4qEk6Qpzlq7ob9ic3OOtrs18wKDnHhuItn/p77FtFOrj+WChSaK5t73nWjQ==
X-Received: by 2002:a62:8683:0:b029:1a3:9879:c326 with SMTP id x125-20020a6286830000b02901a39879c326mr11654251pfd.72.1610699985843;
        Fri, 15 Jan 2021 00:39:45 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e13sm7748155pfj.63.2021.01.15.00.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 00:39:45 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Bin Ji <bin.ji@unisoc.com>, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
Date:   Fri, 15 Jan 2021 16:39:33 +0800
Message-Id: <20210115083933.50522-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Ji <bin.ji@unisoc.com>

Add ETM amba id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).

Signed-off-by: Bin Ji <bin.ji@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b20b6ff17cf6..66c6641c71ea 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1709,9 +1709,11 @@ static int etm4_remove(struct amba_device *adev)
 
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
+	CS_AMBA_ID(0x000bbd05),			/* Cortex-A55 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
 	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
 	CS_AMBA_ID(0x000bb959),			/* Cortex-A73 */
+	CS_AMBA_ID(0x000bbd0a),			/* Cortex-A75 */
 	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
 	CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
 	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
-- 
2.25.1


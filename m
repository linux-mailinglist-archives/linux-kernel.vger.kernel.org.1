Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C52F9A43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbhARG5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbhARG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:56:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4A3C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:56:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y12so8868584pji.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weuvAfNnNCd2tmWpXq3kmfhtbT4oAQK64i4pkJmWrFE=;
        b=i+QhsRG2ZMGUDhb1vb8PajpEZZis3eqdSvZZha3zhBRhhj0FvyGZtKVynzY0WRThai
         7H1I8LhqYwpeG6RirNdonVVGSuyvUvz7N0KJEQ4rr9vDfY87A4QKuO8KDcqFEtAIyksO
         TiTPyvsLQbUPs9OyDtXW4DnboK22pNPYkEQeWFOkf1Qq7Cv10cWo8MI/I87ZayRxho+P
         Cyi9AusxBmW1hoE1DNCyWI9lapOFBr4lrF58S2OpjeKLsiiaCBxsuHOU0PrKrcw9INcS
         kRTkFSm03WMQlZE3CaKx1g7jYmNE9qxun8p1NK5ZKphZ8bhMFexSe5z7PNfBYPkB2lpe
         O6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weuvAfNnNCd2tmWpXq3kmfhtbT4oAQK64i4pkJmWrFE=;
        b=rMN42ksdIq8Cqeg7eD85kbzAT+xWeVeIIFBZOcnQgcVycK3H7AvTnYWz76ZcBB6hSY
         S3yjACBeO2zvxmYZZkGp9Wg0S0VoiPgPXpx2wTmVZGVvo4aCir3bzsG53uNHJg2yNI69
         3RSDFyuIoZynseqkLskXweGWrqtO/ZcxmGvR3nHZiqUePz8X+V54TJz8UGJuqnuHp9+i
         PE3oIjuy2G4cmjQ69JPCApZQva5Exe4zQV/7eH472OyTOt/f9aHJI0bw6rHK4bGNvB5A
         Ki35pLa6AkUWD2QuWAPlblXW1w2XeH8q1guvJUMDN5soZ0ADN6X4od93vD3/xhQMMCPz
         xsTQ==
X-Gm-Message-State: AOAM530EjxcGvBtb5+NJL7ptZT+HIsDLTIcQw6byT/aJ8b6Wdb/RS9a5
        jGCqr+VX7rPJIFpVCT0lCI8=
X-Google-Smtp-Source: ABdhPJwxLh/1BYpv6UTij5rNeZIDjgF/KHDL+Oy3mRvOIsEdHeQNY3H1caeFlSzKwpnYClbmrpUkRw==
X-Received: by 2002:a17:902:7102:b029:de:aa85:e04e with SMTP id a2-20020a1709027102b02900deaa85e04emr4426741pll.23.1610952967127;
        Sun, 17 Jan 2021 22:56:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j15sm15132277pfn.180.2021.01.17.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 22:56:06 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Bin Ji <bin.ji@unisoc.com>, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH V2] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
Date:   Mon, 18 Jan 2021 14:55:49 +0800
Message-Id: <20210118065549.197489-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add AMBA UCI id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).

Signed-off-by: Bin Ji <bin.ji@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes since v1:
* Addressed Mike's comments - changed to use CS_AMBA_UCI_ID().
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b20b6ff17cf6..8c4b0c46c8f3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1713,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
 	CS_AMBA_ID(0x000bb959),			/* Cortex-A73 */
 	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
+	CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
+	CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
 	CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
 	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
 	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747982E2CBA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgLZARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 19:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLZARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 19:17:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:16:58 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a4so2629435qvd.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=BeBaoXbPcQYJtiHOkSmFqWsNuiuRoYigVpC9YCPgZstszhU4nVwsOU8TS+kkOCHb14
         NAqgzGg7v9MM7PJkETQD4V3LgJvi+JsKFbGVok4dfOKIhIT4cfYNX1SzkjmTJzOLT2J8
         iAGIdwY0A9LbKj1UDwH4paWTesmdvCam7s11p4cGaJlPv+Ap+eOdqzJuFuiDOl1Qic7N
         PFI1jJTwQoscTP29stL197fTiGpfcPVZLqAnSMKbB8dTFubSHI0zJbFy2hTOeHo1yjvQ
         CxpTwjwxddjyEnO8QNzD0vDeWK5SGWZnXenXceec/NI/FQh4il1NEf4VKicRL5CSAIIW
         j77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=ecjIVQCNL9ziqn6UZPVhUvQhjXC2t7bymBAewhZel9ur+jTehJeRvBx7eIMxdHC/TT
         7AxFIbRSl+IdfPvHHDN+P4bGrlzG5nxGoa++GMpN22kmD7C66OLLpFrOQqWFajRUJEbc
         1veONDYbX0Wx/MMQjM4fQ/q0G39IWtdHHtpjXA5bIMWNSrFu/ZPNYmLYW6ZmX93tdAsz
         CQtgRXjfMoeQdCf1dQm/V157y3+tF6smXmaZ12NDv1RIiWggQkYe1wdIebm1JtHsOIVs
         ktbGYk1x7fFdttukMN9NXZD5Iqy+FQPeRiAZ5TmZW+dLTOZCP22P4g/HjOZZBZXKpNlH
         kIng==
X-Gm-Message-State: AOAM533nZ00eS/5yqKQYyD9z8GbI91pBQHM8MWEqGR/sd2g2FzzCJh/T
        +KG2LEN4CYkistSukVCpNE4=
X-Google-Smtp-Source: ABdhPJweMNUt4ABf3/hN1Dqo4NR4y9MimdWypTp/vqBaAG879wlsbcIb40sWcEx+2RGvUIVJYncmOw==
X-Received: by 2002:a0c:fa11:: with SMTP id q17mr37205644qvn.55.1608941818286;
        Fri, 25 Dec 2020 16:16:58 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h1sm18645425qtr.1.2020.12.25.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 16:16:57 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v4 2/3] drivers/soc/litex: separate MMIO from subregister offset calculation
Date:   Fri, 25 Dec 2020 19:16:48 -0500
Message-Id: <20201226001649.2061703-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201226001649.2061703-1-gsomlo@gmail.com>
References: <20201226001649.2061703-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate MMIO (read/write) access into _[read|write]_litex_subregister()
static inline functions, leaving existing "READ|WRITE" macros to handle
calculation of the subregister offset only.

NOTE: this is a non-functional change.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 include/linux/litex.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/litex.h b/include/linux/litex.h
index 67c1a18a7425..918bab45243c 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -24,11 +24,23 @@
 #define LITEX_SUBREG_SIZE	0x1
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
+static inline void _write_litex_subregister(u32 val, void __iomem *addr)
+{
+	writel((u32 __force)cpu_to_le32(val), addr);
+}
+
+static inline u32 _read_litex_subregister(void __iomem *addr)
+{
+	return le32_to_cpu((__le32 __force)readl(addr));
+}
+
 #define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
-	writel((u32 __force)cpu_to_le32(val), base_offset + (LITEX_REG_SIZE * subreg_id))
+	_write_litex_subregister(val, (base_offset) + \
+					LITEX_REG_SIZE * (subreg_id))
 
 #define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
-	le32_to_cpu((__le32 __force)readl(base_offset + (LITEX_REG_SIZE * subreg_id)))
+	_read_litex_subregister((base_offset) + \
+					LITEX_REG_SIZE * (subreg_id))
 
 /*
  * LiteX SoC Generator, depending on the configuration, can split a single
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA431A2415
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgDHObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 10:31:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35828 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgDHObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:31:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so8095164wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xX9cl4CH1nYfDC9Fl1wNJAbL90tz1WTwrpphigm4+/8=;
        b=dokhZuGHn3YLgiexL6ojGAsBDvbpi37YlNqt+fqT9Zr4t+OFx4BO+otEbEobC1U1eg
         poM7omWb/sG+xbWI+TBJz10buBRVHGn/KPn7vUbmvv4QzDftiwX7Qm2w5kCmWmLeoKHw
         mqIy3bhvoQxLTKo0FAq+lDRiAjcShG4CFQb7gaAtbvThT8l5vupBNgUilcAvb78SNpCi
         ZI4jkg3avkm0WhjyKV/QkC2jMSbgcTo5oCh0ZPdIW825XOv7g2jsuksv/uf7I0HrtuCH
         w9pHuhTEIaXWCIQXSn7aikv4LLimat8TrYCSV2WBB5p2W5zYZfOcFpHIAnuSBvmsw3sE
         JHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xX9cl4CH1nYfDC9Fl1wNJAbL90tz1WTwrpphigm4+/8=;
        b=R6QaYsbZoyLHozNB7hYbFHf0Bh2nyxblnPBdg/TBO/6v0lvQxjZWaIsPPR9v2shKbi
         ySJdaES+ID333wrRZU34Dwp8GaDMtgPG+5KASzMmZ1AUPW3SnvSynq2a11Mq8aVRuyEs
         jAzzNp6n+nVPYwI+TaBloY35fUnDqjOA6quE+qdv2PcpMmnlRB2nLEaZF2m61ulIgA/+
         P+qG4maWZrIU79owz3uwZtxbKpgtgVY/VgQhe7yoXyPTh4eD6HmztiPrXnfMRjqrCnuh
         pRtsfIj2CxZZOP+IwE7q32exIFd5zWSOQa8uH4XiylA0QgmXoWnPXFg8C9Dmlxk3VeKn
         jYLQ==
X-Gm-Message-State: AGi0PuazoUiPdv2bg90RxlaPeLOO+9LGT0snYfLL0YCqOYrM8p7XnwIn
        aupE9Qu5xj2bO+HFi8/nOi8=
X-Google-Smtp-Source: APiQypJcxfSQPdgfzVfTtaoDkE3q1F0w92nKE2PFtLR0RsytN1eenLMrY+ja3hE88v1MuuHborgwkQ==
X-Received: by 2002:adf:9022:: with SMTP id h31mr8520524wrh.223.1586356259396;
        Wed, 08 Apr 2020 07:30:59 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:58 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 4/5] arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
Date:   Wed,  8 Apr 2020 16:30:39 +0200
Message-Id: <20200408143040.57458-5-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Completes commit b925adfceb52 ("soc: renesas: Add ARCH_R8A7795[01] for
existing R-Car H3") and commit 361c5dbb446e ("arm64: dts: renesas:
Remove use of ARCH_R8A7795").

CONFIG_ARCH_R8A7795 was split in CONFIG_ARCH_R8A77950 and
CONFIG_ARCH_R8A77951.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes in v2: None

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ac0dd3dbbbfb6..4a361734cfc71 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -849,7 +849,8 @@ CONFIG_QCOM_APR=m
 CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A774B1=y
 CONFIG_ARCH_R8A774C0=y
-CONFIG_ARCH_R8A7795=y
+CONFIG_ARCH_R8A77950=y
+CONFIG_ARCH_R8A77951=y
 CONFIG_ARCH_R8A77960=y
 CONFIG_ARCH_R8A77961=y
 CONFIG_ARCH_R8A77965=y
-- 
2.20.1


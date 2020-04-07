Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCAE1A0C12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgDGKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 06:36:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgDGKgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:36:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so3235458wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ol+vaCJYJOmb17xQ0UGT+1HdKXAsk3yj2s/uWUmOiBs=;
        b=P8ntfIrzx7XCkvwrKYcQ2SFWvNNUMcR0yVny70SYCfEYYkh3uIZICwOYbT0IZAtmDS
         vIXxJgPS08LBuoNOlTx9ZxzVQgvZ9sRVHYzqHNzQkWYnq8U1dR4xsnnk92Ihdv/mC7b1
         FokX4LcFfBbWxXIeV+fRm72GjZh+Y5YUhA8etckXplszoVEL6XLGexmEUaAhTCMXs8uh
         CkjznhoyaNlQPjoz5EHjjiteARj5o0yzvigTPX5roMYiFjLY9yXlJpwWjg0szsYTbJo6
         /cjNieLchRC5jJumDkT86Str8t8J/ax2AS5ZcWRaMHWOuSh03KPS3tKNElNSK7YDBgMZ
         zrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ol+vaCJYJOmb17xQ0UGT+1HdKXAsk3yj2s/uWUmOiBs=;
        b=cFO2o/GH+JGn/WoD9X9SYZlf1adNgGLaMzxaJettbKg1jwUKTif8VdU4s8i9mZh9tx
         cGibEj4eoWjlb+yVwJ7UXo1FdcepD5UwhCywjGciBzWOh2dCI1nmfm5NTNXaeIL8nQ3u
         lvh9R+fTjsF6pveEXUz62NsCLpz/hcWyxJWULKBG6yfghzsCgM88zrTYbPsjdj90WU6u
         sBJuckQP4whHh1VwuyfxqTEUYKIq1t8kBQeCABRBTI28/TjRXfpJEvXL7MCOOtaIVK5P
         gx1kMtUn0AruKtvKsD9YfVm5vHCEu3NQfVv0is++mIPPbCt/sr5VVWnifmAj8xdHuh49
         qkzQ==
X-Gm-Message-State: AGi0PuZvbQ/NUR4ibl0evHXroKmB/wrfe8gnfTKbXfk4vITzavZFOF5w
        RW4KuR14n7Yu7jkqKRdxdnw=
X-Google-Smtp-Source: APiQypIeZi8S0XuxSx9RZsD0A1xI/nmNPgHIHvzHTmy2n2WZAOlRPEd69ICfvzXVEFNtF/MOb76x5A==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr2100522wrt.67.1586255807938;
        Tue, 07 Apr 2020 03:36:47 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id c17sm25016722wrp.28.2020.04.07.03.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:36:47 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 3/4] arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
Date:   Tue,  7 Apr 2020 12:35:36 +0200
Message-Id: <20200407103537.4138-4-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407103537.4138-1-max.krummenacher@toradex.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
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

---

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7e2690b449328..d43bd18bedf1e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -848,7 +848,8 @@ CONFIG_QCOM_APR=m
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


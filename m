Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA51C2C48CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgKYT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgKYT6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:58:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16803C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:58:22 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c66so3359677pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=C2+gt+4Vla//T43iYMds5MwFx2eq1rtnxCXvX+Fkws0=;
        b=bkwK4VpAVhpMM3mZ3JJJcmL343wveYoNrYyuIlWQmGg4j1plhP4wSFrAjNzOMXDQpf
         m9ReO05eTylIEKMQzdbdymApGYTOt67PHKpv90bOeeO7LAqz72AyLZMAXtv5K05cmAxg
         BlJNe6X2Qs21GzTvsOSikAiT0nzcvLY+AyG9hCAILK2jwtaXD+6PmYeJSN4+uzwRmTkn
         criW1cjl3xrjB2HxAFZOguPwlA2pOXImWlekQjswDHxG1v7x8sFO26vLpBNzwR9+N+tn
         bHY6sfMMfEOXuDhZh3LRbzgLsy66nQDxlFB9dkJXMO37YnRoM7qOD0Ff0lRQHnc1VgbH
         R1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=C2+gt+4Vla//T43iYMds5MwFx2eq1rtnxCXvX+Fkws0=;
        b=AVGC9/dmiSRa9bxue23hNoQMlGC1ywJetuowbVdlIH5CTchTR9HBWihk4HTx7qZ39f
         I0wCTHCZVIYiGIAYjfX0pk3nQ7U8oWy2g99HsP6U8puEtxiEpEzTmV3J98AfQRKaerbF
         ITz8xeOUoFUkFY2nWk6Ng3bZOqH6iX6m756O24pdM0hQgLOZ/gUgheOOtwFK91h3Qcrz
         Grmt7iw8iDi4548EUfXDFrxBeKDAr8C+4IgR3kHijtIWLxr+bXQKGNsg7Dpm/SGDnDiB
         0b4RHA/k7uYVOih+qXy4aD61cAGRMtGIabjuy4/oPNNugNXTCMwEPe22SuEarJrfF//A
         vOPw==
X-Gm-Message-State: AOAM532G8+LEAuNKHs2+e5DwxGK5QB7fqW3iI7Uv1eKh+ZfyfhD80xWL
        n4hOGMqby064fEQYhmLVH1UDXw==
X-Google-Smtp-Source: ABdhPJy0oBUqJ5zTUZSRrrCi7ojhyvNYwGOkozXDmt62EACijfKH/cgNzMmUvBT8QbvfsLJ7X71ZVQ==
X-Received: by 2002:a65:6401:: with SMTP id a1mr4400231pgv.149.1606334301571;
        Wed, 25 Nov 2020 11:58:21 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id cu1sm3626192pjb.6.2020.11.25.11.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:58:21 -0800 (PST)
Subject: [PATCH] drivers: clocksource: timer-riscv: Depend on the SBI
Date:   Wed, 25 Nov 2020 11:58:04 -0800
Message-Id: <20201125195804.3780975-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

Fundamentally this is an SBI timer driver, so it cannot be enabled without
support for the RISC-V SBI.

Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation for M-mode systems")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68b087bff59c..3eeaf0efba8f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -655,6 +655,7 @@ config ATCPIT100_TIMER
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
+	depends on RISCV_SBI
 	select TIMER_PROBE
 	select TIMER_OF
 	help
-- 
2.29.2.454.gaff20da3a2-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E271E66AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404715AbgE1Pr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404693AbgE1PrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:47:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C86C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v2so8622534pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rABvwzpSHjK9Um87JqwSpNf8fC8athc+8D0QEbmnNrI=;
        b=IZc05fC2hVRUdUctuTSvYWOzikAy0ps/zfWm31qMoGvq8hMp11Ml1/B1izUv24mB/z
         qjx2bsJVmW1srtAT3T+hcQdqnAHP+f8TCZnv0y1UqVS7WbEAxeRk/WqixTbiB8RL0YY9
         m8mWtnqA2MudUteutSztsLrsBGssFZyvS+onP1qztgMV+TgCpQxVFzTQkLZOzrGbkGc3
         zPGdP8Fhnmfk91gHo3mKGpbZ2X+X46tO+8LcM0LCAdZCyS37HAvaUVoVl66RSVlIbIdY
         eV6hRazLof97B8v4DgFZjJMi5fpUP/cmI439a9eTChRUvH1T2d9c9BKt3dPvlm0Yrqxh
         7j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rABvwzpSHjK9Um87JqwSpNf8fC8athc+8D0QEbmnNrI=;
        b=lBN4ARwNuzz9XPcMr9HZzIu4L0KwnufBzlx9cvmfPXv3Y71vt5lyx0fVIF6mwXHXoV
         vNTyFH+y8eLhNZaUUO+Fgjb0H7sC0S+z8m+/Ts6roHyq6fNI9i49fOxjotqxj6ObUnMY
         7EgznhHwd0MwLzkc/9R0lSkKIRE6pHKE4b7ZYwKqX2JmRHr2Ike56HNcUp6yAZDywyvQ
         YAh6OH6jcvz7POEbpT93rmLjyyGK4bFF5pjX8pD63TsrZBiUSPNWPIFHka2U6VU6wcjw
         kQvQXsXAS7bFIwdrb+yWtK0Rn6NzInaI9bWAvBjwUN0BhfK4ZAZNHTa0BM7/gKuzjPy9
         zuuA==
X-Gm-Message-State: AOAM530AcTGpSOyPF9jzAy4Waq2FpYz7JArSXLoSTOaMfpTJ1AZijNBC
        ehohcCRVmIMYRBmhgT6OgKoxVQ==
X-Google-Smtp-Source: ABdhPJxdahc+f9DIB9SjORBE5j/wBNbjZIfowfCBK8fCGznSzu7kQcY5h/uN99JQRFhu2gKfrlSHyQ==
X-Received: by 2002:a65:534d:: with SMTP id w13mr3471439pgr.18.1590680831305;
        Thu, 28 May 2020 08:47:11 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id y22sm5212551pfc.132.2020.05.28.08.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:47:10 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 3/5] arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
Date:   Thu, 28 May 2020 21:16:23 +0530
Message-Id: <20200528154625.17742-4-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528154625.17742-1-sumit.semwal@linaro.org>
References: <20200528154625.17742-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

This patch adds devicetree nodes for LAB and IBB regulators.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

--
v2: sumits: updated for better compatible string and names
v3: sumits: updated interrupt-names as per review comments

---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 23f9146a161e..1a72fe92f1a6 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -25,5 +25,19 @@ pmi8998_lsid1: pmic@3 {
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		labibb: labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "sc-err";
+			};
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "sc-err";
+			};
+		};
 	};
 };
-- 
2.26.2


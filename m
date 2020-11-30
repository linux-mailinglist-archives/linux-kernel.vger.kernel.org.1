Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990442C84C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgK3NLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgK3NLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:11:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF37C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b23so6442553pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Dt1UKiHvns/wxXXTVZSOMf0MQOF2uaj5QHuWAWvMyQ=;
        b=PAFSo2jPfTIedfGf4MbJ9wcs5CKL5vw7Olli1viJ6nQDcLZv45ihpuSWTVRfPzEC5R
         YoEa4rairAYE4RKF7IN7Gm9U00P0wJ39X43ACor5L6YUicIlyqT21t+3zDUg4GXCbbF/
         chx87dYzAMl8km/aqwTLDQGytETvscHziSGrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Dt1UKiHvns/wxXXTVZSOMf0MQOF2uaj5QHuWAWvMyQ=;
        b=aszLyk7Dsy2Gd7Nm29luXpyCPE+SffvYWq88GBw5Gcfc0xmydtwOhGibQ0Gt7QAHSQ
         wLjxF3qnKyceLiYjvU68u7YLvYZnhxSBVelJpqu9oxVeniW3C2S5boDNeHAxu1ZKPIGr
         ARgFWirauZDXimxkIIfdurzl3JFVuEAS7KJMdTaTZcSdde7cYsLoArGPU9qjCYF/zpIV
         z4PCniVf7aVb+nnucSOcPu0Omr5FhK2rmGwAreGvL7xPdOK68ihr+auPuO9zrBNMU+xl
         DnnTWtAkEp/H2YVEoJF9YePVQToM3MwhYwEh5WuaNPpRXwO8eJIMZ2B0F9Nl4+2591FB
         Indg==
X-Gm-Message-State: AOAM530X4qEwot/CkT1/j6LDtDRhiPfEmEA4zHqzAz/vIofX5n57e8Z9
        4NzaT1YSumiCmNcHt2ggQsaJY6xSQ59e3A==
X-Google-Smtp-Source: ABdhPJxPYkPMleNdgWjsNJzlc+Sz4rGh3xYQQ44QmpGc8cTHgk7td332Ccj3Yu13BbgXQJ146MVs2w==
X-Received: by 2002:a17:902:9f8b:b029:da:726d:3f17 with SMTP id g11-20020a1709029f8bb02900da726d3f17mr6687213plq.35.1606741860095;
        Mon, 30 Nov 2020 05:11:00 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:10:59 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 2/9] dt-bindings: vendor-prefixes: Add honestar vendor prefix
Date:   Mon, 30 Nov 2020 22:10:40 +0900
Message-Id: <20201130131047.2648960-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Honestar Technologies Co., Ltd.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8470..a6cf2cef6f89 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -451,6 +451,8 @@ patternProperties:
     description: Holt Integrated Circuits, Inc.
   "^honeywell,.*":
     description: Honeywell
+  "^honestar,.*":
+    description: Honestar Technologies Co., Ltd.
   "^hoperun,.*":
     description: Jiangsu HopeRun Software Co., Ltd.
   "^hp,.*":
-- 
2.29.2


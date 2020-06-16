Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794B01FB022
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgFPMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgFPMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954CC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d6so1488374pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Im+gWXwz9xrt/i5JNVHGmDB8gIP62Jly/iM3EIi0NBg=;
        b=XYOS/3//CEA68v+h5ngRHMKXDOo7bWl8gOA4MxY7IFFhBr64ctPeOjbdTHTw+cO2i0
         qSghunqiPGyKUL6GxCGttew8Tst+2b0tT+u444JO6vUfdlf03BIeFycb/Kt8E5xvo46Y
         hbXIctmm+yhchgtjbUEFjTfyv7YPB169kf0+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Im+gWXwz9xrt/i5JNVHGmDB8gIP62Jly/iM3EIi0NBg=;
        b=nqkWaZwlSpiycv2l0PEZjgd2neU4FcQ+ylwZX5csLKpiNt+M4OqQ7mFCflhyT6/iUz
         +vUTvEnPaTksXP9GFfLKmASbKHkqHBxYJ598XZDiN7nI+JPuLBppBnOMmMDmcK8vGC44
         W56wFtsZjjEg6cZrc19nykHUHW8J+TLTVwaTB1PwqTJjsDsSuLgPL64UOqReVQdTE27L
         YnNv/ft9p78aR01WX1aEVJ9jZc9jkJdR7kmAXuaAhF02ccN6BcELJmLRWNcpVxFnikPH
         WI0CN6Ggss1G0fKSC24LsmSNTttojycYRscL5IBwRvIsc40+Ovjs9rpzbBSFwct9S0iI
         es9Q==
X-Gm-Message-State: AOAM5322MB4fAtMT08jl2KwcJaCEv2QqSPIHYtYUj96kWZqJVjiFsNas
        jugOTmp6TIA6LcZ6uut4TYh/8w==
X-Google-Smtp-Source: ABdhPJwaPXD+3UGrbUOue2kQH1OEHemcgB9H5Q7Z04moIxoi/6LLQ2MgiaKS6I+q8uTmAUSpd8zc6Q==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr1819369plo.289.1592309832346;
        Tue, 16 Jun 2020 05:17:12 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:11 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 01/12] dt-bindings: vendor-prefixes: Add mstar vendor prefix
Date:   Tue, 16 Jun 2020 21:15:14 +0900
Message-Id: <20200616121525.1409790-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for MStar Semiconductor, Inc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..b09b6c9911c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -680,6 +680,8 @@ patternProperties:
     description: Microsemi Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
+  "^mstar,.*":
+    description: MStar Semiconductor, Inc. (acquired by MediaTek Inc.)
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
-- 
2.27.0.rc0


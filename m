Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B52CA425
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbgLANog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgLANof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:44:35 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDAC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id l4so1223098pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Dt1UKiHvns/wxXXTVZSOMf0MQOF2uaj5QHuWAWvMyQ=;
        b=s+sQYh9u4PNPxijEivUJmC+SmfbhXD8FTmrOqhu9dToUrWo5DfciQQJdy4IbfxcQ8O
         AvhBgVMH/tidGkmkSpJtKl6wamNJiCATDJRvLEaPd6mdat4f0wIX9IBlLAlYf+iT6TbR
         9+uWSA6ucNTLiF3WfGTsnnNF3hWW8jRU5yLmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Dt1UKiHvns/wxXXTVZSOMf0MQOF2uaj5QHuWAWvMyQ=;
        b=i1Akn8Ez17rOluSgNsCVJyS6pSwwYAwvzAndrnqF2UuTu42rqXlBC4iRgGRUKmKIeG
         S5Yjdw/IOpfmshmGQJTRqmU/YzCSqUEsfDvLAVvG2GqfsU6PF8ZjzeQih3xUR0+AlQ4i
         D8vrQFTloZBK9jXUxTKLVDslXVteM5rb/ZIYSci+wOHtbv+8FVJOUl5W0zaF7BSgWYuB
         7rFNcOMA2UdDZCedbjUT04QF+GEWL9mK2lXgp6Uztag7W+EGDolIFbB5aHrOkVzxufLU
         0otrqFoMZ2U8OTfRZwmbWf0Uc1oX3uec2YTd9d069io1csfwV5IWONRBHRgDm/Bwyq4d
         iB5g==
X-Gm-Message-State: AOAM5326oltctsBfwbJqk9wIAWukmAO7ypwB1Xg/GPiUhbybHbuIXUVw
        7OD6lBsORbAU6FldC4eGZz/XoA==
X-Google-Smtp-Source: ABdhPJz6Fbr0orPaVYv9paiSOtvGm5Y86cBYdh70h4VRs2mpXlZ7xEcjl96/rs7H5GIcwZsfby+XCQ==
X-Received: by 2002:a65:620c:: with SMTP id d12mr706840pgv.220.1606830223429;
        Tue, 01 Dec 2020 05:43:43 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:42 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 02/10] dt-bindings: vendor-prefixes: Add honestar vendor prefix
Date:   Tue,  1 Dec 2020 22:43:22 +0900
Message-Id: <20201201134330.3037007-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
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


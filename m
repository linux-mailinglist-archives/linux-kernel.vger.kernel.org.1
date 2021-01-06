Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C42EBC16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAFKFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAFKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:05:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66752C06134C;
        Wed,  6 Jan 2021 02:04:55 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y8so1303595plp.8;
        Wed, 06 Jan 2021 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Pej9jARriZ60BGVv7VhJZA4YZIIR87ryzdHLJ898Gs=;
        b=qihXTtjayFq9zn0t44O/83bH0WSoSXTM59I/yKjBanvKKOYP0dJ64oAip+k62qUN+f
         1yqmVSb1y3iXx+h3RmKkuFPXVZE7zKCnqs7N2wBmGuUq3j+7ezohDYsgtDDUnruXt5Hu
         BeawabdFkJgCZ+sZVkTUqBtpWCnzrdVBirsiGMd5XB5m4yoJEnoKl0zBWo6VowpSa3a9
         XbP2uoIxdmXD+IBb32ZZyACAAI45wxouyQG0Wko3u3p+zCd9LxzFe8JoK0mNGrQzZ9SC
         uab5KHT0xXOzlqfUifDFP/K2OqSDdPH71aOiaX5Lw43POnwL7mnL6V8TzhXvD1WTucj8
         j0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Pej9jARriZ60BGVv7VhJZA4YZIIR87ryzdHLJ898Gs=;
        b=lJwQu3CTwF+kEcMF8NYSXclZY4Nc6RCv5MY2fP7xPeiY24IzZhEZy0JYOjpCnzJs1d
         Z40eicJBvEgi4JPfeJHuPqlrcEtw64OR3dkBKUC3LedTr6LELxDPb2QFssv9QDCpsAxo
         cfdlSmyoYRgZa4nvTG7R1s/IexekXSPz7EC3jK8l0xA4Pq1espXAzyK7tkx5cW27h5i8
         Oo53OJwblRwTJkEJVL7SL+YIcPvmM448WYAWY8Y8jw8gh88g61FGe/UVkmAmHTCS6K7O
         +xhecg6cx6swBumSK8+ZJDwEfepbPmAI/ukCClqU/CdOFhCyUZqJ5LMv3IJd46jFCYkG
         +VWg==
X-Gm-Message-State: AOAM530j6vc0ZnfW6guE8lrvnYnxwHnP8dnyn4IYqleQ/dD0GI1O5iBv
        +6pvFDNeRPq5VQAQYA2mDBEMSkpfZswbGg==
X-Google-Smtp-Source: ABdhPJyC/clUeUiRBbXb8C8snoHqdCBLaw4ar7BFHJNnUaJyNqzVWgrLurrwEuvFtXebc9nIqF1D6w==
X-Received: by 2002:a17:902:aa84:b029:da:f114:6022 with SMTP id d4-20020a170902aa84b02900daf1146022mr3449170plr.46.1609927494999;
        Wed, 06 Jan 2021 02:04:54 -0800 (PST)
Received: from masabert (oki-109-236-4-100.jptransit.net. [109.236.4.100])
        by smtp.gmail.com with ESMTPSA id i10sm2197261pgt.85.2021.01.06.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:04:53 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id B4C52236036D; Wed,  6 Jan 2021 19:04:51 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH/v2] csky: Fix typos in Kconfig
Date:   Wed,  6 Jan 2021 19:04:49 +0900
Message-Id: <20210106100449.237875-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <ae3672c0-84d1-7ee5-1858-33d119544906@infradead.org>
References: <ae3672c0-84d1-7ee5-1858-33d119544906@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/csky/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 7f1721101ea0..e6ddca10e3ee 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -243,9 +243,9 @@ menuconfig HAVE_TCM
 	bool "Tightly-Coupled/Sram Memory"
 	select GENERIC_ALLOCATOR
 	help
-	  The implementation are not only used by TCM (Tightly-Coupled Meory)
-	  but also used by sram on SOC bus. It follow existed linux tcm
-	  software interface, so that old tcm application codes could be
+	  The implementation is not only used by TCM (Tightly-Coupled Memory)
+	  but also used by SRAM on SOC bus. It follows the existing Linux TCM
+	  software interface, so that old TCM application codes could be
 	  re-used directly.
 
 if HAVE_TCM
-- 
2.25.0


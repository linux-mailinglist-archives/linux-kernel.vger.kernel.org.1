Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B82F44D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAMHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbhAMHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:06:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60CC061575;
        Tue, 12 Jan 2021 23:06:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so560388wmz.0;
        Tue, 12 Jan 2021 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K6LXLHuWbF+xM2SfRipuVJYLEQmCNog+ujbAtjwHjzo=;
        b=Zhax2sWm7ZDLEzkyANWjjwnitRdN1lFpLCw+4XU5kgh/hfhd3jy6HrKhWjX+FEp0x+
         i4/XSoiX4BrLXsK7xjdIb10XHx2M7/MznrSCzwFolANU13h/8cpTUAse2U9xVjTrkvnQ
         fuC984HCYfcYwGym67/aV4BPrmPjbDq2HNLXxM6CrPal7qJS0Jbid5F5Lt1KufN5OGT6
         EyQyqtkOCBGfKjh0jyEhGZnBBhRHKKW4+xjI/EvSqaYjAsFp+lGVfGyVgurvV7gbFXgR
         9l7KqGAjOZmADAjbZcJHDys0w5w65YtzwmKgCP9y70Fini+uvTFV71GJycIJmOR3QOkd
         M60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K6LXLHuWbF+xM2SfRipuVJYLEQmCNog+ujbAtjwHjzo=;
        b=EXvkVI3R7jvBa3JZiQ4k1WXGowmIpK0rmEXysn2egFoZeTbOn4uVDWjVAjvpC3OjvA
         GAmosjvwahwUqymxAauDyq1+zowBp8q0Oy05vHjGfp2DOe7ohLPW7NgGEou7ZRbGZZss
         XnUVSdlIfGlxqeROKAQU/BixtAupPqjJdMj1l67XYsTlqc2goR/DfMnEFQzrqDVsUET7
         B1RgU4Yr/m//IjnVDAaLVb7wZ8kzQHdd8ABuUDD7ylmJtOEsJYwqmmt3aZHJXY8sQCrc
         /XseakhQ0YkusOKQqUwSNmEW3TNq6vDt5YE52EnfXR2G9IZsioRPbqdeOWCRuBYxGI6r
         cz2g==
X-Gm-Message-State: AOAM532b4rGyoxrdNkZfzuKgwTUYCdiJFDroZ7NJvEfD2Mn+nlRjSMft
        myMm77jiqxS6KQcPOsEJGY4=
X-Google-Smtp-Source: ABdhPJyvPrftwrv0Z/YTop6vlMbiZwyo5t/0RulUbrFKB3GycoWYphh7SmtQwr9xAxDdNRQTcj5vKA==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr707547wmu.105.1610521565262;
        Tue, 12 Jan 2021 23:06:05 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dc9:b100:30ef:8b8a:711:895d])
        by smtp.gmail.com with ESMTPSA id t1sm1584623wro.27.2021.01.12.23.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 23:06:04 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for doc-next] doc/zh_CN: mips: use doc references instead
Date:   Wed, 13 Jan 2021 08:05:57 +0100
Message-Id: <20210113070557.28792-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chinese mips translations refer to non-existing labels in the original
documentation. Hence, make htmldocs warns about those undefined labels on
all files in ./Documentation/translations/zh_CN/mips/.

Replace the references to non-existing labels with suitable doc references.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210113

Yanteng, please ack.

Jonathan, please pick this doc warning fixup on your -next tree. 

 Documentation/translations/zh_CN/mips/booting.rst     | 2 +-
 Documentation/translations/zh_CN/mips/features.rst    | 2 +-
 Documentation/translations/zh_CN/mips/index.rst       | 2 +-
 Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/zh_CN/mips/booting.rst b/Documentation/translations/zh_CN/mips/booting.rst
index 3099d0fff7a6..96453e1b962e 100644
--- a/Documentation/translations/zh_CN/mips/booting.rst
+++ b/Documentation/translations/zh_CN/mips/booting.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/booting.rst <booting>`
+:Original: :doc:`../../../mips/booting`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_booting:
diff --git a/Documentation/translations/zh_CN/mips/features.rst b/Documentation/translations/zh_CN/mips/features.rst
index 7e67f81a0982..93d93d06b1b3 100644
--- a/Documentation/translations/zh_CN/mips/features.rst
+++ b/Documentation/translations/zh_CN/mips/features.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/features.rst <features>`
+:Original: :doc:`../../../mips/features`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_features:
diff --git a/Documentation/translations/zh_CN/mips/index.rst b/Documentation/translations/zh_CN/mips/index.rst
index 2c7b836a3da5..27a2eae8484a 100644
--- a/Documentation/translations/zh_CN/mips/index.rst
+++ b/Documentation/translations/zh_CN/mips/index.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/index.rst <index>`
+:Original: :doc:`../../../mips/index`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_index:
diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
index 9324a0a26430..f04ba407384a 100644
--- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
+++ b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/mips/ingenic-tcu.rst <ingenic-tcu>`
+:Original: :doc:`../../../mips/ingenic-tcu`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
 
 .. _cn_ingenic-tcu:
-- 
2.17.1


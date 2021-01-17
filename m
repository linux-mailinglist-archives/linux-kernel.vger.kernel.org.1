Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A199F2F91B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbhAQKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbhAQKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:10:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D53C0613C1;
        Sun, 17 Jan 2021 02:09:47 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a10so2919291ejg.10;
        Sun, 17 Jan 2021 02:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OG0a9T+WFxLgbNsjTiDCSg5wdtztxUcxZ9XgUoXZoo=;
        b=ROq6ZncoiQUl5p0D3gO2OGbFGP+YOLig6IES4Yt/CPcBar8m0VRFqLcTZF4qEbVial
         MmdjsNDlg0PBtCZV939ZW4N90rW+m3/MNK2PveyQDLFarucbFA7qlpFhA7MzgMcT4Dkt
         INUuWsyzACArQ0kV5vVDKvSGeF3542jmJ+zI7Qbion8nfIqVSXfAIyAh7b5gvo6iOQae
         CngBFbZcT81aIuAZvgGFfttQzgNFJWdrSjf9UCJqnjzYOtOgqDI5arKyBeUj+DJVieLm
         41TL2cHdSsYNPPgy0mKJJBEAB7MSJ9IotxYivqzTJ7fn94BQpUyx4TeaLtOc/7gBhJ9T
         m1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OG0a9T+WFxLgbNsjTiDCSg5wdtztxUcxZ9XgUoXZoo=;
        b=ruMoLhBYrOdfdDyNDPD7a3t5xwiqIH40XwfD0F4cenc299WLP7BBmWn5tHoHPvdw5t
         QeWGYOTH5TXFoDxYnEOhWP0k+6LRzWnHFW3I4e/gVatPZqqRguVJ3MtbzTAWNdgWEOYQ
         tJE0gh0M+ISjz8r6adG2h7onkj2lELJciDrZt6UvpH3L146kbt+rCan0HSB7zyZRR1Yi
         K3R8LuF8TvIEoDhRukfeb4V9Xc16eNKyAFezM+FAIy+0jHOUjaX7UiVXNg+fXBYOyz4U
         2+f0fjIoTswFnLFdD1/WSTxY5McmHt13UmBpL9fXfwUHHm8qWezMQhfKaG0SYzLukcV6
         gdWw==
X-Gm-Message-State: AOAM5322MdB9+uP7JpMf0EyblrAb1DPWIK08hzVIttJ/e0XOW88weGbh
        cIJgLAx2cj3d/+dVbeXVFH8=
X-Google-Smtp-Source: ABdhPJyxf6qxCc5XJJtyELC+0wnHq2/Kzgxj7mHzbzysTPZBIFxPR+vyDKxKWHAg6wtBGgHzgOhxtw==
X-Received: by 2002:a17:906:a19:: with SMTP id w25mr14424067ejf.335.1610878186325;
        Sun, 17 Jan 2021 02:09:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:c06a:642a:2af4:1e16])
        by smtp.gmail.com with ESMTPSA id s19sm9277855edx.7.2021.01.17.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 02:09:45 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     SeongJae Park <sjpark@amazon.de>, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs/kokr: Link memory-barriers.txt to rst
Date:   Sun, 17 Jan 2021 11:09:31 +0100
Message-Id: <20210117100931.9347-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210117100931.9347-1-sj38.park@gmail.com>
References: <20210117100931.9347-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit links Korean translation of 'memory-barriers.txt' in the
translations index rst file as the original version is linked in
'Documentation/staging/index.rst'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/index.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 27995c4233de..b9e27d20b039 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -10,3 +10,18 @@
    :maxdepth: 1
 
    howto
+
+
+리눅스 커널 메모리 배리어
+-------------------------
+
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ./memory-barriers.txt
+    :literal:
+
+.. raw:: latex
+
+    \normalsize
-- 
2.17.1


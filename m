Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C32EFBC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAHXmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:42:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B20C061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 15:42:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h205so26951608lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 15:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyZz1hqJLMdSGm3NpdXWHq0YcTuVoZkMZNwD2LVgx7M=;
        b=Cecy+RexopWWjUY6s1vtGztmGLgfATcKCPFIG5mLLUv+I0kcdPIafkf+eLttj2ZIxy
         Khquk0RpkdgnuRYxOWzXUl3zGO/Vb/avK515O96DDSVhBE2t5yCG6NJmjTXUMdQUQXLe
         S6zmGieztjARWPaOEnKJPhh3VwOMut7KEydHimLebpuMg4x3cPxTRuM44g5pu/hJQv/G
         pYzdmDpBObtKrmVgmP03+H+ILbPlB6Z0kgUqTxyoxMG10T4+nuJ+XIQZX8WEEQV+oLbM
         Pu4TBcRnx8bVWM5OQmI7vPBDIlozJfydd8bswRhgF4fZF/J+WFJHIa+rInz3TQIKP/G3
         YhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eyZz1hqJLMdSGm3NpdXWHq0YcTuVoZkMZNwD2LVgx7M=;
        b=ONJ2rr8F6MUX1h5xQcWDwMkLDXMsN1EU3hwfD5+5YMvR0cGXKWx5Mo9N4VFTyX+J1C
         KmSYadgcKdVy+BUZ6yOFbwhlos5XjeTmVYkgaBlPaunawA/aeAjcHXTkKKZVuA7h/Bin
         4idvHgixlt0fVifsRImARBLapuABwHIX2++2AdoqXFxG6ApV4tM6IW80yjY7vNskNaz5
         jZmENVbMbbeIIpCGlAstwmAUQ1Kw3EINzobtivYVF26zjQ+JfhmBUW5Ws72/SnCmrMXJ
         2dzrxwuvdEi5Q3iNXQWYghdvEjpAQooNkgQH10vwC+y8WE5uT3QDf4iD8pFjH8R0MC9c
         HMwA==
X-Gm-Message-State: AOAM530RkLM1ZhVf2rlgtTQBIVbQJPdF/I/37GizFxUm0uV+sNJ5p0EN
        NHoysnDkyQc//YB3hPKqcF+HH0mWtFwraQ==
X-Google-Smtp-Source: ABdhPJwd+anPUdoUfNYPTizWNLk8ABzTMWpv1UNiwTvX+WFB2qYHtLJ4Jz4c8RrOhmzHp0MfS0CcLA==
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr2358170ljj.465.1610149332168;
        Fri, 08 Jan 2021 15:42:12 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id r8sm2304907ljd.140.2021.01.08.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 15:42:11 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] nvme: Constify static attribute_group structs
Date:   Sat,  9 Jan 2021 00:41:47 +0100
Message-Id: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to put their addresses in arrays of pointers
to const attribute_groups. Make them const to allow the compiler to put
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/nvme/host/core.c     | 4 ++--
 drivers/nvme/host/fc.c       | 2 +-
 drivers/nvme/target/fcloop.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..fc3743de53be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2849,7 +2849,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group nvme_subsys_attrs_group = {
+static const struct attribute_group nvme_subsys_attrs_group = {
 	.attrs = nvme_subsys_attrs,
 };
 
@@ -3679,7 +3679,7 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group nvme_dev_attrs_group = {
+static const struct attribute_group nvme_dev_attrs_group = {
 	.attrs		= nvme_dev_attrs,
 	.is_visible	= nvme_dev_attrs_are_visible,
 };
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 38373a0e86ef..5d3976116558 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3776,7 +3776,7 @@ static struct attribute *nvme_fc_attrs[] = {
 	NULL
 };
 
-static struct attribute_group nvme_fc_attr_group = {
+static const struct attribute_group nvme_fc_attr_group = {
 	.attrs = nvme_fc_attrs,
 };
 
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 733d9363900e..9a0bd9af3f9a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1544,7 +1544,7 @@ static struct attribute *fcloop_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group fclopp_dev_attrs_group = {
+static const struct attribute_group fclopp_dev_attrs_group = {
 	.attrs		= fcloop_dev_attrs,
 };
 
-- 
2.30.0


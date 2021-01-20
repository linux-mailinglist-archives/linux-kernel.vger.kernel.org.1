Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30022FD37B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbhATO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390940AbhATOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:47:21 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:46:41 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 22so25512699qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=haYCR44fZsm3Dr8asxMS8claKbS3LRjIocLXQM4kdgk=;
        b=P1E1rBrb6Wgo9lT1dloy04vrL4NoTgfFkmlo+PoyFTMPGEaiJz5QV7b9RgRhPFkxKf
         B9JFupJwhPiQxCYGgk9T+OCtlcHP58Ge3z4VgG3FIkP3hO6rZeKK/pL15NC3DOBHvhfg
         v5Rd6JhdW06EEgDEvo0AbtRp6+3zR6O/lvOgWQf1v9EZGQ/o096hRUFDDFKgMXTvJ1sg
         2IVmUxgLO0eTIh+LM98jHWlnqfsoaJD57q3nQrvqLkIaDGjIeKhMUkq4e0sdXcyBJAyJ
         6qsva3wyD9TCOf9OfL3ATJDFvJ+afZgHLjY7kOZryCJRUvxpJo4W8Aqz4SqOWibtosfO
         OagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=haYCR44fZsm3Dr8asxMS8claKbS3LRjIocLXQM4kdgk=;
        b=Hc7JHN8u9oLiPc2NNGK3fhYHuQJceZEDCzzCmTk0+fQdTsUMPRnnZ18L4K6Zqr3YrE
         ASME5ZaC0y0g/M1/SNKpna4GCgp7Hvk/4F6kHNXnohyhvAkgufBfPwUMomuXox/ZlVYU
         46jq1peOLmCWmQCJFPFXJlJ12Yb6RO5laL3TLKiaHOQ5oHLGOXu4tooiYvQkCf3W3OZJ
         Mwj6rcFTGPIOTWKh8oImWdJ5t2g5m/+e8xpV1Bhc3ywMfHEHWciqHBZLNbTzrhdlfwZu
         n7gD5ccRzDXkB2ZSb+GFD+Mp0+20SW1YWQUG8DRFfrZrWO4kzx4G+C9sc+5AUt6Fjx1Q
         rt/g==
X-Gm-Message-State: AOAM531ePbUML9qKhaDn56SC1Pxwh/cPwoQQDfuS2CGcOc9yqlukdaIw
        Xovk7hBzIT6HON/zYYWF2HQ=
X-Google-Smtp-Source: ABdhPJz4Kx24Gy1EOcBjl3VXy+WySQJt3VL1aDFU5eEPb0YHhnnwE6KWFxXa/3H5oNKvTvztQQCJ9w==
X-Received: by 2002:a37:6f42:: with SMTP id k63mr9674866qkc.291.1611154000613;
        Wed, 20 Jan 2021 06:46:40 -0800 (PST)
Received: from localhost.localdomain ([156.146.54.160])
        by smtp.gmail.com with ESMTPSA id y9sm1262588qtm.96.2021.01.20.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:46:39 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gustavo@embeddedor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: linux: Fix in two lines in the file list_lru.sh ,resposible -> responsible
Date:   Wed, 20 Jan 2021 20:16:28 +0530
Message-Id: <20210120144628.3864652-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/resposible/responsible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/list_lru.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..1b5fceb565df 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -146,7 +146,7 @@ typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
  * @lru: the lru pointer.
  * @nid: the node id to scan from.
  * @memcg: the cgroup to scan from.
- * @isolate: callback function that is resposible for deciding what to do with
+ * @isolate: callback function that is responsible for deciding what to do with
  *  the item currently being scanned
  * @cb_arg: opaque type that will be passed to @isolate
  * @nr_to_walk: how many items to scan.
@@ -172,7 +172,7 @@ unsigned long list_lru_walk_one(struct list_lru *lru,
  * @lru: the lru pointer.
  * @nid: the node id to scan from.
  * @memcg: the cgroup to scan from.
- * @isolate: callback function that is resposible for deciding what to do with
+ * @isolate: callback function that is responsible for deciding what to do with
  *  the item currently being scanned
  * @cb_arg: opaque type that will be passed to @isolate
  * @nr_to_walk: how many items to scan.
--
2.30.0


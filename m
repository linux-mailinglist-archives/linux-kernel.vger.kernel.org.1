Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5715C2F8A35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhAPBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbhAPBCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:02:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B71C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:01:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b3so6580823pft.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/mp76MFo6zTjFjyOBvebu3sCb2at4yhvzchcxGzAJY=;
        b=eTns0+A0Jh44BGeLpyuOu82aLDRyU7xVPBTkiWP2SZ1nDm+dA7pPrnFGTZX/y0vIfN
         LPh0y3Y4feGb+EngZ0hL1Smx2PcYFLO1oU67bLxu0KvrFRQ2n8KBlkvWlNoWjAgqmjVX
         Zis14wVgqAkGHTqKh+pABXu0rfXcG51IhSqQffOoRnIz+84TMRmlm4G4uTwxsWY8TgV9
         oGuXYzuSmo9iG+j3X1FKW4ddinkPxrl8WpAxOV97E9keR2wMY1R3ADx4lX/46p5bVdSh
         cl/oN5SlraJtlY0PZ0WxNPv13oSz8fdZc/1dxbULaij6Y+ahr8uQ/yNAjANs6wjUz/FR
         4U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/mp76MFo6zTjFjyOBvebu3sCb2at4yhvzchcxGzAJY=;
        b=idmJziFghtDA5oV9IAdi9Q3d6Ih6768+p/awS1J+nxpoqex+m+sE34OXML6mdZxseG
         i8NL7xGUiB4Zxf0w+ZTVQJfwpMIK7TdWoRg95ay3Q4FhRrsmIqo1Kj3FRbD+XvYL/0Lj
         allcA8iq43m0e1RCxs8rl+swWUD1HbTXEYjYNe9WSNBNOICeF2K+ksFkzDL39RgYpwkR
         GD6/yjTquD2VuJONVJNZ1alfo9N/8jifJLRROxTaJdEEj6jCMTm4dACQHBJ1K2T/8nJS
         25NT5FaAdOXzgTdf1UweocvMS8FbP+n8NRgF6JZETr3ubHe+yqcf70Eg2dTHJIYaaxAw
         JftQ==
X-Gm-Message-State: AOAM531/x3KbH/aqEvEfFbTEur5Jcp93HOzYCOptpK6BkFT64NMtaTQa
        FuyeDpf8tvk0kXVncC4XlME=
X-Google-Smtp-Source: ABdhPJyt5J6InzBYDb66nerwEzhvBEI6MibHYKZtV6y0ROLsXS0Qso+dxTu1nOzxy+JZmnP746O1xw==
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id l143-20020a6288950000b029019e92ec6886mr15372417pfd.12.1610758911045;
        Fri, 15 Jan 2021 17:01:51 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id 131sm542601pfa.210.2021.01.15.17.01.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 17:01:50 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        yejune.deng@gmail.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, lkp@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: dynamic_queue_limits: Fix when built in ARCH nds32
Date:   Sat, 16 Jan 2021 09:01:39 +0800
Message-Id: <20210116010139.71748-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arch nds32, build fail with following errors:
lib/dynamic_queue_limits.c: In function 'dql_reset':
lib/dynamic_queue_limits.c:119:2: error: implicit declaration of
       function 'memset' [-Werror=implicit-function-declaration]
memset(dql, 0, offsetof(struct dql, lowest_slack));

Add <linux/string.h> fixes that.

Fixes: 36ef65b21930 ("lib: dynamic_queue_limits: use memset and offsetof ")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 lib/dynamic_queue_limits.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index 21f07452a6f7..334ac16a1bfc 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -10,6 +10,7 @@
 #include <linux/dynamic_queue_limits.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
+#include <linux/string.h>
 
 #define POSDIFF(A, B) ((int)((A) - (B)) > 0 ? (A) - (B) : 0)
 #define AFTER_EQ(A, B) ((int)((A) - (B)) >= 0)
-- 
2.29.0


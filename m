Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE792A49E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgKCPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKCPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915BC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:31:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k18so13195085wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXlb9heLa6kkwouNTwIIOIWMo+YR89VhadoqFB4UnL4=;
        b=AWSOfzSfAjrXvlG/k8OB/VxWgM6ajWM7CMBaq62WE4Syycr0k8qgmylvnRyGTPQwYm
         cQcZnmO+ryY7/Fk1tSrYWvCiAuZbr5CAuwGE1ZB/w/44REfMKXUyCwFQFc2+SGbBYWlN
         XeX8rXsiNiwGlAg6ClW02e7LwUaFm2scamauU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXlb9heLa6kkwouNTwIIOIWMo+YR89VhadoqFB4UnL4=;
        b=D7o2q+0bAiZzVwP2PlHeXMQUkm97oSX5Mo7JcR7nBU5YMnc/B4f8ZhquMzHPLfS3sV
         2ODDpFQCBICD8udS3ULJ5To8egImRAlbvhAIbfhuVjfoqF/HFPcxuqC9uC7iLnfRg8Pp
         qglHkZiTOYGyGOILBmnnFKjDhNITtHTdNrpVoc3R72bZN8GzyeUXmUsjdS4A+BrQUg+k
         +8Y/Tu5+v1kKSe2PkoRD/QDS/Vm/e4pGYeuhvrqE/OEAFmCK8gXZdA46G6DPBJXTBDN4
         gj3bCow8WMO+mPAuUPkQXD4xPti6Nuq9w6Kve6eTMKeubTs9JFFFuHdszlFL7WRHkQlR
         vkHQ==
X-Gm-Message-State: AOAM530zAeVGfonY7FMRfhpWB5SqSpt6b7Ep24V9a8zgIhg57YvcNKbO
        2zTt5S8hziCK1xJ9NsySzEheHI5lPMLPTLhj
X-Google-Smtp-Source: ABdhPJy4uWEyZvhM164baFgqEmCr0TVVkuxKVbl83kdii9i3U8zspWt3idT5hly5tvCAc75IlJRpAA==
X-Received: by 2002:a1c:6456:: with SMTP id y83mr320087wmb.59.1604417499734;
        Tue, 03 Nov 2020 07:31:39 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 2/8] libbpf: Add support for task local storage
Date:   Tue,  3 Nov 2020 16:31:26 +0100
Message-Id: <20201103153132.2717326-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..bed00ca194f0 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Netronome Systems, Inc. */
 
+#include "linux/bpf.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
@@ -230,6 +231,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog


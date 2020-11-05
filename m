Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A92A8A48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgKEW7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbgKEW6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB2C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:58:35 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w1so3614893wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSzUbTNsne9al3ng9/59i+9c1bESHaPY8FhaRGWHPGM=;
        b=g6qYBO05iUB0cm/lqCdeg0InQvZWeFPoV0wFXeSG74v2stDp5QroUZ61bEvVXBU2u0
         NvqmoCfpR4L7CdpvdspgK5zn4NjEpM0X5mh3aeis3eMqRLztZyGIPnd7HFrGGlP+mzMJ
         38Nlpkc+FHl3DwRynVu/B9jHNi7UWOb5WvEfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSzUbTNsne9al3ng9/59i+9c1bESHaPY8FhaRGWHPGM=;
        b=XSW0LeXcs2eHmmCQGI23+VCElv3YragEhFvPh52DaSMMvgbeAzg7d8QkAq1OOGfZbz
         0qgUVh1rUMHeBgJLssOsiojDySe62ZriD0cqY5IrMOpbdMrCk2X9I8ygSgiTI1BTNENE
         yZWUTDapEiSZb+gGzdKT2vAp/1XHkirIBvODh9qSpddonWcvaee4tiyGUb6Ma4wF7vEk
         lCQlDqVVtAOnT07scuyBAIxT+kJ7yX3oLClXUqU0t8Os2mbeu0F2uTsknOriADtM66JG
         lrgulaubepVqldyeQ2dlJheV+8bSBiwwRyo+kA4P02iIOuuI+EshsV0/2XxP2dCc6HFP
         vszQ==
X-Gm-Message-State: AOAM531hS9CPELTpZi1/gdy+ZGiy+lSI+EFlZa8BQSOdaHtHdnqwYpiW
        LB6ISDw4sDmqC3FJikIKK++2ViNZFPWVEDcI
X-Google-Smtp-Source: ABdhPJzyTCmCvCKNIyBSvHg10s/bOj6yoiAMYsXrCmiPuKR8pRIZWbN5fYurkSho3Cq0ODgfKoBx8Q==
X-Received: by 2002:adf:94e3:: with SMTP id 90mr5139155wrr.380.1604617113942;
        Thu, 05 Nov 2020 14:58:33 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:33 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 4/9] bpftool: Add support for task local storage
Date:   Thu,  5 Nov 2020 22:58:22 +0000
Message-Id: <20201105225827.2619773-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the binary to handle the BPF_MAP_TYPE_TASK_STORAGE as
"task_storage" for printing and parsing. Also updates the documentation
and bash completion

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
 tools/bpf/bpftool/bash-completion/bpftool       | 2 +-
 tools/bpf/bpftool/map.c                         | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index dade10cdf295..3d52256ba75f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -50,7 +50,8 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
+		| **task_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 3f1da30c4da6..fdffbc64c65c 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -705,7 +705,7 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage' -- \
+                                struct_ops inode_storage task_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index a7efbd84fbcc..b400364ee054 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -51,6 +51,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
+	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1464,7 +1465,8 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage }\n"
+		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
+		"		  task_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
-- 
2.29.1.341.ge80a0c044ae-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E82A8142
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgKEOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgKEOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:04 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E21C061A4C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:48:03 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k9so1816839edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFN4S6xNJ1smJ8e1NKpWimVp/f5smo2slL3MYnYJ44M=;
        b=OxTaqHHGi15u/Op1eENYnF1Eks/51ypycGjeRM2R8/3iD6lmYG7ZzYR0YkZ0c4c1Q9
         zQHT4K9VfrY18CbYCRlbn6VNSXvUFhIlpBC2tbUJgSsB1OGPRKXym7B1e1wJqKiQR9W/
         hh3GTf4XNbK/8+MMGUpbzO795Q2iEBLMBNLxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFN4S6xNJ1smJ8e1NKpWimVp/f5smo2slL3MYnYJ44M=;
        b=j7q6GGuDsAZExNRdiZ+4BcjWuLAr21K7nzf/6v1T86a+GMIXbylwxH834QpGFOHrbI
         XNfsPnB/W3RJPcUxqP82RHfur0K8igDlsDByA/O5YNBu7ScrXbSJIlmraBVuiLbLWeaM
         JW3dHT8PBOuaTtSQql9gIVYWkkGh7v51e2H/r3Fn7A7eBGDHvwSRvFemcXYNP0LZVtLL
         r6ILWyRqXdpWFxvZnP/bbeBsCmDqVEOLTaZuM4XYzPEFaQZVIDKiyTnvzF785aVFF91v
         7s1ku3unZQAc8vFCJFkGpnBcGJGfDihyENnPqpxLQfMErWJoIUsfZjecNm1aajiKJvwO
         io1w==
X-Gm-Message-State: AOAM533LELzzc9qCrcRixJ7CERAZQXvH0GvBUPDObIuQgej0QGWXbgXO
        QMpqrrMEmVkthVdDKq7KNqMJvnCjyu1BpyFz
X-Google-Smtp-Source: ABdhPJyIFyngjhqYKh7s0D2gWBoIartgdwNrduxulVu47dLTjOIDSV0q/LNfVUI8FDX1szKPCjJhQg==
X-Received: by 2002:a05:6402:1388:: with SMTP id b8mr2963595edv.1.1604587682387;
        Thu, 05 Nov 2020 06:48:02 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:01 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 4/9] bpftool: Add support for task local storage
Date:   Thu,  5 Nov 2020 15:47:50 +0100
Message-Id: <20201105144755.214341-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D9B2A6A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKDQpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgKDQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:45:01 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB1C061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:45:01 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id e18so11979919edy.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GqRxMuRSCk3pA8cj/SIZ2TBkRpOcHYXrUjExpfJnAs=;
        b=nG1z420yGZvqqFXpI+0coJ/yx6cAUdwWP9rssOjDBDfg7ETelQLL5qoOl8j5Zzi/RD
         9t9QgKcNslkMhmtZ8L9be69BMYxvMJZZGYEAmEMvhjfKjOs/RN10vXAcbZvEjKOKGSci
         ZMVAHRFKud6bI2/8sYvx72iKWI0YpW6y8fnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GqRxMuRSCk3pA8cj/SIZ2TBkRpOcHYXrUjExpfJnAs=;
        b=PqhrzXz2QhWQuzFb+JVEhmnmo0nZAJAcJ57gVE07gA1q/m++LQTJyn1s+3tTHbUgjU
         on03EXnsx8X+s9POVewagVNefwxVFa9xr3a3w7+xIXRBbSfwAILtNz/JvJhgLEWHjwht
         Rz3WAmwfZQwglQ4G/UvFzvL9NBbf2PIxoq8b9Xx4C/VOPqmW2RtK+ZiAzdqHDmoLiJzg
         W39wvAdpslXz7J8bf6x8qugRqqu53Du+jypxBjP1/9n3MRYYLnY339uogPo1u1aKkKeW
         auj1CDZwaG5mLx/i+G/1zj+OI9RMTpxTy7alWtjiKYf5dRxujOidrFqaTV8FaLBTr9ol
         nFHA==
X-Gm-Message-State: AOAM5328n43rL+6vM39WE9GOgmNPayAsBeY/XLu8ChVlcxS7QboNurPZ
        f3NF41GJ/2GTo5lThnhHmzHuOMOzOOxQdvlB
X-Google-Smtp-Source: ABdhPJyaK21fS98vxgrLdIHMXL0fy1Fr9HE2Z0WgWnLT2VMWt8vw5ugi861/PzqBpU3l2J4qxwSx8w==
X-Received: by 2002:a05:6402:142c:: with SMTP id c12mr28897416edx.41.1604508299644;
        Wed, 04 Nov 2020 08:44:59 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g20sm1283551ejz.88.2020.11.04.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:44:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v3 2/9] libbpf: Add support for task local storage
Date:   Wed,  4 Nov 2020 17:44:46 +0100
Message-Id: <20201104164453.74390-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201104164453.74390-1-kpsingh@chromium.org>
References: <20201104164453.74390-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog


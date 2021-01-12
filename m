Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A502F2F30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhALMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbhALMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:35:22 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E9C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:34:42 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id w204so445931wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pU2TD0vHzJMOEXt8gPn4RurzqWNYxl51610uNTFZEgc=;
        b=FpRsluB+WQNzSpcn2oBDxF4pnB7gSgIte+V69x6+EXwPE9aAwIfjrCtScG7gBxwfuh
         cC9EZH6eRaOenzBj8p5IvQ8KpokVaV/5rDVvuxgPjh+TtgimAbcZUCDtip1k+YtlCuys
         51gLgakYwh0MvLiITSMHNI6bOO3wQPKziNYpxfIpYerqK/Zm18mmNScXxi2dxin+rQMr
         eb2YIeH084l1rvj4OgGWpP3eQ3RZ8uGLlO/LtL8a2fpPhH4YW6bu2isnSYX+482HmpTH
         pmoOR8z7htAckAZ5wItUZ3PUtNrUvv22bXjYXD9q4Qx++ghRotqEYcRrwIEXwe8bBEJC
         C84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pU2TD0vHzJMOEXt8gPn4RurzqWNYxl51610uNTFZEgc=;
        b=Z0h/9L1dMcPDZg5tsx9oIUhW4eJXYi+TCNWJyBx5/KchoS7HouZozKX09dbgcLaMuK
         a0OoDx2/799udDgkxSXqZcTMwBOyL6fFwQuc4LVicv9b+bGfMQQXE0oFla2nLFoPMBQk
         BSrYWz3wRb5SXEs4Ap6o7gqg3B0HNOmH9PAXr9Mjnn1Z0q0Y1p79/+2nSv6twVahKqor
         KOjSEfg75W0zPQUfQExXOTlumpdFwu7PoLJAFW2WHpMlKyE6mtWDEAN5zUkHJi3njHwT
         fvtPs3yjs3JG+xI0LvorE6gRvitb2jOTkl3VyR+eyLNK2JgmKGfit4lZyBTjWPQJr+BJ
         8XCQ==
X-Gm-Message-State: AOAM533ttnLRg4VNQ9teEi02VmDILqJUUP4+hgKPEkwHv2kPhzvE2rpf
        zn1qgNT4QU/W0G1Sn43PgkIhFZE+r8IsrQ==
X-Google-Smtp-Source: ABdhPJyVzH2vHwtrz088JpONtQgIlsJac7eMd4o2O2YP+YmvRQGj35xZOoAbCdLsV1t1496eZLiNRqQ2b1AWWg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c2e8:: with SMTP id
 e8mr3341182wmk.103.1610454880590; Tue, 12 Jan 2021 04:34:40 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:34:22 +0000
Message-Id: <20210112123422.2011234-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next] bpf: Clarify return value of probe str helpers
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the buffer is too small to contain the input string, these
helpers return the length of the buffer, not the length of the
original string. This tries to make the docs totally clear about
that, since "the length of the [copied ]string" could also refer to
the length of the input.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/uapi/linux/bpf.h       | 10 +++++-----
 tools/include/uapi/linux/bpf.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 77d7c1bb2923..a1ad32456f89 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2993,10 +2993,10 @@ union bpf_attr {
  * 		string length is larger than *size*, just *size*-1 bytes are
  * 		copied and the last byte is set to NUL.
  *
- * 		On success, the length of the copied string is returned. This
- * 		makes this helper useful in tracing programs for reading
- * 		strings, and more importantly to get its length at runtime. See
- * 		the following snippet:
+ * 		On success, returns the number of bytes that were written,
+ * 		including the terminal NUL. This makes this helper useful in
+ * 		tracing programs for reading strings, and more importantly to
+ * 		get its length at runtime. See the following snippet:
  *
  * 		::
  *
@@ -3024,7 +3024,7 @@ union bpf_attr {
  * 		**->mm->env_start**: using this helper and the return value,
  * 		one can quickly iterate at the right offset of the memory area.
  * 	Return
- * 		On success, the strictly positive length of the string,
+ * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 77d7c1bb2923..a1ad32456f89 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2993,10 +2993,10 @@ union bpf_attr {
  * 		string length is larger than *size*, just *size*-1 bytes are
  * 		copied and the last byte is set to NUL.
  *
- * 		On success, the length of the copied string is returned. This
- * 		makes this helper useful in tracing programs for reading
- * 		strings, and more importantly to get its length at runtime. See
- * 		the following snippet:
+ * 		On success, returns the number of bytes that were written,
+ * 		including the terminal NUL. This makes this helper useful in
+ * 		tracing programs for reading strings, and more importantly to
+ * 		get its length at runtime. See the following snippet:
  *
  * 		::
  *
@@ -3024,7 +3024,7 @@ union bpf_attr {
  * 		**->mm->env_start**: using this helper and the return value,
  * 		one can quickly iterate at the right offset of the memory area.
  * 	Return
- * 		On success, the strictly positive length of the string,
+ * 		On success, the strictly positive length of the output string,
  * 		including the trailing NUL character. On error, a negative
  * 		value.
  *

base-commit: e22d7f05e445165e58feddb4e40cc9c0f94453bc
--
2.30.0.284.gd98b1dd5eaa7-goog


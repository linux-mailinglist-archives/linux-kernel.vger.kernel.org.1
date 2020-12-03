Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1492CDAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgLCQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbgLCQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:55 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D403C094250
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:03:43 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id n5so1969511qvt.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+oJt4YN1vV8BikzJk8T4MnuRoPet/ONJM85/l1oaFsA=;
        b=fVN2tNQLNEwDBCS0z2Ugrc7Z322KowXofgwiQ9YEdeV/KCt2OGr2VBVa1EMDEa3wKz
         YpU4Ba+Cl9MxtT2dEJYg5FdMcHTjj+6fBROVSB/N+NSL0TiLW2mHwqpo8ifxLtEZdrD+
         x6P66T34hNWOrJKcGHbv30mOOjKtNiOFoExyWjKuAxS5djB+RtMiBt7GhEBLLZmKKHfl
         Md5+jyELCFNLSaecee9i0NHD+EcOtPwqyRNlPsuXVZ3P88OJm/Zhyt6gjKgapTAQ/79f
         FBvvYqNEbTpfZY7SzjM3k9cEX9dCDVEtrwx1ftqs398vsjI90tGKgDpMAGHK1AY5ZvjS
         Vr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+oJt4YN1vV8BikzJk8T4MnuRoPet/ONJM85/l1oaFsA=;
        b=lzu+CotmS+KS2yi/+Yv1o4UViveBW8NgMs06BxVO4uM3qEaSIOqxUfykKYEwxyX+wv
         pzXd4FXLVRwlXKIogagDYZzIKjWFPnqeFHera++o8twAAEDg4pJ7x4dl0xvRM6p4eTRg
         eqMngGyicxVWzZgJbHoxq7t4QwimkFBFQsjRw5lVL41UFPPXiqGBxc1btETA1yHR8hCc
         m+bNmFbhCi1WDd8CA+zwhE6VVF/n56qJOgFxQpDebBdZxjF7lOX4hwHOWGLk9WSFKLzg
         q7SMtYU4pxj9o9OVIVk4frUGV79QF6LMEMt4nZDcZgviIPgGdPflzF3TXvUn2mTc2AZn
         x/mA==
X-Gm-Message-State: AOAM531i2IRHn2at/XXzpbrbWHgeGQTP5SeObZNNTdtLbGcuGF199/z4
        e86oegzNf/TNAB/tCKw0Q9sxlOOlCnEnzw==
X-Google-Smtp-Source: ABdhPJzEd1nsztwyeAv0SEjKx8FK75ZZ+DgtqH3y1CX08lYeGnBAHDonB2nICe8xfwm8dnQc5SWESwtNDMWl4Q==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:9d07:: with SMTP id
 m7mr4069974qvf.5.1607011422530; Thu, 03 Dec 2020 08:03:42 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:45 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-15-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 14/14] bpf: Document new atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change-Id: Ic70fe9e3cb4403df4eb3be2ea5ae5af53156559e
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1583d59d806d..26d508a5e038 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1053,6 +1053,32 @@ encoding.
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
+The basic atomic operations supported (from architecture v4 onwards) are:
+
+    BPF_ADD
+    BPF_AND
+    BPF_OR
+    BPF_XOR
+
+Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
+memory location addresed by ``dst_reg + off`` is atomically modified, with
+``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
+immediate, then these operations also overwrite ``src_reg`` with the
+value that was in memory before it was modified.
+
+The more special operations are:
+
+    BPF_XCHG
+
+This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
+off``.
+
+    BPF_CMPXCHG
+
+This atomically compares the value addressed by ``dst_reg + off`` with
+``R0``. If they match it is replaced with ``src_reg``, The value that was there
+before is loaded back to ``R0``.
+
 Note that 1 and 2 byte atomic operations are not supported.
 
 You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
-- 
2.29.2.454.gaff20da3a2-goog


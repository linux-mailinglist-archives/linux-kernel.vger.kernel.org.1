Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8C2F6957
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbhANSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbhANSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:45 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20401C0617A3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:32 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q18so2961152wrc.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=ejJx5SL1fxsjwfzzDNBu77jDzM3gbctXjuLEXIC3R0xMOGwoQYZOxS2JvSgYX0pkXg
         BXiXTH+qpyB2ubLuXMn8VO3P+2XHRd9MeE137iyXchQPCm847DnT3AJKSiy4uwQZ1UI8
         /Oc42tfCquYcp6sSW1If1t/HCdJA7h3Gflnw6EUDdo7t143KiehHYxwe9nJFVVMHJXIh
         V+h2JlzkAPAv+oDLUuRfL8H5N0x6CITgrNe7LQHEkdrh2qnu3ClCFI1R9cWo03OVfRPi
         muOfMn91THVE3jIZYdDlfpEEhfp5VUSXNRxf71aaJC0BGfUQP/EREaKjqRXlydjOrFBP
         mGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oW3at7tYerofWpFJJa0IT/4f63HRcTZEokqKQUOM8Tc=;
        b=QpLtV+CjA7qL8gISsKCu6BvUyarY7m8+z9iLFZtpcxC0BK5chnFjQ5s9N+6kVDyjuL
         1nxcYMuvoS9NXwi3sKX0M+TbyNU1vJ+ujvZTE28uNhVmS8dmhy7X9HmBaTjld2MWIKd9
         Qt16SulX/JBDDffEl31yJX02I6JEX5QOmjmclwdOewprXsRdjYhGM1zKig7LtC0XOdQW
         nl1veCpYjttARDSkSCgnVZdBxJfTQzunWlH/k6zKPuNcaLfz/86dgK7T1nWevVKTAxsk
         XSAeIj61tcB7v4xt3D2dqGNtuAD5R5VshSU/eynwGEQwzWiPHKQ/SCk0+nDXLnYo6qFt
         Opvw==
X-Gm-Message-State: AOAM530uSLdp3PlA6/d2KzeDyXBznhHK9oADTez46WggXvdND0HpUrL5
        88Np4AY+X5r4Fk5lORXrZsv6Kdrd8hTGyg==
X-Google-Smtp-Source: ABdhPJwIi3mz/1SY+6oE7+tGQR4TG4Ys8wjpCeHeJPoKZHE0TxLj8pwGF4emyEHgJecZi38QdAkxaELMDCwY1w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:decd:: with SMTP id
 i13mr4665456wrn.144.1610648310534; Thu, 14 Jan 2021 10:18:30 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:51 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 11/11] bpf: Document new atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new atomic instructions.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1583d59d806d..f6d8f90e9a56 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1053,8 +1053,39 @@ encoding.
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
    .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
+The basic atomic operations supported are:
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
 
+Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
+atomic operations require alu32 mode. Clang enables this mode by default in
+architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
+``-Xclang -target-feature -Xclang +alu32``.
+
 You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
 the exclusive-add operation encoded when the immediate field is zero.
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog


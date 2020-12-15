Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6142DACFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgLOMUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgLOMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:20:29 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B7DC0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:49 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id b194so1513062wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Bfu1yJn/kcF0Yo8zAQx6cAw+Cz3e6GVA73k+ZlHyjbw=;
        b=ZYqCWeA16+zZio2g7PNwYJH77/xqbft2wlFuZdsF6W3VdU9IyMjLpGXVsGcvmd/JBj
         QT8wa2MlmMlpXjr4I1opHpAjTKqrcvS/3xZgc7sP2iqwjeD3QcolwYGvtTRbZBkXxASq
         /eTxXFwqo080NpRpJs2Ki6Tx3c1fg7dxc+qtFjP78oHmyydgNKV4bS4KFjPhLjYisA++
         rVpMqJepERBl0HmEklSuA0UEDaWGVtCBZJWNSFYZq/Htm8LSxLVfGTN6hxa1JEhV2jQb
         Drjvrucf8vmSq9MNSp9CL3qvlwysxtSTS5AJZoLK7gy7GH5g2PpOIA1Ju3mSmTOdtjOg
         CzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bfu1yJn/kcF0Yo8zAQx6cAw+Cz3e6GVA73k+ZlHyjbw=;
        b=kVel7UKWt4BDAZ0dxHCn0C13rt4RWmiL2102s80vHKQ4jB5xWjKe9PVpEeHadsL8pu
         02yoI3W9pTIlWNq4J+HVbgHKgPKfiTXuxLOlskpJWDZhaq4uwSSrobERf42Tofujz9NG
         nLiwaK0iDG9LAakaSsDDTfkvS4BX90em3RHTfUfE8u/ysaKlujYWEUBd2R4bFYTPLoDC
         1qqfN+Xfo0762MXCjCrqDogWaSdjPL/PCP4DeM6rn7X0CHlCbyzKC3Hqcv9K0Oq87SAk
         oXR4RpOZy7f4xfZIzlltJgnm/b1IZhqlDJRYbOdF16Gbx5gwEOHKBz/7wYvmdR6Xx+Er
         1KSA==
X-Gm-Message-State: AOAM5317msZQ95valf30V/pd6Gsg1zCe7dJTgGX2CczqF9MdCiRVXRac
        5+LtIUZzvHWv3HvDlR/P7LVHDbjo7mrAhw==
X-Google-Smtp-Source: ABdhPJzAwh+WXmESVFfSLS1u1Y8GZCtAi19e7Ii3Li0i/xAbohXK2UQuWMqITMvD5b6Z22xnigwappFhpR+Wlw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:25c2:: with SMTP id
 l185mr32768635wml.113.1608034728668; Tue, 15 Dec 2020 04:18:48 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:16 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-13-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 11/11] bpf: Document new atomic instructions
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

Document new atomic instructions.

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
2.29.2.684.gfbc64c5ab5-goog


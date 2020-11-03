Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FB2A49DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgKCPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgKCPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1DC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:31:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e6so1763544wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2y4hk3wUSBj863VcUmFuOwBL57/qX5+mXhXp+P+CXR4=;
        b=cULKAoQgQgQAG6X4ocsSYr23+YABObTSG57CjNHLb9bls1OW9o9JyG4/17R7NzvoP5
         ZyOggwfwrd+A3an0fRAxo8mQTHT9sDAK50fsqJYuQUsVzV9O5teadRpkoazNPYxWz23q
         5clOmFa+LtfF9Nrco0t5s7Q1w8+9aXnAERaAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2y4hk3wUSBj863VcUmFuOwBL57/qX5+mXhXp+P+CXR4=;
        b=finhSD55PMEcSyHY9zsR1VF8oEOy7zY0SzDIyqPq/SfURVjslslpgxJp53kYJ3wdKT
         1SrgENIeVUQsZsjamW6izgLU/ceHq+5KuEZWTVmQ2vpE/W9pITgd8B3QoQPYWex0BFgy
         CjsbHSDCnkWUvNfNoiNbyw1zEA8eMR0IZqTn574dBtMpBjTSpFEi7qD72LB7FxkGmyTh
         dOjHUKwAKkNXZpFiJYrh4ftE6kW5srzvPRidoXvHI9PBu7PcWygC2ewx498vcjgAPI5R
         l3YS7jhvNpS5s+s/jY/Nlp+Q2XYyqAJ9FQZczJDnF+C7WGcZseVlHgRlQZ2D6a6Zb05B
         KQrQ==
X-Gm-Message-State: AOAM532X/Vcwiug6TqfPHhgFprlMWwhS33Z3xRCD65sTkPrcFjlCHqd8
        UgaYXUYpNOMoCKbjp63SgAmGBkjdmyYba9qA
X-Google-Smtp-Source: ABdhPJwkTeyIGO0Op8NzJa/OZrn+ORxAxPa8HnLy4gHWNNXKd22/75EeT6aO/EblOWtNvzO4f7mTSw==
X-Received: by 2002:adf:df02:: with SMTP id y2mr28720914wrl.403.1604417504001;
        Tue, 03 Nov 2020 07:31:44 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:43 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 6/8] bpf: Update selftests for local_storage to use vmlinux.h
Date:   Tue,  3 Nov 2020 16:31:30 +0100
Message-Id: <20201103153132.2717326-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

With the fixing of BTF pruning of embedded types being fixed, the test
can be simplified to use vmlinux.h

Signed-off-by: KP Singh <kpsingh@google.com>
---
 .../selftests/bpf/progs/local_storage.c       | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index 09529e33be98..ef3822bc7542 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -4,9 +4,8 @@
  * Copyright 2020 Google LLC.
  */
 
+#include "vmlinux.h"
 #include <errno.h>
-#include <linux/bpf.h>
-#include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -36,23 +35,6 @@ struct {
 	__type(value, struct dummy_storage);
 } sk_storage_map SEC(".maps");
 
-/* TODO Use vmlinux.h once BTF pruning for embedded types is fixed.
- */
-struct sock {} __attribute__((preserve_access_index));
-struct sockaddr {} __attribute__((preserve_access_index));
-struct socket {
-	struct sock *sk;
-} __attribute__((preserve_access_index));
-
-struct inode {} __attribute__((preserve_access_index));
-struct dentry {
-	struct inode *d_inode;
-} __attribute__((preserve_access_index));
-struct file {
-	struct inode *f_inode;
-} __attribute__((preserve_access_index));
-
-
 SEC("lsm/inode_unlink")
 int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
 {
-- 
2.29.1.341.ge80a0c044ae-goog


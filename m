Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8521275CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:02:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE756C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:02:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so559879wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdZb3lkVUE/br401TIltJMdSSQTxebl44uSvpco1MYk=;
        b=esIbknqQR1PWGRENT0xKgyxyBUfTCQPkzyu0zLWk74o/new4euRMzzV+8wd2MhjqMx
         mXfpdhkmcqZTr0/mz5EDpZJjFtPgff9yeCEE5kvsn6cMlMidKrR4DvhVe9MtsCJE3wkf
         MELyEzgTi5LoRSRjzur483hto6+zAHlm6i30M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdZb3lkVUE/br401TIltJMdSSQTxebl44uSvpco1MYk=;
        b=UM+/UqUz50r3lWoo7zaFPiNeQhmq9os216CLa2QfJx9xOqnETnT3mjXtjNkyUmAm6G
         1JAUpadO/ddqlRXGUVEysWdt0vv+41J4LnNbBy+pOp3FXvYLFKCJi1TloQartnLlL8uP
         lp7hcAOHciYIw9W+AxENbAnRE7+H5qTumnWj3++v9F7E+ssDm1fDKQMVn8Zq8CPLpzyF
         /mQPXgWoR9Q8LK8o/q5f+I6lk8voUTBCWcCmSAUpPYtJICTBE/1oqp74vGytVXSmOKaH
         UhPFEOOYowoTwWDg2CxaMgMba5/e8o/L9Vm0wd/lGGKkxewmy+627ggjRp7qjXQLItGl
         ea7Q==
X-Gm-Message-State: AOAM533iZvfK7vHq6Slr2HUcTRFrxs3BhXKRvn8oFtkjNbaQjJAaGWru
        ZiYQYc67BCm0sR0oam8JXQv35w==
X-Google-Smtp-Source: ABdhPJw01DyGsYQK0//pvTxTR5IoS3N3sptt7R9Q4hiyc/CBkbaYXGi4glGU0Ks0BXomXuNo91tMkw==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr245825wmj.3.1600876935669;
        Wed, 23 Sep 2020 09:02:15 -0700 (PDT)
Received: from antares.lan (a.5.8.e.c.0.7.0.9.d.7.b.b.9.4.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:749b:b7d9:70c:e85a])
        by smtp.gmail.com with ESMTPSA id u66sm262359wme.12.2020.09.23.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 09:02:14 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: explicitly size compatible_reg_types
Date:   Wed, 23 Sep 2020 17:01:55 +0100
Message-Id: <20200923160156.80814-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrays with designated initializers have an implicit length of the highest
initialized value plus one. I used this to ensure that newly added entries
in enum bpf_reg_type get a NULL entry in compatible_reg_types.

This is difficult to understand since it requires knowledge of the
peculiarities of designated initializers. Use __BPF_ARG_TYPE_MAX to size
the array instead.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15ab889b0a3f..d7c993ded26a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4002,7 +4002,7 @@ static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_T
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 
-static const struct bpf_reg_types *compatible_reg_types[] = {
+static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
 	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
 	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
@@ -4025,7 +4025,6 @@ static const struct bpf_reg_types *compatible_reg_types[] = {
 	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
-	[__BPF_ARG_TYPE_MAX]		= NULL,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
-- 
2.25.1


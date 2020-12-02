Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009932CC87C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbgLBU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbgLBU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:37 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21321C061A54
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:55:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so5551719wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXlqoqEBiKKDKku1a+ImTf8NUEd7mW8hynHEOt1YE6I=;
        b=lSZDDuYkzJmdtwJtYk6NIj7wuAWjvahaWLii5npycSlUdAo3QaxpPalEXmkoXnI2M0
         WrWQEldQrKoAK2mkuHGwM0EetQDp9MG1++64WzUUe2DCx8h8JyOr3nAkgmm2GIBXTDug
         7W8j8U2NOlZEos8Leq9nJFwoWYRv8RCxCdWCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXlqoqEBiKKDKku1a+ImTf8NUEd7mW8hynHEOt1YE6I=;
        b=dtHLC6eX7gsSOqb55E58mTU3p5PPX4p60b2ULIBaHKq55SHrIKXwrS0zKYjeuMhEAi
         0R98U/AqB8cIec47rsk8LyGVlQy21kvzI0F7XxQwQerUkyq6kEDZVegaehi3jQsydDhP
         Ryx5VZZARsAKNaV6jZ99Ni05lAS3dSDcc3ZHgO7Lf2G3qQmwD5PHQKIQ/1OusxxURBYJ
         fYKq0tDLn0V688TK9+QvBoSDVZzJ7SdQnew9gq2PEbjSnXCFEQqzTyDZLm9YC3oAmUD+
         b7dfYiaPGBw5nnWh/pIrI6VHq2EpNXDAj1YpMRNxn6ph5JPoaHEdpjHbOd1hIb+j88sD
         si/g==
X-Gm-Message-State: AOAM533ZW3XpQ3o7j0UsSY+OZYnvU5Jws/sTVh7dcA19jMIwrkgeUf6J
        UlVTEQ21Zi56svWRUVLYHc43fA==
X-Google-Smtp-Source: ABdhPJw/FDI/WdpspA6dNXN9xAYhdMJOw/WdPg/yjXG3QTCmYa2PhCvUZqhKVm8IO4yNCNBg9sBzJw==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr5586973wrp.339.1606942555805;
        Wed, 02 Dec 2020 12:55:55 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d2sm3438486wrn.43.2020.12.02.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:55:55 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 6/6] bpf: Test bpf_sk_storage_get in tcp iterators
Date:   Wed,  2 Dec 2020 21:55:27 +0100
Message-Id: <20201202205527.984965-6-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202205527.984965-1-revest@google.com>
References: <20201202205527.984965-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the existing bpf_sk_storage_get test where a socket is
created and tagged with its creator's pid by a task_file iterator.

A TCP iterator is now also used at the end of the test to negate the
values already stored in the local storage. The test therefore expects
-getpid() to be stored in the local storage.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 13 +++++++++++++
 .../progs/bpf_iter_bpf_sk_storage_helpers.c    | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9336d0f18331..b8362147c9e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -978,6 +978,8 @@ static void test_bpf_sk_storage_delete(void)
 /* This creates a socket and its local storage. It then runs a task_iter BPF
  * program that replaces the existing socket local storage with the tgid of the
  * only task owning a file descriptor to this socket, this process, prog_tests.
+ * It then runs a tcp socket iterator that negates the value in the existing
+ * socket local storage, the test verifies that the resulting value is -pid.
  */
 static void test_bpf_sk_storage_get(void)
 {
@@ -994,6 +996,10 @@ static void test_bpf_sk_storage_get(void)
 	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
 		goto out;
 
+	err = listen(sock_fd, 1);
+	if (CHECK(err != 0, "listen", "errno: %d\n", errno))
+		goto out;
+
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
@@ -1007,6 +1013,13 @@ static void test_bpf_sk_storage_get(void)
 	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
 	      getpid(), val, err);
 
+	do_dummy_read(skel->progs.negate_socket_local_storage);
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
+	CHECK(err || val != -getpid(), "bpf_map_lookup_elem",
+	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
+	      -getpid(), val, err);
+
 close_socket:
 	close(sock_fd);
 out:
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index dde53df37de8..6cecab2b32ba 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -45,3 +45,21 @@ int fill_socket_owner(struct bpf_iter__task_file *ctx)
 
 	return 0;
 }
+
+SEC("iter/tcp")
+int negate_socket_local_storage(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = ctx->sk_common;
+	int *sock_tgid;
+
+	if (!sk_common)
+		return 0;
+
+	sock_tgid = bpf_sk_storage_get(&sk_stg_map, sk_common, 0, 0);
+	if (!sock_tgid)
+		return 0;
+
+	*sock_tgid = -*sock_tgid;
+
+	return 0;
+}
-- 
2.29.2.454.gaff20da3a2-goog


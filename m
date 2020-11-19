Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F412B97E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgKSQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKSQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:27:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:27:37 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so7285492wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cupBjlguXrCl4ZT1v3zs9G+3ZU+aGNpRnTKwt9ssey4=;
        b=Ec6NYYeS63zOmWW5s4jQ0VA0BK5/FyqPEgNIfEDWtMD11omBPX2zXZ1Qbk62bSfXej
         1abfFXPgm2FZhpzIHEEW4lBVsB2w74f3jX/vM+mIE1mEdNxwfu82OIkbzuyUnd/EfNnI
         G01b3pfmZhD1qdvhLrM1RDLshAbCliqKSb4nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cupBjlguXrCl4ZT1v3zs9G+3ZU+aGNpRnTKwt9ssey4=;
        b=JD+5LExpju6aXRQ+E1BchB6eCANEE0uwgtrtmJx4EytRZpPyOK15LEflI9io/mrN9R
         EH4/fOQ76KVndh0JsrQjIdo6kXHCth0qEwn6pIP6Y2CBAxEG30nWm5RtAlrrXvbHKOhy
         cc79nbFrSz9YLAvyzxFmJ4dSuEEL1zKahXemmitKBPFQWubOb2+s1YHa0PTyqPXQTPIf
         6ghjShlHWzTkcQUoRiHwu1oKn7TqSY8sTL3gKZ9wzlZTOTmgihnIm61yIkfQnkigIUA9
         Bzyffl8Hg0yDzp4Dus2/d4oXLIQrqLuIu86ni2JHDf5lpdRFKVg37NsKKjDmLcqtx89x
         MZmQ==
X-Gm-Message-State: AOAM531UHPmCb37kuniJU3pytJ2bpDMhhKBjDCSSOwcPMknTSBmPRZ7n
        UQnfGV7EDyX0wh7GJ+HNKxfuYw==
X-Google-Smtp-Source: ABdhPJz6+4/1nN99shYibUPJq3+bbKwakw+4YYiqeSuPjaLugrNgNfBAIEyszlLHPcfpw1DUtHwTjQ==
X-Received: by 2002:a1c:6557:: with SMTP id z84mr5572401wmb.144.1605803256233;
        Thu, 19 Nov 2020 08:27:36 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id i5sm380061wrw.45.2020.11.19.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:27:35 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 5/5] bpf: Add an iterator selftest for bpf_sk_storage_get
Date:   Thu, 19 Nov 2020 17:26:54 +0100
Message-Id: <20201119162654.2410685-5-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201119162654.2410685-1-revest@chromium.org>
References: <20201119162654.2410685-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@google.com>

The eBPF program iterates over all files and tasks. For all socket
files, it stores the tgid of the last task it encountered with a handle
to that socket. This is a heuristic for finding the "owner" of a socket
similar to what's done by lsof, ss, netstat or fuser. Potentially, this
information could be used from a cgroup_skb/*gress hook to try to
associate network traffic with processes.

The test makes sure that a socket it created is tagged with prog_tests's
pid.

Signed-off-by: Florent Revest <revest@google.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 35 +++++++++++++++++++
 .../progs/bpf_iter_bpf_sk_storage_helpers.c   | 26 ++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index bb4a638f2e6f..4d0626003c03 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -975,6 +975,39 @@ static void test_bpf_sk_storage_delete(void)
 	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
 }
 
+/* The BPF program stores in every socket the tgid of a task owning a handle to
+ * it. The test verifies that a locally-created socket is tagged with its pid
+ */
+static void test_bpf_sk_storage_get(void)
+{
+	struct bpf_iter_bpf_sk_storage_helpers *skel;
+	int err, map_fd, val = -1;
+	int sock_fd = -1;
+
+	skel = bpf_iter_bpf_sk_storage_helpers__open_and_load();
+	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
+		goto out;
+
+	do_dummy_read(skel->progs.fill_socket_owners);
+
+	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &val);
+	CHECK(err || val != getpid(), "bpf_map_lookup_elem",
+	      "map value wasn't set correctly (expected %d, got %d, err=%d)\n",
+	      getpid(), val, err);
+
+	if (sock_fd >= 0)
+		close(sock_fd);
+out:
+	bpf_iter_bpf_sk_storage_helpers__destroy(skel);
+}
+
 static void test_bpf_sk_storage_map(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -1131,6 +1164,8 @@ void test_bpf_iter(void)
 		test_bpf_sk_storage_map();
 	if (test__start_subtest("bpf_sk_storage_delete"))
 		test_bpf_sk_storage_delete();
+	if (test__start_subtest("bpf_sk_storage_get"))
+		test_bpf_sk_storage_get();
 	if (test__start_subtest("rdonly-buf-out-of-bound"))
 		test_rdonly_buf_out_of_bound();
 	if (test__start_subtest("buf-neg-offset"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index 01ff3235e413..7206fd6f09ab 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -21,3 +21,29 @@ int delete_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 
 	return 0;
 }
+
+SEC("iter/task_file")
+int fill_socket_owners(struct bpf_iter__task_file *ctx)
+{
+	struct task_struct *task = ctx->task;
+	struct file *file = ctx->file;
+	struct socket *sock;
+	int *sock_tgid;
+
+	if (!task || !file || task->tgid != task->pid)
+		return 0;
+
+	sock = bpf_sock_from_file(file);
+	if (!sock)
+		return 0;
+
+	sock_tgid = bpf_sk_storage_get(&sk_stg_map, sock->sk, 0,
+				       BPF_SK_STORAGE_GET_F_CREATE);
+	if (!sock_tgid)
+		return 0;
+
+	*sock_tgid = task->tgid;
+
+	return 0;
+}
+
-- 
2.29.2.299.gdc1121823c-goog


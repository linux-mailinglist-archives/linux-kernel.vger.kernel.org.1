Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551482DACF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgLOMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgLOMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:19:07 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30EC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:26 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id c2so542882wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uG9hUyn2l1hT7e+Msb6nBQLe6pVUc/Tidhzusbc3Z5E=;
        b=F554MBqsbqXbey5idrt7miiBM6ZHDFHoG2ghFR7rjn7HdfCQZPYS1H43gysHs7NFbq
         /Lk/9pNJ7qSg0sIWFWPKL9WYjw9yvwgGduofqpUzxGhTlBbdQho+xweNJK8WTqV3rSk8
         wXJ5RyRJuQgzgWXzD3P3mzYDwlH8Le2SCXpMS+NjpAPDuhH8EvhAHZ0Yg56Qkm/sAvZq
         KxfENSdqqqWdMtc7RFMWiMBxh3rIk5Av33lp7gHT80VAMbKB0QIP2HNvIVBXo5HY2lsB
         N3w3f18x9dyidDX3jib1zNgPBzOgp3iGR9GjhaRZfDkbWpqeDxuQ2jMnjq8C9pkWTsEi
         0X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uG9hUyn2l1hT7e+Msb6nBQLe6pVUc/Tidhzusbc3Z5E=;
        b=ZPaRO3fwRKJJ+uRPS5abkhq5f/xk0srA+IMqfVRexjKwy9NWBX1InsyoIB7y7bCpry
         3EfGhyIJisBLZzmT6XBuq7W0bFocnOoxeCQIn/uijXvSmD+TbI3vPfFV1srz+hwrqRU6
         nOU7NeUusJwxvsa2NAMDyWDKvkOMfE/JDoX/PE1hCADEFLCgBcyrR7xj2aBnOpvVfizX
         kzIoBf2dSu8XGuUFSQ0ABgen9nbAHRQJO5tyPEsQ90UbdC//52cuZwCxrEq8UgBUrd/o
         dk4vsQ5YEPtvW6JHzNFWBu+poAAVJDQ5QMNxUuYAQCXuHBwoWRxjjE3rcTIFbI/Hjosd
         E+0w==
X-Gm-Message-State: AOAM5333zXgnTWSPxD6bUk7aqGe+2sap74tkd88Ar0FBtuf4A9qPhIWx
        f3ELdQfAygtM/b0cDQSSV/T1LQ6n/+WnOg==
X-Google-Smtp-Source: ABdhPJyfdERVBvcuek5OzTi7nZCXKqkrtDew8jEXtkoC7TJsiXIQjk27q+RU+usPf0JzEydhk65FTCcPS4SN2A==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr282870wms.0.1608034704833; Tue, 15 Dec 2020 04:18:24 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:06 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
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

This provides a convenient perf ringbuf -> libbpf ringbuf migration
path for users of external polling systems. It is analogous to
perf_buffer__epoll_fd.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Difference from v1: Added entry to libbpf.map.

 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 tools/lib/bpf/ringbuf.c  | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6909ee81113a..cde07f64771e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -536,6 +536,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__epoll_fd(struct ring_buffer *rb);

 /* Perf buffer APIs */
 struct perf_buffer;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7c4126542e2b..7be850271be6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
 		btf__new_split;
 		xsk_setup_xdp_prog;
 		xsk_socket__update_xskmap;
+                ring_buffer__epoll_fd;
 } LIBBPF_0.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 5c6522c89af1..45a36648b403 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -282,3 +282,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 	}
 	return cnt < 0 ? -errno : res;
 }
+
+/* Get an fd that can be used to sleep until data is available in the ring(s) */
+int ring_buffer__epoll_fd(struct ring_buffer *rb)
+{
+	return rb->epoll_fd;
+}

base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
--
2.29.2.576.ga3fc446d84-goog


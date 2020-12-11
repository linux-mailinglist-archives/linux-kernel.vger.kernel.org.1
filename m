Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00F2D7CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395203AbgLKRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395175AbgLKRZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:25:00 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:24:19 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k128so3534794wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=APHaC7n4fJLD3RZO8AClrrDhtpxAUE0wAg5Ep4XGGU0=;
        b=qq7A2rqPzveYYXRI9N2jY2DGTRvg8n9VwK+k+N7hTbyEoBTUXCM+OI8LMsazJ5pFPQ
         YCV20vYcOxLziH9Ir48s1vBJ9vF+5nyJkwf3Gw67Gdh8r5rumur9HMhO4TRjg2Rr+DsW
         1L2oPOsRyjwpUWKhWv0+vjQtUVwq/zLpZX9gfzsZIgsPWvHWCuOv2Rvjeu6qxoHv9Od/
         yNQnvNVqkdoPw87GUYgHWI6ZTvIUk2ty5rAFa+0+cDQMvENdXpWsKq1gppOcjNRhTgq3
         hIq0bmtwTaRcbkTZmHuYQoOZg2XRVlgl3dx6YZfMuC9vJJw77tSLkX5sEDZsluyJe8zR
         ty7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=APHaC7n4fJLD3RZO8AClrrDhtpxAUE0wAg5Ep4XGGU0=;
        b=Ny9zeOnpRjaWPzD0ZrVC6CIUbIoYenkGAbe8rq4Jlo2UIQCX30BkIForYODvrYp9OH
         K6KPoge0zgSc6XFNdsaEal/RiS3stsFilAXli2Hx7rgbfZJvNu0HBvzg3Ze/Akd/1b3I
         vaq2cmllspR0clYlfKic1iUjkrr/WbWcM3SXJo0dVSadMyhs+oqAgHcmIAJfWKu/IeS2
         M57N9ekuQmOAV+0mKwZyduoywvHdkI6i9AABZUGlbos6KJhzS5G6/6pv7AyAioV5gqNJ
         NipjPnA2vBxxT8pcI8kz7f2bVWqx0D5XqdEdQLTkkGQdtwDA8MgzEulgM9LBuzF+TtSA
         iBIw==
X-Gm-Message-State: AOAM532LXSmoUsYiO7DF6ed+0FteRQxjEeBgX3JCbOGiFVHqvGBS8XGM
        ZtXa01JJ69tM6S9rRb3/lfJ0pR2h+IJizg==
X-Google-Smtp-Source: ABdhPJyWfQvwgEnC9j8cMIC0WkCfewAlRRlIoL37izfTOAmQzWAl7i6PUwezm7LezdzsGUAfiaufxQ4v121LRA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:e10b:: with SMTP id
 y11mr15012503wmg.65.1607707458151; Fri, 11 Dec 2020 09:24:18 -0800 (PST)
Date:   Fri, 11 Dec 2020 17:24:09 +0000
Message-Id: <20201211172409.1918341-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next] libbpf: Expose libbpf ringbufer epoll_fd
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the user to do their own manual polling in more
complicated setups.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/lib/bpf/libbpf.h  | 1 +
 tools/lib/bpf/ringbuf.c | 6 ++++++
 2 files changed, 7 insertions(+)

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


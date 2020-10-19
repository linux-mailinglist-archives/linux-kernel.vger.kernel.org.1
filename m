Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4D292934
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgJSOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:22:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D43C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:22:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b6so72119pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/V9Dl+1SlZ0dUCQBI3+jo/7i9xpkT3xnOYNJS5o4BOI=;
        b=JcapMd+XTBzyr3lXDa7ilbnuLBLUonybYSy6MGroAv42pUoYKtW2NNyjYmvlf+h1Ed
         5XQRW2/6NAYprpP9L069RVoEI048pXnYA88cNW1KzRl4ReZjWXlG1wZqmA2P8bNfbh0P
         WiU5fnGbAtME5MeTVoGLz0nmwGLhvpu/fZEvGL6avK4bc0uFij+NdxagCJVLwL/nzENA
         IZKjmmm8y0XE7mD8ETjXRPVIJdPBNTu70ANcWG5g8rtFE1SD8LbtLnbB1X6kWl0bN5sd
         MyjiT1qas+cvRYLmKeAWIUsv2WlWrRi56u0pFlNeniV4OWzqjP01E3twLvBsrzkg2CE7
         UWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/V9Dl+1SlZ0dUCQBI3+jo/7i9xpkT3xnOYNJS5o4BOI=;
        b=dCfPwQL+jhc75+pc02Pwv5KqDTzcHTiAhIXXkpPsAZRPDW+2DMb14sC41QYHiEDyhv
         NS4juPqGhDmbQ3VTZ5jgo8oRjUTDSrxfuoOQRAxarKcwUqc96H0dvLTTIVHJA4nJyUeU
         iza39oKkrGo/DToOp/TEW9svuMYMaadWnKhliuBnbt4b9wF4ce9KIJMw4MMBHDUF5L5O
         +fIVHTS8EV1TM8Hb5PZhxUf3KHe3AqgLGNOIc3+A+94B0Nl+hqFRXZSI6JuupLBxH8Lc
         DIPUKMRXbDZVBGkfxlSZRYxwLLZdL26MNLFLaNLmqZ6XBzt0m5781Ir51bss435R+TFj
         5RdQ==
X-Gm-Message-State: AOAM531l/YNxbsNC+o3WI+Yv7WMP8TCf0LWT4CL8zi+/4/nmmX7Qy0t7
        tk7N76NQRngv00EXS1n0xThtucjr230z3A==
X-Google-Smtp-Source: ABdhPJzz1GBu486KUnAj9LuiGTyHBs0Spg+Unla4EO8UnH2Sj+HdG+3et0bejsLNPC24afLo0Uc2EQ==
X-Received: by 2002:a17:90b:2301:: with SMTP id mt1mr50954pjb.80.1603117376865;
        Mon, 19 Oct 2020 07:22:56 -0700 (PDT)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id a11sm78329pfn.125.2020.10.19.07.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 07:22:56 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Returns 0 on success from ring_buffer_resize()
Date:   Mon, 19 Oct 2020 22:22:42 +0800
Message-Id: <20201019142242.11560-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to check the new buffer size, and the return value
had confused resize_buffer_duplicate_size().
...
	ret = ring_buffer_resize(trace_buf->buffer,
		per_cpu_ptr(size_buf->data,cpu_id)->entries, cpu_id);
	if (ret == 0)
		per_cpu_ptr(trace_buf->data, cpu_id)->entries =
			per_cpu_ptr(size_buf->data, cpu_id)->entries;
...

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93ef0ab6ea20..3b5f8ec3781e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1952,18 +1952,18 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long nr_pages;
-	int cpu, err = 0;
+	int cpu, err;
 
 	/*
 	 * Always succeed at resizing a non-existent buffer:
 	 */
 	if (!buffer)
-		return size;
+		return 0;
 
 	/* Make sure the requested buffer exists */
 	if (cpu_id != RING_BUFFER_ALL_CPUS &&
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
-		return size;
+		return 0;
 
 	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
 
@@ -2119,7 +2119,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	}
 
 	mutex_unlock(&buffer->mutex);
-	return size;
+	return 0;
 
  out_err:
 	for_each_buffer_cpu(buffer, cpu) {
-- 
2.17.1


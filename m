Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290642B0ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKLUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKLUJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:09:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4593C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:09:35 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so7309563wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7TtYo1PxIxzaXqQ92+BjQcHOSuanEJBk/khixUznWc=;
        b=QJ8Jtl+WZpjf5yduhb8CapzzbPXA3g3XODaEtW2SWUv6Ock/nei1tkkhKhv0Uu3vCz
         9HpCSmQOKbqt7EENwfppy8KpRVLY9hfLjrI0xeWiTVbd2D+/3TnW6gIVVbGY4qMRj1nc
         Hv4M8a+lF0N9cUNgH4I3SrgerWJty9FJpLJ6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7TtYo1PxIxzaXqQ92+BjQcHOSuanEJBk/khixUznWc=;
        b=mS+hAJs1Coi3DbANhThejED5swz52C6EwWts+S8gfdP6BGB8pWnV0ltIzcbR44/BBY
         Od44zLa2jMe/wVi56QAqg2SKazxEirdauEW+Xg8xHXDrSPe7APyGZbF4emnNhT/YhVXI
         9Ci8rYUHBgPlbm9tmcW9MJSgDrPQH9WOVNJ08nRxDHMndmvUQt+M9iH+J7Q5HP9cZNwp
         kfSVxu9ek6evMDXaY296berSpptzWWk1ChVgk+sv5xnRmH3MdkF9Bx+p3R2d98SUgWXr
         xb0mZrtcBMAHY0pXF6H7j6tLYy0B4anLk+iZ9TzBe6NGAzw3NbHrJ8OdJnDDMOnGiQUy
         x1ww==
X-Gm-Message-State: AOAM531hqzYSKzBVoGhZUDRj/mXTN9GHXSZyesOm5Rgr2FWtyQqvmpoY
        1QjhsAR36MG22FY+uy1p74VSTQ==
X-Google-Smtp-Source: ABdhPJyFTHpTMFFLXUqoegQKs9aIO0k6XsjW9NUhBoGiF0NBrYgkmk1CXv7vmBywKXeD8k7OORJeDA==
X-Received: by 2002:adf:9407:: with SMTP id 7mr1552417wrq.182.1605211773935;
        Thu, 12 Nov 2020 12:09:33 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id g4sm6913032wrp.0.2020.11.12.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:09:33 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@google.com>
Subject: [PATCH] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Thu, 12 Nov 2020 21:09:14 +0100
Message-Id: <20201112200914.2726327-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@google.com>

Iterators are currently used to expose kernel information to userspace
over fast procfs-like files but iterators could also be used to
initialize local storage. For example, the task_file iterator could be
used to store associations between processes and sockets.

This exposes the socket local storage helpers to all iterators. Martin
Kafai checked that this was safe to call these helpers from the
sk_storage_map iterators.

Signed-off-by: Florent Revest <revest@google.com>
---
 kernel/trace/bpf_trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..3530120fa280 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,8 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
 
+#include <net/bpf_sk_storage.h>
+
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
 
@@ -1750,6 +1752,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       NULL;
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
+	case BPF_FUNC_sk_storage_get:
+		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		       &bpf_sk_storage_get_proto :
+		       NULL;
+	case BPF_FUNC_sk_storage_delete:
+		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		       &bpf_sk_storage_delete_proto :
+		       NULL;
 	default:
 		return raw_tp_prog_func_proto(func_id, prog);
 	}
-- 
2.29.2.222.g5d2a92d10f8-goog


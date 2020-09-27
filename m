Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23527A43C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI0VQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI0VQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:16:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F0C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so9808656wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a99k07/EyDDQHmuhibQRaLo4XWgbxK6z35bVqiMsuv8=;
        b=CjFXYG9BR8dkXSbiyxLxrUYbFRhjiOb1vcwmYg4vsW7360k60NHd/8S43UvXZA5FT5
         y5VyC5QYUXGmFaaGmwntXMTbUvqNhpSq3moC26ISTM5UAC+skTj4T6PO3hrzqrT6z15R
         hmAIvGK4AYwwCnEQeuzshHnQDATrFWpGn/iA1WzpjEShT3FvgfRikun4C5n3kerVeLUL
         1ASUSioryEuYeddzAzUwSfgNb8cD3KjYmuWABM8tEtkal6+cf2e68Low/keUuApsOV6f
         /6j0xr2ThzRu2LrBh/JoIfZRwmi19wGblaXZqiOMVOmiIOcQs99OXexE8U3y7loHj9U+
         9Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a99k07/EyDDQHmuhibQRaLo4XWgbxK6z35bVqiMsuv8=;
        b=kxMRYxQ/H+WdsmJbUqoyN2zfA4qI9v9R2FtGJAP9O1ZxcsPbNV4RwNMp7mw0u9/xNr
         UNfpC0dqNtFA68m1sQCL+d1Z+vw+HIxEUt/Hz0ssVMk+hNtW2rprWk8tw91lcfhugDPm
         3nqpnZ/K4Qs2VJ6kvlSFJ36o3JrhnfZg5UkKUdCo20Xtwpq4yychj2eKEeD2qDuRSIT7
         yYoqbFViPHBiRg1Vdetp5fL2eeIjtvebXDgTlG6Kt/kp6nVobdc0wBcCA4k9R5vB36g/
         ff/cnLGt8N8TxcBwQgQCjrnxPxeoRKQi73g/8XxWpi0KZdNC9CiyPLNN/4RZq9Fi2I6W
         9k1g==
X-Gm-Message-State: AOAM532gKL6mSr7eLIHK2Jzz2xz/NML0eGJ1+aTi1q85nSrJ4wun9xf/
        vd0OBYVqrwdC9BBGYYiYaOWoUA==
X-Google-Smtp-Source: ABdhPJxsis82EaVU2Ny17vWSbD6xDjUxPFjWZp3tZqcI8T/hln1YFSfFswHXGrJGbExBNQLQpInGKQ==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr15438828wrv.222.1601241377872;
        Sun, 27 Sep 2020 14:16:17 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s17sm11396676wrr.40.2020.09.27.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 14:16:17 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 3/3] kernel: debug: Centralize dbg_[de]activate_sw_breakpoints
Date:   Sun, 27 Sep 2020 22:15:31 +0100
Message-Id: <20200927211531.1380577-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927211531.1380577-1-daniel.thompson@linaro.org>
References: <20200927211531.1380577-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During debug trap execution we expect dbg_deactivate_sw_breakpoints()
to be paired with an dbg_activate_sw_breakpoint(). Currently although
the calls are paired correctly they are needlessly smeared across three
different functions. Worse this also results in code to drive polled I/O
being called with breakpoints activated which, in turn, needlessly
increases the set of functions that will recursively trap if breakpointed.

Fix this by moving the activation of breakpoints into the debug core.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/debug_core.c       | 2 ++
 kernel/debug/gdbstub.c          | 1 -
 kernel/debug/kdb/kdb_debugger.c | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index faa1f99ce65a..e4339fd82db0 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -768,6 +768,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		}
 	}
 
+	dbg_activate_sw_breakpoints();
+
 	/* Call the I/O driver's post_exception routine */
 	if (dbg_io_ops->post_exception)
 		dbg_io_ops->post_exception();
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index cc3c43dfec44..e9a9c3097089 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1061,7 +1061,6 @@ int gdb_serial_stub(struct kgdb_state *ks)
 				error_packet(remcom_out_buffer, -EINVAL);
 				break;
 			}
-			dbg_activate_sw_breakpoints();
 			fallthrough;	/* to default processing */
 		default:
 default_handle:
diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
index 53a0df6e4d92..0220afda3200 100644
--- a/kernel/debug/kdb/kdb_debugger.c
+++ b/kernel/debug/kdb/kdb_debugger.c
@@ -147,7 +147,6 @@ int kdb_stub(struct kgdb_state *ks)
 		return DBG_PASS_EVENT;
 	}
 	kdb_bp_install(ks->linux_regs);
-	dbg_activate_sw_breakpoints();
 	/* Set the exit state to a single step or a continue */
 	if (KDB_STATE(DOING_SS))
 		gdbstub_state(ks, "s");
@@ -167,7 +166,6 @@ int kdb_stub(struct kgdb_state *ks)
 		 * differently vs the gdbstub
 		 */
 		kgdb_single_step = 0;
-		dbg_deactivate_sw_breakpoints();
 		return DBG_SWITCH_CPU_EVENT;
 	}
 	return kgdb_info[ks->cpu].ret_state;
-- 
2.25.4


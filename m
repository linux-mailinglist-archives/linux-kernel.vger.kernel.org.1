Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0257A268BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgINNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgINNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:02:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92167C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so18653108wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOLZ70bedyzf8xgXzV0MTRrdMCvy/3UOdRHKK+GhNMo=;
        b=POu12cEaJFApnX2+rMx/2kxThtVNQIhVlX9u3uZHeXLJOzGppLaqXQdv+tPvj5R+xE
         tX780vtge+r4reu3udS1EdIs+vCSCvs8D/OznPjbRs9vgy+n5aPGJSYIbTB6XBJCv5nN
         Eo26ybzSJ1+gIxNxBFYRTZ8MiiuFtHMtM5t4awBHb5W7QJUXZGMexDV6XkZH+/ZibUR/
         c57u3FcVLQ9yVf6Pe0gAy47AMCdKNxJpebRjlWTpU6ea9Nj/lqnkyRtHq5C2oaTmtJUN
         vB+yien4dbtStTvDkZj+6qjtUCyixOMzrjEZpwkgJj94aR/1IDbIEu6Lo/fqksseLJT1
         Csmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOLZ70bedyzf8xgXzV0MTRrdMCvy/3UOdRHKK+GhNMo=;
        b=SnTABtOrLgWuEWi0C5xMoKWO9lhGwiqZqpKdZq9nlSzUBOWIhruZUGxVMtyphaL4b0
         1W0ShEmSyc8WCh4F48785mRhAuqk9amYBpboBYD6ET6tXedsKWcbAUwIUoWTqznylyQp
         OyWGcLGOqsouiUlgtGONRidujvkkHpqYNgQfDNPMtZadwWI07Bjhl3kXM4q7gLHxWomx
         q9HLm0kZqL/pOQs9I7vvkHslqu/A6asZ4LYcjXiLSGfeszrE1IwVdD1iAzDaJUKi0SwK
         YEIxrk6+XEGPCY+P2fmfwC3WBJ4SsDVdu1I4YTjw4dLJ0WtLrW62mr7MNTSzZQYez4zr
         vGJw==
X-Gm-Message-State: AOAM532NeJgHHmcY3s1nrIMCSIh/AXf8C2ZLbanwj2qMhj3l2KQWfRAX
        XkaagfsE/Q2+8YlSitAilMnkunNAvr9leg==
X-Google-Smtp-Source: ABdhPJxdxolEdcYMjP3ctpO3wrxCQQtg4g3aiPudfFv1rQGBGhcDTJuT8gbgF3Z/w5SfmtM8lkj34w==
X-Received: by 2002:adf:f70d:: with SMTP id r13mr16395380wrp.317.1600088525276;
        Mon, 14 Sep 2020 06:02:05 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t6sm23420983wre.30.2020.09.14.06.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:02:04 -0700 (PDT)
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
Date:   Mon, 14 Sep 2020 14:01:43 +0100
Message-Id: <20200914130143.1322802-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200914130143.1322802-1-daniel.thompson@linaro.org>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
---
 kernel/debug/debug_core.c       | 2 ++
 kernel/debug/gdbstub.c          | 1 -
 kernel/debug/kdb/kdb_debugger.c | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 9618c1e2faf6..74d42d3f3180 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -763,6 +763,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
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


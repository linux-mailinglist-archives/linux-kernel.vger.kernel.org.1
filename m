Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDB27A438
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI0VQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0VQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:16:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210CC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so4907808wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzXzJiEQzaPFqdy2MIXLtzA73Bjzgyzv9JbfCBicRRs=;
        b=igyIzAGHvljICFK+IdbUtULqLeHSPyp6JXzjwbaqe8JGlP/t81CSxr057hte0SgvqC
         s1GdSXzsLau3c8d8TvlZ2X6nHK+u489twWeKQCcjTLHtFmW8xAO/Sce0ReF+nHi4WMFp
         v8ym2R5v+4LFIuEyudixhrzuyMlww1UrKQETRlCpwXD9TvXM20ugVZfrn2viNTYhvCki
         oc6P14j/c2TrJP4jtnN9I3dF7FmkEc5HLL4Jj1ftXuXUjxZULyCrpzyg/nbjYMNj4bdw
         BnOi9r9TdbodLirQuJrahQhkVWaCOlph68bnak4hOwoXMgG6uMXksvEXXgZAMbVEwU3M
         IFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzXzJiEQzaPFqdy2MIXLtzA73Bjzgyzv9JbfCBicRRs=;
        b=oh+DW0fKKxs+wlrOLBqOiaa/d7IqXG/KUSo/YOc2FAksIYAqKQMzc45T4+gDPv6yGD
         zc7Kp6ZsUyxigmQwtD+DpynxgEqiLoubRh9sHBLVEtNwFGAgHyJVc8r38cVn0RJeD4hh
         AVGm0d9d4CoiDudgB8ZlUhKbH3h2Xl8aGjr0RaCfBwzMwc4+9Fi4NU1olDySCNMzgHlk
         vTxq/qRpIJLzHuOdGmEGFHMZ3SF0QGtW0rSfTBArbJuOnZvF0ugeeIhOP1FaO95B4NgB
         Wd/ZiK+vbL1w2g8nz9G3MZr4aKuAhbqZXPhxZIr5ppVaxMtKImJ1RGOKUumcXF69rp1M
         Ry2w==
X-Gm-Message-State: AOAM532do4Umt+exxcAEGeGPYXnerTCR2u2CtynURMFRCXzXvzbGxkaV
        dmiXI2+mHNLZzKclX1Ce80ML5Q==
X-Google-Smtp-Source: ABdhPJw6VoFcPo1scinS68irhUR+vggXWVATUkZHK+aYqRklkunCw9o1l/IXKGL2BA0qd2LyeF3Epw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr8611991wmn.41.1601241374477;
        Sun, 27 Sep 2020 14:16:14 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s17sm11396676wrr.40.2020.09.27.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 14:16:13 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 0/3] kgdb: Honour the kprobe blocklist when setting breakpoints
Date:   Sun, 27 Sep 2020 22:15:28 +0100
Message-Id: <20200927211531.1380577-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kgdb has traditionally adopted a no safety rails approach to breakpoint
placement. If the debugger is commanded to place a breakpoint at an
address then it will do so even if that breakpoint results in kgdb
becoming inoperable.

A stop-the-world debugger with memory peek/poke intrinsically provides
its operator with the means to hose their system in all manner of
exciting ways (not least because stopping-the-world is already a DoS
attack ;-) ). Nevertheless the current no safety rail approach is
difficult to defend, especially given kprobes can provide us with plenty
of machinery to mark the parts of the kernel where breakpointing is
discouraged.

This patchset introduces some safety rails by using the existing kprobes
infrastructure and ensures this will be enabled by default on
architectures that implement kprobes. At present it does not cover
absolutely all locations where breakpoints can cause trouble but it will
block off several avenues, including the architecture specific parts
that are handled by arch_within_kprobe_blacklist().

v4:
* Fixed KConfig dependencies for HONOUR_KPROBE_BLOCKLIST on kernels
  where MODULES=n
* Add additional debug_core.c functions to the blocklist (thanks Doug)
* Collected a few tags

v3:
* Dropped the single step blocklist checks. It is not proven that the
  code was actually reachable without triggering the catastrophic
  failure flag (which inhibits resume already).
* Update patch description for ("kgdb: Add NOKPROBE labels...") and
  added symbols that are called during trap exit
* Added a new patch to push the breakpoint activation later in the
  flow and ensure the I/O functions are not called with breakpoints
  activated.

v2:
* Reworked after initial RFC to make honouring the blocklist require
  CONFIG_KPROBES. It is now optional but the blocklist will be enabled
  by default for architectures that CONFIG_HAVE_KPROBES

Daniel Thompson (3):
  kgdb: Honour the kprobe blocklist when setting breakpoints
  kgdb: Add NOKPROBE labels on the trap handler functions
  kernel: debug: Centralize dbg_[de]activate_sw_breakpoints

 include/linux/kgdb.h            | 18 ++++++++++++++++++
 kernel/debug/debug_core.c       | 22 ++++++++++++++++++++++
 kernel/debug/gdbstub.c          |  1 -
 kernel/debug/kdb/kdb_bp.c       |  9 +++++++++
 kernel/debug/kdb/kdb_debugger.c |  2 --
 lib/Kconfig.kgdb                | 15 +++++++++++++++
 6 files changed, 64 insertions(+), 3 deletions(-)

--
2.25.4


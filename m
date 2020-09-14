Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05929268BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgINNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgINNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:02:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so11182410wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j11jZizj6KykwFnlMpZUSmD4ixbxGJ3f+H4sr6REKAc=;
        b=U5sDUJFQGkIzR4rv2WYyCEAIfiTmifUAhGXlILPOKVoorTjbw4oLiuAFTBoRzYx0ri
         l7SDFvtolHpXNL6iGcVzBS1H5jSmDDlXbOqJLF1J3WwIKyFl/PPtRvncDFLus+y/CNCx
         o0zx8DAEFW8VIa/cwUBx81/a2fGm/vK1WaCRlHaisfadEfW6aw0YCHLQiVMXINzoytlN
         bDIxdwbbxzRWs7QYkW3jWldNDCu7xcwWyvbxUR1iFefkpyTfJpOrSIgaGEwJanBvHVPL
         u1DlClDDd/bHNPtXcaBW0N9CiYQdMp/5YFjqcwgcTab8jL0X12Qg6kGCqu0DeHiknJ3O
         KLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j11jZizj6KykwFnlMpZUSmD4ixbxGJ3f+H4sr6REKAc=;
        b=YBYY7FqZBkaRoIJfHnwexgKwVe16rPNhHDo6ne1/V4kaGpl0AE9lmaDRcdDmVjZhZ5
         9sehXxcrYxlraEVoKOOxIScn144S1ef8Lo+O5s3fP3RTic2y7nG3U8f8ZmIYVFSoc0Yg
         cKiSG1D8gc8L1TIQ1d4wXmhpifncI+YAvA48nEBumCCYsThqIO1WZ3jfWcEirW1O05Hi
         Ms+bU3kRKSXyXO85Ef4jALRdfgzMhPtPbzwDDCqpvmtW4yUmVMnt6kPQsCsLk3imCQSK
         TcPBoeZxmABguueMPjtDe1eqQoqYRtItc+OEYX8V+DleNB4CDwem4fR2TQpR3FSnV+lo
         Kiaw==
X-Gm-Message-State: AOAM533SHOUUmff1nZja9eszMLYZ0E7njTYUNTU6QmJlGqdQnN20O65H
        q6IK6sQkpMqYtJ+yssxCuAfoUA==
X-Google-Smtp-Source: ABdhPJzIfCh1Zp0fe1yIl/k1EaljKHGFxBKKBpawbZYBW4iZy0TnSRtO4zLscJ9c22EXcbqJvFjplg==
X-Received: by 2002:a1c:7502:: with SMTP id o2mr14623468wmc.29.1600088521467;
        Mon, 14 Sep 2020 06:02:01 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t6sm23420983wre.30.2020.09.14.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:02:00 -0700 (PDT)
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
Date:   Mon, 14 Sep 2020 14:01:40 +0100
Message-Id: <20200914130143.1322802-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
  CONFIG_KPROBES. It is not optional but the blocklist will be enabled
  by default for architectures that CONFIG_HAVE_KPROBES

Daniel Thompson (3):
  kgdb: Honour the kprobe blocklist when setting breakpoints
  kgdb: Add NOKPROBE labels on the trap handler functions
  kernel: debug: Centralize dbg_[de]activate_sw_breakpoints

 include/linux/kgdb.h            | 18 ++++++++++++++++++
 kernel/debug/debug_core.c       | 17 +++++++++++++++++
 kernel/debug/gdbstub.c          |  1 -
 kernel/debug/kdb/kdb_bp.c       |  9 +++++++++
 kernel/debug/kdb/kdb_debugger.c |  2 --
 lib/Kconfig.kgdb                | 14 ++++++++++++++
 6 files changed, 58 insertions(+), 3 deletions(-)

--
2.25.4


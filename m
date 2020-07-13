Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBB21B5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 09:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJNK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:10:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80DC2077D;
        Fri, 10 Jul 2020 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386658;
        bh=IdMXbwyEGNqssAVvu1gRwaePl/hFoKsm8vRdaRbHayM=;
        h=From:To:Cc:Subject:Date:From;
        b=MwNW/yxg+TlGN1RCZn1NS/Dplg2o27i6zc3y7WncWdpM096idPwrXGYkY+7VucHPG
         mkOax9I/xrcqPVVFJLGIXVITPo5xWWg/05TBbm7DxtShJ5spB1IZt6gj3Cjx35nojh
         DRKaHmalGk4j52Tc8C0znfxApZpedtuH6mcWgiDw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 0/4] perf-probe: Fix GNU IFUNC probe issue etc.
Date:   Fri, 10 Jul 2020 22:10:54 +0900
Message-Id: <159438665389.62703.13848613271334658629.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the v2 patches to fix some issues of probing on GNU IFUNC,
duplicated symbols, and memory leak, which were reported by Andi.
V1 is here:

 https://lkml.kernel.org/r/159428201109.56570.3802208017109058146.stgit@devnote2

In this version, I've added Srikar's reviewed-by and Andi's Tested-by (Thanks
Srikar and Andi!) and fix some messages and code according to the comment.

Thank you,

---

Masami Hiramatsu (4):
      perf-probe: Avoid setting probes on same address on same event
      perf-probe: Fix wrong variable warning when the probe point is not found
      perf-probe: Fix memory leakage when the probe point is not found
      perf-probe: Warn if the target function is GNU Indirect function


 tools/perf/util/probe-event.c  |   18 ++++++++++++++++--
 tools/perf/util/probe-finder.c |    5 ++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

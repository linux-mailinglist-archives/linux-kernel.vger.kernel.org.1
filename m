Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4033F219A70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGIIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 04:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgGIIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:06:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69D82070E;
        Thu,  9 Jul 2020 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282016;
        bh=Xq0HhldQJjIqVceZma9RR/Iq0hTiyoPSHamuX31b3H4=;
        h=From:To:Cc:Subject:Date:From;
        b=fhA/htY437eypjArUNMqIUNJoDc63rJ/fDYWBCIUYQqCBf9SzX32tzUreEYiksTYj
         JiiAs8NloPm9dqi3G05t28+3NNbPtdl2vzD9DwgWVBnftxPWut20Ru0feJ/IHFs07J
         YleckON+HuGLkkWzc/wyd1FzpIjFb6pG4hvmNKGs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 0/4] perf-probe: Fix GNU IFUNC probe issue etc.
Date:   Thu,  9 Jul 2020 17:06:51 +0900
Message-Id: <159428201109.56570.3802208017109058146.stgit@devnote2>
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

Here are patches to fix some issues of probing on GNU IFUNC, duplicated
symbols, and memory leak, which were reported by Andi.

Andi reported that some issues on probing memcpy function in glibc,
which was related to GNU IFUNC (indirect function). As I described
in the patch [4/4], it is hard to support probing on the functions
which are selected by GNU indirect function because those are chosen
at runtime. I think we need a user-mode helper in uprobes to find which
one is chosen at runtime. (Oleg, Srikar, would you have any idea?)

While cleaning up the patches, I also found a memory leak problem
so fixed it ([3/4]).

Thank you,

---

Masami Hiramatsu (4):
      perf-probe: Avoid setting probes on same address on same event
      perf-probe: Fix wrong variable warning when the probe point is not found
      perf-probe: Fix memory leakage when the probe point is not found
      perf-probe: Warn if the target function is GNU Indirect function


 tools/perf/util/probe-event.c  |   14 ++++++++++++++
 tools/perf/util/probe-finder.c |    5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

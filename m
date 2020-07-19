Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160E2251E9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGSNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 09:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgGSNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:02:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD8A22B4D;
        Sun, 19 Jul 2020 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595163736;
        bh=Id77zpyFsJHytkt8QiavJBPJpLwSIW2/srv55L169SE=;
        h=From:To:Cc:Subject:Date:From;
        b=1dOQW/LdsFiyQM4tBMjdwsLSYCpwnmHPoMHCz1KVNnlNhVU53V5cmN0BBFp5GhIUN
         AlJwbSF+s2dfs3ijby55wS6uxxPWo9K7GPv4JO6p24zEr0EknrKEEWFL7/AXluVQ+X
         43qiq0UfAt+77gqp8KdtUZhl4nKUliQ9D1OOwhx8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/urgent improvements and fixes
Date:   Sun, 19 Jul 2020 10:02:05 -0300
Message-Id: <20200719130205.2430019-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 8882572675c1bb1cc544f4e229a11661f1fc52e4:

  Merge tag 'drm-fixes-2020-07-17-1' of git://anongit.freedesktop.org/drm/drm into master (2020-07-16 21:39:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-19

for you to fetch changes up to 25d4e7f513d4f8afcf81cb6f00edf1248b0ff8fc:

  tools arch kvm: Sync kvm headers with the kernel sources (2020-07-17 09:39:16 -0300)

----------------------------------------------------------------
Third batch of perf tooling fixes for 5.8:

- Update hashmap.h from libbpf and kvm.h from x86's kernel UAPI,
  silencing build warnings.

- Set opt->set in libsubcmd's OPT_CALLBACK_SET(). Fixes
  'perf record --switch-output-event event-name' usage.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Arnaldo Carvalho de Melo (2):
  perf tools: Sync hashmap.h with libbpf's
  tools arch kvm: Sync kvm headers with the kernel sources

Ravi Bangoria (1):
  libsubcmd: Fix OPT_CALLBACK_SET()

 tools/arch/x86/include/uapi/asm/kvm.h |  5 +++--
 tools/lib/subcmd/parse-options.c      |  3 +++
 tools/perf/util/hashmap.h             | 12 ++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.26.2

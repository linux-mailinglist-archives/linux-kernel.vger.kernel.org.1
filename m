Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84352A0E34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgJ3S70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgJ3S70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:59:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.223.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A070C2072C;
        Fri, 30 Oct 2020 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604084365;
        bh=o1IAhNJMoX4o4Wisjvms7J1UX40PfopzotbKZQI3Hw4=;
        h=From:To:Cc:Subject:Date:From;
        b=MrAZVF7QmCOkeiwDJKaCNlSa2Qes1oEpWoyB2cJG1HUSUGDoqyXKO05rDI6ug/era
         Y5CkFf7bxM4FK3kLeopFmLtRPuIC/GmxxvD/jjj5lYSDB71rgzBbWxs4U5pcIPlPBE
         7GNelMHzo4I4ALUImJW8BqudQS5zdi9Jl2O29Ol8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Leo Yan <leo.yan@linaro.org>, Peng Fan <fanpeng@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stanislav Ivanichkin <sivanichkin@yandex-team.ru>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.10: 2nd batch
Date:   Fri, 30 Oct 2020 15:59:08 -0300
Message-Id: <20201030185908.20611-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 7cf726a59435301046250c42131554d9ccc566b8:

  Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-10-18 14:45:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-10-30

for you to fetch changes up to 7b3bcedf5ee50ca9b0ec74003e14ccbd088408d1:

  perf scripting python: Avoid declaring function pointers with a visibility attribute (2020-10-30 08:35:16 -0300)

----------------------------------------------------------------
perf tools updates for v5.10: 2nd batch.

- Update documentation about CAP_PERFMON.

- Add --quiet option to 'perf stat record'.

- Update kernel header copies.

- Do not compile BPF specific code if libbpf isn't available.

- Fix visibility attribute in python module init code with newer gcc.

- Add perf arch instructions annotate handlers for MIPS.

- Show in 'perf version' if libpfm4 is linked in.

- Fix DRAM_BW_Use 0 issue for CLX/SKX in intel JSON vendor event files.

- Add test for JSON defined arch std events.

- Fix the build on new fedora by removing LTO compiler options when
  building perl support.

- Improve warning if no memory nodes are detected.

- Make 'perf test tsc' present in arm64.

- Support regex pattern in --for-each-cgroup in 'perf stat'.

- Remove broken __no_tail_call attribute.

- Add kvm-stat for arm64.

- Fix segfault when trying to trace events by cgroup.

- Fix crash with non-jited BPF progs

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results on the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-for-v5.10-2020-10-30

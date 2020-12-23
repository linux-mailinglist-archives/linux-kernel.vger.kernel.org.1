Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB12E190B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgLWGkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLWGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:40:32 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E59C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:51 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b5so2674717pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oNvfzfKf6TpzAj6vq/wi/rHDkEjWq04NYAvd2KpIxsc=;
        b=VvgrPHnKeDY1Y/w7AdTYKLo6VfrTMp1dj98gqI3OYdpZwHDFuWXhpT8H5j5XjdHms0
         ysacDSIurwNh3mmG+zZhZNobMR3oNaHgE2G2tOyI7VGkaZDAWiA4GSQbw8HuVAKZOq+y
         1eJWe17yTTFUYFJtt9eTh/Gs9LG8Dyw27T4hqDhI+43rImXmv5l8Xc+wxfPKaJtcDuoX
         z61m74ah3EDZymkZt1+1GV2DhzmRpvMKdbAUxT4sXIG+1znRUUyQMc4/ZpyFd/vgkac6
         dM5nglCQ6jMCgDP0zU67OyUP2CuyOD/a6NzOfT217zKxtFTSkt1dLwbb0OwLazZ3oKg7
         kLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oNvfzfKf6TpzAj6vq/wi/rHDkEjWq04NYAvd2KpIxsc=;
        b=jGF7EG8YVxmufcEAlwVqspfqfagkk9LKeEE8dNrXHnUKx1fN4mev/JgP6iZKgJlbAa
         561x5BgdtwB4/WYHV1RaQ1bkhhs9tzIOHNJzsUiIxIuNl6KEdo8um6DwfU5DcMdGarX8
         kMWa+gASN9tKi+4jtBcKGrmXUbJWxdEcbZ/D41LmkR3KqVWI4EkktcoSRwJ5Y/G7Y6y2
         bzWkdh+JGrJomimI6rwCOL7rISWRmV8CvttLwyDSOeHB4KjBI64Adb4RyXh5mQqe8nAj
         XZwSsIFc5EjJglvKCv/E4ySm8iz7rn8M1uQXXbibU5VsT0oZSk7W2fBC/kAfQEljJw29
         QRsA==
X-Gm-Message-State: AOAM531pbT9vkZxzlQRE9DWhXbqbYtfCNfFY3ziCffPXxd4tfMUadJWR
        EYyTerQZ759nYkNatM05H5k8Fg==
X-Google-Smtp-Source: ABdhPJw3Bk91Zeuja80eQ1mkI9AkO83Wlv8eiHL3JSfgU9eINs+0jlMMLnhiWeTVyalLSjk4TBJmIw==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr25223591pjb.179.1608705591246;
        Tue, 22 Dec 2020 22:39:51 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 6sm21905688pfj.216.2020.12.22.22.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Dec 2020 22:39:50 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] perf arm64: Support SDT
Date:   Wed, 23 Dec 2020 14:39:03 +0800
Message-Id: <20201223063905.25784-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to enable SDT on Arm64.

Since Arm64 SDT marker in ELF file is different from other archs,
especially for using stack pointer (sp) to retrieve data for local
variables, patch 01 is used to fixup the arguments for this special
case.  Patch 02 is to add argument support for Arm64 SDT.

This patch set has been verified on Arm64/x86_64 platforms with a
testing program usdt_test [1].  The program run the SDT interfaces
one by one for DTRACE_PROBE, DTRACE_PROBE1, ..., DTRACE_PROBE12, so
it tries to verify probe with different count of arguments (the
arguments count is 0 to 12).

The testing flow and result are shown as below:

  # perf buildid-cache --add /root/test/usdt_test
  # perf probe sdt_usdt:test_probe
  # perf probe sdt_usdt:test_probe_param1
  # perf probe sdt_usdt:test_probe_param1x
  # perf probe sdt_usdt:test_probe_param2
  # perf probe sdt_usdt:test_probe_param2x
  # perf probe sdt_usdt:test_probe_param3
  # perf probe sdt_usdt:test_probe_param3x
  # perf probe sdt_usdt:test_probe_param4
  # perf probe sdt_usdt:test_probe_param4x
  # perf probe sdt_usdt:test_probe_param5
  # perf probe sdt_usdt:test_probe_param5x
  # perf probe sdt_usdt:test_probe_param6
  # perf probe sdt_usdt:test_probe_param6x
  # perf probe sdt_usdt:test_probe_param7
  # perf probe sdt_usdt:test_probe_param7x
  # perf probe sdt_usdt:test_probe_param8
  # perf probe sdt_usdt:test_probe_param8x
  # perf probe sdt_usdt:test_probe_param9
  # perf probe sdt_usdt:test_probe_param9x
  # perf probe sdt_usdt:test_probe_param10
  # perf probe sdt_usdt:test_probe_param10x
  # perf probe sdt_usdt:test_probe_param11
  # perf probe sdt_usdt:test_probe_param11x
  # perf probe sdt_usdt:test_probe_param12
  # perf probe sdt_usdt:test_probe_param12x

  # perf record \
        -e sdt_usdt:test_probe_param1 -e sdt_usdt:test_probe_param1x \
        -e sdt_usdt:test_probe_param2 -e sdt_usdt:test_probe_param2x \
        -e sdt_usdt:test_probe_param3 -e sdt_usdt:test_probe_param3x \
        -e sdt_usdt:test_probe_param4 -e sdt_usdt:test_probe_param4x \
        -e sdt_usdt:test_probe_param5 -e sdt_usdt:test_probe_param5x \
        -e sdt_usdt:test_probe_param6 -e sdt_usdt:test_probe_param6x \
        -e sdt_usdt:test_probe_param7 -e sdt_usdt:test_probe_param7x \
        -e sdt_usdt:test_probe_param8 -e sdt_usdt:test_probe_param8x \
        -e sdt_usdt:test_probe_param9 -e sdt_usdt:test_probe_param9x \
        -e sdt_usdt:test_probe_param10 -e sdt_usdt:test_probe_param10x \
        -e sdt_usdt:test_probe_param11 -e sdt_usdt:test_probe_param11x \
        -e sdt_usdt:test_probe_param12 -e sdt_usdt:test_probe_param12x \
        -e sdt_usdt:test_probe  -aR sleep 5

   # ./usdt_test   => Execute in another terminal

   # perf script

       usdt_test  7999 [003] 80493.418276:          sdt_usdt:test_probe: (aaaab0d80714)
       usdt_test  7999 [003] 80493.418352:   sdt_usdt:test_probe_param1: (aaaab0d80728) arg1=1
       usdt_test  7999 [003] 80493.418379:   sdt_usdt:test_probe_param2: (aaaab0d80744) arg1=1 arg2=2
       usdt_test  7999 [003] 80493.418405:   sdt_usdt:test_probe_param3: (aaaab0d80764) arg1=1 arg2=2 arg3=3
       usdt_test  7999 [003] 80493.418432:   sdt_usdt:test_probe_param4: (aaaab0d80788) arg1=1 arg2=2 arg3=3 arg4=4
       usdt_test  7999 [003] 80493.418459:   sdt_usdt:test_probe_param5: (aaaab0d807b0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5
       usdt_test  7999 [003] 80493.418487:   sdt_usdt:test_probe_param6: (aaaab0d807dc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6
       usdt_test  7999 [003] 80493.418516:   sdt_usdt:test_probe_param7: (aaaab0d8080c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7
       usdt_test  7999 [003] 80493.418545:   sdt_usdt:test_probe_param8: (aaaab0d80840) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8
       usdt_test  7999 [003] 80493.418574:   sdt_usdt:test_probe_param9: (aaaab0d80874) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9
       usdt_test  7999 [003] 80493.418603:  sdt_usdt:test_probe_param10: (aaaab0d808a8) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10
       usdt_test  7999 [003] 80493.418632:  sdt_usdt:test_probe_param11: (aaaab0d808dc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11
       usdt_test  7999 [003] 80493.418662:  sdt_usdt:test_probe_param12: (aaaab0d80910) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11 arg12=12
       usdt_test  7999 [003] 80493.418687:  sdt_usdt:test_probe_param1x: (aaaab0d8092c) arg1=1
       usdt_test  7999 [003] 80493.418713:  sdt_usdt:test_probe_param2x: (aaaab0d80950) arg1=1 arg2=2
       usdt_test  7999 [003] 80493.418739:  sdt_usdt:test_probe_param3x: (aaaab0d8097c) arg1=1 arg2=2 arg3=3
       usdt_test  7999 [003] 80493.418766:  sdt_usdt:test_probe_param4x: (aaaab0d809b0) arg1=1 arg2=2 arg3=3 arg4=4
       usdt_test  7999 [003] 80493.418792:  sdt_usdt:test_probe_param5x: (aaaab0d809ec) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5
       usdt_test  7999 [003] 80493.418820:  sdt_usdt:test_probe_param6x: (aaaab0d80a30) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6
       usdt_test  7999 [003] 80493.418847:  sdt_usdt:test_probe_param7x: (aaaab0d80a7c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7
       usdt_test  7999 [003] 80493.418875:  sdt_usdt:test_probe_param8x: (aaaab0d80ad0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8
       usdt_test  7999 [003] 80493.418904:  sdt_usdt:test_probe_param9x: (aaaab0d80b2c) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9
       usdt_test  7999 [003] 80493.418933: sdt_usdt:test_probe_param10x: (aaaab0d80b90) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10
       usdt_test  7999 [003] 80493.418962: sdt_usdt:test_probe_param11x: (aaaab0d80bfc) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=9 arg10=10 arg11=11
       usdt_test  7999 [003] 80493.418991: sdt_usdt:test_probe_param12x: (aaaab0d80cb0) arg1=1 arg2=2 arg3=3 arg4=4 arg5=5 arg6=6 arg7=7 arg8=8 arg9=281474762776336 arg10=281474762776340 arg11=281474762776344 arg12=281474762776348

[1] https://people.linaro.org/~leo.yan/debug/perf/usdt_test.c


Leo Yan (2):
  perf probe: Fixup Arm64 SDT arguments
  perf arm64: Add argument support for SDT

 tools/perf/arch/arm64/util/perf_regs.c | 94 ++++++++++++++++++++++++++
 tools/perf/util/probe-file.c           | 32 ++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.17.1


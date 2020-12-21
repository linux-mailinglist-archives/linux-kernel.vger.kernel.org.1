Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536072DF961
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgLUHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLUHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:01:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA0C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n7so5811891pgg.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CkeGUkVP1MrdephEMncKOSEjriNxIpjP5NtBsxTHOc=;
        b=i6YzegxM6i9aHjvqH1zD18F6nkfUDX1R9ficPB8uwxcQ+cytq5TgNcIHsuQfFtRand
         zYqWuTLB358ck/1tQPK29KIGmoHReMGY/12u3o9appSL+g+SBOeOX/UpwmQvKvpjkfi+
         c6+StJEMXQOClWLP1Bgn9gxlOD7YqUFP/f3NKNlucvsa4t8Y3hdS19N5DbKMpKbBCeG4
         fKlK14CsXeTi8D2cUxxwyUcsV6JOJVWPIEYgi37lVGlineNRMdYciWh777i0LPyvlioH
         /LZPfKWLltbd0+3mHXEwsf2p6270vPjrX+fvNFyw/xefS9HU9oGxEeDWUUfRoYB16Qg+
         8PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9CkeGUkVP1MrdephEMncKOSEjriNxIpjP5NtBsxTHOc=;
        b=qBG16mVE32H0NaI4KL3EPKNTxgf+EYUK0JHcDnPSOxzX1eijAT6QeAK5jkwoFoGUBs
         M29Mh++u0ZqsEG8+VwH+Wt3nSTSdf6cMMtX+OxYUmRh1qYpHsKcvuO8WXZTLWrOjFQEl
         UUDeGFZmNVIUS21Pht9Fn8RQsMgczDkiwYtW/MU2BTTERQgJ5GzefGoMdry2aM37HInX
         ngh0AURqsfNy8K4I8FvIEeEEFXZTlqqnOy00vLBgXrhXehI4x7xdHK49WAPDNShP83B1
         cLhJQmNKuJcZkRedXUwxZD0WMqckhVmW+9w/MQgRjKdaUXzDv8/TZ4G89Ghw6M30xBeR
         GDOg==
X-Gm-Message-State: AOAM531i7d7Do52dZ22SsFsiiGfaGXAFG+QJYGVWhPLPjkgbw5+KVpAG
        JwSwBFWjFyktIpD+uOLJoAHNjSoNImo=
X-Google-Smtp-Source: ABdhPJw+ADcZqwNp0AKfElkaxe+3A06z/iwakWCD2C6DutowJEalZLqVPIbRTiuIlrty9hXz5/roBg==
X-Received: by 2002:a63:4426:: with SMTP id r38mr13996472pga.240.1608534037289;
        Sun, 20 Dec 2020 23:00:37 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id p22sm16421131pgk.21.2020.12.20.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:00:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 0/3] perf tools: Minor improvements in event synthesis
Date:   Mon, 21 Dec 2020 16:00:26 +0900
Message-Id: <20201221070029.1451176-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to optimize the event synthesis during perf record.

The first patch is to reduce memory usage when many threads are used.
The second is to avoid unncessary syscalls for kernel threads.  And
the last one is to reduce the number of threads to iterate when new
threads are being created at the same time.

Unfortunately there's no dramatic improvement here but I can see ~5%
gain in the 'perf bench internals synthesize' on a big machine.
(The numbers are not stable though)


Before:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 68831.480 usec (+- 101.450 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.896 usec


After:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 65036.370 usec (+- 158.121 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.515 usec


Thanks,
Namhyung


Namhyung Kim (3):
  perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
  perf tools: Skip MMAP record synthesis for kernel threads
  perf tools: Use scandir() to iterate threads

 tools/perf/util/synthetic-events.c | 88 ++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 30 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog


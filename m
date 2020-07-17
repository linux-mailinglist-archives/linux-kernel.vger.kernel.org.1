Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C0F223E10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGQOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:32:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07BC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so6752415pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G133bjyWU6YxjxNXSltSpNAZBCuWwbhnSWFi85dFkXY=;
        b=Zd90PHMhnFKyf2vFOT6DHV+FbYypiiQAQ3WBTuZT+v1gVzK43ceEM2mqIgVvhmiHOh
         k8GvuKxUVbbUGS+v1R3gBoc7HRTbRaryShMtnVcZi3hDTWhgLGKTF58HNGI6bSxJlxWH
         C2SxITIDFbIetK4gtSZ2Ima7fd4DEUbs9rgOiV+GBZmn9f3i5RurZdCFTFkXvBioi5GI
         EIFCiLuLWewwPYnSIADQDVWsohx8YdPh5+yNpRUdgR25UzztWriTMkFUQthWjTiMu1j2
         vkQlggYeqEDrL8aM5vDjK1/vnwRMm9gh2v5P+ypZbWiZ78kSf8qEZLY7IiLEi6LNvlLv
         PETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G133bjyWU6YxjxNXSltSpNAZBCuWwbhnSWFi85dFkXY=;
        b=Wh6mk/W8k/XCd7amK7ciOA2Qu739Awjtis4n85YdimbQJ8Z6EoV1AHHIJumSuW6RJo
         Yg+hJE8wHsNhRLW0tmgzo7zuJ305Afh8lxg5scCxM7MVzA7Pc3OaZAg5xtEWNTKB8e3U
         OzG3JuANn6HMkGvpJlKCbIhZ9hvNUMTLJp8qe8k3Ly6G/gLDyOJHHgv3fy+W61T0bHPq
         VI1A07oUnefOGemjYnWGPb2bNym7wulDrzab+YJiOxkd8pX79lRPNhx0lBhl1DaDNyQs
         Yukk7iy6lUXZnt8ykyRvUSzFm2+VbWExzIwFBhwLmZ1AlW9+hnUON3riyOQI7oBkyjVa
         JI/A==
X-Gm-Message-State: AOAM530opW9rbikQszvdfGg63GcTwAyVWgu3+3GDZHbosxMnmTdQbX2F
        1YYEis50RzoDJfwOOZf4Z1E=
X-Google-Smtp-Source: ABdhPJxZZ/Tpua7pLli6hhHDdUjG1hPssVZ61Wgy0rwOwNxGiUl+r8zIbG718yacabPS0t+Fof/tsQ==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr8935487pfn.143.1594996369460;
        Fri, 17 Jul 2020 07:32:49 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id f29sm8052506pga.59.2020.07.17.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:32:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 00/17] perf: ftrace enhancement
Date:   Fri, 17 Jul 2020 22:32:12 +0800
Message-Id: <20200717143229.47546-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf has basic kernel ftrace support but lack support of most tracing
options. This serias is target to enhance the perf ftrace functionality so
that we can make full use of kernel ftrace with perf.

In general, this serias be cataloged into two main changes:
  1) Improve usability of existing functions. For example, we don't need to type
     extra option to select the tracer.
  2) Add new options to support all other ftrace functions.

Here is a glance of all ftrace functions with this serias:

$ sudo perf ftrace -h

 Usage: perf ftrace [<options>] [<command>]
    or: perf ftrace [<options>] -- <command> [<options>]

    -a, --all-cpus        system-wide collection from all CPUs
    -C, --cpu <cpu>       list of cpus to monitor
    -D, --delay <n>       ms to wait before starting tracing after program start
    -F, --funcs           Show available functions to filter
    -G, --graph-funcs <func>
                          trace given functions using function_graph tracer
    -g, --nograph-funcs <func>
                          Set nograph filter on given functions
    -m, --buffer-size <size>
                          size of per cpu buffer
    -N, --notrace-funcs <func>
                          do not trace given functions
    -p, --pid <pid>       trace on existing process id
    -T, --trace-funcs <func>
                          trace given functions using function tracer
    -t, --tracer <tracer>
                          tracer to use: function or function_graph (This option is deprecated)
    -v, --verbose         be more verbose
        --func-opts <options>
                          function tracer options, available options: call-graph,irq-info
        --graph-opts <options>
                          graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>
        --inherit         trace children processes

v6:
  o fix return value of read_tracing_file_to_stdout().
  o make __cmd_ftrace() shorter.
  o remove option '-t, --tid <tid>'.
v5:
  o trivial fixes.
v4:
  o add util/parse-sublevel-options.c
  O remove -D/--graph-depth
v3:
  o add --func-opts and --graph-opts to set tracer specific options.
  o support units as a suffix for option '-m/--buffer-size'.
v2:
  o patches for option '-u/--userstacktrace' and '--no-pager' are dropped.
  o update all related perf documentation.
  o rename some options. Now all funcgraph tracer options are prefixed with
    '--graph-', while all function tracer options are prefixed with '--func-'.
  o mark old options deprecated instead of removing them.


Changbin Du (17):
  perf ftrace: select function/function_graph tracer automatically
  perf ftrace: add option '-F/--funcs' to list available functions
  perf ftrace: factor out function write_tracing_file_int()
  perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
  perf ftrace: show trace column header
  perf ftrace: add option '--inherit' to trace children processes
  perf: util: add general function to parse sublevel options
  perf ftrace: add support for tracing option 'func_stack_trace'
  perf ftrace: add support for trace option sleep-time
  perf ftrace: add support for trace option funcgraph-irqs
  perf ftrace: add support for tracing option 'irq-info'
  perf ftrace: add option 'verbose' to show more info for graph tracer
  perf ftrace: add support for trace option tracing_thresh
  perf: ftrace: allow set graph depth by '--graph-opts'
  perf ftrace: add option -D/--delay to delay tracing
  perf: ftrace: Add set_tracing_options() to set all trace options
  perf ftrace: add change log

 tools/perf/Documentation/perf-config.txt |   5 -
 tools/perf/Documentation/perf-ftrace.txt |  33 +-
 tools/perf/builtin-ftrace.c              | 412 +++++++++++++++++++++--
 tools/perf/util/Build                    |   1 +
 tools/perf/util/debug.c                  |  61 +---
 tools/perf/util/parse-sublevel-options.c |  70 ++++
 tools/perf/util/parse-sublevel-options.h |  11 +
 7 files changed, 507 insertions(+), 86 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

-- 
2.25.1


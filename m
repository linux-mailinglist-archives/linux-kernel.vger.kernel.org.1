Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8147258BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIAJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:38:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:45308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgIAJih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:38:37 -0400
IronPort-SDR: sUTLlJjt70Takf/9LPA3XJWJXxqch3PBzwj72O4awNGRi2wXbEW9+eOE0LoYxpZEPFnUV7Xmii
 frOayHZRGBag==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175181490"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175181490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 02:38:37 -0700
IronPort-SDR: 7yFd2FX5pDlM2VuWchapDGnsG/YUIBvs1NB/OlBExH6zhiNrUyYmakyTu9rBz9xFLl2/++SMkE
 H0vIIE3SPXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="502181158"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2020 02:38:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] perf tools: Enable AUX area tracing snapshots using a FIFO
Date:   Tue,  1 Sep 2020 12:37:52 +0300
Message-Id: <20200901093758.32293-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are V2 patches to enable AUX area tracing snapshots using a FIFO.
Presently SIGUSR2 can be used but the advantage of the FIFO is that access
is governed by access to the FIFO.  Refer to the example in patch 5.

The first 4 patches are preparation, including patch 4 which enhances the
--control option to accept file names.

Patch 5 adds snapshot control command.

The final patch updates Intel PT documentation.


Changes in V2:
	Use fifo: prefix in --control option


Adrian Hunter (6):
      perf tools: Consolidate --control option parsing into one function
      perf tools: Handle read errors from ctl_fd
      perf tools: Use AsciiDoc formatting for --control option documentation
      perf tools: Add FIFO file names as alternative options to --control
      perf record: Add 'snapshot' control command
      perf intel-pt: Document snapshot control command

 tools/perf/Documentation/perf-intel-pt.txt | 23 ++++++-
 tools/perf/Documentation/perf-record.txt   | 56 ++++++++---------
 tools/perf/Documentation/perf-stat.txt     | 48 ++++++++-------
 tools/perf/builtin-record.c                | 74 +++++++++++++----------
 tools/perf/builtin-stat.c                  | 35 +++++------
 tools/perf/util/evlist.c                   | 96 +++++++++++++++++++++++++++---
 tools/perf/util/evlist.h                   |  6 +-
 tools/perf/util/record.h                   |  1 +
 tools/perf/util/stat.h                     |  1 +
 9 files changed, 227 insertions(+), 113 deletions(-)


Regards
Adrian

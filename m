Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B32830B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJEHOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:14:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:10321 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgJEHNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:13:40 -0400
IronPort-SDR: 9e/n0SWbtUbw5LcMT3qdnqgORlMInxmEPXOkBXIxvkYpcB+xA0eWd0FVXYN7qkSnXbp8acVyTx
 GuzJIMvqZyRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="227479244"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="227479244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 00:13:31 -0700
IronPort-SDR: uxWQmbwCpK4F2lQ/V3graQfcw63T5S2aUS5CbQyx9O89xEz4ZzN3XHRf4hpLnQixNM4Hybe+I3
 mHhEZUJVnaoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="309718067"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2020 00:13:30 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/8] stm class/intel_th: Updates for v5.10
Date:   Mon,  5 Oct 2020 10:13:11 +0300
Message-Id: <20201005071319.78508-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Apologies for the late posting. These are the updates that I have for
the next merge window if that's still doable.

Six patches add support for exporting more of ftrace via STM, 3 of them
get into ftrace territory, but Steven reviewed all of them and there
should be no conflicts.

Two patches add new PCI IDs to the Intel TH driver, which would normally
go in a "fixes" patchset, but this late in the cycle that doesn't make
much sense, so they are included in the same series.

Alexander Shishkin (2):
  intel_th: pci: Add Alder Lake-S support
  intel_th: pci: Add Alder Lake CPU support

Tingwei Zhang (6):
  stm class: ftrace: Change dependency to TRACING
  tracing: Add flag to control different traces
  tracing: Add trace_export support for event trace
  tracing: Add trace_export support for trace_marker
  stm class: ftrace: Enable supported trace export flag
  stm class: ftrace: Use different channel accroding to CPU

 drivers/hwtracing/intel_th/pci.c |  10 ++
 drivers/hwtracing/stm/Kconfig    |   2 +-
 drivers/hwtracing/stm/ftrace.c   |   7 +-
 include/linux/trace.h            |   7 +
 kernel/trace/trace.c             | 270 +++++++++++++++++--------------
 5 files changed, 169 insertions(+), 127 deletions(-)

-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72569284357
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFA2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:28:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:32306 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgJFA2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:28:17 -0400
IronPort-SDR: 0TUlEdmekibR2kh+PS+MtYXujUk1h5iDMJ5/dzGoiH2dI58jWQlosAW4Q0+kHs7MPaP1YkOFMG
 5zS043mxfULg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228348091"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="228348091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 16:37:56 -0700
IronPort-SDR: cMO7g/JJOouwTrPvicRrhZmZGubU0+t3+tCdhI6VoU1wbxPmEsPkrxQc6AhgK16oPsfKgsZzTg
 9traa417jWuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="516668265"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2020 14:22:05 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPXvl-0000xF-1c; Mon, 05 Oct 2020 21:22:01 +0000
Date:   Tue, 6 Oct 2020 05:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>
Subject: [RFC PATCH] dma-buf: system_heap: sys_uncached_heap can be static
Message-ID: <20201005212117.GA34870@c357f605a08d>
References: <20201003040257.62768-8-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003040257.62768-8-john.stultz@linaro.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 system_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 952f1fd9dacfda..fa17959d81795d 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -22,7 +22,7 @@
 #include <linux/vmalloc.h>
 
 struct dma_heap *sys_heap;
-struct dma_heap *sys_uncached_heap;
+static struct dma_heap *sys_uncached_heap;
 
 struct system_heap_buffer {
 	struct dma_heap *heap;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978852573C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgHaGfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 02:35:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:57375 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:35:51 -0400
IronPort-SDR: +XW6kss/CIDOWIPS/v3JqcQLsZVTN72r/PyBSmiiMgTv1E6Nt85p0V8yvCKLVEwkfEqQWhPasn
 73FVuHrOcShA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156178461"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="156178461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 23:35:50 -0700
IronPort-SDR: KBXyTTDiqCRLALor4ZrP2eG7wFDIPkn6lzMhbouuhP22i+9izpIayBGt5FDsdx/3AEWe78wmoP
 j642F28t+OnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="330595899"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2020 23:35:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BCA7D301C59; Sun, 30 Aug 2020 23:23:32 -0700 (PDT)
Date:   Sun, 30 Aug 2020 23:23:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] perf record: Add 'snapshot' control command
Message-ID: <20200831062332.GW1509399@tassilo.jf.intel.com>
References: <20200829105015.10800-1-adrian.hunter@intel.com>
 <20200829105015.10800-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829105015.10800-6-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:50:14PM +0300, Adrian Hunter wrote:
> Add 'snapshot' control command to create an AUX area tracing snapshot the
> same as if sending SIGUSR2. The advantage of the FIFO is that access is
> governed by access to the FIFO.

How about the --switch-output SIGUSR2 switch? Could that be handled too?

Other than that it looks great. Thanks.

-Andi


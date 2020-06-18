Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3191FF465
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgFRONv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:13:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:41861 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbgFRONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:13:50 -0400
IronPort-SDR: c4aarDERm/AHYz4XmbDck8mtVoDgoCk88l9yoXlq1vfB8fFDue9+NvhsvKxdrtqTYWXxviZfWW
 p6WMW/v7adLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="160677192"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="160677192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:13:49 -0700
IronPort-SDR: jk6Z/xghMixVveuzV47x56u8F2cumT/HPXJZLEnYZ6tSN6mZMWxSmnDjo/hzQoCQxld7bbEMsj
 m7YAfMudqZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="262035116"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2020 07:13:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7BDFA301674; Thu, 18 Jun 2020 07:13:49 -0700 (PDT)
Date:   Thu, 18 Jun 2020 07:13:49 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [perf] sort : Fix null pointer dereference in
 _hist_entry__sym_snprintf
Message-ID: <20200618141349.GA793265@tassilo.jf.intel.com>
References: <20200618003040.26360-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618003040.26360-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index d42339df20f8..25c7c96893f6 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -294,6 +294,9 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
>  				     u64 ip, char level, char *bf, size_t size,
>  				     unsigned int width)
>  {
> +	if (!ms) 
> +		return 0;
> +
>  	struct symbol *sym = ms->sym;
>  	struct map *map = ms->map;
>  	size_t ret = 0;

This should have given warnings because Linux and perf coding style
forbids fixed statement/declarations.

Also what's the backtrace where it is NULL? Perhaps better to fix it in
the caller.

-Andi

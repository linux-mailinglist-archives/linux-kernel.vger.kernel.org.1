Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3025B223
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgIBQxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:53:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:5186 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgIBQxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:53:48 -0400
IronPort-SDR: jKEuZOE7NeSqSfDFcXItK7D6Kjf/Bqug+rGY0uIUGNrLutZZkbkOmTXb8i9hY6iZTjC/JUAnll
 Zee3aZDckaqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145122005"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="145122005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 09:53:45 -0700
IronPort-SDR: LSWN7VetCWVKMpwY44r2CEvwkEIMd/09TYyDAKRPxD5Jm3cijVKWBknLMfATKDER1p+qOd1QIx
 aGtQ9IvMauoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="338982858"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2020 09:53:44 -0700
Received: from [10.249.227.213] (abudanko-mobl.ccr.corp.intel.com [10.249.227.213])
        by linux.intel.com (Postfix) with ESMTP id 5116658010E;
        Wed,  2 Sep 2020 09:53:43 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] perf intel-pt: Document snapshot control command
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-7-adrian.hunter@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <edfbc250-593e-69cd-ea22-819e8389dee1@linux.intel.com>
Date:   Wed, 2 Sep 2020 19:53:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901093758.32293-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.09.2020 12:37, Adrian Hunter wrote:
> The documentation descibes snapshot mode.  Update it to include the new
> snapshot control command.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Regards,
Alexei

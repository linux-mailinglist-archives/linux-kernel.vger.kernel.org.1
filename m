Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928522B3E49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKPIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:07:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:62659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgKPIHv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:07:51 -0500
IronPort-SDR: 8bhSxBnmf8uS97ufUQGBBO/5ds2mtZbnzimIUUPbN0v8CFBXCjBQIYuAtUcFIJgub56jUsfQ1b
 NOtNu07yX16A==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="188756759"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="188756759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 00:07:50 -0800
IronPort-SDR: R4JysSwXqhdByP21uKOaZ6ohL1mHDQQUBlI59b/PSrWBg2VUUecakweR6nTKY6YBx1I7wbfvbZ
 LCYmO1c9BBIA==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="475443146"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 00:07:47 -0800
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
 <38be0597-7f93-0aa1-b4c5-3c7f23b74f13@linux.intel.com>
 <20201115133558.GN894261@tassilo.jf.intel.com>
 <CAP-5=fW-9oj4PK=hBmvrCqfzLnoqTe502FRb74Jwqpo+3KoJKw@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fd75f693-0e84-78d1-6891-37af1b93542f@linux.intel.com>
Date:   Mon, 16 Nov 2020 16:07:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW-9oj4PK=hBmvrCqfzLnoqTe502FRb74Jwqpo+3KoJKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 11/16/2020 3:25 PM, Ian Rogers wrote:
> <quote>
> No given metric group:
> L2_Evictions_Silent_PKI
> L2_Evictions_NonSilent_PKI

These two metrics are available on SKX/CLX. From TMA_Metrics.csv, they are under the column 'SKX' 
not under the column 'SKL/KBL'.

Thanks
Jin Yao

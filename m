Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860771ADEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgDQNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 09:50:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:36603 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbgDQNux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:50:53 -0400
IronPort-SDR: J8WaFWawGcvGQz4HoftGNIsuiqDX+4fpj3vGJmk13qzrG3pW4fPGXFTHpNMVUvABnou3c6KJFK
 V3rWmY+tjfwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 06:50:52 -0700
IronPort-SDR: 8S2Sl+OVIIW6N2PNKyR0yP64+1w762U7E5P28etcHAl0DsgqVFbAi/WKBr2IpyS2wt6JrVBwAY
 m6lUOU6G7LuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="279690455"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2020 06:50:50 -0700
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
 <20200416151443.GA2650@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5b8f28f5-968f-bfff-68af-ed0350a90765@intel.com>
Date:   Fri, 17 Apr 2020 16:50:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416151443.GA2650@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 6:14 pm, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 01, 2020 at 01:16:08PM +0300, Adrian Hunter escreveu:
>> Currently, callchains can be synthesized only for synthesized events.
>> Support also synthesizing callchains for regular events.
> 
> This is super cool, I wonder if we shouldn't do it automatically or just
> adding a new type of callchains, i.e.:
> 
> 	perf record --call-graph pt uname
> 
> Should take care of all the details, i.e. do the extra steps below
> behind the scenes.
> 
> Possibly even find out that the workload specified was built with
> -fomit-frame-pointers, that the hardware has Intel PT and do all behind
> the scenes for:
> 
> 	perf record -g uname
> 
> Alternatively we could take some less seemingly far fetched approach and
> make this configurable via:
> 
> 	perf config call-graph.record-mode=pt
> 
> What do you think?

Adding a --call-graph option sounds reasonable, and config to define default
callgraph options.  But this was done at Andi Kleen's request, so he may
want to comment.


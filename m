Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C91B0186
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 08:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDTGWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 02:22:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:19853 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgDTGWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:22:39 -0400
IronPort-SDR: V8em/6ICF8alXucfFTPVWKkUlvoNxFjHkRB4asc7jjVZ6D30kpWwrfX+tu2W1x0pNM3+tdqgHE
 FvQue0uo0hYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 23:22:38 -0700
IronPort-SDR: 69ilx8/hIKLxrOVh33VUsECubwjLkI8yXJ4G+KH2JtvcPbMKjdpr7gC0r4dcVfPbT7N/Oaw8pV
 kbpbyOF2V0CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="456278140"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2020 23:22:35 -0700
Subject: Re: [PATCH V6 00/15] perf/x86: Add perf text poke events
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7720bfa0-2280-17c5-1537-b87617b18884@intel.com>
Date:   Mon, 20 Apr 2020 09:21:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/04/20 11:13 pm, Adrian Hunter wrote:
> Hi
> 
> Here are patches to add a text poke event to record changes to kernel text
> (i.e. self-modifying code) in order to support tracers like Intel PT
> decoding through jump labels, kprobes and ftrace trampolines.
> 
> The first 8 patches make the kernel changes and the subsequent patches are
> tools changes.
> 
> The next 4 patches add support for updating perf tools' data cache
> with the changed bytes.
> 
> The next patch is an Intel PT specific tools change.
> 
> The final 2 patches add perf script --show-text-poke-events option
> 
> Patches also here:
> 
> 	git://git.infradead.org/users/ahunter/linux-perf.git text_poke
> 
> Changes in V6
> 
>   perf: Add perf text poke event
> 
> 	Adjustments due to re-base on top of cgroup event patches
> 
>   perf/x86: Add perf text poke events for kprobes
> 
> 	Expand commit message
> 	Add Masami's Ack
> 
>   perf tools: Add support for PERF_RECORD_TEXT_POKE
> 
> 	Adjustments due to re-base on top of cgroup event patches
> 	Improvements to perf_event__fprintf_text_poke()
> 
>   perf script: Add option --show-text-poke-events
>   perf script: Show text poke address symbol
> 
> 	New patches
> 

Any comments?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5A2DF64B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgLTRZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 12:25:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:27113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbgLTRZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 12:25:16 -0500
IronPort-SDR: kIMAnrlcRa56w/vFJj2kcK00TzTz+FzaOy+EEXlANAwnIVoxodFqdDW7N2+E4UZdvUOb9xt1+U
 5l1aUdeQ0RKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="163370750"
X-IronPort-AV: E=Sophos;i="5.78,435,1599548400"; 
   d="scan'208";a="163370750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 09:23:26 -0800
IronPort-SDR: c7R+7h+hiZ44AsrrBOv+h3Y4AVOjl/PITCiy+hBdjR8wJQ1gwTNOPlwU9/t+BHFy0I1GHOMTmf
 kiukFm5TPirw==
X-IronPort-AV: E=Sophos;i="5.78,435,1599548400"; 
   d="scan'208";a="371902073"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.252.58.250]) ([10.252.58.250])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 09:23:24 -0800
Subject: Re: [PATCH 0/5] perf stat: Introduce --iiostat mode to provide I/O
 performance metrics
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Ian Rogers <irogers@google.com>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
 <20201214132828.GD238399@kernel.org>
 <20201215030430.GA1538637@tassilo.jf.intel.com>
 <20201215135849.GD252952@kernel.org>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <bea68d24-8b21-c4a7-5cd4-14d31b484222@linux.intel.com>
Date:   Sun, 20 Dec 2020 20:23:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201215135849.GD252952@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/2020 4:58 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 14, 2020 at 07:04:30PM -0800, Andi Kleen escreveu:
>>> My first thought was: Why not have a 'perf iiostat' subcommand?
>   
>> Same would apply to a lot of options in perf stat.
>   
>> I guess you could add some aliases to "perf" that give shortcuts
>> for common perf stat command lines.
> Yeah, and we have a mechanism for that, that was exercised only in the
> 'perf archive' case:
>
> ~/libexec/perf-core/perf-archive
>
> I tried this and it works:
>
> [root@five ~]# ls -la ~/bin/perf
> lrwxrwxrwx. 1 root root 19 Feb 18  2020 /root/bin/perf -> /home/acme/bin/perf
> [root@five ~]# vim ~acme/libexec/perf-core/perf-cgtop
> [root@five ~]# chmod +x ~acme/libexec/perf-core/perf-cgtop
> [root@five ~]# cat ~acme/libexec/perf-core/perf-cgtop
> perf top --hierarchy --all-cgroups -s cgroup,dso,sym $*
> [root@five ~]# perf cgtop
> [root@five ~]#
>
> use 'e' to expand collapse the current level (+ -> -), 'E'/'C' to
> expand/collapse all levels.
>
> 'perf help' doesn't show it, which is a shame, I'll add support for it
> to traverse ~/libexec/perf-core/perf-* and get the first non interpreter
> comment line as a description for the command, so to add a new one is
> just a matter of dropping a shell + man page, no need to change the perf
> binary.
>
>
> To test that '$*' at the end:
>
> [root@five ~]# perf cgtop -U
>
> I.e.:
>
> [acme@five perf]$ perf top -h -U
>
>   Usage: perf top [<options>]
>
>      -U, --hide_user_symbols
>                            hide user symbols
>
> [acme@five perf]$
>
> And it works, just kernel level samples grouped in an hierarchy, first
> cgroup, then dso, then the symbol.
>
> Also, using this with the 'P' hotkey:
>
> [root@five ~]# perf cgtop --percent-limit 1
>
> Shows how it looks like:
>
> [root@five ~]# cat perf.hist.0
> -  86.77%        /user.slice/user-1000.slice/session-2.scope
>     -  36.18%        [kernel]
>            2.24%        [k] unmap_page_range
>            1.15%        [k] clear_page_rep
>            1.10%        [k] add_mm_counter_fast
>            1.03%        [k] alloc_set_pte
>            1.03%        [k] handle_mm_fault
>     -  17.65%        libc-2.32.so
>            2.04%        [.] _int_malloc
>            1.82%        [.] __memmove_avx_unaligned_erms
>            1.48%        [.] __strlen_avx2
>            1.13%        [.] _int_free
>            1.12%        [.] malloc
>     -   8.09%        make
>            1.65%        [.] jhash_string
>            1.05%        [.] hash_find_slot
>     -   6.90%        ld-2.32.so
>            2.03%        [.] do_lookup_x
>            1.49%        [.] _dl_lookup_symbol_x
>     -   4.78%        cc1
>     -   4.60%        libperl.so.5.32.0
>     -   2.86%        bash
>     -   1.98%        libselinux.so.1
>     -   1.61%        libpython2.7.so.1.0
>     -   1.06%        libpcre2-8.so.0.10.0
> -   9.17%        /user.slice/user-1000.slice/session-4.scope
>     -   4.66%        perf
>     -   2.40%        libc-2.32.so
>     -   1.82%        [kernel]
> -   4.04%        /
>     -   4.02%        [kernel]
> [root@five ~]#
>
> So 'perf iiostat' would become:
>
> [root@five ~]# cat ~acme/libexec/perf-core/perf-iiostat
> perf stat --iiostat $*
> [root@five ~]#
>
> There are parameters to that '--iiostat' in the current patchset that
> may complicates this tho, with some changes I guess we get what we want.
>
> - Arnaldo

Hello Arnaldo,
Sorry for delayed response.

This is the interesting approach to get shorter command. Thank you for the
explanation. I will update the patchset.

- Alexander

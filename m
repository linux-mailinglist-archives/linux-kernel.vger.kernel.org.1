Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC52DAE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgLON7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbgLON7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:59:18 -0500
Date:   Tue, 15 Dec 2020 10:58:49 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608040717;
        bh=PYuk8SeZSF/X++CdNREjUE0YAdh9XJJ0ALKF88UwywQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfrm+RxGvqIWV2URnlvNwfqIPi4OuXEgBkEp7tMQFti9+IAsLNuo0inWmd8mIyBvk
         y+9zCxWc3HVNLjOYba3spZbqjkAsxbFdxp0T7Ekjyb4QjE9t88yMeyXJCIkuurTkpv
         KlBgZUFEln1xoVLv1b4nALWQxpZsAnslxcpM4IWjePrGMS/aMgaaPq3GDY+Is9yXto
         2Z1nimL+kaYFI2e9PxfhYZpMFeMA01HaqDY9C/gls+wpneyQUnDLq1EaI5QBXjiJdn
         FB7ifOblDblwXX3ALLhk15HoKgCwUb1ibY9my4arBBbCbIE0Le4oCfieAN5R9ja1lt
         Kg7fWi3a7Anqw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/5] perf stat: Introduce --iiostat mode to provide I/O
 performance metrics
Message-ID: <20201215135849.GD252952@kernel.org>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
 <20201214132828.GD238399@kernel.org>
 <20201215030430.GA1538637@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215030430.GA1538637@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 07:04:30PM -0800, Andi Kleen escreveu:
> > My first thought was: Why not have a 'perf iiostat' subcommand?
 
> Same would apply to a lot of options in perf stat.
 
> I guess you could add some aliases to "perf" that give shortcuts
> for common perf stat command lines.

Yeah, and we have a mechanism for that, that was exercised only in the
'perf archive' case:

~/libexec/perf-core/perf-archive

I tried this and it works:

[root@five ~]# ls -la ~/bin/perf
lrwxrwxrwx. 1 root root 19 Feb 18  2020 /root/bin/perf -> /home/acme/bin/perf
[root@five ~]# vim ~acme/libexec/perf-core/perf-cgtop
[root@five ~]# chmod +x ~acme/libexec/perf-core/perf-cgtop
[root@five ~]# cat ~acme/libexec/perf-core/perf-cgtop
perf top --hierarchy --all-cgroups -s cgroup,dso,sym $*
[root@five ~]# perf cgtop
[root@five ~]#

use 'e' to expand collapse the current level (+ -> -), 'E'/'C' to
expand/collapse all levels.

'perf help' doesn't show it, which is a shame, I'll add support for it
to traverse ~/libexec/perf-core/perf-* and get the first non interpreter
comment line as a description for the command, so to add a new one is
just a matter of dropping a shell + man page, no need to change the perf
binary.


To test that '$*' at the end:

[root@five ~]# perf cgtop -U

I.e.:

[acme@five perf]$ perf top -h -U

 Usage: perf top [<options>]

    -U, --hide_user_symbols
                          hide user symbols

[acme@five perf]$

And it works, just kernel level samples grouped in an hierarchy, first
cgroup, then dso, then the symbol.

Also, using this with the 'P' hotkey:

[root@five ~]# perf cgtop --percent-limit 1

Shows how it looks like:

[root@five ~]# cat perf.hist.0 
-  86.77%        /user.slice/user-1000.slice/session-2.scope
   -  36.18%        [kernel]
          2.24%        [k] unmap_page_range
          1.15%        [k] clear_page_rep
          1.10%        [k] add_mm_counter_fast
          1.03%        [k] alloc_set_pte
          1.03%        [k] handle_mm_fault
   -  17.65%        libc-2.32.so
          2.04%        [.] _int_malloc
          1.82%        [.] __memmove_avx_unaligned_erms
          1.48%        [.] __strlen_avx2
          1.13%        [.] _int_free
          1.12%        [.] malloc
   -   8.09%        make
          1.65%        [.] jhash_string
          1.05%        [.] hash_find_slot
   -   6.90%        ld-2.32.so
          2.03%        [.] do_lookup_x
          1.49%        [.] _dl_lookup_symbol_x
   -   4.78%        cc1
   -   4.60%        libperl.so.5.32.0
   -   2.86%        bash
   -   1.98%        libselinux.so.1
   -   1.61%        libpython2.7.so.1.0
   -   1.06%        libpcre2-8.so.0.10.0
-   9.17%        /user.slice/user-1000.slice/session-4.scope
   -   4.66%        perf
   -   2.40%        libc-2.32.so
   -   1.82%        [kernel]
-   4.04%        /
   -   4.02%        [kernel]
[root@five ~]#

So 'perf iiostat' would become:

[root@five ~]# cat ~acme/libexec/perf-core/perf-iiostat
perf stat --iiostat $*
[root@five ~]#

There are parameters to that '--iiostat' in the current patchset that
may complicates this tho, with some changes I guess we get what we want.

- Arnaldo

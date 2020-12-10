Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93D2D637F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392752AbgLJR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388162AbgLJR0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:26:41 -0500
Date:   Thu, 10 Dec 2020 14:26:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607621159;
        bh=quYKzsDU862+nRlXTPuDCAuMGhp5TDY5xpKfmxQEJGQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehiGJcWCONuJ3f5LG/7UrIcl4jidi49AZhFybLKsLFbBrylQOYJubcG2P/KlINcM8
         Jll/Tk4T7gEugmo7X8aUQRg+JELxo0xbr3KwTlMrw2nygIBGFwOpaXhoPrMYnlI8Z/
         jGNqD5tuRtwy8yx8KA6LxSDVU2ZDy5dwdp2qB+tGgECG3SVJ+dzz5GFcu/cgvVrfZ4
         LiBM47OVkOva36lEN6fTZZY1zM7rPyzhetmc2e9vNhC58JcIKJhv0trvaCstwD8ANP
         bR8O6Aki0w/54haOqaiDvDntpQ73bHRVurCwZ1eSzuMH+PAyDj4QP092160ZGKpinm
         Z8ED9ouGgU36Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [BUG] jevents problem when cross building Re: [PATCH 2/3] perf
 tools: Allow to enable/disable events via control file
Message-ID: <20201210172608.GC195565@kernel.org>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-3-jolsa@kernel.org>
 <7bcde520-e933-c2d6-c960-3f8acdaf6047@huawei.com>
 <20201210162430.GH69683@krava>
 <20201210171503.GA195565@kernel.org>
 <20201210171903.GB195565@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210171903.GB195565@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 10, 2020 at 02:19:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 10, 2020 at 02:15:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Dec 10, 2020 at 05:24:30PM +0100, Jiri Olsa escreveu:
> > > On Mon, Dec 07, 2020 at 08:02:20PM +0300, Alexei Budankov wrote:
> > > > On 06.12.2020 20:05, Jiri Olsa wrote:
> > > > > @@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> > > > >  	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
> > > > >  	int ctlfd_pos = evlist->ctl_fd.pos;
> > > > >  	struct pollfd *entries = evlist->core.pollfd.entries;
> > > > > +	struct evsel *evsel;
> > > > > +	char *evsel_name;

> > > > >  	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
> > > > >  		return 0;
> > > > > @@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> > > > >  			case EVLIST_CTL_CMD_DISABLE:
> > > > >  				evlist__disable(evlist);
> > > > >  				break;
> > > > > +			case EVLIST_CTL_CMD_ENABLE_EVSEL:
> > > > > +				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
> 
> > > > It makes sense to check that evsel_name still points
> > > > into cmd_data buffer after assigning to event name.
 
> > > right, will add that
 
> > So, I'm finishing test builds, so probably I'll push the first two
> > patches publicly and then you can send a patch on top of this, ok?
 
> > Unless the tests break somewhere and then I'll have to restart, so I'll
> > fold in whatever gets at that time...
 
> That was quick:
 
> [perfbuilder@five ~]$ time dm
> Thu Dec 10 01:44:52 PM -03 2020
> # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.10.0-rc6.tar.xz
> # dm
>    1    78.47 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>    2   104.38 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>    3   105.64 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>    4    96.52 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    5    81.08 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    6    85.20 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    7   106.10 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    8   120.20 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>    9   109.99 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   10   117.76 alpine:edge                   : Ok   gcc (Alpine 10.2.0) 10.2.0, Alpine clang version 10.0.1
>   11    69.15 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
>   12    84.55 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1), clang version 10.0.0
>   13    82.69 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.3.1 20200518 (ALT Sisyphus 9.3.1-alt1), clang version 10.0.1
>   14    66.22 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>   15   100.16 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-9), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>   16    11.20 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   17    11.90 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   18    26.33 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   19    31.80 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
>   20   116.02 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), clang version 9.0.1 (Red Hat 9.0.1-2.module_el8.2.0+309+0c7b6b03)
>   21    62.27 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201106 releases/gcc-10.2.0-475-g099857318c, clang version 10.0.1
>   22    77.82 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
>   23: debian:9
> 
> 
> There I go...
> 
> [perfbuilder@five ~]$ tail -20 dm.log/android-ndk\:r12b-arm
>   FLEX     /tmp/build/perf/util/expr-flex.c
>   CC       /tmp/build/perf/util/pmu-bison.o
>   CC       /tmp/build/perf/util/expr-bison.o
>   CC       /tmp/build/perf/util/expr-flex.o
>   CC       /tmp/build/perf/util/expr.o
>   CC       /tmp/build/perf/util/parse-events.o
>   CC       /tmp/build/perf/util/parse-events-flex.o
>   CC       /tmp/build/perf/util/pmu.o
>   CC       /tmp/build/perf/util/pmu-flex.o
>   LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>   LD       /tmp/build/perf/util/perf-in.o
>   LD       /tmp/build/perf/perf-in.o
>   LINK     /tmp/build/perf/perf
> /tmp/build/perf/perf-in.o:hist.c:function pmu_for_each_sys_event: error: undefined reference to 'pmu_sys_event_tables'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
> make[1]: *** [Makefile.perf:233: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [perfbuilder@five ~]
> 
> Now to figure out who generates this pmu_sys_event_tables, John?

One more:

[perfbuilder@five ~]$ tail -20 dm.log/debian\:experimental-x-mips64
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  CC       /tmp/build/perf/util/expr.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
/usr/lib/gcc-cross/mips64-linux-gnuabi64/9/../../../../mips64-linux-gnuabi64/bin/ld: /tmp/build/perf/perf-in.o: in function `pmu_for_each_sys_event':
/git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
/usr/lib/gcc-cross/mips64-linux-gnuabi64/9/../../../../mips64-linux-gnuabi64/bin/ld: /git/linux/tools/perf/util/pmu.c:825: undefined reference to `pmu_sys_event_tables'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:659: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:233: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[perfbuilder@five ~]$

And another:

[perfbuilder@five ~]$ tail -20 dm.log/fedora:24-x-ARC-uClibc
  CC       /tmp/build/perf/util/expr.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
/tmp/build/perf/perf-in.o: In function `pmu_for_each_sys_event':
/git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
/git/linux/tools/perf/util/pmu.c:816: undefined reference to `pmu_sys_event_tables'
/tmp/build/perf/perf-in.o: In function `pmu_add_sys_aliases':
/git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
/git/linux/tools/perf/util/pmu.c:886: undefined reference to `pmu_sys_event_tables'
collect2: error: ld returned 1 exit status
Makefile.perf:659: recipe for target '/tmp/build/perf/perf' failed
make[2]: *** [/tmp/build/perf/perf] Error 1
Makefile.perf:232: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make: *** [all] Error 2
make: Leaving directory '/git/linux/tools/perf'
+ exit 1
[perfbuilder@five ~]$

So far all the cross builds failed.

- Arnaldo

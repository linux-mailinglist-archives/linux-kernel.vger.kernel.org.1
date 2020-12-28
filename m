Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617932E684A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgL1NCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbgL1NCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:02:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC1CE208B6;
        Mon, 28 Dec 2020 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609160482;
        bh=KJdayGjn6AwRQNSH5ewYryKljIf7pqsTeozhO3zMG/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZ7J1gxIg0i6/pI8XGJoMESUBv7ojHLQgPHk4ya6WJncz+eaDJO2HO+LYJCZVkJs4
         J83wyAekRXcPKQr/dIc3WV959GvkFDi/DPQhKFxxmAH598PL8fQWgra2gdtGBl9nCv
         emhgw/zjAmuh843RfGxgyDEVJiXGnlLz3iC1sfX6hGyBH70lY5UM/ZYsBKG+zLvAJe
         D2Z1dOZm+bGtbhtlFTvAGHBW3dxGG8qeqSIkS8OJ1O6rnb96M+GvPb8tnjuB4zzHc3
         v4TvNwLmdVevZWowfyuqVkUgpnCu5tjjOYcEoQbPvAR5iCJKKLhIJ6Gdr2GZed/PXS
         0QQDoxGk7SP3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4723411E9; Mon, 28 Dec 2020 10:01:38 -0300 (-03)
Date:   Mon, 28 Dec 2020 10:01:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/15] perf tools: Add support to read build id from
 compressed elf
Message-ID: <20201228130138.GB521329@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-7-jolsa@kernel.org>
 <20201215155503.GM258566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215155503.GM258566@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 15, 2020 at 12:55:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 14, 2020 at 11:54:48AM +0100, Jiri Olsa escreveu:
> > Adding support to decompress file before reading build id.
> > 
> > Adding filename__read_build_id and change its current
> > versions to read_build_id.
> > 
> > Shutting down stderr output of perf list in the shell test:
> >   82: Check open filename arg using perf trace + vfs_getname          : Ok
> 
> Tentatively cherry picking this one.

This one made into v5.11. Processing the tooling bits in the other
patches now, into perf/core.

- Arnaldo
>  
> > because with decompression code in the place we the
> > filename__read_build_id function is more verbose in case
> > of error and the test did not account for that.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../tests/shell/trace+probe_vfs_getname.sh    |  2 +-
> >  tools/perf/util/symbol-elf.c                  | 37 ++++++++++++++++++-
> >  2 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > index 11cc2af13f2b..3d31c1d560d6 100755
> > --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> > @@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
> >  file=$(mktemp /tmp/temporary_file.XXXXX)
> >  
> >  trace_open_vfs_getname() {
> > -	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> > +	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> >  	perf trace -e $evts touch $file 2>&1 | \
> >  	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
> >  }
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 44dd86a4f25f..f3577f7d72fe 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -534,7 +534,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
> >  
> >  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
> >  
> > -int filename__read_build_id(const char *filename, struct build_id *bid)
> > +static int read_build_id(const char *filename, struct build_id *bid)
> >  {
> >  	size_t size = sizeof(bid->data);
> >  	int err = -1;
> > @@ -563,7 +563,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
> >  
> >  #else // HAVE_LIBBFD_BUILDID_SUPPORT
> >  
> > -int filename__read_build_id(const char *filename, struct build_id *bid)
> > +static int read_build_id(const char *filename, struct build_id *bid)
> >  {
> >  	size_t size = sizeof(bid->data);
> >  	int fd, err = -1;
> > @@ -595,6 +595,39 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
> >  
> >  #endif // HAVE_LIBBFD_BUILDID_SUPPORT
> >  
> > +int filename__read_build_id(const char *filename, struct build_id *bid)
> > +{
> > +	struct kmod_path m = { .name = NULL, };
> > +	char path[PATH_MAX];
> > +	int err;
> > +
> > +	if (!filename)
> > +		return -EFAULT;
> > +
> > +	err = kmod_path__parse(&m, filename);
> > +	if (err)
> > +		return -1;
> > +
> > +	if (m.comp) {
> > +		int error = 0, fd;
> > +
> > +		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
> > +		if (fd < 0) {
> > +			pr_debug("Failed to decompress (error %d) %s\n",
> > +				 error, filename);
> > +			return -1;
> > +		}
> > +		close(fd);
> > +		filename = path;
> > +	}
> > +
> > +	err = read_build_id(filename, bid);
> > +
> > +	if (m.comp)
> > +		unlink(filename);
> > +	return err;
> > +}
> > +
> >  int sysfs__read_build_id(const char *filename, struct build_id *bid)
> >  {
> >  	size_t size = sizeof(bid->data);
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo

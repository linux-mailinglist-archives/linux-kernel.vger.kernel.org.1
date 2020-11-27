Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312EE2C6C36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgK0T44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbgK0TuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3V1r7AUS3ALgFNZhJLtLjbFxEEffP+H9D3V9s7L4xI=;
        b=bVa3QQLT7jAucGeJsNWMsPyaooIVZYO+L1UAxHq3jXONSTFA90MGg2Q93Svkf7bt+t/rZH
        KulSDhEgXFI+++IdsFJz1axQPF+CWZWhGvIRM3xKgTQGC2asO2c7L4A+sPsqUr0/Cxt4UW
        g8iEbkQVa/b9OqhIBIzk75VPjtIzT5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-BgKeFo2COY6dT_2N9BzYKg-1; Fri, 27 Nov 2020 14:49:09 -0500
X-MC-Unique: BgKeFo2COY6dT_2N9BzYKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76F471934100;
        Fri, 27 Nov 2020 19:49:07 +0000 (UTC)
Received: from krava (unknown [10.40.194.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33FB260BF1;
        Fri, 27 Nov 2020 19:49:04 +0000 (UTC)
Date:   Fri, 27 Nov 2020 20:49:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 22/25] perf buildid-cache: Add support to add build ids
 from perf data
Message-ID: <20201127194903.GC2788968@krava>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-23-jolsa@kernel.org>
 <20201126175706.GI70905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126175706.GI70905@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:57:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 26, 2020 at 06:00:23PM +0100, Jiri Olsa escreveu:
> > Adding support to specify perf data file as -a option file
> > argument,
> > 
> > If the file is detected to be perf data file, it is processed
> > and all dso objects with sample hit are stored to the build
> > id cache.
> 
> Would be interesting if the steps to have that debuginfod server running
> at that 192.168.122.174:8002 URL were spelled out here, for
> completeness.

right, will add that

jirka

> 
> - Arnaldo
>  
> >   $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-cache -a perf.data
> >   OK   5dcec522abf136fcfd3128f47e131f2365834dd7 /home/jolsa/.debug/.build-id/5d/cec522abf136fcfd3128f47e131f2365834dd7/elf
> >   OK   5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
> > 
> > By default we store only dso with hits, but it's possible to
> > specify 'all' to store all dso objects, like:
> >     -a perf.data,all
> > 
> >   $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-cache -a perf.data,all
> >   OK   5dcec522abf136fcfd3128f47e131f2365834dd7 /home/jolsa/.debug/.build-id/5d/cec522abf136fcfd3128f47e131f2365834dd7/elf
> >   OK   6ce92dc7c31f12fe5b7775a2bb8b14a3546ce2cd /lib/modules/5.10.0-rc2speed+/kernel/drivers/firmware/qemu_fw_cfg.ko
> >   OK   bf3f6d32dccc159f841fc3658c241d0e74c61fbb /lib/modules/5.10.0-rc2speed+/kernel/drivers/block/virtio_blk.ko
> >   OK   e896b4329cf9f190f1a0fae933f425ff8f71b052 /lib/modules/5.10.0-rc2speed+/kernel/drivers/char/virtio_console.ko
> >   OK   5bedc933cb59e053ecb472f327bd73c548364479 /lib/modules/5.10.0-rc2speed+/kernel/drivers/input/serio/serio_raw.ko
> >   OK   cecc506368a8b7a473a5f900d26f0d3d914a9c23 /lib/modules/5.10.0-rc2speed+/kernel/arch/x86/crypto/crc32c-intel.ko
> >   OK   91076fb3646d061a0a42cf7bddb339a665ee4f80 /lib/modules/5.10.0-rc2speed+/kernel/arch/x86/crypto/ghash-clmulni-intel.ko
> >   OK   4e2a304d788bb8e2e950bc82a5944e042afa0bf2 /lib/modules/5.10.0-rc2speed+/kernel/drivers/media/cec/core/cec.ko
> >   OK   31ab0da5ad81e6803280177f507a95f3053d585e /lib/modules/5.10.0-rc2speed+/kernel/lib/libcrc32c.ko
> >   OK   f6154bca47c149f48c942fcc3d653041dd285c65 /lib/modules/5.10.0-rc2speed+/kernel/drivers/gpu/drm/ttm/ttm.ko
> >   OK   723f5852de81590d54b23b38c160d3618b41951b /lib/modules/5.10.0-rc2speed+/kernel/arch/x86/crypto/crct10dif-pclmul.ko
> >   OK   06b1eab7f141cbc3e5a5db47909c8ab5cb242e40 /lib/modules/5.10.0-rc2speed+/kernel/drivers/gpu/drm/drm_ttm_helper.ko
> >   OK   38292b862cf3ff87489508fdb4895efa45780813 /lib/modules/5.10.0-rc2speed+/kernel/drivers/gpu/drm/qxl/qxl.ko
> >   OK   cdf51e58609bf2ce4837a7b195e0ccae0a930907 /lib/modules/5.10.0-rc2speed+/kernel/arch/x86/crypto/crc32-pclmul.ko
> >   OK   5ca8958388f6688452ecc2cb83d6031394c659ad /lib/modules/5.10.0-rc2speed+/kernel/drivers/gpu/drm/drm.ko
> >   OK   236bc4e4f38bf3559007566cb32b3dcc1bc28d2d /lib/modules/5.10.0-rc2speed+/kernel/drivers/gpu/drm/drm_kms_helper.ko
> >   OK   5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
> >   OK   66db2be3efaa43bb5a5c481986e9554e1885cc69 /usr/lib/systemd/systemd
> >   OK   7db607d9f2de89860d9639712da64c8bacd31e4b /usr/lib64/libm-2.30.so
> >   OK   55b5f9652e1d17c1dd58f62628d5063428e5db91 /usr/lib64/libudev.so.1.6.15
> >   OK   63b97070bf097130713bb6c89cf7100b5f3c9b17 /usr/lib64/libunistring.so.2.1.0
> >   ...
> > 
> > Once perf data is specified, no other file can be specified in
> > the option, otherwise it causes syntax error.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../perf/Documentation/perf-buildid-cache.txt |  12 +-
> >  tools/perf/builtin-buildid-cache.c            | 213 +++++++++++++++++-
> >  tools/perf/util/probe-event.c                 |   6 +-
> >  3 files changed, 225 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
> > index f6de0952ff3c..b77da5138bca 100644
> > --- a/tools/perf/Documentation/perf-buildid-cache.txt
> > +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> > @@ -23,7 +23,17 @@ OPTIONS
> >  -------
> >  -a::
> >  --add=::
> > -        Add specified file to the cache.
> > +        Add specified file or perf.data binaries to the cache.
> > +
> > +        If the file is detected to be perf data file, it is processed
> > +        and all dso objects with sample hit are stored to the cache.
> > +
> > +        It's possible to specify 'all' to store all dso objects, like:
> > +            -a perf.data,all
> > +
> > +        Once perf data is specified, no other file can be specified in
> > +        the option, otherwise it causes syntax error.
> > +
> >  -f::
> >  --force::
> >  	Don't complain, do it.
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> > index a25411926e48..f0afb2c89e03 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -29,6 +29,11 @@
> >  #include "util/probe-file.h"
> >  #include <linux/string.h>
> >  #include <linux/err.h>
> > +#include <linux/zalloc.h>
> > +#include <sys/stat.h>
> > +#ifdef HAVE_DEBUGINFOD_SUPPORT
> > +#include <elfutils/debuginfod.h>
> > +#endif
> >  
> >  static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
> >  {
> > @@ -348,6 +353,203 @@ static int build_id_cache__show_all(void)
> >  	return 0;
> >  }
> >  
> > +#ifdef HAVE_DEBUGINFOD_SUPPORT
> > +static int call_debuginfod(const char *sbuild_id, char **path, bool debuginfo)
> > +{
> > +	debuginfod_client *c;
> > +	int fd;
> > +
> > +	c = debuginfod_begin();
> > +	if (c == NULL)
> > +		return -1;
> > +
> > +	pr_debug("trying debuginfod for executable <%s> ... ", sbuild_id);
> > +
> > +	if (debuginfo) {
> > +		fd = debuginfod_find_debuginfo(c, (const unsigned char *) sbuild_id,
> > +					       0, path);
> > +	} else {
> > +		fd = debuginfod_find_executable(c, (const unsigned char *) sbuild_id,
> > +						0, path);
> > +	}
> > +	if (fd >= 0)
> > +		close(fd); /* retaining reference by realname */
> > +
> > +	debuginfod_end(c);
> > +	pr_debug("%s%s\n", *path ? "OK " : "FAILED", *path ? *path : "");
> > +	return *path ? 0 : -1;
> > +}
> > +#else
> > +static int call_debuginfod(const char *sbuild_id __maybe_unused,
> > +			   char **path __maybe_unused,
> > +			   bool debuginfo __maybe_unused)
> > +{
> > +	return -1;
> > +}
> > +#endif
> > +
> > +struct dso_store_data {
> > +	bool	 hits;
> > +};
> > +
> > +static int dso_store(struct dso *dso, struct machine *machine, void *priv)
> > +{
> > +	struct dso_store_data *data = priv;
> > +	char sbuild_id[SBUILD_ID_SIZE];
> > +	struct build_id bid;
> > +	char *path = NULL, *link = NULL;
> > +	bool is_kallsyms;
> > +	int err = -1;
> > +
> > +	/*
> > +	 * There's no build id in dso, nothing to do..
> > +	 */
> > +	if (!dso->has_build_id || !build_id__is_defined(&dso->bid))
> > +		return 0;
> > +
> > +	if (data->hits && !dso->hit)
> > +		return 0;
> > +
> > +	/*
> > +	 * The storing process is:
> > +	 *   - get build id of the dso
> > +	 *   - check if it is already in cache
> > +	 *   - check if it matches provided build id from mmap2 event
> > +	 *   - if not, try debuginfod to download the binary
> > +	 *   - store binary to build id database
> > +	 */
> > +	is_kallsyms = !strcmp(machine->mmap_name, dso->short_name);
> > +	build_id__sprintf(&dso->bid, sbuild_id);
> > +
> > +	link = build_id_cache__linkname(sbuild_id, NULL, 0);
> > +	if (!link)
> > +		return -ENOMEM;
> > +
> > +	if (!access(link, X_OK)) {
> > +		pr_debug("already in cache - %s <%s>\n", dso->long_name, sbuild_id);
> > +		err = 0;
> > +		goto out;
> > +	}
> > +
> > +	path = strdup(dso->long_name);
> > +	if (!path)
> > +		goto out;
> > +
> > +	if (is_kallsyms) {
> > +		/*
> > +		 * Find out if we are on the same kernel as perf.data
> > +		 * and store kallsyms in that case.
> > +		 */
> > +		err = sysfs__read_build_id("/sys/kernel/notes", &bid);
> > +		if (err < 0)
> > +			goto out;
> > +	} else {
> > +		struct nscookie nsc;
> > +		struct stat st;
> > +
> > +		nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > +
> > +		/*
> > +		 * Does the file exists in the first place, if it does,
> > +		 * resolve path and read the build id.
> > +		 */
> > +		if (stat(dso->long_name, &st)) {
> > +			nsinfo__mountns_exit(&nsc);
> > +			zfree(&path);
> > +			goto try_download;
> > +		}
> > +
> > +		err = filename__read_build_id(dso->long_name, &bid);
> > +		nsinfo__mountns_exit(&nsc);
> > +
> > +		if (err <= 0)
> > +			goto out;
> > +	}
> > +
> > +	/*
> > +	 * If we match, then what we want in mmap2 event
> > +	 * is what we got in the binary,
> > +	 */
> > +	if (bid.size != dso->bid.size || memcmp(&bid, &dso->bid, bid.size)) {
> > +		char sbid[SBUILD_ID_SIZE];
> > +
> > +		build_id__sprintf(&bid, sbid);
> > +		pr_debug("mmap build id <%s> does not match for %s <%s>\n",
> > +			 sbuild_id, path, sbid);
> > +		zfree(&path);
> > +	}
> > +
> > +try_download:
> > +	/*
> > +	 * We did not match build id or did not find the
> > +	 * binary - try debuginfod as last resort.
> > +	 */
> > +	if (!path) {
> > +		bool debuginfo;
> > +		char *tmp = NULL;
> > +
> > +		/*
> > +		 * The debuginfo retrieval for standard binaries
> > +		 * is handled within build_id_cache__add function.
> > +		 *
> > +		 * For kernel and kernel modules we have to ask
> > +		 * for debuginfo directly, because debuginfod
> > +		 * does not treat them as binaries.
> > +		 */
> > +		debuginfo = is_kallsyms ||
> > +			    is_kernel_module(dso->long_name, PERF_RECORD_MISC_CPUMODE_UNKNOWN);
> > +
> > +		if (call_debuginfod(sbuild_id, &tmp, debuginfo)) {
> > +			err = -1;
> > +			goto out;
> > +		}
> > +
> > +		path = tmp;
> > +
> > +		/*
> > +		 * The kernel dso is now elf binary, so disable is_kallsyms
> > +		 * so build_id_cache__add can prepare proper file names.
> > +		 */
> > +		is_kallsyms = false;
> > +	}
> > +
> > +	pr_debug("linking %s %s <%s>\n", dso->short_name, path, sbuild_id);
> > +
> > +	err = build_id_cache__add(sbuild_id, path, path,
> > +				  dso->nsinfo, is_kallsyms, false);
> > +out:
> > +	free(path);
> > +	fprintf(stderr, "%s %s %s\n", err ? "FAIL" : "OK  ", sbuild_id, dso->long_name);
> > +	return 0;
> > +}
> > +
> > +static int
> > +build_id_cache__add_perf_data(const char *path, bool all)
> > +{
> > +	struct perf_session *session;
> > +	struct dso_store_data priv = {
> > +		.hits = !all,
> > +	};
> > +	struct perf_data data = {
> > +		.path  = path,
> > +		.mode  = PERF_DATA_MODE_READ,
> > +	};
> > +	int err;
> > +
> > +	session = perf_session__new(&data, false, &build_id__mark_dso_hit_ops);
> > +	if (IS_ERR(session))
> > +		return PTR_ERR(session);
> > +
> > +	err = perf_session__process_events(session);
> > +	if (err)
> > +		goto out;
> > +
> > +	err = __perf_session__cache_build_ids(session, dso_store, &priv);
> > +out:
> > +	perf_session__delete(session);
> > +	return err;
> > +}
> > +
> >  int cmd_buildid_cache(int argc, const char **argv)
> >  {
> >  	struct strlist *list;
> > @@ -440,7 +642,15 @@ int cmd_buildid_cache(int argc, const char **argv)
> >  		list = strlist__new(add_name_list_str, NULL);
> >  		if (list) {
> >  			strlist__for_each_entry(pos, list)
> > -				if (build_id_cache__add_file(pos->s, nsi)) {
> > +				if (is_perf_data(pos->s)) {
> > +					struct str_node *all_pos = strlist__next(pos);
> > +					bool all = !strcmp("all", all_pos ? all_pos->s : "");
> > +
> > +					if (build_id_cache__add_perf_data(pos->s, all))
> > +						pr_warning("Couldn't add build ids from %s\n", pos->s);
> > +					if (all)
> > +						pos = all_pos;
> > +				} else if (build_id_cache__add_file(pos->s, nsi)) {
> >  					if (errno == EEXIST) {
> >  						pr_debug("%s already in the cache\n",
> >  							 pos->s);
> > @@ -449,7 +659,6 @@ int cmd_buildid_cache(int argc, const char **argv)
> >  					pr_warning("Couldn't add %s: %s\n",
> >  						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
> >  				}
> > -
> >  			strlist__delete(list);
> >  		}
> >  	}
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 8eae2afff71a..e821bb977c9b 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1616,9 +1616,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	pr_debug("symbol:%s file:%s line:%d offset:%lu return:%d lazy:%s\n",
> > -		 pp->function, pp->file, pp->line, pp->offset, pp->retprobe,
> > -		 pp->lazy_line);
> > +	pr_debug2("symbol:%s file:%s line:%d offset:%lu return:%d lazy:%s\n",
> > +		  pp->function, pp->file, pp->line, pp->offset, pp->retprobe,
> > +		  pp->lazy_line);
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.26.2
> > 
> 
> -- 
> 
> - Arnaldo
> 


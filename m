Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955E268F63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgINPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgINPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:14:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515BB208B3;
        Mon, 14 Sep 2020 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600096455;
        bh=gsN0Hgz71ycV/Rhqmz+pV7tWaH9kIZurEr45/d12W4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJbHNKK9261JpkbPvTOAhiP2FmlLD/oN0aYsH/93qHtu7uGmVr+ajOy9meEBUeVYd
         xBCdH02Lu0Fgsdz4G23NWpUMbrDnuZ9xKYOmlDZKrWAN+gXUMoWR1NFdn/hqh8Z8+q
         CY/f/B9NOc/S3mYAGUMRBWqoGj3WoEH2Thuts5TQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BB8D40D3D; Mon, 14 Sep 2020 12:14:13 -0300 (-03)
Date:   Mon, 14 Sep 2020 12:14:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/26] perf tools: Add buildid-list --store option
Message-ID: <20200914151413.GB160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-25-jolsa@kernel.org>
 <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 03:42:55PM +0900, Namhyung Kim escreveu:
> On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding buildid-list --store option to populate
> > .debug data with build id files.
> 
> Hmm.. isn't it better to add it to the buildid-cache command?

Yes, that is the right place. 'buildid-list' is about perf.data files,
buildid-cache is about .debug cache.

- Arnaldo
 
> >
> >   $ rm -rf ~/.debug/
> >
> >   $ perf buildid-list
> >   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
> >   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
> >
> >   $ perf buildid-list --store
> >
> >   $ find ~/.debug/
> >   .../.debug/
> >   .../.debug/usr
> >   .../.debug/usr/lib64
> >   .../.debug/usr/lib64/ld-2.31.so
> >   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b
> >   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/elf
> >   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/debug
> >   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/probes
> >   .../.debug/usr/lib64/libc-2.31.so
> >   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2
> >   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/elf
> >   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/debug
> >   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/probes
> >   .../.debug/.build-id
> >   .../.debug/.build-id/18
> >   .../.debug/.build-id/18/05c738c8f3ec0f47b7ea09080c28f34d18a82b
> >   .../.debug/.build-id/d2
> >   .../.debug/.build-id/d2/78249792061c6b74d1693ca59513be1def13f2
> >
> > It's possible to query debuginfod daemon for binaries by defining
> > DEBUGINFOD_URLS variable with server URL, like:
> >
> >   $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-list --store
> >   OK   439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 .../.debug/.build-id/43/9fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/elf
> >   FAIL 23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
> >   FAIL d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
> >   FAIL 1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
> >   OK   ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd
> >   OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
> >   OK   3b9b2ef537520303411ad5038b596d5d18e7c2b8 /usr/lib64/libpcre2-8.so.0.10.0
> >
> > Increasing debug level in util/probe-event.c to get rid
> > of the sdt probes messages on single verbose level (-v).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> [SNIP]
> > +static int dso__store(struct dso *dso, struct machine *machine __maybe_unused, void *priv)
> > +{
> > +       struct dso_store_data *data = priv;
> > +       char sbuild_id[SBUILD_ID_SIZE];
> > +       u8 bid[BUILD_ID_SIZE];
> > +       char *path = NULL;
> > +       bool is_kallsyms;
> > +       int err = -1;
> > +
> > +       if (!dso->has_build_id ||
> > +           !build_id__is_defined(dso->build_id))
> > +               return 0;
> > +
> > +       if (data->with_hits && !dso->hit)
> > +               return 0;
> > +
> > +       /*
> > +        * The storing process is:
> > +        *   - get build id of the dso
> > +        *   - check if it matches provided build id from mmap3 event
> > +        *   - if not, try debuginfod to download the binary
> > +        *   - store binary to build id database
> > +        */
> > +       is_kallsyms = !strcmp(machine->mmap_name, dso->short_name);
> > +       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> > +
> > +       if (is_kallsyms) {
> > +               /*
> > +                * Find out if we are on the same kernel as perf.data
> > +                * and keel kallsyms in that case.
> > +                */
> > +               path = strdup(dso->long_name);
> > +               if (!path)
> > +                       goto out_err;
> > +
> > +               err = sysfs__read_build_id("/sys/kernel/notes", &bid, sizeof(bid));
> > +               if (err < 0)
> > +                       goto out_err;
> > +       } else {
> > +               struct stat st;
> > +
> > +               /*
> > +                * Does the file exists in the first place, if it does,
> > +                * resolve path and read the build id.
> > +                */
> > +               if (stat(dso->long_name, &st)) {
> > +                       zfree(&path);
> > +                       goto try_download;
> > +               }
> > +
> > +               path = nsinfo__realpath(dso->long_name, dso->nsinfo);
> > +               if (!path)
> > +                       goto out_err;
> > +
> > +               err = filename__read_build_id(path, &bid, sizeof(bid));
> 
> Is it ok to read the file out of the namespace?
> 
> Thanks
> Namhyung
> 
> 
> > +               if (err != sizeof(bid))
> > +                       goto out_err;
> > +       }
> > +
> > +       /*
> > +        * If we match then we want in mmap3 event,
> > +        * is what we got in the binary, so we're happy.
> > +        */
> > +       if (memcmp(&bid, dso->build_id, BUILD_ID_SIZE)) {
> > +               char sbid[SBUILD_ID_SIZE];
> > +
> > +               build_id__sprintf(bid, sizeof(bid), sbid);
> > +               pr_debug("mmap build id <%s> does not match for %s <%s>\n",
> > +                        sbuild_id, path, sbid);
> > +               zfree(&path);
> > +       }
> > +
> > +try_download:
> > +       /*
> > +        * We did not match build id or did not find the
> > +        * binary - try debuginfod as last resort.
> > +        */
> > +       if (!path) {
> > +               char *tmp = NULL;
> > +
> > +               /*
> > +                * The debuginfo retrieval is handled within
> > +                * build_id_cache__add function.
> > +                */
> > +               if (get_executable(sbuild_id, &tmp)) {
> > +                       err = -1;
> > +                       goto out_err;
> > +               }
> > +
> > +               path = tmp;
> > +
> > +               /*
> > +                * The kernel dso is now elf binary, so disable is_kallsyms
> > +                * so build_id_cache__add can prepare proper file names.
> > +                */
> > +               is_kallsyms = false;
> > +       }
> > +
> > +       pr_debug("linking %s %s <%s>\n", dso->short_name, path, sbuild_id);
> > +
> > +       err = build_id_cache__add(sbuild_id, path, path,
> > +                                 dso->nsinfo, is_kallsyms, false);
> > +out_err:
> > +       free(path);
> > +       fprintf(stderr, "%s %s %s\n", err ? "FAIL" : "OK  ", sbuild_id, dso->long_name);
> > +       return 0;
> > +}

-- 

- Arnaldo

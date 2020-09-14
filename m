Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909AC268514
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgINGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:43:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52451 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgINGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:43:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id q9so9480540wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wqaP0tdnhnrGCUcokXX6ommGqTHWwKvvJsNWJ3jmcg=;
        b=OIEuXMbztZI4tltc84OW6c+Xe2SMqcetlHwzkLgS+rVUpcmoWG84k0n9oM+7LigaDK
         HPrqAKHXMeFu4VB72I+nqYLq9jHG96jEYi4UtRI4PtHWiASi3IbUlCbfVoB+7ZedglS0
         GNY7LXNAID9iEgviVj/J5h7KLFPv6pGZ//qIlhNgBELlFwhufAaKYqgD+lwTsOsa1pEM
         hlucSrNRvJcPrqCY0yFODARZp0nTZ7vEnwn5aMAakKCWSDjr0cQCXEFuGpgS2TUn44Dd
         cqUZPM257DAp0zB+/RA7Z08IBR99/zclQU7luL+sNWDRsuavtbX/HwxJEnZNpJ2PgCP8
         rkTQ==
X-Gm-Message-State: AOAM531FCMU/HxLemBjfh0uvL//l4wmWnXt9/yc2itmC3l6V8d/mHeYd
        OMafGbHHwaE5E8DSVl4P8CvSyd9laB1+Yd5iKr8=
X-Google-Smtp-Source: ABdhPJxeO4GxH7Eg6naaJX8CmUrhr2f4j+5mo4HzCxkxfSSFny4DayYTZSyDj9S/3I7ZSU+ABZ54oxEcbGPpdVZz5sQ=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr13328985wmm.128.1600065786341;
 Sun, 13 Sep 2020 23:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-25-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-25-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 15:42:55 +0900
Message-ID: <CAM9d7ch5Od3Pz6GORmkW6RfUQL6ON0DVJ+dndA9mGCv6ppLsbA@mail.gmail.com>
Subject: Re: [PATCH 24/26] perf tools: Add buildid-list --store option
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding buildid-list --store option to populate
> .debug data with build id files.

Hmm.. isn't it better to add it to the buildid-cache command?

>
>   $ rm -rf ~/.debug/
>
>   $ perf buildid-list
>   1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
>   d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so
>
>   $ perf buildid-list --store
>
>   $ find ~/.debug/
>   .../.debug/
>   .../.debug/usr
>   .../.debug/usr/lib64
>   .../.debug/usr/lib64/ld-2.31.so
>   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b
>   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/elf
>   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/debug
>   .../.debug/usr/lib64/ld-2.31.so/1805c738c8f3ec0f47b7ea09080c28f34d18a82b/probes
>   .../.debug/usr/lib64/libc-2.31.so
>   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2
>   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/elf
>   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/debug
>   .../.debug/usr/lib64/libc-2.31.so/d278249792061c6b74d1693ca59513be1def13f2/probes
>   .../.debug/.build-id
>   .../.debug/.build-id/18
>   .../.debug/.build-id/18/05c738c8f3ec0f47b7ea09080c28f34d18a82b
>   .../.debug/.build-id/d2
>   .../.debug/.build-id/d2/78249792061c6b74d1693ca59513be1def13f2
>
> It's possible to query debuginfod daemon for binaries by defining
> DEBUGINFOD_URLS variable with server URL, like:
>
>   $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-list --store
>   OK   439fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46 .../.debug/.build-id/43/9fe9bdeaed66af2bb8b8de5e650d5ecc3d8d46/elf
>   FAIL 23b87f5b0560481043257e82be670bc97786a171 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/net/ipv4/netfilter/ip_tables.ko.xz
>   FAIL d2b3be372bcdd4ebc15e479d2ff803657de0fd1e /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/drivers/block/virtio_blk.ko.xz
>   FAIL 1466a71bcd0ff5c975ee79b72752137c0143d225 /lib/modules/5.9.0-0.rc3.1.mmap3.fc34.x86_64/kernel/fs/xfs/xfs.ko.xz
>   OK   ad60d10b38c93bd8738d5aa594e240f01bb328cd /usr/lib/systemd/systemd
>   OK   589e403a34f55486bcac848a45e00bcdeedd1ca8 /usr/lib64/libcrypto.so.1.1.1g
>   OK   3b9b2ef537520303411ad5038b596d5d18e7c2b8 /usr/lib64/libpcre2-8.so.0.10.0
>
> Increasing debug level in util/probe-event.c to get rid
> of the sdt probes messages on single verbose level (-v).
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
[SNIP]
> +static int dso__store(struct dso *dso, struct machine *machine __maybe_unused, void *priv)
> +{
> +       struct dso_store_data *data = priv;
> +       char sbuild_id[SBUILD_ID_SIZE];
> +       u8 bid[BUILD_ID_SIZE];
> +       char *path = NULL;
> +       bool is_kallsyms;
> +       int err = -1;
> +
> +       if (!dso->has_build_id ||
> +           !build_id__is_defined(dso->build_id))
> +               return 0;
> +
> +       if (data->with_hits && !dso->hit)
> +               return 0;
> +
> +       /*
> +        * The storing process is:
> +        *   - get build id of the dso
> +        *   - check if it matches provided build id from mmap3 event
> +        *   - if not, try debuginfod to download the binary
> +        *   - store binary to build id database
> +        */
> +       is_kallsyms = !strcmp(machine->mmap_name, dso->short_name);
> +       build_id__sprintf(dso->build_id, sizeof(dso->build_id), sbuild_id);
> +
> +       if (is_kallsyms) {
> +               /*
> +                * Find out if we are on the same kernel as perf.data
> +                * and keel kallsyms in that case.
> +                */
> +               path = strdup(dso->long_name);
> +               if (!path)
> +                       goto out_err;
> +
> +               err = sysfs__read_build_id("/sys/kernel/notes", &bid, sizeof(bid));
> +               if (err < 0)
> +                       goto out_err;
> +       } else {
> +               struct stat st;
> +
> +               /*
> +                * Does the file exists in the first place, if it does,
> +                * resolve path and read the build id.
> +                */
> +               if (stat(dso->long_name, &st)) {
> +                       zfree(&path);
> +                       goto try_download;
> +               }
> +
> +               path = nsinfo__realpath(dso->long_name, dso->nsinfo);
> +               if (!path)
> +                       goto out_err;
> +
> +               err = filename__read_build_id(path, &bid, sizeof(bid));

Is it ok to read the file out of the namespace?

Thanks
Namhyung


> +               if (err != sizeof(bid))
> +                       goto out_err;
> +       }
> +
> +       /*
> +        * If we match then we want in mmap3 event,
> +        * is what we got in the binary, so we're happy.
> +        */
> +       if (memcmp(&bid, dso->build_id, BUILD_ID_SIZE)) {
> +               char sbid[SBUILD_ID_SIZE];
> +
> +               build_id__sprintf(bid, sizeof(bid), sbid);
> +               pr_debug("mmap build id <%s> does not match for %s <%s>\n",
> +                        sbuild_id, path, sbid);
> +               zfree(&path);
> +       }
> +
> +try_download:
> +       /*
> +        * We did not match build id or did not find the
> +        * binary - try debuginfod as last resort.
> +        */
> +       if (!path) {
> +               char *tmp = NULL;
> +
> +               /*
> +                * The debuginfo retrieval is handled within
> +                * build_id_cache__add function.
> +                */
> +               if (get_executable(sbuild_id, &tmp)) {
> +                       err = -1;
> +                       goto out_err;
> +               }
> +
> +               path = tmp;
> +
> +               /*
> +                * The kernel dso is now elf binary, so disable is_kallsyms
> +                * so build_id_cache__add can prepare proper file names.
> +                */
> +               is_kallsyms = false;
> +       }
> +
> +       pr_debug("linking %s %s <%s>\n", dso->short_name, path, sbuild_id);
> +
> +       err = build_id_cache__add(sbuild_id, path, path,
> +                                 dso->nsinfo, is_kallsyms, false);
> +out_err:
> +       free(path);
> +       fprintf(stderr, "%s %s %s\n", err ? "FAIL" : "OK  ", sbuild_id, dso->long_name);
> +       return 0;
> +}

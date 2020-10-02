Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E34281958
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgJBRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJBRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:35:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD899C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:35:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so2678776wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsyeaEJR3XOxfCZSZo0V0L7zb0UPe0ZFB9//ROCUYNY=;
        b=soVGwITStmIiSwuwmUcQHg3qLan+qgauyQxKd6RwYvz2rtZoW4ezd84tB1srQmN0nh
         R3pQlMVdQm/1nCVH/2menBP8aEel4pFvR6mSjZ28qHcsvLfzhNpGShpoAbHbS3gTJqqq
         FJrXIdCaOrmPh9MSoEr1iy1eJvOOxDPWNiL7j74NZIiYTkQUFIVsy0D3wmN7MV/MmbMj
         HYySEe0QeaksKGXA4aDxiUb1c1V5oSWeJN/Hkjtp71+8ZED/Rvxo6Kn/5sqAt8qdynET
         YDdKfMyUWpIclvvXxOSvxMQVdXFq16FVLRiQ5wbTqUMFgZumTJPr8+250qn9RWH6TyEP
         Z/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsyeaEJR3XOxfCZSZo0V0L7zb0UPe0ZFB9//ROCUYNY=;
        b=jZfwhh6LqfK7ZqZqKO222gjgoq+PCASsQugL3nvPp8jqC7UsS1+/ANN8u9oS26SmeA
         YT5uVD7pu70BCBnlqR84vBALoWpGAawg922flAepB7nscY/fIskZf2h5XWI5RyCDAUDi
         3Ll/NkWW64FY/cRu/qKo3b+6qVr7VMF9gWytJVW8yKUg3MgFlcWc1Vme+aluGS5bdyNB
         loBW2yQswewLgzczIxh9Y+NaFEnGh6ajsah0993/PxGCabfZgggW/u6XKN2qGEYY22C5
         8NgnYCR/oJMNcHfc2R1McQw5TnpkySBdF4Aw9jLVeMtNklA45fZBOWQfyxQK/l++wQkQ
         /vkQ==
X-Gm-Message-State: AOAM531T2kvemygg1LZ9itbE7blnvVv24ZQ5v1OJ/Bk+unjzmiyoLfrA
        QugGGfXkWVHRnBvGsdjBnkaTxwe6D7so1FAS95nRow==
X-Google-Smtp-Source: ABdhPJxkNacnFBtYba67xZs+g+JvdsyG6F7/8dK+Mo8fvRKgROlXyOlcd1QdRA3z9Sgpt5fYGHu3ULMb+nEzSk+h+Po=
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr4123320wrs.48.1601660102938;
 Fri, 02 Oct 2020 10:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava> <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
In-Reply-To: <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 2 Oct 2020 10:34:51 -0700
Message-ID: <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 6:07 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Jiri,
>
> On Fri, Oct 2, 2020 at 4:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding test for build id cache that adds binary
> > with sha1 and md5 build ids and verifies it's
> > added properly.
> >
> > The test updates build id cache with perf record
> > and perf buildid-cache -a.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > v2 changes:
> >   - detect perf build directory when checking for build-ex* binaries
> >
> >  tools/perf/Makefile.perf          |  14 +++++
> >  tools/perf/tests/shell/buildid.sh | 101 ++++++++++++++++++++++++++++++
> >  2 files changed, 115 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/buildid.sh
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 920d8afb9238..b2aeefa64e92 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
> >  #
> >  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> >  #
> > +# Define NO_BUILDID_EX if you do not want buildid-ex-* binaries
> > +#
> >
> >  # As per kernel Makefile, avoid funny character set dependencies
> >  unexport LC_ALL
> > @@ -349,6 +351,11 @@ ifndef NO_PERF_READ_VDSOX32
> >  PROGRAMS += $(OUTPUT)perf-read-vdsox32
> >  endif
> >
> > +ifndef NO_BUILDID_EX
> > +PROGRAMS += $(OUTPUT)buildid-ex-sha1
> > +PROGRAMS += $(OUTPUT)buildid-ex-md5
> > +endif
> > +
> >  LIBJVMTI = libperf-jvmti.so
> >
> >  ifndef NO_JVMTI
> > @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
> >         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
> >  endif
> >
> > +ifndef NO_BUILDID_EX
> > +$(OUTPUT)buildid-ex-sha1:
> > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> > +$(OUTPUT)buildid-ex-md5:
> > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> > +endif
>
> Can we just build them in the test shell script instead?
>
> Thanks
> Namhyung

That'd mean perf test having a dependency on a compiler :-/ That said
there are some existing dependencies for BPF compilers.

Thanks,
Ian

>
> > +
> >  ifndef NO_JVMTI
> >  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
> >
> > diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> > new file mode 100755
> > index 000000000000..dd9f9c306c34
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/buildid.sh
> > @@ -0,0 +1,101 @@
> > +#!/bin/sh
> > +# build id cache operations
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +ex_md5=buildid-ex-md5
> > +ex_sha1=buildid-ex-sha1
> > +
> > +# skip if there are no test binaries
> > +if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> > +       ex_dir=$(dirname `which perf`)
> > +       ex_md5=${ex_dir}/buildid-ex-md5
> > +       ex_sha1=${ex_dir}/buildid-ex-sha1
> > +
> > +       if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
> > +               echo "failed: no test binaries"
> > +               exit 2
> > +       fi
> > +fi
> > +
> > +echo "test binaries: ${ex_sha1} ${ex_md5}"
> > +
> > +# skip if there's no readelf
> > +if [ ! -x `which readelf` ]; then
> > +       echo "failed: no readelf, install binutils"
> > +       exit 2
> > +fi
> > +
> > +check()
> > +{
> > +       id=`readelf -n $1 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> > +
> > +       echo "build id: ${id}"
> > +
> > +       link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
> > +       echo "link: ${link}"
> > +
> > +       if [ ! -h $link ]; then
> > +               echo "failed: link ${link} does not exist"
> > +               exit 1
> > +       fi
> > +
> > +       file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
> > +       echo "file: ${file}"
> > +
> > +       if [ ! -x $file ]; then
> > +               echo "failed: file ${file} does not exist"
> > +               exit 1
> > +       fi
> > +
> > +       diff ${file} ${1}
> > +       if [ $? -ne 0 ]; then
> > +               echo "failed: ${file} do not match"
> > +               exit 1
> > +       fi
> > +
> > +       echo "OK for ${1}"
> > +}
> > +
> > +test_add()
> > +{
> > +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> > +       perf="perf --buildid-dir ${build_id_dir}"
> > +
> > +       ${perf} buildid-cache -v -a ${1}
> > +       if [ $? -ne 0 ]; then
> > +               echo "failed: add ${1} to build id cache"
> > +               exit 1
> > +       fi
> > +
> > +       check ${1}
> > +
> > +       rm -rf ${build_id_dir}
> > +}
> > +
> > +test_record()
> > +{
> > +       data=$(mktemp /tmp/perf.data.XXX)
> > +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> > +       perf="perf --buildid-dir ${build_id_dir}"
> > +
> > +       ${perf} record --buildid-all -o ${data} ${1}
> > +       if [ $? -ne 0 ]; then
> > +               echo "failed: record ${1}"
> > +               exit 1
> > +       fi
> > +
> > +       check ${1}
> > +
> > +       rm -rf ${build_id_dir}
> > +       rm -rf ${data}
> > +}
> > +
> > +# add binaries manual via perf buildid-cache -a
> > +test_add ${ex_sha1}
> > +test_add ${ex_md5}
> > +
> > +# add binaries via perf record post processing
> > +test_record ${ex_sha1}
> > +test_record ${ex_md5}
> > +
> > +exit ${err}
> > --
> > 2.26.2
> >

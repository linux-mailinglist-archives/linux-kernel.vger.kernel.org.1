Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C118281D30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJBUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBUzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:55:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1242065D;
        Fri,  2 Oct 2020 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601672130;
        bh=vn2dtzloDflamPSOR08Sc0E+h1XUXfZWBcTlMtsslCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOkV36aitWp9zX/k/mj9ecGsl4PqTirYwgJz8IS3L99FpkIXJxlih8A3LNu169t5Y
         +WCOjWviLyoXgvNItcdjeh2ZJEbbprKz51IRu/0PIuIpdW8p3Ep+ZZvr4FAR3MIrmX
         H79xlsvGDRi+ybsEU/vM+J1YjPXlnETiGaarPr2M=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68219403AC; Fri,  2 Oct 2020 17:55:27 -0300 (-03)
Date:   Fri, 2 Oct 2020 17:55:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
Message-ID: <20201002205527.GA7581@kernel.org>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava>
 <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 02, 2020 at 10:34:51AM -0700, Ian Rogers escreveu:
> On Fri, Oct 2, 2020 at 6:07 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Jiri,
> >
> > On Fri, Oct 2, 2020 at 4:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > Adding test for build id cache that adds binary
> > > with sha1 and md5 build ids and verifies it's
> > > added properly.
> > >
> > > The test updates build id cache with perf record
> > > and perf buildid-cache -a.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > > v2 changes:
> > >   - detect perf build directory when checking for build-ex* binaries
> > >
> > >  tools/perf/Makefile.perf          |  14 +++++
> > >  tools/perf/tests/shell/buildid.sh | 101 ++++++++++++++++++++++++++++++
> > >  2 files changed, 115 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/buildid.sh
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 920d8afb9238..b2aeefa64e92 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
> > >  #
> > >  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> > >  #
> > > +# Define NO_BUILDID_EX if you do not want buildid-ex-* binaries
> > > +#
> > >
> > >  # As per kernel Makefile, avoid funny character set dependencies
> > >  unexport LC_ALL
> > > @@ -349,6 +351,11 @@ ifndef NO_PERF_READ_VDSOX32
> > >  PROGRAMS += $(OUTPUT)perf-read-vdsox32
> > >  endif
> > >
> > > +ifndef NO_BUILDID_EX
> > > +PROGRAMS += $(OUTPUT)buildid-ex-sha1
> > > +PROGRAMS += $(OUTPUT)buildid-ex-md5
> > > +endif
> > > +
> > >  LIBJVMTI = libperf-jvmti.so
> > >
> > >  ifndef NO_JVMTI
> > > @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
> > >         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
> > >  endif
> > >
> > > +ifndef NO_BUILDID_EX
> > > +$(OUTPUT)buildid-ex-sha1:
> > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> > > +$(OUTPUT)buildid-ex-md5:
> > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> > > +endif
> >
> > Can we just build them in the test shell script instead?
> >
> > Thanks
> > Namhyung
> 
> That'd mean perf test having a dependency on a compiler :-/ That said
> there are some existing dependencies for BPF compilers.

If doing it in the test shell script ends up being advantageous, we
could skip the test if a suitable compiler isn't available.

- Arnaldo
 
> Thanks,
> Ian
> 
> >
> > > +
> > >  ifndef NO_JVMTI
> > >  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
> > >
> > > diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> > > new file mode 100755
> > > index 000000000000..dd9f9c306c34
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/buildid.sh
> > > @@ -0,0 +1,101 @@
> > > +#!/bin/sh
> > > +# build id cache operations
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +ex_md5=buildid-ex-md5
> > > +ex_sha1=buildid-ex-sha1
> > > +
> > > +# skip if there are no test binaries
> > > +if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> > > +       ex_dir=$(dirname `which perf`)
> > > +       ex_md5=${ex_dir}/buildid-ex-md5
> > > +       ex_sha1=${ex_dir}/buildid-ex-sha1
> > > +
> > > +       if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
> > > +               echo "failed: no test binaries"
> > > +               exit 2
> > > +       fi
> > > +fi
> > > +
> > > +echo "test binaries: ${ex_sha1} ${ex_md5}"
> > > +
> > > +# skip if there's no readelf
> > > +if [ ! -x `which readelf` ]; then
> > > +       echo "failed: no readelf, install binutils"
> > > +       exit 2
> > > +fi
> > > +
> > > +check()
> > > +{
> > > +       id=`readelf -n $1 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> > > +
> > > +       echo "build id: ${id}"
> > > +
> > > +       link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
> > > +       echo "link: ${link}"
> > > +
> > > +       if [ ! -h $link ]; then
> > > +               echo "failed: link ${link} does not exist"
> > > +               exit 1
> > > +       fi
> > > +
> > > +       file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
> > > +       echo "file: ${file}"
> > > +
> > > +       if [ ! -x $file ]; then
> > > +               echo "failed: file ${file} does not exist"
> > > +               exit 1
> > > +       fi
> > > +
> > > +       diff ${file} ${1}
> > > +       if [ $? -ne 0 ]; then
> > > +               echo "failed: ${file} do not match"
> > > +               exit 1
> > > +       fi
> > > +
> > > +       echo "OK for ${1}"
> > > +}
> > > +
> > > +test_add()
> > > +{
> > > +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> > > +       perf="perf --buildid-dir ${build_id_dir}"
> > > +
> > > +       ${perf} buildid-cache -v -a ${1}
> > > +       if [ $? -ne 0 ]; then
> > > +               echo "failed: add ${1} to build id cache"
> > > +               exit 1
> > > +       fi
> > > +
> > > +       check ${1}
> > > +
> > > +       rm -rf ${build_id_dir}
> > > +}
> > > +
> > > +test_record()
> > > +{
> > > +       data=$(mktemp /tmp/perf.data.XXX)
> > > +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> > > +       perf="perf --buildid-dir ${build_id_dir}"
> > > +
> > > +       ${perf} record --buildid-all -o ${data} ${1}
> > > +       if [ $? -ne 0 ]; then
> > > +               echo "failed: record ${1}"
> > > +               exit 1
> > > +       fi
> > > +
> > > +       check ${1}
> > > +
> > > +       rm -rf ${build_id_dir}
> > > +       rm -rf ${data}
> > > +}
> > > +
> > > +# add binaries manual via perf buildid-cache -a
> > > +test_add ${ex_sha1}
> > > +test_add ${ex_md5}
> > > +
> > > +# add binaries via perf record post processing
> > > +test_record ${ex_sha1}
> > > +test_record ${ex_md5}
> > > +
> > > +exit ${err}
> > > --
> > > 2.26.2
> > >

-- 

- Arnaldo

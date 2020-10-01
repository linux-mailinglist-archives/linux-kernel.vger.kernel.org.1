Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5177727FC64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgJAJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgJAJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:25:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601544349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A9iSVeX976yE3dlIwzRUHllOOZTDOuJyUsyj0zxqhmo=;
        b=hb79ktCd52IOSop0z3lk43hdysDbT8qmfoEsoM/+LfDWivmugGtf11LwqHMvlMVCJ4GvK9
        Sxkkw07I9kJl7TMFqYuVnsd+zoGVKzY+FArhoent7Zu9BBK8z4zyLJe/3tdoUMDbgQPMqa
        WtK90He292Fq9bXp+UFw5Gbnp8xOu4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585--MF_0C8tNZ6CXYFvIMCj_g-1; Thu, 01 Oct 2020 05:25:36 -0400
X-MC-Unique: -MF_0C8tNZ6CXYFvIMCj_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F099C1074642;
        Thu,  1 Oct 2020 09:25:33 +0000 (UTC)
Received: from krava (ovpn-115-79.ams2.redhat.com [10.36.115.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 27F935C1CF;
        Thu,  1 Oct 2020 09:25:30 +0000 (UTC)
Date:   Thu, 1 Oct 2020 11:25:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
Message-ID: <20201001092530.GB3999500@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <CAP-5=fVwe5wowm9Z6RgMAKA-nRd01U6DL0LGuUJSnPc_H=w17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVwe5wowm9Z6RgMAKA-nRd01U6DL0LGuUJSnPc_H=w17w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:00:05PM -0700, Ian Rogers wrote:
> On Wed, Sep 30, 2020 at 10:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test for build id cache that adds binary
> > with sha1 and md5 build ids and verifies it's
> > added properly.
> >
> > The test updates build id cache with perf record
> > and perf buildid-cache -a.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> This is great! If I build perf and test from the build directory the
> test gets run. If I build using O=/tmp/perf and run from that
> directory then ./tests/shell isn't found and the test doesn't run.
> Similarly the install directory doesn't contain the executables and so
> the test is skipped. Is there any way to get the test running in these
> other scenarios?

ok, if there's already some way to get the build path I did not see that
I'll check and add something if it's missing

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Makefile.perf          | 14 +++++
> >  tools/perf/tests/shell/buildid.sh | 90 +++++++++++++++++++++++++++++++
> >  2 files changed, 104 insertions(+)
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
> > +
> >  ifndef NO_JVMTI
> >  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
> >
> > diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> > new file mode 100755
> > index 000000000000..57fcd28bc4bd
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/buildid.sh
> > @@ -0,0 +1,90 @@
> > +#!/bin/sh
> > +# build id cache operations
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# skip if there are no test binaries
> > +if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> > +       echo "failed: no test binaries"
> > +       exit 2
> > +fi
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
> > +test_add buildid-ex-sha1
> > +test_add buildid-ex-md5
> > +
> > +# add binaries via perf record post processing
> > +test_record buildid-ex-sha1
> > +test_record buildid-ex-md5
> > +
> > +exit ${err}
> > --
> > 2.26.2
> >
> 


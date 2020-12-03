Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1C2CE185
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgLCWWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729635AbgLCWWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607034070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ISPHS/qFGkoXfeg13gVylWvk6gUYj8tbfF+wixKiaM=;
        b=QUJmcUkkUvDA1+L+/A+V4wUJny+MbuJsnOZWhKB/D0QRG2i8gJ6qa9c+yi3aSlObutn5jB
        sUp7nBTP7gkZW7c8RSPzx6QREALfTStPcOPQwEOgtdQVaAKTcgkRtJPRzHLDL0CoantNcq
        v2LdWIOdzJ4FLvicwb//sSE3OhBlllI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-_bslx57CO3iA7XJ7psvDIQ-1; Thu, 03 Dec 2020 17:21:02 -0500
X-MC-Unique: _bslx57CO3iA7XJ7psvDIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92111005513;
        Thu,  3 Dec 2020 22:21:00 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 98EC65D6AC;
        Thu,  3 Dec 2020 22:20:58 +0000 (UTC)
Date:   Thu, 3 Dec 2020 23:20:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC v2 1/2] perf: support build BPF skeletons with perf
Message-ID: <20201203222057.GD3613628@krava>
References: <20201201073647.753079-1-songliubraving@fb.com>
 <20201201073647.753079-2-songliubraving@fb.com>
 <20201201205433.GE3169083@krava>
 <709375F7-A386-415B-926E-0A19783D09A5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709375F7-A386-415B-926E-0A19783D09A5@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:47:59PM +0000, Song Liu wrote:

SNIP

> >> # As per kernel Makefile, avoid funny character set dependencies
> >> unexport LC_ALL
> >> @@ -735,7 +737,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
> >> 	$(x86_arch_prctl_code_array) \
> >> 	$(rename_flags_array) \
> >> 	$(arch_errno_name_array) \
> >> -	$(sync_file_range_arrays)
> >> +	$(sync_file_range_arrays) \
> >> +	bpf-skel
> > 
> > I think the 'prepare' target is misused already with other stuff,
> > there's generated bpf_counter.c dependency on util/bpf_skel/bpf_prog_profiler.skel.h
> > in util/.bpf_counter.o.cmd, that should triger the build no?
> 
> This doesn't work for me. Once bpf-skel is removed from "prepare", we hit
> compilation error before util/.bpf_counter.o.cmd is generated. 

ok, I'll check on that with your new version

SNIP

> >> +submake_extras := feature_display=0
> >> +
> >> +$(SKEL_TMP_OUT):
> >> +	$(Q)$(MKDIR) -p $@
> >> +
> >> +$(BPFTOOL): | $(SKEL_TMP_OUT)
> >> +	CFLAGS= $(MAKE) $(submake_extras) -C ../bpf/bpftool \
> >> +		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
> >> +
> >> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_OUT)
> >> +	$(call QUIET_CLANG, $@)
> >> +	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && \
> >> +	$(LLVM_STRIP) -g $@
> >> +
> >> +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> >> +	$(call QUIET_GENSKEL, $@)
> > 
> > is there a reason to use call in here? you could define QUIET_GENSKEL
> > to use $@ and use it the same way as we use the rest of QUIET_* stuf
> > in Makefile.perf
> 
> I am not following here. $(CALL QUIET_xx) was used for QUIET_CLEAN and 
> QUIET_INSTALL in Makefile.perf. What is the preferred pattern here?

right it's QUIET_CLEAN and QUIET_INSTALL because they need argument,
QUIET_GENSKEL uses $@, which is used directly in other QUIET_* macros

> 
> > 
> >> new file mode 100644
> >> index 0000000000000..5263e9e6c5d83
> >> --- /dev/null
> >> +++ b/tools/perf/util/bpf_skel/.gitignore
> >> @@ -0,0 +1,3 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +.tmp
> >> +*.skel.h
> >> \ No newline at end of file
> >> diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_skel/dummy.bpf.c
> >> new file mode 100644
> >> index 0000000000000..492a43a851deb
> >> --- /dev/null
> >> +++ b/tools/perf/util/bpf_skel/dummy.bpf.c
> > 
> > hum, what's the reason for dummy skeleton? it just adds
> > time to compilation no?
> 
> It is mostly to test 1/2 of the set works fine. I guess we can remove 
> it in 2/2?

so it needs to be there otherwise the compilation fails?

I'll check your new version

thanks,
jirka


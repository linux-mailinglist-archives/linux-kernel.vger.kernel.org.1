Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7BF281C09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgJBT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgJBT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601666994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUF8r6P20KLuB/qZTy80TaYlmTrYZ31o4GL8SMne1Mc=;
        b=S2pmYheCScYhbLNh++XN1USyPiXsQjkVnLRSeyuHYKt91spro2kRLkSL1NPHD+2EKj2SyH
        WzAh8FrAUvvON7BrKfSiKb9oHtyW5kIsASNP6tsrggCYipSxGC7Me3Hnp/uhGlGJKyrgIH
        eb725075iv6w2MqvybbK4HVlFEI5whc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-jZrE_AY5O5OsnuRt6N3Tiw-1; Fri, 02 Oct 2020 15:29:50 -0400
X-MC-Unique: jZrE_AY5O5OsnuRt6N3Tiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07508030BE;
        Fri,  2 Oct 2020 19:29:48 +0000 (UTC)
Received: from krava (ovpn-114-211.ams2.redhat.com [10.36.114.211])
        by smtp.corp.redhat.com (Postfix) with SMTP id E1F6973677;
        Fri,  2 Oct 2020 19:29:45 +0000 (UTC)
Date:   Fri, 2 Oct 2020 21:29:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
Message-ID: <20201002192944.GH3999500@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava>
 <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:34:51AM -0700, Ian Rogers wrote:

SNIP

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

it would solve the build-directory/install-directory
lookup search.. but it'd need to do detect compiler
and depend on it as Ian said

do you have some other reason to compile it in test?

thanks,
jirka

> >
> > Thanks
> > Namhyung
> 
> That'd mean perf test having a dependency on a compiler :-/ That said
> there are some existing dependencies for BPF compilers.

> 
> Thanks,
> Ian

SNIP


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDF287142
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgJHJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgJHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602148322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SI5KXM+HfSVoiFUKPevuobVKY3ePMXmgfp8KUxkUlTk=;
        b=Wp4NoYyY2h6Ds/zmAtZTZ3BapViLwHA2ueKktSyRjWEzmWreyZbClSJ7tEsW/HumGtyBpX
        eYrExpmBeECMhvQwxyKW+yK5wIHZHbU8iaoNTNqBoXlDN/xllA2eMUDxcND4EBugE7aluc
        gGd1bPIMnAP92njJ25WGAlgAgAhAWhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-pjd9CC1MPfurAuB6Xwinig-1; Thu, 08 Oct 2020 05:12:00 -0400
X-MC-Unique: pjd9CC1MPfurAuB6Xwinig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 749798064AD;
        Thu,  8 Oct 2020 09:11:58 +0000 (UTC)
Received: from krava (unknown [10.40.195.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id C8DA055761;
        Thu,  8 Oct 2020 09:11:54 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:11:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
Message-ID: <20201008091153.GB656950@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava>
 <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
 <20201002192944.GH3999500@krava>
 <CAM9d7cgoaU4wcid46+uScFcZtMZZQR+fijuE7XO1mjC2cLwX-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgoaU4wcid46+uScFcZtMZZQR+fijuE7XO1mjC2cLwX-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:37:45AM +0900, Namhyung Kim wrote:
> On Sat, Oct 3, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Oct 02, 2020 at 10:34:51AM -0700, Ian Rogers wrote:
> >
> > SNIP
> >
> > > > > +
> > > > >  LIBJVMTI = libperf-jvmti.so
> > > > >
> > > > >  ifndef NO_JVMTI
> > > > > @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
> > > > >         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
> > > > >  endif
> > > > >
> > > > > +ifndef NO_BUILDID_EX
> > > > > +$(OUTPUT)buildid-ex-sha1:
> > > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> > > > > +$(OUTPUT)buildid-ex-md5:
> > > > > +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> > > > > +endif
> > > >
> > > > Can we just build them in the test shell script instead?
> >
> > it would solve the build-directory/install-directory
> > lookup search.. but it'd need to do detect compiler
> > and depend on it as Ian said
> >
> > do you have some other reason to compile it in test?
> 
> No I just wanted to make it easy to find the binaries
> and assumed a compiler is available in the test machine
> (which is not true for my company setup.... :-/)
> 
> But otherwise we should keep the binaries somewhere
> in the install directory..

hum, could we go in with the v3 and then you guys
could customize it to what would work for you?

thanks,
jirka


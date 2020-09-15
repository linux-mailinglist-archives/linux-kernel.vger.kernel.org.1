Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39E26AE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIOT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:57:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36389 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgIOT4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600199807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EG240xw++cE/nxteG5CE2tKZsoEWmY2AlaIBC28s7o8=;
        b=e29M/SvaLKCCfBPVna039juguO3Po3HFjInxFkFOg7cwT687IeAqjUcS7TFhYP9cilDc4O
        EoBxEOjgyLLqumtq17xXlItGPIjVrGrddL9M34+GVjukw50mVcDPwN06xst0eKGeO/569W
        WPgkspwrap4kMVk5Q6cqhnGXuP5l6HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-5tI3tJ-GMrmBGAAK0tBLPA-1; Tue, 15 Sep 2020 15:56:36 -0400
X-MC-Unique: 5tI3tJ-GMrmBGAAK0tBLPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD3761074648;
        Tue, 15 Sep 2020 19:56:34 +0000 (UTC)
Received: from ovpn-114-91.phx2.redhat.com (ovpn-114-91.phx2.redhat.com [10.3.114.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 198D519D7C;
        Tue, 15 Sep 2020 19:56:32 +0000 (UTC)
Message-ID: <0679eacce01f187037e726a45e6acdacde61f99d.camel@redhat.com>
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
From:   David Malcolm <dmalcolm@redhat.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Date:   Tue, 15 Sep 2020 15:56:32 -0400
In-Reply-To: <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
References: <20200915031819.386559-1-namhyung@kernel.org>
         <20200915031819.386559-6-namhyung@kernel.org>
         <20200915121912.GF720847@kernel.org>
         <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-15 at 11:59 -0700, Ian Rogers wrote:
> On Tue, Sep 15, 2020 at 5:19 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Tue, Sep 15, 2020 at 12:18:13PM +0900, Namhyung Kim escreveu:
> > > The evsel->unit borrows a pointer of pmu event or alias instead
> > > of
> > > owns a string.  But tool event (duration_time) passes a result of
> > > strdup() caused a leak.
> > > 
> > > It was found by ASAN during metric test:
> > 
> > Thanks, applied.
> 
> Thanks Namhyung and Arnaldo, just to raise a meta point. A lot of the
> parse-events asan failures were caused by a lack of strdup causing
> frees of string literals. It seems we're now adding strdup
> defensively
> but introducing memory leaks. Could we be doing this in a smarter
> way?
> For C++ I'd likely use std::string and walk away. For perf code the
> best source of "ownership" I've found is to look at the "delete"
> functions and figure out ownership from what gets freed there - this
> can be burdensome. For strings, the code is also using strbuf and
> asprintf. One possible improvement could be to document ownership
> next
> to the struct member variable declarations. Another idea would be to
> declare a macro whose usage would look like:
> 
> struct evsel {
> ...
>   OWNER(char *name, "this");
> ...
>   UNOWNED(const char *unit);
> ...
> 
> Maybe then we could get a static analyzer to complain if a literal
> were assigned to an owned struct variable. Perhaps if a strdup were
> assigned to an UNOWNED struct variable perhaps it could warn too, as
> presumably the memory allocation is a request to own the memory.
> 
> There was a talk about GCC's -fanalyzer option doing malloc/free
> checking at Linux plumbers 2 weeks ago:
> https://linuxplumbersconf.org/event/7/contributions/721/attachments/542/961/2020-LPC-analyzer-talk.pdf
> I added David Malcolm, the LPC presenter, as he may have ideas on how
> we could do this in a better way.

Hi Ian.

Some ideas (with the caveat that I'm a GCC developer, and not a regular
on LKML): can you capture the ownership status in the type system?
I'm brainstorming here but how about:
  typedef char *owned_string_t;
  typedef const char *borrowed_string_t;
This would at least capture the intent in human-readable form, and
*might* make things more amenable to checking by a machine.  It's also
less macro cruft.
I take it that capturing the ownership status with a runtime flag next
to the pointer in a struct is too expensive for your code?


Some notes on -fanalyzer:

Caveat: The implementation of -fanalyzer in gcc 10 is an early
prototype and although it has found its first CVE I don't recommend it
for use "in anger" yet; I'm working on getting it more suitable for
general usage for C in gcc 11.  (mostly scaling issues and other
bugfixing)

-fanalyzer associates state machines with APIs; one of these state
machines implements leak detection for malloc, along with e.g. double-
free detection.  I'm generalizing this checker to other acquire/release
APIs: I have a semi-working patch under development (targeting GCC 11)
that exposes this via a fndecl attribute, currently named
"deallocated_by", so that fn decls can be labeled e.g.:

extern void foo_release (foo *);
extern foo *foo_acquire (void)
  __attribute__((deallocated_by(foo_release));

and have -fanalyzer detect leaks, double-releases, use-after-release,
failure to check for NULL (alloc failure) etc.

Ultimately this attribute might land in the libc header for strdup (and
friends), but I can also special-case strdup so that the analyzer
"knows" that the result needs to be freed if non-NULL (and that it can
fail and return NULL).

Hope this is constructive
Dave

[...]



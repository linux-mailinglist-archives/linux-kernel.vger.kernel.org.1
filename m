Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD452691B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgINQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgINQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:36:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WDMT4z+GYiPzqUDcVnVV7jQyFbfLccJ4XjhSBakvxjY=; b=e6+JbYmbABPLBOMdfnaNTiaF0A
        pBG/q91PcXZX1t0MJFpX40KBCJi9XmiN+KhKdSnj1tT06UrOS8VS5XFXukMiPqqhpDfUnmbNqqCem
        pcI+JKLldqcHd8kAmUq0RmWSm8MCnZI07pIzUurMEBrwhZ9m1yPIuqZuayDG/aSYv9bESda3pJzJG
        uCkSGQWnQ2VqI36ySZ3h0/BqRGulBGOa7d2I5pXQqpkvP2hMl+6So/6rEJ3/UgtHmkvXrKJESmJeJ
        JUuhghlGU+NQfHAFV/uX7Gjpr9ijAoAlGAgpdk7pifShbnmnL+EBVJhxEqXle6ZdOZDh273FKLYLN
        bHELImPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHrS5-0000dy-97; Mon, 14 Sep 2020 16:35:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 823AD3003D8;
        Mon, 14 Sep 2020 18:35:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3824C2B4A4AFF; Mon, 14 Sep 2020 18:35:34 +0200 (CEST)
Date:   Mon, 14 Sep 2020 18:35:34 +0200
From:   peterz@infradead.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914152841.GC160517@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:

> > >   struct {
> > >     struct perf_event_header header;
> 
> > >     u32                      pid, tid;
> > >     u64                      addr;
> > >     u64                      len;
> > >     u64                      pgoff;
> > >     u32                      maj;
> > >     u32                      min;
> > >     u64                      ino;
> > >     u64                      ino_generation;
> > >     u32                      prot, flags;
> > >     u32                      reserved;
> 
> What for this reserved? its all nicely aligned already, u64 followed by
> two u32 (prot, flags).

I suspect it is so that sizeof(reserve+buildid) is a multiple of 8. But
yes, that's a wee bit daft, since the next field is a variable length
character array.

> > >     u8                       buildid[20];
>  
> > Do we need maj, min, ino, ino_generation for mmap3 event?
> > I think they are to compare binaries, then we can do it with
> > build-id (and I think it'd be better)..
> 
> Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
> superset of MMAP2.

Well, the 'funny' thing is that if you do use buildid, then
{maj,min,ino,ino_generation} are indeed superfluous, but are combined
also large enough to contain buildid.

> If we want to ditch useless stuff, then trow away pid, tid too, as we
> can select those via sample_type.

Correct.

So something like:

struct {
  struct perf_event_header header;

  u64                      addr;
  u64                      len;
  u64                      pgoff;
  union {
    struct {
      u32                  maj;
      u32                  min;
      u64                  ino;
      u64                  ino_generation;
    };
    u8                     buildid[20];
  };
  u32                      prot, flags;
  char			   filename[];
  struct sample_id         sample_id;
};

Using one of the MISC bits to resolve the union. Might actually bring
benefit to everyone. Us normal people get to have a smaller MMAP record,
while the buildid folks can have it too.

Even more extreme would be using 2 MISC bits and allowing the union to
be 0 sized for anon.

That said; I have the nagging feeling there were unresolved issues with
mmap2, but I can't seem to find any relevant emails on it :/ My
google-fu is weak today.

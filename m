Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB01EA083
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgFAJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:06:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgFAJGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591002405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UvJDyc0SNLrckwmxaRE6oBgOUtc5VyDs6iQ/WZzZhA=;
        b=fRxb3rOjdKXz+JMe3HNqUGH4mEMntxLJdVzUEOYdPSbQqT0FYTlhLA5gb532LqmvdBr97+
        acaFYBon4S2KKrfV4n7H+XdMSHqErYaKbF+Qa2Mh3mKpZBVDH+K5/YiWEnX1X1aSYavHzZ
        Jgkz+D/56INUusmcbF+bCddUHXawPUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-InHkK0fbNKGSW5jmwCGDLA-1; Mon, 01 Jun 2020 05:06:43 -0400
X-MC-Unique: InHkK0fbNKGSW5jmwCGDLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B8484E03F;
        Mon,  1 Jun 2020 09:06:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32C9C2DE8A;
        Mon,  1 Jun 2020 09:06:37 +0000 (UTC)
Date:   Mon, 1 Jun 2020 11:06:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/14] perf tools: Add fake pmu support
Message-ID: <20200601090636.GH881900@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-5-jolsa@kernel.org>
 <CAP-5=fV0Q3Y0wmZd6jeO3VFw-OJMp81zPoEts0S_Ai82VzWEOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV0Q3Y0wmZd6jeO3VFw-OJMp81zPoEts0S_Ai82VzWEOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:22:30AM -0700, Ian Rogers wrote:

SNIP

> > +
> > +       list = alloc_list();
> > +       if (!list)
> > +               YYABORT;
> > +
> > +       err = parse_events_add_pmu(_parse_state, list, $1, NULL, false, false);
> > +       free($1);
> > +       if (err < 0)
> 
> nit: on error this needs:
> free(list);
> otherwise something like fuzz testing could go down the error path and
> complain about memory leaks.

right, I'll add that

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > +               YYABORT;
> > +       $$ = list;
> > +}
> > +|
> > +PE_PMU_EVENT_FAKE opt_pmu_config
> > +{
> > +       struct list_head *list;
> > +       int err;
> > +
> > +       list = alloc_list();
> > +       if (!list)
> > +               YYABORT;
> > +
> > +       err = parse_events_add_pmu(_parse_state, list, $1, $2, false, false);
> > +       free($1);
> > +       parse_events_terms__delete($2);
> > +       if (err < 0)
> > +               YYABORT;
> > +       $$ = list;
> > +}
> >
> >  value_sym:
> >  PE_VALUE_SYM_HW
> > --
> > 2.25.4
> >
> 


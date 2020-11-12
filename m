Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041652B103A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKLV0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbgKLV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605216367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWB515gB9BSyjwiQk48WO0yqF/B8oRyGtkVCRBUfRJY=;
        b=RNqKtT41eJH8paQiZiuLioz+ab+AYw4MIRBQ/qD1WSkkd8uJvcSv0IK/ReusgMzmqa6TMD
        gkoDIcLmVJqR/C5GwaSoBGP2iY7+aYungb6CHvMyc8BnYLFg8pu/TSFff1VKioiOhfPiH7
        gXG24ysjVFVibKhIxw7J6zRbMYhNJro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-AgUUydp_MFSRijVjhGRY1w-1; Thu, 12 Nov 2020 16:26:00 -0500
X-MC-Unique: AgUUydp_MFSRijVjhGRY1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0811074643;
        Thu, 12 Nov 2020 21:25:58 +0000 (UTC)
Received: from krava (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 292401002382;
        Thu, 12 Nov 2020 21:25:54 +0000 (UTC)
Date:   Thu, 12 Nov 2020 22:25:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
Message-ID: <20201112212554.GA753418@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
 <20201111170046.GB466880@tassilo.jf.intel.com>
 <20201112115710.GE619201@krava>
 <20201112203952.GA393548@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112203952.GA393548@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:39:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 12, 2020 at 12:57:10PM +0100, Jiri Olsa escreveu:
> > On Wed, Nov 11, 2020 at 09:00:46AM -0800, Andi Kleen wrote:
> > > On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> > > > Adding --buildid-mmap option to enable build id in mmap2 events.
> > > > It will only work if there's kernel support for that and it disables
> > > > build id cache (implies --no-buildid).
> 
> > > What's the point of the option? Why not enable it by default
> > > if the kernel supports it?
>  
> > > With the option most user won't get the benefit.
>  
> > > The only reason I can think of for an option would be to disable
> > > so that old tools can still process.
>  
> > yes, that was request in the rfc post, we want the new default
> > perf.data be still readable by older perf tools
> 
> We need to change perf so that when it finds some option it doesn't
> grok, it just ignores extra things in a record like MMAP2 and just warns
> the user that things are being ignored.
> 
> So that we can add new stuff by default without requiring an ever longer
> command line option, like with --all-cgroups, etc.
> 
> And provide the options to avoid using new stuff if we know that the
> perf.data file will be processed by someone with an older tool that
> can't update.

hum, can we just stop being this way compatible? ;-)

I can't see too much benefit in it, but not sure how common is
to report perf.data with older perf than it was recorded with

most of the time it will probably work anyway, just big changes
list this one will screw that

jirka


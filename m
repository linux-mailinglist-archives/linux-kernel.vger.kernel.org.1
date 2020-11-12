Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7CE2B0486
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKLL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgKLL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605182241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83w/1Q8eKBY/M3hgJMXofHi6YmZoj03v//KCkf2z5gI=;
        b=bAp/0zCo8zohCsdR69CVJTUC2Jl3daLDQwhLk45NjN+10+8YS9DsuazRT87g96l6zKrJdL
        bHJz5rbfKYO9ZsUFIqrrVA6NLE+0ktu3ohmM6uNTEMguGqJYmxRKUAbU1S16W+2jtRFee8
        63OpSOAutirMLpklQxiYIUqlNd5oq9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-D9yiioqgMCubAdQjgcyeqw-1; Thu, 12 Nov 2020 06:57:17 -0500
X-MC-Unique: D9yiioqgMCubAdQjgcyeqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D28803F60;
        Thu, 12 Nov 2020 11:57:15 +0000 (UTC)
Received: from krava (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56ED05B4B9;
        Thu, 12 Nov 2020 11:57:11 +0000 (UTC)
Date:   Thu, 12 Nov 2020 12:57:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201112115710.GE619201@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-25-jolsa@kernel.org>
 <20201111170046.GB466880@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111170046.GB466880@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:00:46AM -0800, Andi Kleen wrote:
> On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> > Adding --buildid-mmap option to enable build id in mmap2 events.
> > It will only work if there's kernel support for that and it disables
> > build id cache (implies --no-buildid).
> 
> What's the point of the option? Why not enable it by default
> if the kernel supports it?
> 
> With the option most user won't get the benefit.
> 
> The only reason I can think of for an option would be to disable
> so that old tools can still process.

yes, that was request in the rfc post, we want the new default
perf.data be still readable by older perf tools

jirka


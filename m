Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C926969A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgINU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgINU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600115378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1KVa3xurs4GlWZdhzpCFiegs+d93bptxd2qYE3J8TY=;
        b=ePy2qwvNXUMAHE4p2T+2WOluoWJ6nV56cXyVCXPx0j6bmyCMcbh/gegQ8NktTHBHywrCnX
        6v1Il+jN45PdTL/engNUj11JsV53xMCMsducmRlPTiOpqh0WlkbEWoSzbA6rWeSaMTkqO8
        eS28TUsh7MXPXbCjRIUOwdmvBiL7Z1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-g-lU0J8iNfq0hcKup-D5yw-1; Mon, 14 Sep 2020 16:29:34 -0400
X-MC-Unique: g-lU0J8iNfq0hcKup-D5yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C677D801F9A;
        Mon, 14 Sep 2020 20:29:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5066E75120;
        Mon, 14 Sep 2020 20:29:27 +0000 (UTC)
Date:   Mon, 14 Sep 2020 22:29:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/26] perf tools: Try load vmlinux from buildid database
Message-ID: <20200914202925.GU1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-10-jolsa@kernel.org>
 <CAM9d7ch7TqHr8dwCQ3_OZjpvp4yv+u=ipdDJR=AcCdUb2zSw2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch7TqHr8dwCQ3_OZjpvp4yv+u=ipdDJR=AcCdUb2zSw2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:25:39PM +0900, Namhyung Kim wrote:
> On Mon, Sep 14, 2020 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we don't check on kernel's vmlinux the same way as
> > we do for normal binaries, but we either look for kallsyms
> > file in build id database or check on known vmlinux locations
> > (plus some other optional paths).
> >
> > This patch adds the check for standard build id binary location,
> > so we are ready once we start to store it there from debuginfod
> > in following changes.
> 
> But dso__load_vmlinux_path() already has the logic.
> Also you should check symbol_conf.ignore_vmlinux_buildid.

I wanted to have it not dependent on !symbol_conf.ignore_vmlinux
which is needed to call dso__load_vmlinux_path

also the idea was to try the build id vmlinux before the configured
vmlinux locations, because they found the vmlinux in my setup ;-)

I'll double check the logic again

thanks,
jirka


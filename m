Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739DE28D449
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgJMTPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgJMTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602616519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NSQGNPVNn3MMVnlXmuKZ5mJnLSCV39BNCiQePPuj3I4=;
        b=DiZcak+S94Ye9WbllttBT3V2Ok5fuqhf7df6npHgy4tfOlNjmDlqLcRLLMCOacSnS/ptlk
        RAoQVk3q3YlfD8Yy+XVHvF/PAcu27xgfqsVaFYeP5OhrjlBXy4607LB7XR8kXNglXbFkPi
        NsiXyBB2w1hrcbC1Ceq5NuIdeqnisoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-DJ2ME411MsqdApV3GVVo7A-1; Tue, 13 Oct 2020 15:15:14 -0400
X-MC-Unique: DJ2ME411MsqdApV3GVVo7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0570B64145;
        Tue, 13 Oct 2020 19:15:13 +0000 (UTC)
Received: from krava (unknown [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7AD396EF7C;
        Tue, 13 Oct 2020 19:15:10 +0000 (UTC)
Date:   Tue, 13 Oct 2020 21:15:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
Message-ID: <20201013191509.GA1199570@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <20201013161340.GH1063281@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013161340.GH1063281@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:13:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 30, 2020 at 07:15:04PM +0200, Jiri Olsa escreveu:
> > Adding test for build id cache that adds binary
> > with sha1 and md5 build ids and verifies it's
> > added properly.
> > 
> > The test updates build id cache with perf record
> > and perf buildid-cache -a.
> 
> 
> [root@five ~]# perf test "build id"
> 82: build id cache operations                                       : Skip
> [root@five ~]# set -o vi
> [root@five ~]# perf test -v "build id"
> 82: build id cache operations                                       :
> --- start ---
> test child forked, pid 88384
> failed: no test binaries
> test child finished with -2
> ---- end ----
> build id cache operations: Skip
> [root@five ~]#

hm, output looks like older version of the test

> 
> Also the other patches clashed with Namhyung's patch series, can you
> please check?

right, new api is different now

> 
> I've just pushed what I have to acme/perf/core

I rebased and pushed perf/build_id_size branch, also will post new version

thanks,
jirka


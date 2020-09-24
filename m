Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE19277278
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgIXNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbgIXNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600954533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzBvnuUfa45ZSmPhP8GQJzcypn51oFxXOujgo6huJIU=;
        b=JPt8aPDELdf12QZ1jW7dGvrI3UrFCz6qhtJ+axICXgq3Me5qLb9QnZbO0ZtHv/PSSbU9zc
        qilx+XMCjOKrq+S2Tj1BIRkCuhw+4Yg77zCInoaMvrrWCJ3GEw4e9zVhkrqSdYOiKK55KI
        +JiZOxHOWEMf6BYqXZnG2SitvEGrwfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-EvOrQrLiMNmtUTHL6b2fPg-1; Thu, 24 Sep 2020 09:35:31 -0400
X-MC-Unique: EvOrQrLiMNmtUTHL6b2fPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8361289CCFE;
        Thu, 24 Sep 2020 13:35:06 +0000 (UTC)
Received: from krava (ovpn-115-138.ams2.redhat.com [10.36.115.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7CD5D73691;
        Thu, 24 Sep 2020 13:35:04 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:35:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET v2 0/7] perf inject: Speed build-id injection
Message-ID: <20200924133503.GD3150401@krava>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:05:30PM +0900, Namhyung Kim wrote:
> Hello,
> 
> This is my second attempt to speed up build-id injection.  As this is
> to improve performance, I've added a benchmark for it.  Please look at
> the usage in the first commit.
> 
> By default, it measures average processing time of 100 MMAP2 events
> and 10000 SAMPLE events.  Below is the current result on my laptop.
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 22.997 msec (+- 0.067 msec)
>     Average time per event: 2.255 usec (+- 0.007 usec)
> 
> With this patchset applied, it got this:
> 
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 18.441 msec (+- 0.106 msec)
>     Average time per event: 1.808 usec (+- 0.010 usec)
>     Average build-id-all injection took: 13.451 msec (+- 0.132 msec)
>     Average time per event: 1.319 usec (+- 0.013 usec)

nice, I can see that speed up as well

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


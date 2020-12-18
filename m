Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB20D2DE9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgLRTcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbgLRTcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608319857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5j5/xV2pbOpdG2BBGCtsw2z0PV21PcVqfX1sCFjv0s=;
        b=HnOaYzgQozaeGagCw6vs4DcyLdBwl+0vx3oPzIsfiFUQKLgZFxjMVQEtQKD2N1hWZf7GC9
        bFIPhBjNRa99JkwpTJBDh2dlxKYsWYOqgW4hASs6a1SvZCu7/73LF2wuoxh223oG3d/TvW
        8dq+S4Z+wEsjeZASOcQwRRK4Pl89o/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-8nlXG9VNN0iWic-1WH4Ldg-1; Fri, 18 Dec 2020 14:30:53 -0500
X-MC-Unique: 8nlXG9VNN0iWic-1WH4Ldg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008E4107ACE6;
        Fri, 18 Dec 2020 19:30:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.37])
        by smtp.corp.redhat.com (Postfix) with SMTP id 937AF3AA2;
        Fri, 18 Dec 2020 19:30:47 +0000 (UTC)
Date:   Fri, 18 Dec 2020 20:30:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 4/8] perf daemon: Add daemon command
Message-ID: <20201218193046.GD105234@krava>
References: <20201212104358.412065-1-jolsa@kernel.org>
 <20201212104358.412065-5-jolsa@kernel.org>
 <1e467abe-4613-765f-5138-6215b711f9fb@huawei.com>
 <20201215194354.GH698181@krava>
 <CAM9d7ciuss-iD68etX9mo=gjO7_Wh+Ve81=35BDx6hL=oWK_4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciuss-iD68etX9mo=gjO7_Wh+Ve81=35BDx6hL=oWK_4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 10:25:06PM +0900, Namhyung Kim wrote:

SNIP

> >
> > so the current way is, that following creates daemon:
> >
> >   # perf daemon --config <CONFIG>
> >
> > and any other 'non --config' option' is used to 'query/control' daemon:
> >
> >   # perf daemon
> >   # perf daemon --signal
> >   # perf daemon --stop
> >   ...
> 
> My opinion is that it'd be better having sub-commands for essential
> operations like start, stop.  Also daemons tend to have 'status' or
> 'reload' operations too.
> 
>   # perf daemon start --config ...
>   # perf daemon stop

ok, seems better

> 
> As a system daemon, I agree it should follow the standard location
> for the default base directory and config file.

currently we have this order:

  1. custom perfconfig if specified
  2. system perf config /etc/perfconfig if exists
  3. $HOME/.perfconfig if exists

I think we should keep that, when there's a perf systemd service config
file for this, it can use --config 'whatever'

jirka


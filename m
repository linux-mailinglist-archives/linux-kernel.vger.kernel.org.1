Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3E2DB16F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgLOQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729543AbgLOQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608049629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPQsVq8BBcf6J2KxS5M7IZMeB7NPgMCHFu+wKJdA7lQ=;
        b=O4GDT4p/x9wLyk5+4pgnvAoiBcUPP9nZqb3Mcc4XmeNdow11Rk68JaxWn8ORXCukhtSoqo
        WzxQJqRmNkWy3o9bPj5+cWO5aIQgh7/VoxmjcEXZ+FLLwQjWheHYQXSwl9qiiPsDo7T47l
        Q1Q73xYYvvH3x7upGZtTw/d3f18Ehww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-_ARBfzVBOkGsgRJTGuaYWg-1; Tue, 15 Dec 2020 11:27:07 -0500
X-MC-Unique: _ARBfzVBOkGsgRJTGuaYWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C080190A7B6;
        Tue, 15 Dec 2020 16:27:05 +0000 (UTC)
Received: from krava (ovpn-113-169.ams2.redhat.com [10.36.113.169])
        by smtp.corp.redhat.com (Postfix) with SMTP id D8F6F60C15;
        Tue, 15 Dec 2020 16:27:02 +0000 (UTC)
Date:   Tue, 15 Dec 2020 17:27:01 +0100
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 3/3] perf tools: Add evlist/evlist-verbose control
 commands
Message-ID: <20201215162701.GB698181@krava>
References: <20201210204330.233864-1-jolsa@kernel.org>
 <20201210204330.233864-4-jolsa@kernel.org>
 <20201215152343.GG252952@kernel.org>
 <20201215155911.GD658008@krava>
 <20201215160933.GO258566@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215160933.GO258566@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:09:33PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > instead of:
>  
> >   echo 'enable-cycles' > control
>  
> > I'd like to avoid any elaborate parsing logic..
>  
> > how about that?
> 
> Use space to separate command from its arguments, keep the same
> experience as:
> 
> [acme@quaco ~]$ perf evlist -h
> 
>  Usage: perf evlist [<options>]
> 
>     -f, --force           don't complain, do it
>     -F, --freq            Show the sample frequency
>     -g, --group           Show event group information
>     -i, --input <file>    Input file name
>     -v, --verbose         Show all event attr details
>         --trace-fields    Show tracepoint fields
> 
> [acme@quaco ~]$
> 
> and:
> 
> echo "evlist arguments"
> 
> ?
> 
> Fits the bill :-)

ok

> 
> The experience users have on existing commands, the same arguments, etc.
> 
> Even -h can have its uses, i.e. has this daemon support for some option
> or is it an old version?

Alexei just suggested to add 'stop' control command and use it
instead of kill signal, which is good idea

but other than that daemon just opens the control file and
shows its path

jirka


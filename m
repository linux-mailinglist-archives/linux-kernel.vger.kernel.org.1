Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA727AF35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1NkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgI1NkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:40:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601300403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Be9X77dK3loBF392caUbhqpeq0u1t0zlwY6mgNKh10E=;
        b=OCtTTk3ygxOnomdGRQScL5H0bKqeYFga+ZbtSh9f+Y06GXW60+d2lfFJCya2l3vnFPzKcW
        GoNe0xberI1pIZYTrhsjvdJGtdqaVKQd4LUrS0S1iYxuIlfjiJe380Rf8nMfFhFnKEKUHZ
        pJr+5Di+bmiPT1tphmO06Byp9is5wUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-0LNSBslXMyeIX6IDsK5xiQ-1; Mon, 28 Sep 2020 09:39:59 -0400
X-MC-Unique: 0LNSBslXMyeIX6IDsK5xiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B86478ECE49;
        Mon, 28 Sep 2020 13:39:44 +0000 (UTC)
Received: from krava (unknown [10.40.193.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 669678BB25;
        Mon, 28 Sep 2020 13:39:43 +0000 (UTC)
Date:   Mon, 28 Sep 2020 15:39:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200928133942.GC3517742@krava>
References: <20200927074312.GA3664097@laniakea>
 <20200928100808.GA3517742@krava>
 <20200928104311.GA412466@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928104311.GA412466@laniakea>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:43:11PM +0200, Hagen Paul Pfeifer wrote:
> * Jiri Olsa | 2020-09-28 12:08:08 [+0200]:
> 
> >patch below fixes it for me, but seems strange this was
> >working till now.. maybe you're the only one using this
> >with python3 ;-)
> 
> and I thought python2 is obsolete and not maintained anymore ... ;-)
> Anyway, the patch fixed everything: no more garbage for Python2 and Python3
> as well as no bytearray type Python3!
> 
> Tested-by: Hagen Paul Pfeifer <hagen@jauu.net>
> 
> Thank you Jiri!
> 
> Probably this patch should be applied on stable too!? Not sure when the 
> problem was introduced.

great, I'll check on that and send full patch later, thanks 

jirka

> 
> Hagen
> 
> >jirka
> >
> >
> >---
> >diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
> >index 599a1543871d..13fdc51c61d9 100644
> >--- a/tools/perf/util/print_binary.c
> >+++ b/tools/perf/util/print_binary.c
> >@@ -50,7 +50,7 @@ int is_printable_array(char *p, unsigned int len)
> > 
> > 	len--;
> > 
> >-	for (i = 0; i < len; i++) {
> >+	for (i = 0; i < len && p[i]; i++) {
> > 		if (!isprint(p[i]) && !isspace(p[i]))
> > 			return 0;
> > 	}
> >
> 


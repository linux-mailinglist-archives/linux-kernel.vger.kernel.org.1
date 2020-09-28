Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1427B526
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgI1TTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgI1TTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:19:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE38520719;
        Mon, 28 Sep 2020 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601320792;
        bh=AcJ39ofrz6T0k2m+AFSa/F0aj1TwmZub8Ps+MoCoRP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIoBpvj4EMQZ6t9Ft22q0hyFLZBZ4BpM4ZT64oxO3AJcBL3fY0QkEuQs86WNqPHOu
         owXCeIvRy1QvUK1jYN/JHQa/fQ7LxGx1fhxLJGfgWWHa/GvSuhJentgF4CnQROQR1A
         nM9JbpdSL4eDbZ0vD7aBE7oW7Qn5KNKKxFvid26A=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F00CA400E9; Mon, 28 Sep 2020 16:19:49 -0300 (-03)
Date:   Mon, 28 Sep 2020 16:19:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200928191949.GG3087422@kernel.org>
References: <20200927074312.GA3664097@laniakea>
 <20200928100808.GA3517742@krava>
 <20200928104311.GA412466@laniakea>
 <20200928133942.GC3517742@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928133942.GC3517742@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 28, 2020 at 03:39:42PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 28, 2020 at 12:43:11PM +0200, Hagen Paul Pfeifer wrote:
> > * Jiri Olsa | 2020-09-28 12:08:08 [+0200]:
> > 
> > >patch below fixes it for me, but seems strange this was
> > >working till now.. maybe you're the only one using this
> > >with python3 ;-)
> > 
> > and I thought python2 is obsolete and not maintained anymore ... ;-)
> > Anyway, the patch fixed everything: no more garbage for Python2 and Python3
> > as well as no bytearray type Python3!
> > 
> > Tested-by: Hagen Paul Pfeifer <hagen@jauu.net>
> > 
> > Thank you Jiri!
> > 
> > Probably this patch should be applied on stable too!? Not sure when the 
> > problem was introduced.
> 
> great, I'll check on that and send full patch later, thanks 

Thanks, I'll do one more pull req for v5.9, will have that in.

Hagen, please consider sending a patch making using python3 the default,
with python2 left just for whoever still needs it.

Thanks!

- Arnaldo
 
> jirka
> 
> > 
> > Hagen
> > 
> > >jirka
> > >
> > >
> > >---
> > >diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
> > >index 599a1543871d..13fdc51c61d9 100644
> > >--- a/tools/perf/util/print_binary.c
> > >+++ b/tools/perf/util/print_binary.c
> > >@@ -50,7 +50,7 @@ int is_printable_array(char *p, unsigned int len)
> > > 
> > > 	len--;
> > > 
> > >-	for (i = 0; i < len; i++) {
> > >+	for (i = 0; i < len && p[i]; i++) {
> > > 		if (!isprint(p[i]) && !isspace(p[i]))
> > > 			return 0;
> > > 	}
> > >
> > 
> 

-- 

- Arnaldo

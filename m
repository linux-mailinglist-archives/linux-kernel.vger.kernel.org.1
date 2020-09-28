Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C571827AC26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgI1KnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgI1KnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:43:19 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:43:19 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4C0JyX4lcYzQlLc;
        Mon, 28 Sep 2020 12:43:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 3Z61HEDtY_hU; Mon, 28 Sep 2020 12:43:13 +0200 (CEST)
Date:   Mon, 28 Sep 2020 12:43:11 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200928104311.GA412466@laniakea>
References: <20200927074312.GA3664097@laniakea>
 <20200928100808.GA3517742@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928100808.GA3517742@krava>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.82 / 15.00 / 15.00
X-Rspamd-Queue-Id: 88079170E
X-Rspamd-UID: c898f5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Olsa | 2020-09-28 12:08:08 [+0200]:

>patch below fixes it for me, but seems strange this was
>working till now.. maybe you're the only one using this
>with python3 ;-)

and I thought python2 is obsolete and not maintained anymore ... ;-)
Anyway, the patch fixed everything: no more garbage for Python2 and Python3
as well as no bytearray type Python3!

Tested-by: Hagen Paul Pfeifer <hagen@jauu.net>

Thank you Jiri!

Probably this patch should be applied on stable too!? Not sure when the 
problem was introduced.

Hagen

>jirka
>
>
>---
>diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
>index 599a1543871d..13fdc51c61d9 100644
>--- a/tools/perf/util/print_binary.c
>+++ b/tools/perf/util/print_binary.c
>@@ -50,7 +50,7 @@ int is_printable_array(char *p, unsigned int len)
> 
> 	len--;
> 
>-	for (i = 0; i < len; i++) {
>+	for (i = 0; i < len && p[i]; i++) {
> 		if (!isprint(p[i]) && !isspace(p[i]))
> 			return 0;
> 	}
>

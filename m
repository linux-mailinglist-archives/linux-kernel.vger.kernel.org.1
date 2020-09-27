Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786FA27A00A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgI0JUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgI0JUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:20:16 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E59C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 02:20:15 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Bzg991djMzQlWH;
        Sun, 27 Sep 2020 11:20:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 1bMPKKK7PZCs; Sun, 27 Sep 2020 11:20:10 +0200 (CEST)
Date:   Sun, 27 Sep 2020 11:20:08 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200927092008.GB3664097@laniakea>
References: <20200927074312.GA3664097@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927074312.GA3664097@laniakea>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.37 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3369916A5
X-Rspamd-UID: 450e56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short addendum: even under python2 not everything is perfect. It seems that
the "comm-name-memory-reuse" problem is a general problem - for python3 and
python2.

In the following example the prev_comm name should be chrome only, but is
"chromesandbox", common_comm is correctly "chrome". I believe that the memory
area for prev_comm & next_comm has not been fully memset'ed before
(memset(mem, 0, 16)).

That the string in Python3 is now a bytearray instead of a string is a
second, independent problem.

Python 2 example:

sched__sched_switch      2 563232.889356634  2924848 chrome               prev_comm=chromesandbox, prev_pid=2924848, prev_prio=120, prev_state=S, next_comm=swapper/2, next_pid=0, next_prio=120
Sample: {addr=0, cpu=2, datasrc=84410401, datasrc_decode=N/A|SNP N/A|TLB N/A|LCK N/A, ip=18446744072189289569, period=1, phys_addr=0, pid=2924848, tid=2924848, time=563232889356634, transaction=0, values=[(0L, 0L)], weight=0}


Hagen

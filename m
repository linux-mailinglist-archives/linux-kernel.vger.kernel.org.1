Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DD279F50
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgI0HnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 03:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgI0HnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 03:43:21 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD7C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 00:43:21 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Bzd1K4nb5zQlQr;
        Sun, 27 Sep 2020 09:43:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id yUCFpNA4QEHE; Sun, 27 Sep 2020 09:43:14 +0200 (CEST)
Date:   Sun, 27 Sep 2020 09:43:12 +0200
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200927074312.GA3664097@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.77 / 15.00 / 15.00
X-Rspamd-Queue-Id: A4CF0EF9
X-Rspamd-UID: b19b0d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Jiri, Arnaldo,

after updating Debian (probably with the advent of Python 3.8.5, guessing)
I get a wired behavior with python scripting. The error is that the python type
for prev_comm and next_comm are not strings anymore, rather bytearrays. Which
are incompatible types and scripts will not work anymore. NOTE: common_comm is
still fine (see swapper & mutex-thread-co), so they must be treated internal
differently compared to prev_comm and next_comm and possibly show a way to solve
this problem!

After bisecting the kernel (perf) even back to v5.6 the problem still exist.
Compiling perf with PYTHON=python2 do not show any problems - no problems in
the Python2 world. So I assume with Python 3.8.5 (or other helper library)
something changed internally. I assume the cause exists in perf forever but
is now triggered with the new Python3 version.

How to reproduce:

make PYTHON=python3
./perf record -e sched:sched_switch -a -- sleep 5
./perf script --gen-script py
./perf script -s ./perf-script.py

[..]
sched__sched_switch      7 563231.759525792        0 swapper              prev_comm=bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00'), prev_pid=0, prev_prio=120, prev_state=, next_comm=bytearray(b'mutex-thread-co\x00'), next_pid=3447985, next_prio=120
Sample: {addr=0, cpu=7, datasrc=84410401, datasrc_decode=N/A|SNP N/A|TLB N/A|LCK N/A, ip=18446744072189289569, period=1, phys_addr=0, pid=0, tid=0, time=563231759525792, transaction=0, values=[(0, 0)], weight=0}

sched__sched_switch      7 563231.759582596  3447985 mutex-thread-co      prev_comm=bytearray(b'mutex-thread-co\x00'), prev_pid=3447985, prev_prio=120, prev_state=, next_comm=bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00'), next_pid=0, next_prio=120
Sample: {addr=0, cpu=7, datasrc=84410401, datasrc_decode=N/A|SNP N/A|TLB N/A|LCK N/A, ip=18446744072189289569, period=1, phys_addr=0, pid=3447983, tid=3447985, time=563231759582596, transaction=0, values=[(0, 0)], weight=0}


See =bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00') - should be swapper/7


Note: the byte array has the length of 16 - exactly like the kernel
(TASK_COMM_LEN). I assume this is somehow copied directly into the variables
and not stringified anymore.


Even worse: I discovered bytearrays which are not correctly "memseted":
	bytearray(b'chrome\x00sandbox\x00\x00')

chrome should be the comm name, but is 'chromesandbox' somehow. See the null
bytes in between.

Jiri, Arnaldo - I tried to fix this. But the Python binding magic for the
automatically generated events are hard to get comfy.

Hagen

PS: assume this fix is also kernel stable relevant.

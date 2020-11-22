Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809EF2BC6F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 17:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKVQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 11:25:05 -0500
Received: from devianza.investici.org ([198.167.222.108]:49181 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgKVQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 11:25:05 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CfFxV5nC8z6vN2;
        Sun, 22 Nov 2020 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1606062302;
        bh=QcWR4yUWxgdddYWQjk+/esln63CLBQyRf6DDRrfXeHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PHqVtJDF24qCCM+l7hQFN/YGlgPB0QrIrY56Vu+utdJa78Ty7aSP121aSEkMRDzsC
         09wkxAbbAkMX6+xtS4AR+cmi3kBned/32bXocn1H+qdDVrsBFgDQdd9udgf5B8x2FI
         1Nb4jwnSLAg6n8UxyM/gZCbV2EI921nW/Fly4CNA=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CfFxV2YS2z6vMg;
        Sun, 22 Nov 2020 16:25:02 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v7 0/5] Fortify strscpy()
Date:   Sun, 22 Nov 2020 17:24:46 +0100
Message-Id: <20201122162451.27551-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


I hope your families, friends and yourselves are fine.

This patch implements a fortified version of strscpy() enabled by setting
CONFIG_FORTIFY_SOURCE=y.
The new version ensures the following before calling vanilla strscpy():
1. There is no read overflow because either size is smaller than src length
or we shrink size to src length by calling fortified strnlen().
2. There is no write overflow because we either failed during compilation or at
runtime by checking that size is smaller than dest size.
Note that, if src and dst size cannot be got, the patch defaults to call vanilla
strscpy().

The patches adds the following:
1. Implement the fortified version of strscpy().
2. Add a new LKDTM test to ensures the fortified version still returns the same
value as the vanilla one while panic'ing when there is a write overflow.
3. Correct some typos in LKDTM related file.

I based my modifications on top of two patches from Daniel Axtens which modify
calls to __builtin_object_size, in fortified string functions, to ensure the
true size of char * are returned and not the surrounding structure size.

About performance, I measured the slow down of fortified strscpy(), using the
vanilla one as baseline.
The hardware I used is an Intel i3 2130 CPU clocked at 3.4 GHz.
I ran "Linux 5.10.0-rc4+ SMP PREEMPT" inside qemu 3.10 with 4 CPU cores.
The following code, called through LKDTM, was used as a benchmark:
#define TIMES 10000
	char *src;
	char dst[7];
	int i;
	ktime_t begin;

	src = kstrdup("foobar", GFP_KERNEL);

	if (src == NULL)
		return;

	begin = ktime_get();
	for (i = 0; i < TIMES; i++)
		strscpy(dst, src, strlen(src));
	pr_info("%d fortified strscpy() tooks %lld", TIMES, ktime_get() - begin);

	begin = ktime_get();
	for (i = 0; i < TIMES; i++)
		__real_strscpy(dst, src, strlen(src));
	pr_info("%d vanilla strscpy() tooks %lld", TIMES, ktime_get() - begin);

	kfree(src);
I called the above code 30 times to compute stats for each version (in ns, round
to int):
| version   | mean    | std    | median  | 95th    |
| --------- | ------- | ------ | ------- | ------- |
| fortified | 245_069 | 54_657 | 216_230 | 331_122 |
| vanilla   | 172_501 | 70_281 | 143_539 | 219_553 |
On average, fortified strscpy() is approximately 1.42 times slower than vanilla
strscpy().
For the 95th percentile, the fortified version is about 1.50 times slower.

So, clearly the stats are not in favor of fortified strscpy().
But, the fortified version loops the string twice (one in strnlen() and another
in vanilla strscpy()) while the vanilla one only loops once.
This can explain why fortified strscpy() is slower than the vanilla one.

Please, let me know your opinion about the patch and if you have any idea to
improve it.


Best regards.

Daniel Axtens (2):
  string.h: detect intra-object overflow in fortified string functions
  lkdtm: tests for FORTIFY_SOURCE

Francis Laniel (3):
  string.h: Add FORTIFY coverage for strscpy()
  Add new file in LKDTM to test fortified strscpy.
  Correct wrong filenames in comment.

 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/bugs.c               | 50 +++++++++++++++
 drivers/misc/lkdtm/core.c               |  3 +
 drivers/misc/lkdtm/fortify.c            | 82 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              | 19 +++---
 include/linux/string.h                  | 75 ++++++++++++++++++----
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 213 insertions(+), 18 deletions(-)
 create mode 100644 drivers/misc/lkdtm/fortify.c

-- 
2.20.1


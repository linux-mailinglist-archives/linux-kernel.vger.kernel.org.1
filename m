Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62F2B7C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKRLRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:17:09 -0500
Received: from latitanza.investici.org ([82.94.249.234]:45377 "EHLO
        latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgKRLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:17:08 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 06:17:07 EST
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4Cbg5B6LrHz8sh0;
        Wed, 18 Nov 2020 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1605697662;
        bh=pRohe2wpPXolmMdvR/at0ovtLoyHsrhZfm/U2gcuOco=;
        h=From:To:Cc:Subject:Date:From;
        b=ULcHjlhqS7tEyxvDIdLm53xZYmh18NOkJmka/k9b5EZG1tIW1LZDa8wFvZoF4wgLM
         tnhC8hKV7+kgqbHvFZuhl2tFpqz9ruQPPWtN6VFjO03GnaIiHyUkN+p2fg56jXX9Yu
         1jMRh6w9IioF7zEjfvnlTIf4mUjqne5QxBvt2QU4=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4Cbg5B0w7fz8sgF;
        Wed, 18 Nov 2020 11:07:41 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     akpm@linux-foundation.org
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        keescook@chromium.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [PATCH v5 0/5] Fortify strscpy()
Date:   Wed, 18 Nov 2020 12:07:26 +0100
Message-Id: <20201118110731.15833-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


I hope your families, friends and yourselves are fine.

This patch set answers to this issue:
https://github.com/KSPP/linux/issues/46

I based my modifications on top of two patches from Daniel Axtens which modify
calls to __builtin_object_size to ensure the true size of char * are returned
and not the surrounding structure size.

To sum up, in my first patch I implemented a fortified version of strscpy.
This new version ensures the following before calling vanilla strscpy:
1. There is no read overflow because either size is smaller than src length
or we shrink size to src length by calling fortified strnlen.
2. There is no write overflow because we either failed during compilation or at
runtime by checking that size is smaller than dest size.
The second patch brings a new file in LKDTM driver to test this new version.
The test ensures the fortified version still returns the same value as the
vanilla one while panic'ing when there is a write overflow.
The third just corrects some typos in LKDTM related file.

If you see any problem or way to improve the code, feel free to share it.


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


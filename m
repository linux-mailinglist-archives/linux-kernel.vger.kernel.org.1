Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C202F0F25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbhAKJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:32:50 -0500
Received: from devianza.investici.org ([198.167.222.108]:48799 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbhAKJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:32:50 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4DDpBB3lblz6v8y;
        Mon, 11 Jan 2021 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1610356914;
        bh=esG6VqDUFVCdrIj93XWTgBoGpprN/Tj8Y746iTS3G6E=;
        h=From:To:Cc:Subject:Date:From;
        b=FN2qPUCZvFH/IZ0YLYBycGZFcJpyWjYGGfykmVSTJuZV05tIziDcSeJKecrsSv4wp
         uVSCsD6KzkFKD12eIVXt5GwY14fmhpVZugXoU1/HbDKhVQGaVjW74uXpIrMZoAU2Q6
         q3NR9eC+uIHUr/PCdO2DigunGzRUpY/hemGVhy6I=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4DDpBB2CWkz6v8w;
        Mon, 11 Jan 2021 09:21:54 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC PATCH v2 0/1] Create header for fortified string functions.
Date:   Mon, 11 Jan 2021 10:21:40 +0100
Message-Id: <20210111092141.22946-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


First, I hope your families, friends and yourself are fine.

In a recent mail about the merge of a new fortified string function, Linus
Torvalds suggested the creation of a dedicated header file for these functions:
https://marc.info/?l=linux-mm-commits&m=160810366111244
This will make the code cleaner and also improve compile time for people who do
not set CONFIG_FORTIFY_SOURCE.

So, this patch creates fortify-string.h which is a new header which contains
all the fortified versions of functions declared in string.h.
Since code was moved, I might as well correct the warnings raised by
checkpatch.pl.

I benchmarked the code compilation with and without CONFIG_FORTIFY_SOURCE.
To do this, I compiled 10 times a x86_64_defconfig'ured kernel using make -j4
and cleaning after each compilation.
These compilations were first done without CONFIG_FORTIFY_SOURCE defined,
then with this option defined.
The results were collected using the time bash builtin and are the following
(in seconds, rounded to 10^-3):
|     |   min   |   max   |   mean  | std. dev. |  median | 99th percentile |
| --- | ------- | ------- | ------- | --------- | ------- | --------------- |
| w/o | 524.488 | 526.982 | 525.111 |   0.722   | 524.901 |     526.848     |
| w/  | 529.502 | 531.795 | 529.939 |   0.671   | 529.783 |     531.633     |
First, the results are quite stable as shown by the standard deviation
(less than 1 second).
On average, compile time without CONFIG_FORTIFY_SOURCE is 0.919% faster.
For the median case, compiling without setting this option is  0.930% faster.
Finally, with the 99th percentile, not using CONFIG_FORTIFY_SOURCE is 0.908%
faster.

Globally, using a different header seems to provide a roughly 1% faster compile
time for people who do not set CONFIG_FORTIFY_SOURCE.
This is not a huge gain... but still a gain!
Especially on compilation which is an operation kernel developers do a lot.

So, I await your opinions and reviews on this patch.

Version history:
* v2: Correct misguarded instructions which follow if.


Best regards.

Francis Laniel (1):
  string.h: Move fortified functions definitions in a dedicated header.

 include/linux/fortify-string.h | 302 +++++++++++++++++++++++++++++++++
 include/linux/string.h         | 282 +-----------------------------
 2 files changed, 303 insertions(+), 281 deletions(-)
 create mode 100644 include/linux/fortify-string.h

-- 
2.20.1


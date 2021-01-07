Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F072ED32B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbhAGPCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbhAGPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:02:44 -0500
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jan 2021 07:02:03 PST
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C22C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 07:02:03 -0800 (PST)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4DBThy1TLcz10hD;
        Thu,  7 Jan 2021 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1610031122;
        bh=3vWxTF3DOXG7UTTxjnoVIe5BPNzSqqV8llgmGOfUPE8=;
        h=From:To:Cc:Subject:Date:From;
        b=j20sc4ONIq9qDkp1fr2njdlgb/OXHzRo9SanhrsQD+gziX0nRMMs0IiZuL3f81cy3
         gcGeR2gylRIvKocyVXjsjMluHtIHUrM3LAhIfjsfhBq1IqcAq0+d79/cjDy8VXh0wW
         kcvIajmVxXjHlbHufS2qoSCJGHmn0WKtzWBZ1+ck=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4DBThy0Hb4z13GK;
        Thu,  7 Jan 2021 14:52:01 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org,
        Francis Laniel <laniel_francis@privacyrequired.com>
Subject: [RFC PATCH 0/1] Create header for fortified string functions.
Date:   Thu,  7 Jan 2021 15:51:42 +0100
Message-Id: <20210107145143.7438-1-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

Hi.


First, I do hope you are fine and the same for your relatives.

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
|  w/ | 529.502 | 531.795 | 529.939 |   0.671   | 529.783 |     531.633     |
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


Best regards.

Francis Laniel (1):
  string.h: Move fortified functions definitions in a dedicated header.

 include/linux/fortify-string.h | 302 +++++++++++++++++++++++++++++++++
 include/linux/string.h         | 282 +-----------------------------
 2 files changed, 303 insertions(+), 281 deletions(-)
 create mode 100644 include/linux/fortify-string.h

-- 
2.20.1


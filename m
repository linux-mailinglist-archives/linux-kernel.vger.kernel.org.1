Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B952275FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:30:48 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Sep 2020 11:30:48 PDT
Received: from agrajag.zerfleddert.de (agrajag.zerfleddert.de [IPv6:2a01:4f8:bc:1de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7455C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:30:48 -0700 (PDT)
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id 4FFAE5B20AD2; Wed, 23 Sep 2020 20:21:22 +0200 (CEST)
Date:   Wed, 23 Sep 2020 20:21:22 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] lib/crc32.c: fix trivial typo in preprocessor condition
Message-ID: <20200923182122.GA3338@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether crc32_be needs a lookup table is chosen based on CRC_LE_BITS.
Obviously, the _be function should be governed by the _BE_ define.

This probably never pops up as it's hard to come up with a configuration
where CRC_BE_BITS isn't the same as CRC_LE_BITS and as nobody is using
bitwise CRC anyway.

<rant>
While skimming through some mailing lists, I learned that not only is
this a safety critical bug[tm], it likely will also lead to a car crash
unless fixed[1]. We can't let that happen, can we?
As the safety experts are now for more than one month working on a patch
already, it's maybe time to save them some effort.

[1]: https://lists.elisa.tech/g/devel/message/1089
</rant>

Fixes: 46c5801eaf86 ("crc32: bolt on crc32c")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
Sorry for spamming people in CC:, there doesn't seem to be a designated
maintainer for lib/crc*.

 lib/crc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index 35a03d03f973..2a68dfd3b96c 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -331,7 +331,7 @@ static inline u32 __pure crc32_be_generic(u32 crc, unsigned char const *p,
 	return crc;
 }
 
-#if CRC_LE_BITS == 1
+#if CRC_BE_BITS == 1
 u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_be_generic(crc, p, len, NULL, CRC32_POLY_BE);
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E661281B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgJBTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:15:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39573 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:15:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002191548euoutp0259efca115550121ef3da6b69625230c3~6QuA9K4DZ0075300753euoutp02D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 19:15:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002191548euoutp0259efca115550121ef3da6b69625230c3~6QuA9K4DZ0075300753euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601666148;
        bh=MtoSHjC2XjoWoOZrgZW6Bv3cm9lONexqqG1ENgBgQus=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Mz+9VuZD4G2RMaAlGzSrUNfJaC7Kfxos6pCoPXmLzEwU63vRquEUHWgoBaTi+WGr3
         jKxzg/j7mYOSausX6/iaieebx53JluZaR1899lHXXNLVsuWjaZ7WxYnF95oYPXfLch
         JC34g7oy4ZAkJjHty68kpHFRGo57Gc+xXFZn73RA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002191547eucas1p2bfedc5838bfbb049b3e2b829c0934dca~6QuAH0CVk1293512935eucas1p2Z;
        Fri,  2 Oct 2020 19:15:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 62.27.06318.36C777F5; Fri,  2
        Oct 2020 20:15:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002191546eucas1p13545280767220c473c19d1071c87d107~6Qt-GFgY91179911799eucas1p1H;
        Fri,  2 Oct 2020 19:15:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002191546eusmtrp157747baecd4cd11720b9c671cf98c4ed~6Qt-FaF_x1763417634eusmtrp1k;
        Fri,  2 Oct 2020 19:15:46 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-66-5f777c63d9ae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.2F.06314.26C777F5; Fri,  2
        Oct 2020 20:15:46 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002191546eusmtip1bc7cf1718d1a229fcd9e836b93381973~6Qt_7FHKz0871608716eusmtip1o;
        Fri,  2 Oct 2020 19:15:46 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] checkpatch: Fix false positive on empty block comment lines
Date:   Fri,  2 Oct 2020 21:15:25 +0200
Message-Id: <20201002191525.18942-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7rJNeXxBu93Slp8WKthsXHGelaL
        2fcfs1jcPLSC0eLyrjlsFmuP3GV3YPOY1dDL5vFl1TVmj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mo4fXgGW8Edtopts6YyNjCuYu1i5OSQEDCReDVjO5DNxSEksIJRYsL7xWwQzhdGiYtb
        pjJDOJ8ZJb7fO8kC03JqSRMjRGI5o0THqXdQ/c8ZJZbtucIMUsUm4CjRv/QEUIKDQ0QgVeL3
        Q0OQGmaBfYwSO+9NAasRFvCReHrgJRuIzSKgKvH6+wowm1fAWmLC9wZGiG3yEu3Lt0PFBSVO
        znwCdgW/gJbEmqbrYDYzUE3z1tlgp0oItLNLfGy8DNXsInFv8l6os4UlXh3fwg5hy0icntzD
        AnKchEC9xORJZhC9PYwS2+b8gKq3lrhz7hcbSA2zgKbE+l36EGFHiaMftjJDtPJJ3HgrCHEC
        n8SkbdOhwrwSHW1CENUqEuv690ANlJLofbUC6jAPiY2z+1gmMCrOQvLYLCTPzELYu4CReRWj
        eGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgUjn97/jXHYz7/iQdYhTgYFTi4eUwKI8XYk0s
        K67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtS
        i2CyTBycUg2My196cR3SsF/1W/HTowwhmTjXPawTTl/pvC1bsaFC9tbV65UiAixNB+Yuj0s9
        Geg/w6ymvf6sMYuXzIk9id0OiyK2bPhZ0MF62cJggd7Xa3vjBeRmTvfXncJ/vyF2SeWJ2C3f
        ze7/Z5IxFbYKlOC44zXr0+evk7zbvDTmVOn/ZQ2qySuyNT2qxFKckWioxVxUnAgAEOgUKCYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd2kmvJ4g3O7BS0+rNWw2DhjPavF
        7PuPWSxuHlrBaHF51xw2i7VH7rI7sHnMauhl8/iy6hqzR9+WVYwenzfJBbBE6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWcPjyDreAOW8W2WVMZ
        GxhXsXYxcnJICJhInFrSxNjFyMUhJLCUUeLB7V6mLkYOoISUxMq56RA1whJ/rnWxQdQ8ZZTo
        37mQGSTBJuAo0b/0BNggEYF0ia2LzoEVMQvsY5TYf3QxO0hCWMBH4umBl2wgNouAqsTr7yvA
        bF4Ba4kJ3xsYITbIS7Qv3w4VF5Q4OfMJC8gRzALqEuvnCYGE+QW0JNY0XWcBsZmBypu3zmae
        wCgwC0nHLISOWUiqFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMiW3Hfm7ewXhpY/Ah
        RgEORiUe3gSj8ngh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpnIrOU
        aHI+MF7zSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwTuS6V9nr
        fejg9UvbBHeLvz7ov7+p4PZjn+A7gVYn5a+qFe/Vqbiweml5xY6bTIrX0zhDk069cVl8YZ5/
        p9IzFx4psbu77boeLsjsTOA7mDYzrNpb/3Hj7wzVFVbnsrqUN5q8ua2wM2+eL0t1SGbbtamL
        np9oyF66JTP1ibuhsb+DibHFltlZSizFGYmGWsxFxYkADsGynp8CAAA=
X-CMS-MailID: 20201002191546eucas1p13545280767220c473c19d1071c87d107
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002191546eucas1p13545280767220c473c19d1071c87d107
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002191546eucas1p13545280767220c473c19d1071c87d107
References: <CGME20201002191546eucas1p13545280767220c473c19d1071c87d107@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid false positives in presence of SPDX-License-Identifier in
networking files it is required to increase the leeway for empty block
comment lines by one line.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a213cdb82ab0..60e10da4cccb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3460,7 +3460,7 @@ sub process {
 		if ($realfile =~ m@^(drivers/net/|net/)@ &&
 		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
 		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 2) {
+		    $realline > 3) {
 			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
-- 
2.26.2


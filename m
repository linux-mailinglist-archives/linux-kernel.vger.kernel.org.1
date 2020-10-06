Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E802848C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJFImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:42:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47379 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:42:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201006083512euoutp0280748aa508d4d362263d7419f14d096d~7Wj1upAjv2367623676euoutp027
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 08:35:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201006083512euoutp0280748aa508d4d362263d7419f14d096d~7Wj1upAjv2367623676euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601973312;
        bh=L55rxqXB07v3Kxq32jg1aVLk9eBXuoB/Q5f8PW5NHLY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tOAL57ddWMR90yHWjTzKL1I85pAtd4ZCbUAa3vcxYihL0eA7NMtOJaLghpdZ3jD8p
         cfg0LcwRRLboFCLQqYHe/cDmTzgEmwsx3t43HD0hpv79votOJXBOJyEgxUGF4hffrS
         7NT7itEedmLdyK8AHM1UiTr2Knnv+KP4q+phmR9Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201006083512eucas1p269df91bdc00e611678ec93dca15870c3~7Wj1ajpYf0279102791eucas1p2x;
        Tue,  6 Oct 2020 08:35:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C7.C9.06456.F3C2C7F5; Tue,  6
        Oct 2020 09:35:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf~7Wj1EawRi3149631496eucas1p2e;
        Tue,  6 Oct 2020 08:35:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201006083511eusmtrp2232b316dd46d9c40dbe681f4bda36a94~7Wj1D1Vc62328123281eusmtrp25;
        Tue,  6 Oct 2020 08:35:11 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d3-5f7c2c3fcc5f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.92.06017.F3C2C7F5; Tue,  6
        Oct 2020 09:35:11 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201006083511eusmtip2b663af3e904504fb669352830a81b32c~7Wj04sZ6a0464004640eusmtip2a;
        Tue,  6 Oct 2020 08:35:11 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2] checkpatch: Fix false positive on empty block comment
 lines
Date:   Tue,  6 Oct 2020 10:35:09 +0200
Message-Id: <20201006083509.19934-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7r2OjXxBq3zrC0+rNWw2DhjPavF
        7PuPWSxuHlrBaHF51xw2i7VH7rI7sHnMauhl8/iy6hqzR9+WVYwenzfJBbBEcdmkpOZklqUW
        6dslcGVsWrqeueAUd8XJ7qQGxp8cXYycHBICJhKXPvewdjFycQgJrGCUaJ36hw3C+cIo8enw
        LCjnM6NE58ybzDAtS+b1QyWWM0qsuzQVynnOKLH/2gSwKjYBR4n+pSeABnNwiAikSvx+aAhS
        wyywj1Fi570pYDXCAoESM+9/ZgOxWQRUJWbunscOYvMKWEt8f/OdCWKbvET78u1sEHFBiZMz
        n7CA2PwCWhJrmq6D2cxANc1bZzODLJAQaGaXWHFnAyNEs4vEr9bTUGcLS7w6voUdwpaR+L9z
        PhPIcRIC9RKTJ5lB9PYwSmyb84MFosZa4s65X2wgNcwCmhLrd+lDhB0len5fYoRo5ZO48VYQ
        4gQ+iUnbpjNDhHklOtqEIKpVJNb174EaKCXR+2oF1GEeEifWvmSawKg4C8ljs5A8Mwth7wJG
        5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKeX0v+OfdjB+vZR0iFGAg1GJh7dCrDpe
        iDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1O
        TS1ILYLJMnFwSjUwzsg9PXF20KrLz9JWnO3seRPP67r7geGb1FfzLznV5H8w9ve4yVJs5Txt
        6s19/JYRWlPPXOSy94g8GW1+7szOrX/X39NQnFZvvTv2OM80oTn3LqpvT3uSKHfIzO5Sy6k/
        0Q8ZM70t3aZMP7k3s4QvoLWrrnNdyOb3UpVGQutNar7uYHkQw5dWrsRSnJFoqMVcVJwIAJUG
        QQElAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4PV17nZp4gw1flCw+rNWw2DhjPavF
        7PuPWSxuHlrBaHF51xw2i7VH7rI7sHnMauhl8/iy6hqzR9+WVYwenzfJBbBE6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVsWrqeueAUd8XJ7qQG
        xp8cXYycHBICJhJL5vWzdTFycQgJLGWUWLhuMZDDAZSQklg5Nx2iRljiz7UuqJqnjBK3X+1i
        BEmwCThK9C89wQpiiwikS2xddA6siFlgH6PE/qOL2UESwgL+Ekc3rGcCsVkEVCVm7p4HFucV
        sJb4/uY7E8QGeYn25dvZIOKCEidnPmEBOYJZQF1i/TwhkDC/gJbEmqbrLCA2M1B589bZzBMY
        BWYh6ZiF0DELSdUCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgRGx7djPLTsYu94FH2IU
        4GBU4uFVEKmOF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOgdyYyS4km
        5wOjNa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+Oyv5V2aVdL
        Y/XYmaTcEnO0rm6SP8wxPSHr97xXkVwqWa4vWeQO/ozyvtmrflH/6+ubC7++fNj3VPzaYv9M
        1UyXZUpfhUrPKWn3aW6WVjfSfFGqXnzjZu/8VfyzS//kcbWJ+N92v3C6ylMn37dC4/Bzdo6n
        rpXrqlaE+pls3e/PbZm6MeKEsxJLcUaioRZzUXEiAHP6SlSeAgAA
X-CMS-MailID: 20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf
References: <CGME20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid false positives in presence of SPDX-License-Identifier in
networking files it is required to increase the leeway for empty block
comment lines by one line.

For example, checking drivers/net/loopback.c which starts with

    // SPDX-License-Identifier: GPL-2.0-or-later
    /*
     * INET          An implementation of the TCP/IP protocol suite for the LINUX

rsults in an unnecessary warning

    WARNING: networking block comments don't use an empty /* line, use /* Comment...
    +/*
    + * INET                An implementation of the TCP/IP protocol suite for the LINUX

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes in v2:
  - added example warning in the commit description
  - added a comment in the code

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a213cdb82ab0..3555ac812c99 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3460,7 +3460,7 @@ sub process {
 		if ($realfile =~ m@^(drivers/net/|net/)@ &&
 		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
 		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 2) {
+		    $realline > 3) { # Do not warn about the initial copyright comment block after SPDX-License-Identifier
 			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
-- 
2.26.2


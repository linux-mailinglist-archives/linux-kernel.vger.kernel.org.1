Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCF2D5921
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgLJLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:22:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56958 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgLJLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:22:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201210112149euoutp026b1427c8aac7ea06b50609d00cfac51f~PVw3eP9lI1511015110euoutp02_
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:21:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201210112149euoutp026b1427c8aac7ea06b50609d00cfac51f~PVw3eP9lI1511015110euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607599309;
        bh=m/hIpRoga9xdyOraCEwM6+OGSPEefGpZYRg/hmX5mNw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KaURiBLjGuZNwdXR+kXoe/5JC94tFMhJXu4aqOXc+FwS6AYbfwvDdHgXfc6WeAmvl
         QZHA5yt0Q95aWsOC3z5MispwavUZeOp2gFZt/5Cg/Kl1lxbUptkoCqxUyluyNgCGDB
         i7c45ruRofBgQ4xo7AZzdgsmOFh6VOKa3CsJazS0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201210112148eucas1p25fd7a8cd1668b21de2a94d2613e9f8e3~PVw3KXvJL2247822478eucas1p2P;
        Thu, 10 Dec 2020 11:21:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 29.D5.27958.CC402DF5; Thu, 10
        Dec 2020 11:21:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201210112148eucas1p287afa49e63255e3320495d480eb06965~PVw2nU_LP2247822478eucas1p2N;
        Thu, 10 Dec 2020 11:21:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201210112148eusmtrp144de498a2e3bc1fd0862edae1640f8d3~PVw2muZwK0100401004eusmtrp13;
        Thu, 10 Dec 2020 11:21:48 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-14-5fd204cc110d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.F5.21957.BC402DF5; Thu, 10
        Dec 2020 11:21:47 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201210112147eusmtip118da705976e50591b582c4d5c0e71eee~PVw2JLO2U0894008940eusmtip1C;
        Thu, 10 Dec 2020 11:21:47 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: max14577: Add proper module aliases strings
Date:   Thu, 10 Dec 2020 12:21:39 +0100
Message-Id: <20201210112139.5370-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7djP87pnWC7FGyx9oWaxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbNYe+QuuwObx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fA
        lfHjwEOmgjtsFfuvrWFrYPzF2sXIySEhYCIxZUcjcxcjF4eQwApGibVX9rJAOF8YJTomtLFB
        OJ8ZJeY+WcUE09I5bwYTRGI5o0TX331gCbCWGx/AbDYBQ4mut11sILaIgILE5t5nYPuYBa4z
        SjxrUAWxhQXcJdpWnGMBsVkEVCXWN68A6+UVsJF41/QTapm8xOoNB8DukxB4yS5xvqGPESLh
        IvF17hZ2CFtY4tVxGFtG4vTkHhaIhmZGiYfn1rJDOD2MEpebZkB1W0vcOfcL6DwOoJM0Jdbv
        0ocIO0o8fdjMChKWEOCTuPFWEOJoPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUtQJR4Sy64J
        Q4IkVmLD6v+sExjlZiGsWsDIuIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw2k//O/5p
        B+PcVx/1DjEycTAeYpTgYFYS4Z3AeCleiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+q2WvihQTS
        E0tSs1NTC1KLYLJMHJxSDUyzuw+0XL7EziXxlrUuZcrdtOgdJh0sr1kWlmhcv/q85V+8n7VQ
        meHZF0Gff6pF7d50/lVNgr/aapuNS8R6Ktu7Zq65p5rRLfYnuqxkuV/92tuMCs3XDyTzyp3X
        K/y1ntVzwnvTJxNna1/aI7XQbfPfI0L+fW8uWzMdWLRE9Uq5er5UpO5cV96LVR5JzDMs72x9
        zcqno3tx44OdsnWBS1hvhr/KPBX5KLLlZMSfyxtzrcrsEn91+94UNFt+idGcYffE6vs3ZWtY
        Zl1MLzhz8fiy8M7pwts5VVp4o7bv2sX4f3rokxMeAjsq183K+jhj54+pS7bH8Fs9W/7bUq3o
        nL+ozX3n8nc+Xx+xGs+tcfVUYinOSDTUYi4qTgQAgX5L6mUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t/xu7qnWS7FG9w7bmOxccZ6VoupD5+w
        WVz/8pzV4vz5DewWl3fNYbNYe+QuuwObx6ZVnWwefVtWMXp83iQXwBylZ1OUX1qSqpCRX1xi
        qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/HjwEOmgjtsFfuvrWFrYPzF
        2sXIySEhYCLROW8GE4gtJLCUUWLeLwmIuIzEyWkNUDXCEn+udbF1MXIB1XxilLh48w5Ygk3A
        UKLrLUiCk0NEQEFic+8zVpAiZoHbjBKTb61lBkkIC7hLtK04xwJiswioSqxvXgG2jVfARuJd
        008miA3yEqs3HGCewMizgJFhFaNIamlxbnpusaFecWJucWleul5yfu4mRmCYbTv2c/MOxnmv
        PuodYmTiYDzEKMHBrCTCO4HxUrwQb0piZVVqUX58UWlOavEhRlOgfROZpUST84GBnlcSb2hm
        YGpoYmZpYGppZqwkzrt17pp4IYH0xJLU7NTUgtQimD4mDk6pBiY248nfbK3FczVdKrZLHllX
        pPDqtlDN/avXr89rW31a2iFK/Mvtr+bd+zp9dPmufUpWL1mtwsAnu8jMamXJjHeZCj4eqTXV
        xv3bJ57T1jRpaz33TiS8z/j7sy8mprNjFy024M+Y8frjqWRd9uSIL8bb20KklHfsLbziGnMv
        Y99ixmSmhLcrqv+H2FSqC73JPHr7gaHcxk6FmoniDuG/Hy9d8Enx3GX2LY89WBukNkyPteE9
        vMCPl3VS75YtdYvO8P5q9C+XfKL5pUlvsfWiM30T+X+ksgb5Prz+Y5rMyyn3pK76mH5r4Ta3
        DG/bvSqj9uv+Rs+uM+ovNSJezfT0YLuWfiRBukC97j3nS/srIUosxRmJhlrMRcWJAKTSr8+8
        AgAA
X-CMS-MailID: 20201210112148eucas1p287afa49e63255e3320495d480eb06965
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201210112148eucas1p287afa49e63255e3320495d480eb06965
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201210112148eucas1p287afa49e63255e3320495d480eb06965
References: <CGME20201210112148eucas1p287afa49e63255e3320495d480eb06965@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper modalias structures to let this driver load automatically if
compiled as module, because max14577 MFD driver creates MFD cells with
such compatible strings.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/max14577-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index e34face736f4..1d78b455cc48 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -269,3 +269,5 @@ module_exit(max14577_regulator_exit);
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:max14577-regulator");
+MODULE_ALIAS("platform:max77836-regulator");
-- 
2.17.1


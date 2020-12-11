Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35A2D72BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437302AbgLKJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:21:05 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24166 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404401AbgLKJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:20:35 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201211091951epoutp030bf6b97bb4c9c79050dd005c09e9152d~Pnvqbc9Zi1657516575epoutp033
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201211091951epoutp030bf6b97bb4c9c79050dd005c09e9152d~Pnvqbc9Zi1657516575epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607678391;
        bh=ohgKPbsgCEs/Rg0yN/iTohBOMP6Lg1rrKl+Mg5HSpSY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UrGjLCkZ3NH/z1peNI1aDzNBZOCUmvOx4urm+vLeR5jMEwHOuByHvWgxy3ixqzeoN
         UcxXgH2DZt07PFKLNHr4i2vRdXSENxt3RgCb6onjG6rRtuUiTY5AAGV7FQfsxB0xl4
         gK2dnjNCB7jAB0dVnanTInG1Vu7+LqmWXEDtRmM4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201211091950epcas5p34ef5280f7b60cc5f58c9a0a23b68422e~Pnvpw4h5t2217522175epcas5p3o;
        Fri, 11 Dec 2020 09:19:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.00.15682.6B933DF5; Fri, 11 Dec 2020 18:19:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201211091546epcas5p24511325afff612d57306d733a3307648~PnsGxin2V1267412674epcas5p2N;
        Fri, 11 Dec 2020 09:15:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201211091546epsmtrp26e19eca5d4168b93bcaf894058062f31~PnsGwsQQ90753707537epsmtrp2y;
        Fri, 11 Dec 2020 09:15:46 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-eb-5fd339b6775a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.01.13470.2C833DF5; Fri, 11 Dec 2020 18:15:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201211091544epsmtip187cfebb6c98e4b7104bd267ff5b1d6a6~PnsEfxsaG0516605166epsmtip1d;
        Fri, 11 Dec 2020 09:15:44 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, vincenzo.frascino@arm.com,
        samitolvanen@google.com, ardb@kernel.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v.narang@samsung.com, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] arm64/entry.S: check for stack overflow in el1 case
 only
Date:   Fri, 11 Dec 2020 14:45:31 +0530
Message-Id: <1607678131-20347-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRjtt3u9u4qLy7byU9NquR5KK6HyBj2MoiZFavRGnUsvWulam5YF
        paRZ6jSjF2WpPbS4ZNYmo7RVzMLMJS4xHayyMq2sdJmZ62FtV+m/c75zznfg4yMxoRP3I7er
        0hiNSpkiIbxwY/2smbONC1sVc3U6oK11DD38rQ/Rp153EXRfpQ7R+rfPPejW2vMEXV+Wi9MV
        7VYefed8owddce2zB21uvIBo059hnM6xzw8XyK+XXkfycn26XM/mEXLDlUx5UQ2L5AP6wChi
        q9eiRCZl+x5GM2dJvFfyb50eV7NkxlBxJS8LvSDykScJ1DzoLynE85EXKaTqEHQahzCXIKS+
        IrAPhXDCdwQ3e4rwscSg8/5owoTAyB7hc+QbghGW5btcBCUDtvau2yWmqhHU245hLoJRlxA8
        sz10t4uoSLDY9O5CnJKCadDsTguoVXCry+DB9QWCrTnPHQbqJR+uDB79R8h/ZAUUVAVxHhF8
        bKjhc9gPBr6YCM6fjeDrvSrEkZMIKqyO0a1LoTc7i+dahFGzoLp2DjcOgFNPbvBcGKPGQ+HP
        Lh43F8Dt0jEshRzbzdE1/jDgcIweRg6vqgcRd71YqGsrJopRwLn/DeUIsciXUWtTkxjtfHWo
        itkr0ypTtemqJFnCrlQ9cr9HcMRt9KKzX2ZGPBKZEZCYRCwIwJ8phIJE5b79jGaXQpOewmjN
        yJ/EJT4CyQ9LnJBKUqYxOxlGzWjGVB7p6ZfFC/u1+oA64nSTWGsr11UmhnSM8GdG3wjzzWAT
        CnPDz5Z1BGo2Pbn79l3HB//3i3+x322e5dMOR4dtXCAaN2nl5UPrZrRhM5ZfHXm8cKulRKlU
        F1DiH8d3+6mSMzY8/dlyMbiSln6KWrv0kmJH98Xf97xrLQ12eg3T37u+1dSC5wl6MpsmUluK
        jkzbHOUIj002GF4FVWXZ7Z3d7Y7Ljxzx4ybjaQWTwgy5h97ENPNFxhTL7LjQXlmfFS/tdgZe
        i6wZyLDElU3IjjFnKg6WTGlb7XOmAQ7Hb1mW4zndO18kdYYcm7qtPtiwYLM1RiM3TqcfJpzI
        E0fGRoFz+fgmqUD/YFiCa5OVocGYRqv8C48VNaeNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO4hi8vxBnseqlpc3J1q8fPLe0aL
        qQ+fsFm8X9bDaLHp8TVWi8u75rBZHJ7fxmKx9PpFJoudc06yWixd8ZbV4tDJuYwWe//9ZLFo
        uWPqwOuxZt4aRo8Fm0o9Nq3qZPPYvKTeo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDL+9mxi
        KVjFUfF9wjKmBsa7bF2MnBwSAiYSX3/tZ+li5OIQEtjNKHFp11wmiIS0xM9/71kgbGGJlf+e
        s0MUfWKU6Fz2B6ybTUBPYtWuPWDdIgI7GSXWvDkOVsUssAyoavdSxi5GDg5hAV+J3QvyQBpY
        BFQl9n49xA5i8wq4S2x8spkVYoOcxM1zncwTGHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIDkMtzR2M21d90DvEyMTBeIhRgoNZSYRXluVSvBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MLjJfd7Xsd2f12bY18dzUy3ONC6Z++1a3
        wHmS9I17v4RfcCZ8v/DM6XLgziV7cxf5T/Lyiti5cfbstWJ9mw1WH9A87/ts65Itf6aaS1de
        1+YR4j2f+bfhaNR716BXZ683rX1zfuOsHG4brbLvem3VD6TMzK62sRX9Vfj3SO+h8hufmHBn
        YT/xPouq5OUZn8+Lsp8ObrnJqe+06WWUvqkd903nCd9K9px3eWH5+KJmami+ToJXdkxuw/uy
        +6ovQvaumXqhqTD6Zq1g1Tu//uV2F59eSwxfOKuJme3w7a+BZ17I9l/7/6qtc8bpP6zRDArK
        133iN3LNuH/a4ePpx4cq88+/jY2U5U9x4lO2urR+ghJLcUaioRZzUXEiAC5Wb8myAgAA
X-CMS-MailID: 20201211091546epcas5p24511325afff612d57306d733a3307648
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201211091546epcas5p24511325afff612d57306d733a3307648
References: <CGME20201211091546epcas5p24511325afff612d57306d733a3307648@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current code checks for sp bit flip in all exceptions,
but only el1 exceptions requires this. el0 can not enter
into stack overflow case directly.

it will improve performance for el0 exceptions and interrupts.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 arch/arm64/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2a93fa5..cad8faf 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -77,6 +77,7 @@ alternative_else_nop_endif
 
 	sub	sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
+	.if	\el == 1
 	/*
 	 * Test whether the SP has overflowed, without corrupting a GPR.
 	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
@@ -118,6 +119,7 @@ alternative_else_nop_endif
 	/* We were already on the overflow stack. Restore sp/x0 and carry on. */
 	sub	sp, sp, x0
 	mrs	x0, tpidrro_el0
+	.endif
 #endif
 	b	el\()\el\()_\label
 	.endm
-- 
1.9.1


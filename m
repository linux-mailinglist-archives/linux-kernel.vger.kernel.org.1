Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC427F175
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgI3Sjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:39:33 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54364 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:39:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200930183925euoutp02349b2e7c23356cf21082f11456392372~5o7ryAmuM0433604336euoutp02D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200930183925euoutp02349b2e7c23356cf21082f11456392372~5o7ryAmuM0433604336euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601491165;
        bh=SbxBiLARl8Dk0g1H6VHe2CLw9OQir8e+udgbGy3RVlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llAuxwu6paNfd7/hgyFkKZTjYGyfyR33E6/s7hCxeuufve5rNmBllDWAv+2LVDasp
         QXNLevyHaBNPf5WM04OWN32wWftMfoar2Z7mIE1doGKisFwsMbOPT0BD9mn3b/xU9o
         X8f508imiVmA1QRZZZAs0xQZ5S+AJ+GRP3wHahn4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200930183925eucas1p10ea13169b9db5c50f98010d79e5d13cc~5o7rHTezI1420814208eucas1p1U;
        Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.7B.05997.DD0D47F5; Wed, 30
        Sep 2020 19:39:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d~5o7qTi2iF0648106481eucas1p23;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200930183924eusmtrp2d3d24d8314b170b7e5554bd635a5a4a7~5o7qS4kag3109431094eusmtrp2C;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-49-5f74d0dd24a5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.F3.06017.CD0D47F5; Wed, 30
        Sep 2020 19:39:24 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200930183924eusmtip16c45496739c7641979f85916558be3f6~5o7qHNSoW2620526205eusmtip1i;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 2/4] arm: decompressor: define a new zImage tag
Date:   Wed, 30 Sep 2020 20:34:11 +0200
Message-Id: <20200930183413.17023-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTn2727uxOnt/XwZJGwngppD4kPDEkruiBBVPSHlLbZxZnbsk0t
        g3JlWJnVnM2WioVoipbSNDWdPYZoNbOHj7QUjKLS0gQnvmrmdpX875zf+T3OgUMT0gGhLx2n
        SeS0GrlKRnmQNc2Tbzb2vU2M3vSzk8APzZVCbKx4JsD6LD2Je843CHDrVTVusI8JcI+tFGHL
        ly4hbq/Pp7DN1Ijwg6Y+Ef7c3y3E5c5XCI8YZgT4z9NJEldZTMQOhm3vekewefp3JPu37AfB
        3rUksZayKxTb22Wl2OG2NhFbVZTKGkaGKPb3k06KvV5dhthRy6p9npEe249xqrhkThsUetRD
        6RjKFCV89D7tTBsj9cjqmYFoGphgqG2PyEAetJQpRWC7eJ7MQOLZxoHggimGH4wieGL+JJwX
        fMgS8HgJAsfQUyHffEegz88RudQUEwY3il+4B0uYfgIGTSWkqyGYewhmzL/cVouZcKhtPugS
        kMxaqMsbp1y1hAmBwvFqtxEwfnCppNaNi5nt8P510xxnEby8/dW9qjcTAPcvfHDXxCw/7VEe
        4coCppiGkec9JG+0C7r7R+fqxTDYMh+wEmYe3xHwp6VCtnEbr81EUJM/MccPgd62KcrFIRh/
        qKwP4uEwyB3uEPFSL+geWsSv4AXGmlsED0vgcrqUZ6+BihvWOUNfuDZYigxIlrvgmNwFB+T+
        z7qLiDLkwyXp1LGcbouGOxWok6t1SZrYwJgTaguafUC7s8VRh+r/KGyIoZHMU2LQJEZLhfJk
        XYrahoAmZEsk4a/tUVLJMXnKGU57IlqbpOJ0NrSCJmU+kq2FA0ekTKw8kYvnuAROOz8V0GJf
        PYr0Dkm1Ho5ZfUbZopmwTSNLSfbE8D0nVzU+MfZt+cUGsmCtRLF0/84DOFK4we/x0d9R66bT
        d5uWPVDe7IzfOxq6/txZR/iUyfxMSx/3n65WxTcosq3TOWLVW3ujVVNnz56cCqZay83+8sIt
        xV67eotofcSh0oKTIR17FEVnjetlpE4p3xxAaHXyf8Ter5R8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7p3LpTEG5z/zGmxccZ6VotJ6w4w
        WTRMbGCxuNm4m8niTHeuxe7TX5ksbh5awWix6fE1VovLu+awWRyaupfRYu2Ru+wWDx/cYLVY
        /e8Uo8WHCf+ZLP7s/8lisXnTVGYHAY/L1y4ye8xuuMji8XfVC2aPBZtKPTat6mTzuHNtD5vH
        u3Pn2D02L6n3mPDhLZvH+31X2Tz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48vbHvaCW/wV/5q/sjQw7uHpYuTgkBAwkbg+
        kamLkYtDSGApo8SUBcuZIOJSEivnpncxcgKZwhJ/rnWxQdQ8ZZT40N3GCJJgE3CU6F96ghUk
        ISLwhlmifeIzsCpmgWWMEov/97OCTBIWcJLYfiwEpIFFQFVix+zvbCA2r4C1xKLvW9ghNshL
        tC/fDhbnFLCRuHT2CJgtJJArsX3iJyaIekGJkzOfsICMZBZQl1g/TwgkzC+gJbGm6ToLiM0M
        NKZ562zmCYxCs5B0zELomIWkagEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAiN927OeW
        HYxd74IPMQpwMCrx8E7IK4kXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFG
        U6A3JzJLiSbnA5MRUI+hqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
        Jd9ZKjMdQ3cfESr2ytG7qWL0x9lnwsYT8WERs57z27z94GVfrlwmv15+5vJ/PdU+8cvNkqNf
        zo1kvP3Lf3VBU+kJzTXdi17Wx2zZLbRwkWLrhdPWwQ/e7tp+aWHQ5J3Msv3fZl1lrSoWEdDn
        m/y1q3OHFncdQ9eKWHU7zntcml4Bb7h9ciSVWIozEg21mIuKEwGd0f2ZDgMAAA==
X-CMS-MailID: 20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200930183413.17023-1-l.stelmach@samsung.com>
        <CGME20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
requirements of the decompressor code.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 9 ++++++++-
 arch/arm/include/asm/image.h           | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index a6b151112ac5..3e7443b52f5b 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -43,6 +43,11 @@ SECTIONS
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
     LONG(ZIMAGE_MAGIC(TEXT_OFFSET))
     LONG(ZIMAGE_MAGIC(MALLOC_SIZE))
+    LONG(ZIMAGE_MAGIC(3))
+    LONG(ARM_ZIMAGE_MAGIC4)
+    LONG(ZIMAGE_MAGIC((_end - __bss_start) +
+                      (_stack_end - _stack_start) +
+                      MALLOC_SIZE))
     LONG(0)
     _table_end = .;
   }
@@ -117,10 +122,12 @@ SECTIONS
   . = BSS_START;
   __bss_start = .;
   .bss			: { *(.bss) }
+  . = ALIGN(8);		/* the stack must be 64-bit aligned and adjoin bss */
   _end = .;
 
-  . = ALIGN(8);		/* the stack must be 64-bit aligned */
+  _stack_start = .;
   .stack		: { *(.stack) }
+  _stack_end = .;
 
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
index 8150b9490e86..8be6dbc69fbb 100644
--- a/arch/arm/include/asm/image.h
+++ b/arch/arm/include/asm/image.h
@@ -15,6 +15,7 @@
 #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
 #define ARM_ZIMAGE_MAGIC2 (0x45454545)
 #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
+#define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
 
 #ifndef __ASSEMBLY__
 
@@ -42,6 +43,8 @@ struct arm_zimage_tag {
 			__le32 text_offset;
 			__le32 malloc_size;
 		} krnl_size;
+#define ZIMAGE_TAG_ZIMAGE_MEM ARM_ZIMAGE_MAGIC4
+		__le32 zimage_mem;
 	} u;
 };
 
-- 
2.26.2


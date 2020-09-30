Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B525A27F176
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgI3Sjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:39:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54040 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgI3Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:39:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200930183925euoutp01cead7fe21240a1a59b86ba18a3bdbd09~5o7rdpZRV2669126691euoutp01l
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200930183925euoutp01cead7fe21240a1a59b86ba18a3bdbd09~5o7rdpZRV2669126691euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601491165;
        bh=VmU9hk7sPc2YuQEvFLqAo5Y66addDZ+CZ+WSSzVah+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uemZWrQDVzTIaOnLEwkajWVQktnlzBEFpX1IgFEVDsPIqiNjJUAis5oJ6WbNSLQmj
         eSnrA+Lnc8tXnwPvZJAKt2cDud3m3hMiakifKfnb4TowVwM6WZgzowzX9u0jKUFp6f
         5fUUrUkro5jqGw83jjPaHTfBZ7q1r3EIhyj4XFEI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200930183925eucas1p1330ac8f4604e78248ee16f75f951b84e~5o7rJumvE1417114171eucas1p1R;
        Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.10.06318.DD0D47F5; Wed, 30
        Sep 2020 19:39:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa~5o7qlcgEN0403504035eucas1p18;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200930183924eusmtrp2ca3ec9f629d8e5fbbb528bbff9b7990a~5o7qk0Aa93109431094eusmtrp2D;
        Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-78-5f74d0ddeeb2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.F3.06017.CD0D47F5; Wed, 30
        Sep 2020 19:39:24 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200930183924eusmtip201d1f06b3cbb8d76328fb13cf88a615e~5o7qcJD5P2698626986eusmtip2D;
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
Subject: [PATCH v3 3/4] arm: Add kexec_image_info
Date:   Wed, 30 Sep 2020 20:34:12 +0200
Message-Id: <20200930183413.17023-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOjsfp7LgiXzSLRhcSSrtQBzVJKThEQUEQCWYrD0t0yzaX
        GZZLIdM0Ny9pKiWVqavUps68LV2a2dK8ZYZaRmV5KykNLS85j5H//Z73e573Ah+JiYb4jmSg
        PJRVyCXBYkKAG55NvtrU2xLq75bQgtGP0gv5dFJBDY9Wa9U4/fZSJY9+eVVGV5rHefRbUx6i
        9R87+XR7RRZBm1KrEf2wrteK/tDXxafvz7xA9KhmlkdPPZnE6WJ9KrabYto7WzEmU92KM9O6
        rxiTrVcxel0swfR0VhHMt+ZmK6b4biSjGR0hmO/G1wRzrUSHmJ/6VQdtfQWeAWxw4FlW4ep1
        XHAqf7IWC9HanTOnZfPUqNYmDlmTQG2H5Kf5RBwSkCIqD4H2TTPGiTEEHd39C+InAl3fH/Qv
        8q4udp5FVC6Cynofjr8gaLjpYGGC8obEnOd8S3g51YfBYGoubhEYdQ/BbPow3+JaRm2BNE2R
        lYVxah3kabtxCwspD0iZjsO5aashJreMsLA15QltTXUE57GHxhuf5j1LKRd4EPVmnrE5f3Rp
        5vzaQOWTUP7+6UKjPWCu/kFwvAwGG0qsOF4Js+W3eHGInONISE7awWXjERiyJhayHtDT/Juw
        eDBqIxRWuHJlbxi6Xs/nonbQNWLPrWAHSYY0jCsL4cplEedeCwWJVQsNHSFhMA9pkDhj0TEZ
        iw7I+D8rG2E65MCqlDIpq9wmZ8M2KyUypUou3XzytEyP5r6geaZh/DEyTp0wIYpEYluhRh7q
        L+JLzirDZSYEJCZeLvRpMh8TCQMk4edZxWl/hSqYVZqQE4mLHYTbbg/4iSipJJQNYtkQVvHv
        lUdaO6rRi/2NXeU1zw50fPay9tIVRa1ZssFnoElwznfXtI1b4RPV0juBE2U5F3cajw5u9T/v
        5z5QOP45wjMn9leJ0wMP8mGbs8++k0ecq7MLGiKM0sNIWzraciilv4o9E4nd1vQDEzCsL1qR
        Y+x1b5+5MB20N2a9w1hESFOPIT482jXscUqrGFeekmxxwRRKyV/1GAkDfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7p3LpTEG6xYIG+xccZ6VotJ6w4w
        WTRMbGCxuNm4m8niTHeuxe7TX5ksbh5awWix6fE1VovLu+awWRyaupfRYu2Ru+wWDx/cYLVY
        /e8Uo8WHCf+ZLP7s/8lisXnTVGYHAY/L1y4ye8xuuMji8XfVC2aPBZtKPTat6mTzuHNtD5vH
        u3Pn2D02L6n3mPDhLZvH+31X2Tz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+XPg8wFE/kqTk9fwNTAeJC7i5GTQ0LAROLe
        kU7GLkYuDiGBpYwS794sYO1i5ABKSEmsnJsOUSMs8edaFxtEzVNGiRvXH7CBJNgEHCX6l55g
        BUmICLxhlmif+AysillgGaPE4v/9rCBVwgKGEtMnbGAHsVkEVCVWTLzNAmLzClhLTPnbxQKx
        Ql6iffl2sKmcAjYSl84eAbOFBHIltk/8xARRLyhxcuYTFpDrmAXUJdbPEwIJ8wtoSaxpug42
        hhloTPPW2cwTGIVmIemYhdAxC0nVAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRv+3Y
        zy07GLveBR9iFOBgVOLhnZBXEi/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTi
        Q4ymQG9OZJYSTc4HJiSgHkNTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxS
        DYyeR67mvLsedlS+53zFd+cTHwTCnA79mzL3up7l/bOJEcvOfXshLaJmNSviyL5yx3brk45/
        tyeVTPyhzGkrKzqNIeaP29r816tb5h60vrT6hNu/PGbW5vAVkp4T7LeZ5OonHCm1cbp/MuPV
        pFaWNBOTwFQGkd1b5Izyt8Vo+Ri4PQrawZImqaDEUpyRaKjFXFScCAC+VYu6EAMAAA==
X-CMS-MailID: 20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200930183413.17023-1-l.stelmach@samsung.com>
        <CGME20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec_image_info to print detailed information about a kexec image.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 5d84ad333f05..a0c229eec0b2 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -29,6 +29,32 @@ extern unsigned long kexec_boot_atags;
 
 static atomic_t waiting_for_crash_ipi;
 
+/**
+ * kexec_image_info - For debugging output.
+ */
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("%s:%d:\n", func, line);
+	pr_debug("  kexec kimage info:\n");
+	pr_debug("    type:        %d\n", kimage->type);
+	pr_debug("    start:       %lx\n", kimage->start);
+	pr_debug("    head:        %lx\n", kimage->head);
+	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("      segment[%lu]: %08lx - %08lx, 0x%x bytes, %lu pages\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -40,6 +66,8 @@ int machine_kexec_prepare(struct kimage *image)
 	__be32 header;
 	int i, err;
 
+	kexec_image_info(image);
+
 	image->arch.kernel_r2 = image->start - KEXEC_ARM_ZIMAGE_OFFSET
 				     + KEXEC_ARM_ATAGS_OFFSET;
 
-- 
2.26.2


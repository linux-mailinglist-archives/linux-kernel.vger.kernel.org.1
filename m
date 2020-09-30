Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355B727F172
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI3Sj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:39:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54324 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:39:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200930183924euoutp029470d6eee65cbd1ab9689a46cbac60e9~5o7qMgmHx0221702217euoutp02j
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200930183924euoutp029470d6eee65cbd1ab9689a46cbac60e9~5o7qMgmHx0221702217euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601491164;
        bh=8vwQTEgVDY2ghaKzB6k6FPzBJ7fCcE8/kpOER0oeXtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHQqZOzzo3MrhC7R2TH/ei/DezBYCMfzVFid1Gp7+eI1ozXKlLy7D9N6V8cYaTIoR
         P+K5UWbAzX4s547ozFpBGkyq4UG6j40pE7z/JCXNi88/1W/fZ7qDn8ljwghbM/Jojy
         APU2qHU2L9ZepR+VWJnOE/hD2YAijesvTf7LmMFg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200930183923eucas1p295b229c64943b6a50be03c4457f06984~5o7pKFWgz0648506485eucas1p2u;
        Wed, 30 Sep 2020 18:39:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.7B.05997.AD0D47F5; Wed, 30
        Sep 2020 19:39:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200930183921eucas1p11a56f805421a614be67f869f5ed18b9b~5o7n-vm9O0403004030eucas1p1y;
        Wed, 30 Sep 2020 18:39:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200930183921eusmtrp243769591507cf1ae1c02222a2a4c8bf5~5o7n_-xek3109431094eusmtrp2-;
        Wed, 30 Sep 2020 18:39:21 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-46-5f74d0da99a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.F8.06314.9D0D47F5; Wed, 30
        Sep 2020 19:39:21 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200930183921eusmtip2ff25058789e2d67e1991755cade2657e~5o7n0EKZ41393513935eusmtip2j;
        Wed, 30 Sep 2020 18:39:21 +0000 (GMT)
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
Subject: [PATCH v3 0/4] kexec_file_load() for arm
Date:   Wed, 30 Sep 2020 20:34:09 +0200
Message-Id: <20200930183413.17023-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3V3N1W1anuwFw/4wSDN73FAjzT8uUhASlFLZyouP3LQ9
        UotyPsiysqmJTgUlUscsrVUrH+VaoulMFNE0FLQizUrN1NJ85HaV/O97zvmc7zkHDomJvvFd
        yEiZkpXLJNFiwh43Nky37vjQpgzd+bBwH/04r5JPZ1WYeLQ6U43TPUk1PLrlppSusUzy6B6z
        DtGGT118uqO6kKDNOS8R/bC+T0AP9Hfz6fL5ZkSPaRZ49GzdNE4/MeRgBymmo6sdYwrU7Tgz
        px/CmGKDijHobxBMb1ctwYy0tgqYJ/cTGc3YD4IZfdVJMBlP9Yj5Zdhy1CHE3ieMjY68yMo9
        Dpyxj/icqcdj553iR4xSNTI5pCM7EqjdMNtURaQje1JE6RBcHy9BXDCBoN1iFHDBLwQarYa/
        3HJtPoln1SKqDEH9bBAHDSJ4ffeRrUBQfnCn5C3fWnCi+jEYzinDrQFGlSJYyPtus3KkPKGl
        S0NYNU5tA92gFrNqIeUNA2lfcG7cVkgre25j7CgfMFnGeRyzFpq0n23MGmo7PEh+b9PYIp/y
        rACzDgOqhIQebRHijALg/dzI0g2OMNz4VMDpTbBQVbRoSi7qRMjO2sv13kJgLPyztIQ39LbO
        EFYGo9ygstqDS/vBF2M54lpXQ/ePtdwKqyHLmItxaSFcvybiaFeouFO7ZOgCt4d1SIPE+SuO
        yV9xQP7/WcUI0yNnVqWQhrOKXTI2zl0hkSpUsnD3czFSA1p8Qct848QLVD171owoEokdhBqZ
        MlTEl1xUJEjNCEhM7CT0f2c5LRKGSRIusfKYULkqmlWY0UYSFzsLve59PSWiwiVK9jzLxrLy
        5SqPtHNRo2CN67Rzyv6SWx8D5RX+IcdHSzfkbnozmNe8O+xvY9h+5iQ2FRdfmR0r8OpnUlUu
        fW0DUXv8r6wby+6+lHY113NHVJBS57kwlSoPrFhfn9Lwe2bVT69Do3GHTb51GZbkY3rmtG+I
        4bJJHHsqZtL7OTkQfCS5XnnC7YJ2KLozwHnzkBhXREg8t2NyheQfTFqQ+X4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xe7o3L5TEG1xermWxccZ6VotJ6w4w
        WTRMbGCxuNm4m8niTHeuxe7TX5ksbh5awWix6fE1VovLu+awWRyaupfRYu2Ru+wWDx/cYLVY
        /e8Uo8WHCf+ZLP7s/8lisXnTVGYHAY/L1y4ye8xuuMji8XfVC2aPBZtKPTat6mTzuHNtD5vH
        u3Pn2D02L6n3mPDhLZvH+31X2Tz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48nEVSwF/0Qq3m3LbWA8wNPFyMkhIWAi0fav
        kamLkYtDSGApo8Th+1dZuxg5gBJSEivnpkPUCEv8udbFBlHzlFHi2uRXTCAJNgFHif6lJ1hB
        EiICb5gl2ic+A6tiFljGKLH4fz8rSJWwgKHEmWsT2EBsFgFViRXPZzKD2LwC1hIP25+xQKyQ
        l2hfvh2shlPARuLA6U9gG4SAat5P62aCqBeUODnzCQvIdcwC6hLr5wmBhPkFtCTWNF0HG8MM
        NKZ562zmCYxCs5B0zELomIWkagEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAmN927Ofm
        HYyXNgYfYhTgYFTi4Z2QVxIvxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM
        pkBvTmSWEk3OB6YjoB5DU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        4huLq42PMb/xfr5S5Fgt09spCYrbFUqPPjg+6UOjvFJdyuS9X3li1NRjlXfK2RcvE1d9Ooe7
        amfTuzNFdtEPZ87MOMVw78fSIhf9m8v+uQiz//zc9sXJ5vGWqMgDdR3vrqyJZzjgEe1zZc2k
        F9J2t2ZemDybQaFg7u4ZvQna8w9xPr5jcuLqWSWW4oxEQy3mouJEAMHMrCYPAwAA
X-CMS-MailID: 20200930183921eucas1p11a56f805421a614be67f869f5ed18b9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200930183921eucas1p11a56f805421a614be67f869f5ed18b9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200930183921eucas1p11a56f805421a614be67f869f5ed18b9b
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200930183921eucas1p11a56f805421a614be67f869f5ed18b9b@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches provides implementation of the                                                         
kexec_file_load() system call form the arm architecture. zImage and uImage                                             
(legacy format) files are supported. Like on arm64, there is no                                                        
possibility of loading a new DTB and the currently loaded is reused.                                                   

Changes in v3:
  - move the patchset to next-20200929
  - drop the first patch: set malloc pool size for the decompressor
    (replaced by adc5f70293760)  
  - use text_offset added in 83dfeedb6663e
  - add text_offset and malloc_size to struct zimage_krnl_size
  - add dependency on CONFIG_KEXEC_FILE in arch/arm/include/asm/kexec.h
    to enable compilation without CONFIG_KEXEC
  - add dependency on MMU in Kconfig

Changes in v2:                                                                                                         
  - add CONFIG_KEXEC_FILE_UIMAGE for optional uImage support                                                           
  - MALLOC_SIZE as a define instead of a symbol                                                                        
  - DCSZ tag holds combined dynamic memory requirements (bss+stack+malloc)                                             
  - use union for a single tag structure                                                                               
  - copyright notice includes Russell King                                                                             

Łukasz Stelmach (4):
  arm: add image header definitions
  arm: decompressor: define a new zImage tag
  arm: Add kexec_image_info
  arm: kexec_file: load zImage or uImage, initrd and dtb

 arch/arm/Kconfig                       |  26 +++
 arch/arm/boot/compressed/head.S        |   3 +-
 arch/arm/boot/compressed/vmlinux.lds.S |  22 +--
 arch/arm/include/asm/image.h           |  79 +++++++++
 arch/arm/include/asm/kexec.h           |  16 +-
 arch/arm/kernel/Makefile               |   5 +-
 arch/arm/kernel/kexec_uimage.c         |  80 ++++++++++
 arch/arm/kernel/kexec_zimage.c         | 197 +++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c        |  39 ++++-
 arch/arm/kernel/machine_kexec_file.c   | 211 +++++++++++++++++++++++++
 10 files changed, 660 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/include/asm/image.h
 create mode 100644 arch/arm/kernel/kexec_uimage.c
 create mode 100644 arch/arm/kernel/kexec_zimage.c
 create mode 100644 arch/arm/kernel/machine_kexec_file.c

-- 
2.26.2


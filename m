Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72FF2D2C13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgLHNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:37:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50106 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgLHNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:37:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201208133638euoutp02ed8f60f1e02b9e741d8154229aae1d4b~OwUBBXP7b0061700617euoutp02I
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201208133638euoutp02ed8f60f1e02b9e741d8154229aae1d4b~OwUBBXP7b0061700617euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607434598;
        bh=ZKBFxreRF5PjBXV8hEhuAFzXC4pA6iR6+yrllTXbTH8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HlQeVXtOIQ545acDFhP4tBPP+r0zVqpd9hyPisw5Relaey2oYxcWcEZJ2KkA0GWO0
         T5iBel4glDnxpMTren5WuHZt8tqz5Cpl4tZ7um7VOQgN5Ll0It/v9t5ppKMkK7h1cw
         Uv1ZeeTyj876qU5OplGVaTYlHYwGjfQ7cMtbnDHs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201208133638eucas1p1eff46648bc78e2dafcab872a8babcf03~OwUAy2lxe2624626246eucas1p1n;
        Tue,  8 Dec 2020 13:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 56.8E.45488.6618FCF5; Tue,  8
        Dec 2020 13:36:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14~OwUANuzfI1983319833eucas1p2t;
        Tue,  8 Dec 2020 13:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201208133637eusmtrp29b8a46b7046287338e9dc47334ff27b6~OwUANHlWj1751017510eusmtrp2p;
        Tue,  8 Dec 2020 13:36:37 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-0e-5fcf816626a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.C7.16282.5618FCF5; Tue,  8
        Dec 2020 13:36:37 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201208133637eusmtip2be9bab5f581730aa7c935da148e068d6~OwT-xOHd-3038530385eusmtip25;
        Tue,  8 Dec 2020 13:36:37 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] extcon: max77693: Fix modalias string
Date:   Tue,  8 Dec 2020 14:36:27 +0100
Message-Id: <20201208133627.10699-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djP87ppjefjDXZ8lrDYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLtUfuslvcblzB5sDmsWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZXzYd4OtYB97xa5rt5kaGE+ydTFycEgImEi8OO3bxcjFISSwglGid+V9JgjnC6PE8/sTWCCc
        z4wSy37PZe9i5ATreHR2IVRiOaPE8jmz2eFatm0/ywhSxSZgKNH1tosNxBYRUJDY3PuMFaSI
        WeAho8SMZVPBEsICZhKf3u4Es1kEVCXarm8Fs3kFbCUabrYwQayTl1i94QAzSLOEwEt2id2z
        lzBDJFwkFiy+wwJhC0u8Or4F6j4Zif875zNBNDQzSjw8t5YdwulhlLjcNIMRospa4s65X+Aw
        YBbQlFi/Sx8i7Chx++QzdkjQ8EnceCsIEmYGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLkGd
        5iFxrPksC0i5kECsxKKPrBMY5WYhrFrAyLiKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMj
        MN5P/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuFVkzobL8SbklhZlVqUH19UmpNafIhRmoNFSZx3
        19Y18UIC6YklqdmpqQWpRTBZJg5OqQamdc0/ZMMv//2WN+/upHOLPl2ZphQtu3tV/3vL0gWt
        y/pe9c9TecWcHHVhR3po5c/CKp+bZi4Ztd9nJXx9ejLtU4WGacWiJbJX9L4eOL9CbGNCucXq
        IMuXQvbrPy1/M+HuRd3Wuoff9s5k5GUO9ZvA9dIvMunVj1PcIjv8zrl8kvmfN9Nz00z2iMQ6
        Tt6Hdxv38c0s3/0t5E76bMWFt5eGFWnKxCt5vH12/tXjD6vdzKc/Zzh4unzeSddpU8xuSBqx
        ev10sL0jY+vguWBmK8e7jWvffhL/tLdUWab9fVpenYCQ4DqP2BtRE2Ycf9NVUvju1J3vGxZO
        Wqau9X5+/Zs+4wOnj2kkZTFOPCaTtml+bK8SS3FGoqEWc1FxIgB+TOU5ZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xe7qpjefjDT781LPYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLtUfuslvcblzB5sDmsWlVJ5tH35ZVjB6fN8kFMEfp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXzYd4OtYB97xa5rt5kaGE+y
        dTFyckgImEg8OruQpYuRi0NIYCmjRPfDFqiEjMTJaQ2sELawxJ9rXWwQRZ8YJc7+v88OkmAT
        MJToetsF1iAioCCxufcZK0gRs8BjRolvbR+YQRLCAmYSn97uBCtiEVCVaLu+FczmFbCVaLjZ
        wgSxQV5i9YYDzBMYeRYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIDLRtx35u2cG48tVH
        vUOMTByMhxglOJiVRHjVpM7GC/GmJFZWpRblxxeV5qQWH2I0Bdo3kVlKNDkfGOp5JfGGZgam
        hiZmlgamlmbGSuK8JkfWxAsJpCeWpGanphakFsH0MXFwSjUwVUySXb960xLFDKlcu08pzPf4
        J9zl14+7Xvjo3cor5+/779Hmkv92tNlUvizyxQM/DveMypj0d57qRXM0d1w4oM/WoTdhxevo
        rqWn5fiVP/4IV9nlteNO96fTjtX1L+Wdbm1eaRL3eWpervnE9l1REa//1vpc+rbTjEk196qx
        nKH+NtX8mP4e6yD+xplnqi60zjZ3EVpuVHV25bedjReuLf+XPW9rL1+cV5TblOdZkxpnOGp8
        5HXVmdjRKrh0rVjo6mltBV/Oyn562HA7z2v+7w3Pu8M0H21nULI4Gl12Yl7H668OoQc/m7xW
        D2s8aKTVu1ndJs/W9u+jlzEFfAe5y5n3z3FVdavvXG3I/LNSiaU4I9FQi7moOBEAdm+2l70C
        AAA=
X-CMS-MailID: 20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14
References: <CGME20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device driver name is "max77693-muic", so advertise it
properly in the modalias string. This fixes automated module loading when
this driver is compiled as a module.

Fixes: db1b9037424b ("extcon: MAX77693: Add extcon-max77693 driver to support Maxim MAX77693 MUIC device")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max77693.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 4a410fd2ea9a..92af97e00828 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1277,4 +1277,4 @@ module_platform_driver(max77693_muic_driver);
 MODULE_DESCRIPTION("Maxim MAX77693 Extcon driver");
 MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:extcon-max77693");
+MODULE_ALIAS("platform:max77693-muic");
-- 
2.17.1


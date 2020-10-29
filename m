Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2029E6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgJ2JCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:02:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33191 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgJ2JBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:01:16 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201029063541epoutp04409337fac007e5616eb6824581ba3786~CYxDHwdox1003510035epoutp04V
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:35:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201029063541epoutp04409337fac007e5616eb6824581ba3786~CYxDHwdox1003510035epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603953341;
        bh=qoMxnydnLzDEzvJ5HFMoSre/kwCmR9YjW6adtjRZMzw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lsd0hIHXZ2RKBBQ4N1GEp29/gwcmZeStnT9jW3VwSPIWsMjG+biDadrQ4zgmV1+6O
         j8Puc4PLqiOtXWND2dc8chnpOBpuqTiscvnJcyNSMqSKuLc/fwD9BHzor5ncgpVnaK
         VPxDEs59VOMCLz6pbXCJuMbpmbxgGL3f3F+01i9g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201029063540epcas1p45824b355c9d0a3f7ddc6c8fc8af64a60~CYxCiCZ131513715137epcas1p4v;
        Thu, 29 Oct 2020 06:35:40 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CMG0W5R6hzMqYkc; Thu, 29 Oct
        2020 06:35:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.5E.63458.BB26A9F5; Thu, 29 Oct 2020 15:35:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201029063539epcas1p36375a73634374656654da00cbaf91531~CYxBiFc3G2546825468epcas1p3A;
        Thu, 29 Oct 2020 06:35:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201029063539epsmtrp2839f9e869bd4b23977872ad39e9e763e~CYxBhlhL72638926389epsmtrp2q;
        Thu, 29 Oct 2020 06:35:39 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-89-5f9a62bb9524
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.2D.08745.BB26A9F5; Thu, 29 Oct 2020 15:35:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201029063538epsmtip2b85760b1157c6659cf0ae5c19a548cc8~CYxBJNreQ2299222992epsmtip2e;
        Thu, 29 Oct 2020 06:35:38 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sangmoon Kim <sangmoon.kim@samsung.com>
Subject: [PATCH] char: misc: increase DYNAMIC_MINORS value
Date:   Thu, 29 Oct 2020 15:28:55 +0900
Message-Id: <20201029062855.19757-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7bCmge7upFnxBp/vqlv8nXSM3aJ58Xo2
        i8u75rBZ3HrQyOLA4vH71yRGj/1z17B79G1ZxejxeZNcAEtUjk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJOxoFZB5gKHrNVfDv2g62B8Rhr
        FyMnh4SAicS2B70sXYxcHEICOxglth5dwwSSEBL4xChx7Z4aROIzo8Tfr3dZYDoen1rFCJHY
        xShxedpLRoiOL4wSTycHg9hsAroSX+ZdBouLANl/nqwGa2YW8JT4uv0MM4gtLGAlcfhhA9g2
        FgFViUU/ZrKB2LwCthJLj11kglgmL7F6wwFmkGUSApPZJQ5N7oS620XiVPdfKFtY4tXxLewQ
        tpTE53d72SDsfYwSe1bKQDRPYZRYPmUHVJGxRG/PBaCpHEAXaUqs36UPEVaU2Pl7LiPEoXwS
        7772sIKUSAjwSnS0CUGUqEk8fnWXEcKWkei/Mx8aKB4S3348ZoaEQ6zEpi2bWCcwys5CWLCA
        kXEVo1hqQXFuemqxYYERciRtYgQnIy2zHYyT3n7QO8TIxMF4iFGCg1lJhPeF4Mx4Id6UxMqq
        1KL8+KLSnNTiQ4ymwACbyCwlmpwPTId5JfGGpkbGxsYWJmbmZqbGSuK8f7Q74oUE0hNLUrNT
        UwtSi2D6mDg4pRqYpAME8tZli26KeZ4vVmfBwN71Ven8N85g+WP5UyT7ONQjVj9Z4/b9nvYt
        qcAb/6/J5gfe3hikeefcLffIaVId9yWPzgrl+jNlqsnLPZfentz97XQjQ+WW99pFnFuPv4nX
        v60r3XKjtPO5boPNuXsv5nl8nH7Vc9Jq3ole3yY9XjFBfofjJItr9mv/df1VFr0vs3df4H2u
        P76HXne+W3VW3klJfEK9h0zUU6fYfxbPVh3d2XO2YuqXT8Y1YgxmLx0WanwOCL9w4H9tjcDG
        ygSbMN69DPOtHsu8TEq05DudMLlxyceJ+7Vq7E+Wriq+JfeLzWv2ml7lhoVXpeXCzVxd53mI
        7XIwWiW9kEf68Y/NHkosxRmJhlrMRcWJAPBMNq7PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSvO7upFnxButX8ln8nXSM3aJ58Xo2
        i8u75rBZ3HrQyOLA4vH71yRGj/1z17B79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8aBWQeY
        Ch6zVXw79oOtgfEYaxcjJ4eEgInE41OrGEFsIYEdjBIz2ksh4jISOy9uZupi5ACyhSUOHy7u
        YuQCKvnEKLG/9RcbSA2bgK7El3mXwXpFBPQl7pzZywRiMwt4Syyc8IkdxBYWsJI4/LABLM4i
        oCqx6MdMsF5eAVuJpccuMkHskpdYveEA8wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYJDQ0trB+OeVR/0DjEycTAeYpTgYFYS4X0hODNeiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO/XWQvjhATSE0tSs1NTC1KLYLJMHJxSDUz1zM9W9q/P5nKWesldxWjk8+3+h7w2KbGH
        SX0NBuZ3b0R8lD513/SK96cX/ILty72XvrnjOXuFZHb7a+1ZmxtNb1Ur9a5btn5SAc/Ktwof
        NFLVN0am+6xQj3OqEjzoFtEfeJJ5mUamzLSFOsKsrz5NEUji8p1ycUPC2vSpPo6dt97UK8xX
        4V0r9urBX/+nHe9dbvfPtfzfXP7F2/PmqvQPV1KeXF18+PLH0wnaIqpsh67/aoz5lz4tZvae
        R83OLZz33q22nLto7QnzvqCJFRVJQiuLtk/53jglbZvN9bUz+7/V65vvYPpX78rCfPve1Tss
        T3jK9ouu/CE9ucdr7yGJa3FB/8XFM+/vahLJt1qqxFKckWioxVxUnAgAby41T3wCAAA=
X-CMS-MailID: 20201029063539epcas1p36375a73634374656654da00cbaf91531
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201029063539epcas1p36375a73634374656654da00cbaf91531
References: <CGME20201029063539epcas1p36375a73634374656654da00cbaf91531@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DYNAMIC_MINORS value has been set to 64.
Due to this reason, we are facing a module loading fail problem of
device driver like below.

 [   45.712771] pdic_misc_init - return error : -16

We need to increase this value for registering more misc devices.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f6a147427029..ca5141ed5ef3 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -60,7 +60,7 @@ static DEFINE_MUTEX(misc_mtx);
 /*
  * Assigned numbers, used for dynamic minors
  */
-#define DYNAMIC_MINORS 64 /* like dynamic majors */
+#define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
 
 #ifdef CONFIG_PROC_FS
-- 
2.17.1


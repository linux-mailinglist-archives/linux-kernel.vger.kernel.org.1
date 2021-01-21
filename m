Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4EA2FE392
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbhAUHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:13:16 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:61981 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAUHJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:09:34 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210121070840epoutp0346253e4c6ab2be84a6d3628614efe06d~cLZ1yTg4w0970709707epoutp03N
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210121070840epoutp0346253e4c6ab2be84a6d3628614efe06d~cLZ1yTg4w0970709707epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611212920;
        bh=A+3jbTyF6ufeu8ESMdpYJqVLwy5jij2UUmPAwjDCvhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiLbB9cf+P4F0n1t8WPsgs4YAiFEoVTWPlw5PGg65OBDdf9ywiycTdWbtD/72WAec
         y+/hxgVZY+BJtvlz7chQHBr+1o4XVDZhdmCtPKGWkGiY02DQ+BvBZjbgZpqdLjokjD
         DMH8s17s1mMafYxNc3KuOOR9crY4d8UVM1QhlxyM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210121070840epcas2p1fbcce04077f28e1873403204e82959ff~cLZ1H5lH72013420134epcas2p1p;
        Thu, 21 Jan 2021 07:08:40 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DLtlp2Sf9z4x9Pv; Thu, 21 Jan
        2021 07:08:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.40.52511.57829006; Thu, 21 Jan 2021 16:08:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd~cLZxuNq9E1983419834epcas2p1J;
        Thu, 21 Jan 2021 07:08:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210121070836epsmtrp106d41adf269ca1a4e9dbcb4340f2aa29~cLZxth4Un0074500745epsmtrp1_;
        Thu, 21 Jan 2021 07:08:36 +0000 (GMT)
X-AuditID: b6c32a48-4f9ff7000000cd1f-e3-6009287549bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.34.08745.47829006; Thu, 21 Jan 2021 16:08:36 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210121070836epsmtip2eff9c92b3f89751b00feca2ea8bb0e74~cLZxc5odo2241422414epsmtip2G;
        Thu, 21 Jan 2021 07:08:36 +0000 (GMT)
From:   Oh Eomji <eomji.oh@samsung.com>
To:     balbi@kernel.org
Cc:     Oh Eomji <eomji.oh@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_mass_storage: cahnge wait_event to
 wait_event_timeout
Date:   Thu, 21 Jan 2021 15:56:45 +0900
Message-Id: <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <eomji.oh@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmqW6pBmeCwYszXBa9TdOZLI61PWG3
        mPbhJ7PFqeULmSyaF69ns/h1cRqrxeVdc9gsFi1rZXbg8Lh8xdtj06pONo95JwM99s9dw+7R
        t2UVo8fnTXIBbFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
        AbpumTlA5ygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNC/SKE3OLS/PS9ZLz
        c60MDQyMTIEqE3Iynq44y1zQwFGxu28pSwPjS7YuRk4OCQETifP3f7N3MXJxCAnsYJTomLqM
        DcL5xChx8EETM4TzmVGi+d57RpiWfR83MUIkdjFKfNv5ix0kISTwg1Hi5h03EJtNQFVi+rLt
        YA0iAiISbc9nMIE0MAvMZ5LYvaEVaAcHh7BAuMS7zxkgNSxA9a8XLGQFsXkFXCTuNn5ghlgm
        J3HzXCeYzSmgLLHs41awxRIC59gluj68Z4cocpFYeuMI1EPCEq+Ob4GKS0m87G+Dssslzs45
        DdXcwChx5dkjFoiEscSsZ+2MIAcxC2hKrN+lD2JKAC07cgusglmAT6Lj8F92iDCvREebEESj
        ksSkpk4mCFtCYsXnJijbQ2Ll6g9skCApk9gy7RHTBEa5WQjzFzAyrmIUSy0ozk1PLTYqMEGO
        sE2M4OSm5bGDcfbbD3qHGJk4GA8xSnAwK4nwPrLkSBDiTUmsrEotyo8vKs1JLT7EaAoMu4nM
        UqLJ+cD0mlcSb2hqZGZmYGlqYWpmZKEkzltk8CBeSCA9sSQ1OzW1ILUIpo+Jg1OqgUnl6gNH
        9eypp/b4BpSnhJqf7mIX0fcsFl7NZme6Oz+6N2RS8t69p3dNOL6qeNfLOSvXTVv8JWRhYszU
        4P3z/Q5sDNX2e71H5fDUmbs0ZjN+nMb568it2xO+37tuEWYVs2Fp7b8JbgJdJx78z/lpXcUx
        ofvG+h8Su5TN1fyD5AN2aM2fnbvt6tEZPCyFbPF3Y2TFPz6IW84h7/909oIbr7pMtV5Y3O2z
        69KuuhAqZRk/gdEg+TSX9uMXhUdsnfO0Z0yuZJrLv/BvtElq3F+/hd8m5kdy/yoq2T4n4u1E
        9VehE6Ze//jx3fXzsnOtJpT9lihyVLDiZxAoithqtELXg21/Qc3F+u9H7h3I5lo2446ZEktx
        RqKhFnNRcSIA9fcRr/cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSvG6JBmeCwe9dUha9TdOZLI61PWG3
        mPbhJ7PFqeULmSyaF69ns/h1cRqrxeVdc9gsFi1rZXbg8Lh8xdtj06pONo95JwM99s9dw+7R
        t2UVo8fnTXIBbFFcNimpOZllqUX6dglcGU9XnGUuaOCo2N23lKWB8SVbFyMnh4SAicS+j5sY
        QWwhgR2MEptvJkPEJSQWdL1mhrCFJe63HGHtYuQCqvnGKHH00UGwBjYBVYnpy7aD2SICIhJt
        z2cwgRQxCyxmkmj8PpcFJCEsECpxf9YcsEksQA2vFyxkBbF5BVwk7jZ+gNogJ3HzXCeYzSmg
        LLHs41aoi5Qkdr3fyTyBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgMNTS
        2sG4Z9UHvUOMTByMhxglOJiVRHgfWXIkCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkgg
        PbEkNTs1tSC1CCbLxMEp1cDU/Ofc3NPtXEcy9ty21LUrlnoS/GpbWJK/1hUm3z/MMlHzl0co
        x2zzYAr1z0rp2i7B/zMnfcFv35PX/K+Jij3w/6g091e+SV3JVPt0hV0dp+1b9Gr/LT+z5nVT
        64+KKLWdvemspc/3Gznv3j3xqfg1h+oznEfqfQsm1xoed5OxfLn9oO79sjtK+09qPd6yccON
        hW5tyzebHuOYubt7V/CrkLZZp6JuSmjHaNVN2JBRxHxw6+3Tz3aYr6j6LLS6eUN8rotsierq
        59NnL0/VvKqbyf3mzMtnt2SVRHef7n2+b+XrybodgoE7fXT/HpNKrTDfVc4Xn7PbVpG5oODN
        Q5ECuYLEaU/jPty0s+rv0TytxFKckWioxVxUnAgAbwAAzbICAAA=
X-CMS-MailID: 20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd
References: <eomji.oh@samsung.com>
        <CGME20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed to return a timeout error if there is no response for a certain
period of time in order to solve the problem of waiting for a event
complete while executing unbind.

Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 950c943..b474840 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -3000,7 +3000,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
 	if (fsg->common->fsg == fsg) {
 		__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
 		/* FIXME: make interruptible or killable somehow? */
-		wait_event(common->fsg_wait, common->fsg != fsg);
+		wait_event_timeout(common->fsg_wait, common->fsg != fsg, HZ / 4);
 	}
 
 	usb_free_all_descriptors(&fsg->function);
-- 
2.7.4


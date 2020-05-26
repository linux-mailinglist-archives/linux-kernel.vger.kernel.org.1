Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231971AB7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407611AbgDPGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:08:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407157AbgDPGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:08:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G63Lhu120500;
        Thu, 16 Apr 2020 02:08:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30egsmsnfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 02:08:06 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03G65uDe130456;
        Thu, 16 Apr 2020 02:08:05 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30egsmsnf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 02:08:05 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03G66q2h029896;
        Thu, 16 Apr 2020 06:08:03 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 30b5h79ydf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 06:08:03 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03G682BF33358242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 06:08:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB34B2070;
        Thu, 16 Apr 2020 06:08:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBFBCB205F;
        Thu, 16 Apr 2020 06:08:00 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 06:08:00 +0000 (GMT)
Subject: [PATCH v11 13/14] powerpc/vas: Free send window in VAS instance
 after credits returned
From:   Haren Myneni <haren@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mikey@neuling.org, srikar@linux.vnet.ibm.com,
        frederic.barrat@fr.ibm.com, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, hch@infradead.org, oohall@gmail.com,
        clg@kaod.org, herbert@gondor.apana.org.au,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ajd@linux.ibm.com
In-Reply-To: <1587016214.2275.1036.camel@hbabu-laptop>
References: <1587016214.2275.1036.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 15 Apr 2020 23:07:36 -0700
Message-ID: <1587017256.2275.1076.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_01:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=3
 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


NX may be processing requests while trying to close window. Wait until
all credits are returned and then free send window from VAS instance.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index d0c07cf..e15b405 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1316,14 +1316,14 @@ int vas_win_close(struct vas_window *window)
 
 	unmap_paste_region(window);
 
-	clear_vinst_win(window);
-
 	poll_window_busy_state(window);
 
 	unpin_close_window(window);
 
 	poll_window_credits(window);
 
+	clear_vinst_win(window);
+
 	poll_window_castout(window);
 
 	/* if send window, drop reference to matching receive window */
-- 
1.8.3.1




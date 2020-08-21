Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C058D24D90E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHUPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 11:49:07 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:37030 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgHUPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:48:55 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LFkv2P031470;
        Fri, 21 Aug 2020 15:48:50 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 332bsb2bft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 15:48:50 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 8EC759D;
        Fri, 21 Aug 2020 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [16.116.165.156])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id DE40F47;
        Fri, 21 Aug 2020 15:48:48 +0000 (UTC)
Date:   Fri, 21 Aug 2020 10:48:48 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
Message-ID: <20200821154848.GI7871@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=2
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..4c2143d8ae45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18874,6 +18874,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	arch/x86/platform
 
+X86 PLATFORM UV HPE SUPERDOME FLEX
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
+R:	Russ Anderson <russ.anderson@hpe.com>
+S:	Supported
+F:	arch/x86/include/asm/uv/
+F:	arch/x86/kernel/apic/x2apic_uv_x.c
+F:	arch/x86/platform/uv/
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.12.3


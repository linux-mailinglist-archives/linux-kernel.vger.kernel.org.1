Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385352C4499
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgKYQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:01:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727980AbgKYQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:01:06 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0APFvrHw009224
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:01:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=jmBFAv6Tv7d8FaSTgr0Txnnnmh/kmI8qNlpogUQf63A=;
 b=j6k2iMNwkTR4IcOPbfVXjT+S2Wgx/dca0/UNmMctUlSmlzM+4BLc37Wx7kR5Y+8PwUg6
 u+Tt09QTs6rgCXJ31LPfyAu6JLvotmPABEy1x8im4pzBdls25DsqN3x2P81mb4yo+iAG
 sVjKG9coNmtrulgkMz6qIiWTjag2QCp1bglM65zOGEhjitdWeMO5CLIFBHVGZjsAUTM3
 YxB8Mvd4QC+rIlLY6Kt4hruPF1fGDLJeJHDGn0jqwRkfGwG9QIaYCG//bj4aihaAc4rY
 yhKFEltUSakMvfCNZ00HmJ82/C46wHnUaVYnNGYEqxsKdcAXF/0v3eWQLMJ1il/A9CxI /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0hjhpbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:01:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 307FD100038
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:01:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B5F92AD2A8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 17:01:00 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov 2020 17:00:59
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Patrice Chotard <patrice.chotard@foss.st.com>
Subject: MAINTAINERS: Update ARM/STI Arch maintainer
Date:   Wed, 25 Nov 2020 17:00:49 +0100
Message-ID: <20201125160049.22260-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_09:2020-11-25,2020-11-25 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Update my email address with the one dedicated to upstream activities.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70f3c16..e9bdd7f6e1d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2488,7 +2488,7 @@ N:	sc27xx
 N:	sc2731
 
 ARM/STI ARCHITECTURE
-M:	Patrice Chotard <patrice.chotard@st.com>
+M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.stlinux.com
-- 
2.17.1


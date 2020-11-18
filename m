Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B52B8242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKRQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:48:49 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:54768 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbgKRQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:48:48 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGmVMI028833;
        Wed, 18 Nov 2020 16:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EcHFVilktMF2E05oaED2Dz/I7Xyg++eV/cmoU4aUmog=;
 b=kt+AAg7F7pbCsOfYpv7sJ5WbG6ZXAhzzw9OCgn++STwznrimJfi1KrQT2MGnprZYaqta
 dKswiKSVVR8j1eS/f/gTPCMyhAx4S15bp8RO838H2/Sq+WutgIFPAecLka8rBMgmIKnF
 NESHdDfh5WIbuQrNPIkdepq+UrYMj3khBwOSRZnFjZtTeEjWetJxc58lyvVXqlbEj9OS
 Su5txRYWb1t9bDQWgGWJE22UKn25ga1l0Cto5KIWFTy9IwY5iyVVbRArmbROxI5mZ/11
 QT+qt850BmkpLXOOY56CEuCK3LSYYtFaSr7oXvGifuXYF/T7ruenqzaVVHAhz4HO9MnD Ng== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 34vu1ywn52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:48:31 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id E09E8CD;
        Wed, 18 Nov 2020 16:48:04 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id A784237;
        Wed, 18 Nov 2020 16:48:04 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 6335B3003D756; Wed, 18 Nov 2020 10:48:04 -0600 (CST)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH v2 5/5] x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
Date:   Wed, 18 Nov 2020 10:47:47 -0600
Message-Id: <20201118164747.236259-6-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201118164747.236259-1-justin.ernst@hpe.com>
References: <20201118164747.236259-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=701 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry and email address for the new uv_sysfs driver and
its maintainer.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43b59542d15..f693d2d97203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18361,6 +18361,12 @@ F:	include/uapi/linux/uuid.h
 F:	lib/test_uuid.c
 F:	lib/uuid.c
 
+UV SYSFS DRIVER
+M:	Justin Ernst <justin.ernst@hpe.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/uv_sysfs.c
+
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
-- 
2.26.2


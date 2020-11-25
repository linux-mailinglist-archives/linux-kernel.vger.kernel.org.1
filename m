Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274EF2C4714
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgKYRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:55:18 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59988 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730749AbgKYRzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:55:16 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHss8s003665;
        Wed, 25 Nov 2020 17:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EcHFVilktMF2E05oaED2Dz/I7Xyg++eV/cmoU4aUmog=;
 b=cYuBddiUxJiv++WcIsl/VhxbLf2r7xUxZBskiAUVYo2dGKNtVYwxWrfc6bH1zPtJsDEl
 PmrngL+pU8usbZbtMgBNTMuMz/Euoz/OXIMcjl6/i3NCxXj0B76h8CDC4bp+pFfYPtYu
 Re4B9kDII8u34UMVpkB7mPtGU+UA4QZi1kakUweWwhgRJsK7hQJoA5plYidkV3vJsqPd
 r102Or5wX/wOJ4mzP73F1wAe20eTqN865bAzFvXZIwTvCGLONyejTzEhv7b4teMOrg8o
 K0sTQJ2GDO4Z7zRROrsT9C9HSWKDHUVlY7vQONOG4kmhorLMND014GenWthFN8RMq9xx fA== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 350bbqe8ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:55:02 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id EE95F8D;
        Wed, 25 Nov 2020 17:55:00 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id B9F2947;
        Wed, 25 Nov 2020 17:55:00 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 72CE8302F4806; Wed, 25 Nov 2020 11:55:00 -0600 (CST)
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
        Mike Travis <mike.travis@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>
Subject: [PATCH v3 5/5] x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
Date:   Wed, 25 Nov 2020 11:54:44 -0600
Message-Id: <20201125175444.279074-6-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201125175444.279074-1-justin.ernst@hpe.com>
References: <20201125175444.279074-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_11:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=833
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250111
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202732B705D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgKQUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:43:25 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:39362 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgKQUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:43:25 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKbc6Z018583;
        Tue, 17 Nov 2020 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=EcHFVilktMF2E05oaED2Dz/I7Xyg++eV/cmoU4aUmog=;
 b=lA+I9G3T8cNIdYrFsd83iqaS5kegyhkbmWL8n9GJtDQxlAVcMbm1Pc+ofeFeBfQfmgK4
 rnGROgjmsAxOKEAXIsecb+eanftF4dU+B9i8fUwMutf1qdcYqVispmwRD0QP74jM/n5o
 pZLKRf+QPRtif+TEqcPQqjaoZXnsqAU4wrfsWqBjRP5Jp9MmvJBy17UBRSTLsSsjnPts
 vvgvpgXVNgTg+xYweZeWCDCUGNazQpjLPnRJBrube1X3dgCapVLWF4oZe//ugwkVVg+T
 EMwyUIMt0AQbNDSLSRAPyndJJ0n4FdpeHTHUGcK6DoFNro7ekkiaRQEysv3rUOrobKuf 8A== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 34vm4g8sgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 20:42:48 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 331DE92;
        Tue, 17 Nov 2020 20:42:47 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id ED4FC4B;
        Tue, 17 Nov 2020 20:42:46 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 7E10E3003D751; Tue, 17 Nov 2020 14:42:45 -0600 (CST)
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
Subject: [PATCH 5/5] x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
Date:   Tue, 17 Nov 2020 14:42:24 -0600
Message-Id: <20201117204224.51230-6-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201117204224.51230-1-justin.ernst@hpe.com>
References: <20201117204224.51230-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=826 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170151
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0A2C4715
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKYRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:55:19 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:29562 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731890AbgKYRzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:55:18 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHs4gg020120;
        Wed, 25 Nov 2020 17:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=iVeTunY/NQ0jDyyvI/9bWZilxImkt59aI/Y9MvK21ZI=;
 b=a1FH2H/rgcG7Rgq4fLcHvS4bgkAA8/82Z8nvN/xefyFOp+ke2BjWYhsO11KvYB1V5CEb
 Nze8UzJtYqg1NXJAuJ7FZ6R9Y1cyz/SdeuO/ksS0q7HkBq/YieHd3EHUH3sc75cvak6a
 73kw6phwuOeKxwPrjx7bSWaEhY8GOsYhK6RakU27m3D7thBaY0rkW0ML4zO9ydbxfef/
 FHf3gviC0FUd5bxphzViyDxWMvZihPwUX/5BvLPZCPGaLeDkG2ChbtpFk4JdoYAffGwS
 Y+n9kleJpa39CoesuZX5TX3cSeAllpUneSQrG4gA9IQByB5zuKHBJ6j9OLH4QGmyIfio og== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 350bb4q149-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:54:53 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 3A2BE58;
        Wed, 25 Nov 2020 17:54:52 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 9437C4B;
        Wed, 25 Nov 2020 17:54:50 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 1C930302F4806; Wed, 25 Nov 2020 11:54:50 -0600 (CST)
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
Subject: [PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver
Date:   Wed, 25 Nov 2020 11:54:39 -0600
Message-Id: <20201125175444.279074-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_11:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=965 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new platform driver to gather topology information from UV systems
and expose that information via a sysfs interface at /sys/firmware/sgi_uv/.

This is version 3 with these changes since version 2:

 * Export sn_coherency_id to fix build failure when UV_SYSFS=m, caused by re-introduction
	of /sys/firmware/sgi_uv/coherence_id in v2.

 * Fix a null pointer dereference in drivers/platform/x86/uv_sysfs.c:uv_ports_exit()
	caused by calling kobject_put() on an out of range index value.

Version 2 included these changes since version 1:

 * Re-introduced /sys/firmware/sgi_uv/coherence_id file in the new driver after
	removing it in Patch 1/5. This keeps the userspace API unbroken.

Justin Ernst (5):
  x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
  x86/platform/uv: Add and export uv_bios_* functions
  x86/platform/uv: Add new uv_sysfs platform driver
  x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
  x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

 .../ABI/testing/sysfs-firmware-sgi_uv         | 141 ++-
 MAINTAINERS                                   |   6 +
 arch/x86/include/asm/uv/bios.h                |  49 +
 arch/x86/include/asm/uv/uv_geo.h              | 103 +++
 arch/x86/platform/uv/Makefile                 |   2 +-
 arch/x86/platform/uv/bios_uv.c                |  55 ++
 arch/x86/platform/uv/uv_sysfs.c               |  63 --
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/uv_sysfs.c               | 862 ++++++++++++++++++
 10 files changed, 1217 insertions(+), 78 deletions(-)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c
 create mode 100644 drivers/platform/x86/uv_sysfs.c

-- 
2.26.2


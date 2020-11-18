Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F32B8244
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKRQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:48:51 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:4008 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbgKRQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:48:50 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGmVdK028864;
        Wed, 18 Nov 2020 16:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=+DZmQvBtwmxF0Ezjhm84s/nfGojILFV3zeKPo/0gxo0=;
 b=avT5sK479ay41Lc8pBAbZ7uS0+NJXQVPQ+PoqR8rUD63kiDn/d0hBx7K3I/Ly1T3TVQc
 /n82XaPdJLcAZC0LSEmRm6N+yQES5zhoxQYjEqfdmm3cFBT2FRUPN/oUeZq1w64QM/+r
 u1RYorwqOD8ihS6tpK17A6OfQeKaxcrcOrZzlgziv6pgBk92IHlG/9sxPg1vP6Dh1Pir
 U1o4fCyaxQeSEGLKl3rH6x/F3jDqzljfl2cclebwZKEdS2U6R5Gj3H6PrHQ9jVU5NSh3
 hieXemTmUixlTMpiX8Fb2JC23MgdKWWCpCbKT87zngmJrRB4f0vDq1/iv6R1DqHJwngB ng== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com with ESMTP id 34vu1ywn4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:48:31 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 2A28C8B;
        Wed, 18 Nov 2020 16:48:00 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id B686337;
        Wed, 18 Nov 2020 16:47:57 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 2B82C302F46F9; Wed, 18 Nov 2020 10:47:57 -0600 (CST)
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
Subject: [PATCH v2 0/5] Add uv_sysfs platform driver
Date:   Wed, 18 Nov 2020 10:47:42 -0600
Message-Id: <20201118164747.236259-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=844 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new platform driver to gather topology information from UV systems
and expose that information via a sysfs interface at /sys/firmware/sgi_uv/.

This is version 2 with these changes since version 1:

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
 arch/x86/platform/uv/bios_uv.c                |  54 ++
 arch/x86/platform/uv/uv_sysfs.c               |  63 --
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/uv_sysfs.c               | 862 ++++++++++++++++++
 10 files changed, 1216 insertions(+), 78 deletions(-)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c
 create mode 100644 drivers/platform/x86/uv_sysfs.c


base-commit: 4ef8451b332662d004df269d4cdeb7d9f31419b5
-- 
2.26.2


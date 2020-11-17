Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672E42B7062
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKQUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:43:27 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:4552 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729109AbgKQUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:43:26 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKdmJY004498;
        Tue, 17 Nov 2020 20:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=Ls+jt1gf5UOuihWLIVWyKyGttnioLA3x32IvnDtSdc4=;
 b=Itn32bB3WrGoSAyNeIJ4BMY7xadxKiEJ3X6cEiiyFeGsyNAcdb3QmQwkYIESfCAxwhpk
 /LSCduxle4+5BiN5OL/utQtQrzJ4RqyEagXkhKCda5p85GkEZUkuh7Eh20sIrJ6Hfxrj
 rAmvfGx7fW0AgtYV8mbYT4gqko/FxCT4XFjYAadrUMgltGXTnYVwI963YJMRANHX/ewc
 DuJQ+D6Je+4GfBYHWbDms4aBtlEmgRP2T2aUQpe3x8LR9KJw4T1ml169ksl89g78QarA
 ViC6RDdyitIXElAIE9fdJ0NBm2qxRyvJGZEriTBGpydOXgnMuwvrCzXp9FicnifooRL6 6Q== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vjdkhx1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 20:42:47 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id D24898D;
        Tue, 17 Nov 2020 20:42:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E66FA4D;
        Tue, 17 Nov 2020 20:42:45 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 7026A302F46F9; Tue, 17 Nov 2020 14:42:45 -0600 (CST)
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
Subject: [PATCH 0/5] Add uv_sysfs platform driver
Date:   Tue, 17 Nov 2020 14:42:19 -0600
Message-Id: <20201117204224.51230-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 adultscore=0
 mlxlogscore=843 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new platform driver to gather topology information from UV systems
and expose that information via a sysfs interface at /sys/firmware/sgi_uv/.

Justin Ernst (5):
  x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
  x86/platform/uv: Add and export uv_bios_* functions
  x86/platform/uv: Add new uv_sysfs platform driver
  x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
  x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

 .../ABI/testing/sysfs-firmware-sgi_uv         | 137 ++-
 MAINTAINERS                                   |   6 +
 arch/x86/include/asm/uv/bios.h                |  49 +
 arch/x86/include/asm/uv/uv_geo.h              | 103 +++
 arch/x86/platform/uv/Makefile                 |   2 +-
 arch/x86/platform/uv/bios_uv.c                |  54 ++
 arch/x86/platform/uv/uv_sysfs.c               |  63 --
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/uv_sysfs.c               | 853 ++++++++++++++++++
 10 files changed, 1202 insertions(+), 79 deletions(-)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h
 delete mode 100644 arch/x86/platform/uv/uv_sysfs.c
 create mode 100644 drivers/platform/x86/uv_sysfs.c


base-commit: 4ef8451b332662d004df269d4cdeb7d9f31419b5
-- 
2.26.2


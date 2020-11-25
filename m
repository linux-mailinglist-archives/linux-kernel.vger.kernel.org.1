Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C913D2C46D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbgKYR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:29:59 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:39614 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731392AbgKYR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:29:59 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHNFFI011180;
        Wed, 25 Nov 2020 17:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=vMFsukLmPFGOSpxBc3MkWPR8cKi5TEO9P3KVrbjJmgk=;
 b=P+0RVlyb7WFCfosip5U8robFihi3Q3co5/Hju0M2kwXicBlEV54y7qpNF0Vugy7Xvilx
 27gCQ8BrnJGFpXttZrTpeHYDoPZXKMS77Izl3HR3jMWg1XnuQPENwfIbJKXpJLARMvWu
 V47qy6Xp3Ptzf3L1KpMkkYwBigKXNAu5VEX7PLPp5x5KR+GdRkT6kCVCGRoKqMpDuLeN
 e1tEW9vG6Zh55H9FjatBIin2e3Wtyzcb9BgBST+HF6xkjd9NjrsH/MripmiZ0nbYavGJ
 GUP8EmOq1LMTW3X5V+s+SUIm3xrYQ5lEnMhrCSrvGZdEXbQUegLNJGo2jC1bLbK5eixg 7A== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 351kdb48j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:29 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 3FFD4A3;
        Wed, 25 Nov 2020 17:29:28 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 951B137;
        Wed, 25 Nov 2020 17:29:26 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/5] x86/platform/uv: Move UV procfs leaves to sysfs
Date:   Wed, 25 Nov 2020 11:29:02 -0600
Message-Id: <20201125172907.240996-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=784 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011250109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Duplicate the current UV procfs leaves to the uv_sysfs driver so they show
up under /sys/firmware/sgi_uv.  Show a 'deprecated' warning message if
any of the old /proc/sgi_uv leaves are used.

These patches depend on the prior set sent by Justin Ernst <justin.ernst@hpe.com>
	x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
	x86/platform/uv: Add and export uv_bios_* functions
	x86/platform/uv: Add new uv_sysfs platform driver
	x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

Mike Travis (5):
  x86/platform/uv: Add kernel interfaces for obtaining system info.
  x86/platform/uv: Add sysfs leaves to replace those in procfs
  x86/platform/uv: Add sysfs hubless leaves
  x86/platform/uv: Add deprecated messages to /proc info leaves
  x86/platform/uv: Update sysfs document file

 .../ABI/testing/sysfs-firmware-sgi_uv         | 16 +++++
 arch/x86/include/asm/uv/bios.h                |  2 +
 arch/x86/kernel/apic/x2apic_uv_x.c            | 38 +++++++++-
 drivers/platform/x86/uv_sysfs.c               | 70 ++++++++++++++++++-
 4 files changed, 123 insertions(+), 3 deletions(-)

-- 
2.21.0


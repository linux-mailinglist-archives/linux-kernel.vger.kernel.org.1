Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1232C6EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgK1EKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:10:41 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:16262 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728995AbgK1Dnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:43:45 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3gjfk012056;
        Sat, 28 Nov 2020 03:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=Hq7vVDkPopPOQ+EyapHllM/37K3mdzGlZN6i17/WXlQ=;
 b=UHLaadvF5zMzLxgtaaEHiy+p04XtzTts1wJBB42QB0Q+2ZkpkjcpWqfr/b3EWRYoPLW+
 Z4yZaspyV4crW7/j4ndfGG+duQxpcYGLWO5dA31HAu3QTQW9krECYhmVlweeJ6a0KGaa
 mMKGe+Npot2V0FeXCO1I3ulXi7M2w/QDJ6p9OkEzEkmuiDEJqcWviScaVXRgyHh1EUJp
 H20fRww1ehiENGlh+q3WgIPMoItDGhNGYMa7jOVJgQGhVGiflKVqI7d9HjLcdbuXiMOZ
 36fRolf7EzZYOSDr/edG+tJ3qX+g0BxfLUISnLnwSqbQqaOAjg/dWvQFz+vaPCCiCziF xA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 351hp4r5mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 03:42:52 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 411F05C;
        Sat, 28 Nov 2020 03:42:51 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C4A704A;
        Sat, 28 Nov 2020 03:42:49 +0000 (UTC)
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
Subject: [PATCH v2 0/5] x86/platform/uv: Move UV procfs leaves to sysfs
Date:   Fri, 27 Nov 2020 21:42:22 -0600
Message-Id: <20201128034227.120869-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=897 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011280025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Duplicate the current UV procfs leaves to the uv_sysfs driver so they show
up under /sys/firmware/sgi_uv.  Show a 'deprecated' warning message if
any of the old /proc/sgi_uv leaves are used.

These patches depend on the prior v3 patchset sent by Justin Ernst <justin.ernst@hpe.com>
	x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
	x86/platform/uv: Add and export uv_bios_* functions
	x86/platform/uv: Add new uv_sysfs platform driver
	x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

v2: Updated to apply to v3 of dependency patch set listed above.

Mike Travis (5):
  x86/platform/uv: Add kernel interfaces for obtaining system info.
  x86/platform/uv: Add sysfs leaves to replace those in procfs
  x86/platform/uv: Add sysfs hubless leaves
  x86/platform/uv: Add deprecated messages to /proc info leaves
  x86/platform/uv: Update sysfs document file

 .../ABI/testing/sysfs-firmware-sgi_uv         | 16 +++++
 arch/x86/include/asm/uv/bios.h                |  2 +
 arch/x86/kernel/apic/x2apic_uv_x.c            | 26 ++++++-
 drivers/platform/x86/uv_sysfs.c               | 70 ++++++++++++++++++-
 4 files changed, 111 insertions(+), 3 deletions(-)

-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEBA2C9031
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgK3Vog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:44:36 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:12780 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730238AbgK3Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:44:35 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AULSO0F013431;
        Mon, 30 Nov 2020 21:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=ybSDlG7N0JuViiD+kbiVP+l/5BYoQGkcruzsYPFStAs=;
 b=JQyznB+0VTxZcRE9MlAtaL0+sSuttuON++RuWLRA/m+0yMPit0w3ytO1aIIeq0E1pVIg
 1onw4kQwsLdLk5JNCiQd++C+L6Fq2kApmhNy+HE3ZtfSXP0wir7I6DGe/vsSwTQP4PEt
 jIX1ZAXI+UV3z2fb3UBQrLNbi+yS+gXrbPcCeId01at3Fspc51Cy3qIZBHVjd9/YUWda
 GUv4A1W2x8pgorsCA9uExofAXeS94ea9knqQJcnhzUuYKGK4GIiRIhhgaMQNLrBEVNV4
 o3CZhHB5hoBkxXjUWaLT5C7moaWXwD3GLFK7xP+PRthLObvClv2oR4bEAK9LLbGE/aWe Gg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 353f73hsdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 21:43:13 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 977E54F;
        Mon, 30 Nov 2020 21:43:12 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id B1A7645;
        Mon, 30 Nov 2020 21:43:11 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 43F68302F4721; Mon, 30 Nov 2020 15:43:11 -0600 (CST)
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
Subject: [PATCH] x86/platform/uv: Fix/cleanup ABI documentation of /sys/firmware/sgi_uv/
Date:   Mon, 30 Nov 2020 15:43:04 -0600
Message-Id: <20201130214304.369348-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_11:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of commit
7ac2f1017115 ("x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/")

3 new warnings were reported from the htmldocs build:
Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.

The line number seems to be irrelevant to the location of the cause for warning.
Three new empty lines were added before codeblock sections to remove the warnings.

Lines directly before codeblock sections with one ':' get a second ':' to match
required formating.

Change an 'If' to 'It'.

This patch depends on a patch in the prior v2 patchset sent by Mike Travis <mike.travis@hpe.com>
	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 .../ABI/testing/sysfs-firmware-sgi_uv         | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 1994d2621eaa..62aeb2a023f1 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -5,7 +5,7 @@ Description:
 		The /sys/firmware/sgi_uv directory contains information
 		about the UV platform.
 
-		Under that directory are a number of read-only attributes:
+		Under that directory are a number of read-only attributes::
 
 			archtype
 			hub_type
@@ -16,7 +16,7 @@ Description:
 
 		The archtype entry contains the UV architecture type that
 		is used to select arch-dependent addresses and features.
-		If can be set via the OEM_ID in the ACPI MADT table or by
+		It can be set via the OEM_ID in the ACPI MADT table or by
 		UVsystab entry both passed from UV BIOS.
 
 		The hub_type entry is used to select the type of hub which is
@@ -38,7 +38,8 @@ Description:
 		this partition is in.
 
 		The uv_type entry contains the hub revision number.
-		This value can be used to identify the UV system version:
+		This value can be used to identify the UV system version::
+
 			"0.*" = Hubless UV ('*' is subtype)
 			"3.0" = UV2
 			"5.0" = UV3
@@ -46,7 +47,7 @@ Description:
 			"7.1" = UV4a
 			"9.0" = UV5
 
-		The /sys/firmware/sgi_uv directory also contains two directories:
+		The /sys/firmware/sgi_uv directory also contains two directories::
 
 			hubs/
 			pcibuses/
@@ -55,7 +56,7 @@ Description:
 		a UV Hub visible to the BIOS. Each hub object's name is appended by a
 		unique ordinal value (ex. /sys/firmware/sgi_uv/hubs/hub_5)
 
-		Each hub object directory contains a number of read-only attributes:
+		Each hub object directory contains a number of read-only attributes::
 
 			cnode
 			location
@@ -71,13 +72,15 @@ Description:
 		This value is used to physically identify a hub within a system.
 
 		The name entry contains the name of the corresponding hub. This name can
-		be two variants:
+		be two variants::
+
 			"UVHub x.x" = A 'node' ASIC, connecting a CPU to the interconnect
-				fabric. The 'x.x' value represents the ASIC revision.
-				(ex. 'UVHub 5.0')
+			fabric. The 'x.x' value represents the ASIC revision.
+			(ex. 'UVHub 5.0')
+
 			"NLxRouter" = A 'router ASIC, only connecting other ASICs to
-				the interconnect fabric. The 'x' value representing
-				the fabric technology version. (ex. 'NL8Router')
+			the interconnect fabric. The 'x' value representing
+			the fabric technology version. (ex. 'NL8Router')
 
 		The nasid entry contains the nasid number of the corresponding hub.
 		If a nasid value is not applicable, the value returned will be -1.
@@ -93,7 +96,7 @@ Description:
 		A port object's name is appended by a unique ordinal value
 		(ex. /sys/firmware/sgi_uv/hubs/hub_5/port_3)
 
-		Each port object directory contains a number of read-only attributes:
+		Each port object directory contains a number of read-only attributes::
 
 			conn_hub
 			conn_port
@@ -116,14 +119,13 @@ Description:
 				/sys/firmware/sgi_uv/hubs/hub_5/port_3/conn_port
 
 			representing that this port is connected to:
-			/sys/firmware/sgi_uv/hubs/hub_3/port_6
-
+				/sys/firmware/sgi_uv/hubs/hub_3/port_6
 
 		The pcibuses directory contains a number of PCI bus objects.
 		Each PCI bus object's name is appended by its PCI bus address.
 		(ex. pcibus_0003:80)
 
-		Each pcibus object has a number of possible read-only attributes:
+		Each pcibus object has a number of possible read-only attributes::
 
 			type
 			location
@@ -133,7 +135,8 @@ Description:
 
 		The type entry contains a value describing the type of IO at
 		the corresponding PCI bus address. Known possible values
-		across all UV versions are:
+		across all UV versions are::
+
 			BASE IO
 			PCIe IO
 			PCIe SLOT
-- 
2.26.2


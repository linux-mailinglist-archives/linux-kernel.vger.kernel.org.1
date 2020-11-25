Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA842C46CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgKYRaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:30:03 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:33500 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730816AbgKYRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:30:00 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APHL1ur018188;
        Wed, 25 Nov 2020 17:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=O/0ENDeFJZBzMlYwPobTmm1A3y4WVZizdDsswzTZ6/Q=;
 b=C3jJ48rIso5KNRXA7XIEI+KDJr+7YmHZr0lMAccuVonFTGl8NROZyEo19FHaWzYX9cpd
 sv/7H7MsbwHaNTz6rLPC76TDBozZA4CnUCbTC6LxNQaU1AWjNSb8Htim4hlnuax0RpeI
 7cdRT4GPNg7wxVCS+UCUHIpma6slZjPtSur+NHJOmUC/KrUM87oIDiZ4L1N/unoH6DYg
 vVikEj3QOXuxGvNFQMAcrvVSbzkYyvX6gyIEqv0LSjWIkIwO49d4Gu5TFGPtLgmY9W4z
 4/jxF0zMcUKbrh9i/KlgZVKuAINqJwHIqfY7D902pue9tzOlictcgiPmg3S6XUcXNPyK ww== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 351mb6uytr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 17:29:42 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 033D099;
        Wed, 25 Nov 2020 17:29:42 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 14ACE37;
        Wed, 25 Nov 2020 17:29:41 +0000 (UTC)
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
Subject: [PATCH 5/5] x86/platform/uv: Update sysfs document file
Date:   Wed, 25 Nov 2020 11:29:07 -0600
Message-Id: <20201125172907.240996-6-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
References: <20201125172907.240996-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_10:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=998 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update sysfs Document file to include moved /proc leaves.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index ca5cdccdb1a8..fa7f7aefa5ed 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -7,9 +7,24 @@ Description:
 
 		Under that directory are a number of read-only attributes:
 
+			archtype
+			hub_type
+			hubless
 			partition_id
 			uv_type
 
+		The archtype entry contains the UV architecture type that
+		is used to select arch-dependent addresses and features.
+		If can be set via the OEM_ID in the ACPI MADT table or by
+		UVsystab entry both passed from UV BIOS.
+
+		The hub_type entry is used to select the type of hub which is
+		similar to uv_type but encoded in a binary format.  Include
+		the file uv_hub.h to get the definitions.
+
+		The hubless entry basically is present and set only if there
+		is no hub.  In this case the hub_type entry is not present.
+
 		The partition_id entry contains the partition id.
 		UV systems can be partitioned into multiple physical
 		machines, which each partition running a unique copy
@@ -18,6 +33,7 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version:
+			"0.*" = Hubless UV ('*' is subtype)
 			"3.0" = UV2
 			"5.0" = UV3
 			"7.0" = UV4
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA21F2C6ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgK1Eoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:44:37 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:62980 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732638AbgK1Ei7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 23:38:59 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AS3bvQA009187;
        Sat, 28 Nov 2020 03:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=FWpz/L2QkNHyC0k3/MK2OtHHRD2xULsRooOrzezouaM=;
 b=MfrParZgxd9Ywu9MQY9g1syz7nBYZk5NBvqM8PIzRDLcR1rkZCALJz5aiUsiiTKx185j
 VbE1Zv/nBWhU2lZnNvRO43FsqmJQn1RW0nGjeueEmAaKhFEEUvR5cEs3r6vY+lMYK9hb
 Y1kp5nfk90bkeyup5JPVPIeXLainZloiN6mjxwzkH/QZeeJKAAoTu1YfJH6jFtRM7ciq
 uyjL8fHglYrBl59iL6oC3OXHFuQqiSiIz0WlFnTLvwXSIACChPOOkvDrTNjfUOzwaFzW
 cjZ+fXIKuTXGzE5GM68t/xv2bmKDMezgRwS5/sX7YaBAqXgfnp2T1KtPxaoPe1NLL6nZ qw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3532m2m0dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 03:42:58 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 2702565;
        Sat, 28 Nov 2020 03:42:58 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 2983A48;
        Sat, 28 Nov 2020 03:42:57 +0000 (UTC)
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
Subject: [PATCH v2 5/5] x86/platform/uv: Update sysfs document file
Date:   Fri, 27 Nov 2020 21:42:27 -0600
Message-Id: <20201128034227.120869-6-mike.travis@hpe.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201128034227.120869-1-mike.travis@hpe.com>
References: <20201128034227.120869-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_02:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update sysfs Document file to include moved /proc leaves.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 50e25ce80fa2..b377f1470ba2 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -7,10 +7,25 @@ Description:
 
 		Under that directory are a number of read-only attributes:
 
+			archtype
+			hub_type
+			hubless
 			partition_id
 			coherence_id
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
@@ -24,6 +39,7 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version:
+			"0.*" = Hubless UV ('*' is subtype)
 			"3.0" = UV2
 			"5.0" = UV3
 			"7.0" = UV4
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F962B823A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgKRQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:48:31 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42574 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbgKRQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:48:29 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIGlcmx002999;
        Wed, 18 Nov 2020 16:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=boUaJnwhVVsBWBNIQWdePYq6dlXfL7IQd85r1LB/DAQ=;
 b=TrO1s83U85KUJjy5BjVILUPjgKRUUabPFKlZRJljOzy6JVb7AHNq9z6pE42lpthkhc+l
 UhvckXunYTM1FdscajjGHaLxYSW0koVeM0QIrQYytZbAhQxh7RNSzThO95EWPNesUen+
 WJkClw70pwGGqJ9Kwl2UxnsSUvsfwf4LBoDzWHHtDPyc5uQw4PflTYeOnzK9ZCB4DIQ7
 qB4EJGw6gS9f0thPJGgheXX1QBRwpIY4ubUDdci4M7tKszNvH34rj33LBwQ8aWnU4VzI
 259yB7+vu3Wa3kb3Mzo6WXzBvxNxjnXAp5nzCmjup1yF1AqRnN5lZbXlyc9x3s3q5tVQ cA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 34vm4ggeuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 16:48:05 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id B865AC7;
        Wed, 18 Nov 2020 16:48:03 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 7BC1737;
        Wed, 18 Nov 2020 16:48:03 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 3795E3003D756; Wed, 18 Nov 2020 10:48:03 -0600 (CST)
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
Subject: [PATCH v2 4/5] x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
Date:   Wed, 18 Nov 2020 10:47:46 -0600
Message-Id: <20201118164747.236259-5-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201118164747.236259-1-justin.ernst@hpe.com>
References: <20201118164747.236259-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ABI documentation to describe the sysfs interface provided by
the new uv_sysfs platform driver.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 .../ABI/testing/sysfs-firmware-sgi_uv         | 141 ++++++++++++++++--
 1 file changed, 127 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 66800baab096..50e25ce80fa2 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -1,27 +1,140 @@
 What:		/sys/firmware/sgi_uv/
-Date:		August 2008
-Contact:	Russ Anderson <rja@sgi.com>
+Date:		September 2020
+Contact:	Justin Ernst <justin.ernst@hpe.com>
 Description:
 		The /sys/firmware/sgi_uv directory contains information
-		about the SGI UV platform.
+		about the UV platform.
 
-		Under that directory are a number of files::
+		Under that directory are a number of read-only attributes:
 
 			partition_id
 			coherence_id
+			uv_type
 
 		The partition_id entry contains the partition id.
-		SGI UV systems can be partitioned into multiple physical
+		UV systems can be partitioned into multiple physical
 		machines, which each partition running a unique copy
-		of the operating system.  Each partition will have a unique
-		partition id.  To display the partition id, use the command::
-
-			cat /sys/firmware/sgi_uv/partition_id
+		of the operating system. Each partition will have a unique
+		partition id.
 
 		The coherence_id entry contains the coherence id.
-		A partitioned SGI UV system can have one or more coherence
-		domain.  The coherence id indicates which coherence domain
-		this partition is in.  To display the coherence id, use the
-		command::
+		A partitioned UV system can have one or more coherence
+		domains. The coherence id indicates which coherence domain
+		this partition is in.
+
+		The uv_type entry contains the hub revision number.
+		This value can be used to identify the UV system version:
+			"3.0" = UV2
+			"5.0" = UV3
+			"7.0" = UV4
+			"7.1" = UV4a
+			"9.0" = UV5
+
+		The /sys/firmware/sgi_uv directory also contains two directories:
+
+			hubs/
+			pcibuses/
+
+		The hubs directory contains a number of hub objects, each representing
+		a UV Hub visible to the BIOS. Each hub object's name is appended by a
+		unique ordinal value (ex. /sys/firmware/sgi_uv/hubs/hub_5)
+
+		Each hub object directory contains a number of read-only attributes:
+
+			cnode
+			location
+			name
+			nasid
+			shared
+			this_partition
+
+		The cnode entry contains the cnode number of the corresponding hub.
+		If a cnode value is not applicable, the value returned will be -1.
+
+		The location entry contains the location string of the corresponding hub.
+		This value is used to physically identify a hub within a system.
+
+		The name entry contains the name of the corresponding hub. This name can
+		be two variants:
+			"UVHub x.x" = A 'node' ASIC, connecting a CPU to the interconnect
+				fabric. The 'x.x' value represents the ASIC revision.
+				(ex. 'UVHub 5.0')
+			"NLxRouter" = A 'router ASIC, only connecting other ASICs to
+				the interconnect fabric. The 'x' value representing
+				the fabric technology version. (ex. 'NL8Router')
+
+		The nasid entry contains the nasid number of the corresponding hub.
+		If a nasid value is not applicable, the value returned will be -1.
+
+		The shared entry contains a boolean value describing whether the
+		corresponding hub is shared between system partitions.
+
+		The this_partition entry contains a boolean value describing whether
+		the corresponding hub is local to the current partition.
+
+		Each hub object directory also contains a number of port objects,
+		each representing a fabric port on the corresponding hub.
+		A port object's name is appended by a unique ordinal value
+		(ex. /sys/firmware/sgi_uv/hubs/hub_5/port_3)
+
+		Each port object directory contains a number of read-only attributes:
+
+			conn_hub
+			conn_port
+
+		The conn_hub entry contains a value representing the unique
+		oridinal value of the hub on the other end of the fabric
+		cable plugged into the port. If the port is disconnected,
+		the value returned will be -1.
+
+		The conn_port entry contains a value representing the unique
+		oridinal value of the port on the other end of the fabric cable
+		plugged into the port. If the port is disconnected, the value
+		returned will be -1.
+
+		Ex:
+			A value of '3' is read from:
+				/sys/firmware/sgi_uv/hubs/hub_5/port_3/conn_hub
+
+			and a value of '6' is read from:
+				/sys/firmware/sgi_uv/hubs/hub_5/port_3/conn_port
+
+			representing that this port is connected to:
+			/sys/firmware/sgi_uv/hubs/hub_3/port_6
+
+
+		The pcibuses directory contains a number of PCI bus objects.
+		Each PCI bus object's name is appended by its PCI bus address.
+		(ex. pcibus_0003:80)
+
+		Each pcibus object has a number of possible read-only attributes:
+
+			type
+			location
+			slot
+			ppb_addr
+			iio_stack
+
+		The type entry contains a value describing the type of IO at
+		the corresponding PCI bus address. Known possible values
+		across all UV versions are:
+			BASE IO
+			PCIe IO
+			PCIe SLOT
+			NODE IO
+			Riser
+			PPB
+
+		The location entry contains the location string of the UV Hub
+		of the CPU physically connected to the corresponding PCI bus.
+
+		The slot entry contains the physical slot number of the
+		corresponding PCI bus. This value is used to physically locate
+		PCI cards within a system.
+
+		The ppb_addr entry contains the PCI address string of the
+		bridged PCI bus. This entry is only present when the PCI bus
+		object type is 'PPB'.
 
-			cat /sys/firmware/sgi_uv/coherence_id
+		The iio_stack entry contains a value describing the IIO stack
+		number that the corresponding PCI bus object is connected to.
-- 
2.26.2


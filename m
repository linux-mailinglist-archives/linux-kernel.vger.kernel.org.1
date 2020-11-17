Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758682B7060
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgKQUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:43:26 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:41210 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbgKQUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:43:25 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKba1W016197;
        Tue, 17 Nov 2020 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=wKSLsrimC0jJ2fzFvjXdpxrW+JvDXwqZ32X+WzALMns=;
 b=VIPtcuFDCQZl88Gj7nSQrGx1+UC789IWybH/B9xi6ji46xDGum92j7vRDgHWSGklUaNt
 iFy7AzoK2QRgHPM2n/98XCQ/mjU7uhJbrPoJpIW1KDkIH4djtbDtfIjiYTv1UJ9Z3MSx
 biSkIMgBkvO8ydUlplEAP98T47M3iWjHjbibATCKzi6eGmwiyhTkpiW+QBm3duN6quxT
 FBz11u7yxchA/0dpP++rALF1kdL6qv+WoI4TMz8tdWn3spM4Kza464RqbBlYmFVmFish
 E8RfYrzgYE4yPnnUONPB/qQczjE4PzRraGIKuqtFbb4h4VZq1XMTDw5ACA1oZM2K2t80 PQ== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 34tsaf6407-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 20:42:47 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id C4D8BA5;
        Tue, 17 Nov 2020 20:42:46 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E63964C;
        Tue, 17 Nov 2020 20:42:45 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 7B1F83003D750; Tue, 17 Nov 2020 14:42:45 -0600 (CST)
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
Subject: [PATCH 4/5] x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
Date:   Tue, 17 Nov 2020 14:42:23 -0600
Message-Id: <20201117204224.51230-5-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201117204224.51230-1-justin.ernst@hpe.com>
References: <20201117204224.51230-1-justin.ernst@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ABI documentation to describe the sysfs interface provided by
the new uv_sysfs platform driver.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 .../ABI/testing/sysfs-firmware-sgi_uv         | 137 ++++++++++++++++--
 1 file changed, 122 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 66800baab096..ca5cdccdb1a8 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -1,27 +1,134 @@
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
-			coherence_id
+			uv_type
 
 		The partition_id entry contains the partition id.
-		SGI UV systems can be partitioned into multiple physical
+		UV systems can be partitioned into multiple physical
 		machines, which each partition running a unique copy
-		of the operating system.  Each partition will have a unique
-		partition id.  To display the partition id, use the command::
+		of the operating system. Each partition will have a unique
+		partition id.
 
-			cat /sys/firmware/sgi_uv/partition_id
+		The uv_type entry contains the hub revision number.
+		This value can be used to identify the UV system version:
+			"3.0" = UV2
+			"5.0" = UV3
+			"7.0" = UV4
+			"7.1" = UV4a
+			"9.0" = UV5
 
-		The coherence_id entry contains the coherence id.
-		A partitioned SGI UV system can have one or more coherence
-		domain.  The coherence id indicates which coherence domain
-		this partition is in.  To display the coherence id, use the
-		command::
+		The /sys/firmware/sgi_uv directory also contains two directories:
 
-			cat /sys/firmware/sgi_uv/coherence_id
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
+
+		The iio_stack entry contains a value describing the IIO stack
+		number that the corresponding PCI bus object is connected to.
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E392EF4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhAHPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:37:03 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:4718 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbhAHPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:37:03 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108FTjEm031569;
        Fri, 8 Jan 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=ojPQdFqYZjqZIawkZaPrBA2l6yZxhKoYEDamdc8m1Io=;
 b=F9GryLE0YsGDDUkITN21NkBKAct2woxqFCPn1TirmMGaGRO36YjoaCxOtE6M4lMIO+mp
 1j0y7EiGlKnpNg//ZW8B7RO8Arrdh6DmT8mLKkHN8QD2IdChCEWrnW+Ujry2xMbL9gVO
 5QOKn58+MMh4DHZG9m3HI9OrJiactLVgK++UpHaMYOGInaCUxQQef1vWqkexTRVrTOwh
 F5nGxupP3LZ2RwVm/bwU5xBw+4o6O36ogUXNooRa8ycl7C2X/8GvOxlRMrbPjQbRO1a9
 inUmYvksL0BgFxVVYNlOTVhYahoizycyZW6EOVKD5WXWgQ/OR7GaDxoRbtFLeAmMk71X mg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 35xnrxsttm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 15:35:52 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id BF4F577;
        Fri,  8 Jan 2021 15:35:51 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 43DCE3A;
        Fri,  8 Jan 2021 15:35:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C23FF8B0EE; Fri,  8 Jan 2021 09:35:49 -0600 (CST)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>, rja_direct@groups.int.hpe.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     "Liang, Kan" <kan.liang@intel.com>
Subject: [PATCH 2/2] perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info
Date:   Fri,  8 Jan 2021 09:35:49 -0600
Message-Id: <20210108153549.108989-3-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108153549.108989-1-steve.wahl@hpe.com>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_07:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The registers used to determine which die a pci bus belongs to don't
contain enough information to uniquely specify more than 8 dies, so
when more than 8 dies are present, use NUMA information instead.

Continue to use the previous method for 8 or fewer because it
works there, and covers cases of NUMA being disabled.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/events/intel/uncore_snbep.c | 93 +++++++++++++++++++---------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2d7014dc46f6..b79951d0707c 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1370,40 +1370,77 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		if (!ubox_dev)
 			break;
 		bus = ubox_dev->bus->number;
-		/* get the Node ID of the local register */
-		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
-		if (err)
-			break;
-		nodeid = config & NODE_ID_MASK;
-		/* get the Node ID mapping */
-		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
-		if (err)
-			break;
+		/*
+		 * The nodeid and idmap registers only contain enough
+		 * information to handle 8 nodes.  On systems with more
+		 * than 8 nodes, we need to rely on NUMA information,
+		 * filled in from BIOS supplied information, to determine
+		 * the topology.
+		 */
+		if (nr_node_ids <= 8) {
+			/* get the Node ID of the local register */
+			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
+			if (err)
+				break;
+			nodeid = config & NODE_ID_MASK;
+			/* get the Node ID mapping */
+			err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
+			if (err)
+				break;
 
-		segment = pci_domain_nr(ubox_dev->bus);
-		raw_spin_lock(&pci2phy_map_lock);
-		map = __find_pci2phy_map(segment);
-		if (!map) {
+			segment = pci_domain_nr(ubox_dev->bus);
+			raw_spin_lock(&pci2phy_map_lock);
+			map = __find_pci2phy_map(segment);
+			if (!map) {
+				raw_spin_unlock(&pci2phy_map_lock);
+				err = -ENOMEM;
+				break;
+			}
+
+			/*
+			 * every three bits in the Node ID mapping register maps
+			 * to a particular node.
+			 */
+			for (i = 0; i < 8; i++) {
+				if (nodeid == ((config >> (3 * i)) & 0x7)) {
+					if (topology_max_die_per_package() > 1)
+						die_id = i;
+					else
+						die_id = topology_phys_to_logical_pkg(i);
+					map->pbus_to_dieid[bus] = die_id;
+					break;
+				}
+			}
 			raw_spin_unlock(&pci2phy_map_lock);
-			err = -ENOMEM;
-			break;
-		}
+		} else {
+			int node = pcibus_to_node(ubox_dev->bus);
+			int cpu;
+
+			segment = pci_domain_nr(ubox_dev->bus);
+			raw_spin_lock(&pci2phy_map_lock);
+			map = __find_pci2phy_map(segment);
+			if (!map) {
+				raw_spin_unlock(&pci2phy_map_lock);
+				err = -ENOMEM;
+				break;
+			}
 
-		/*
-		 * every three bits in the Node ID mapping register maps
-		 * to a particular node.
-		 */
-		for (i = 0; i < 8; i++) {
-			if (nodeid == ((config >> (3 * i)) & 0x7)) {
-				if (topology_max_die_per_package() > 1)
-					die_id = i;
-				else
-					die_id = topology_phys_to_logical_pkg(i);
-				map->pbus_to_dieid[bus] = die_id;
+			die_id = -1;
+			for_each_cpu(cpu, cpumask_of_pcibus(ubox_dev->bus)) {
+				struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+				if (c->initialized && cpu_to_node(cpu) == node) {
+					map->pbus_to_dieid[bus] = die_id = c->logical_die_id;
+					break;
+				}
+			}
+			raw_spin_unlock(&pci2phy_map_lock);
+
+			if (WARN_ON_ONCE(die_id == -1)) {
+				err = -EINVAL;
 				break;
 			}
 		}
-		raw_spin_unlock(&pci2phy_map_lock);
 	}
 
 	if (!err) {
-- 
2.26.2


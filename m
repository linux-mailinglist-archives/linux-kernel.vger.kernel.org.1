Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04A2EF4F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbhAHPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:37:06 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:29724 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbhAHPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:37:05 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108FStEt007605;
        Fri, 8 Jan 2021 15:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=OFIJHQ47QjlgHlb6yf9nx137Tc8rxjjJoqCct97VcuY=;
 b=FzOa8Cf7T4rlU7rr9xdxnpzHUhcuFQ/LvSZx5CA+Af1aDdYqt/Ga45AnY2im1aS44acM
 upjEbPpsHKIZLYedyNz635vx418awzC7VCKeb54mQc6LSYiKu0OLbs08iUKR/IXjIGtf
 lxch1yqgcNY2Jf0/r8+9377HxnFy1UiU5smyG48hIS5uWTHOvq6kHtmsVJJnyoS7V7lr
 lFE3Y65R4cK6V+rTfBkSoQ2Km89DjLgMbbSAKJtPpcMvwFiKYSnulSO0uGwScWc3sIGd
 JFYB07CyyYyM/NFncvnUYAR5js+B5Gilx2rAtqefI8zcXOVtHzF6vFfVg1NJm1JTzukM Yg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 35xprk1fk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 15:35:52 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id B495465;
        Fri,  8 Jan 2021 15:35:51 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 43E583D;
        Fri,  8 Jan 2021 15:35:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C171B8B0ED; Fri,  8 Jan 2021 09:35:49 -0600 (CST)
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
Subject: [PATCH 1/2] perf/x86/intel/uncore: Store the logical die id instead of the physical die id.
Date:   Fri,  8 Jan 2021 09:35:48 -0600
Message-Id: <20210108153549.108989-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210108153549.108989-1-steve.wahl@hpe.com>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_07:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phys_id isn't really used other than to map to a logical die id.
Calculate the logical die id earlier, and store that instead of the
phys_id.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/events/intel/uncore.c       | 58 ++++++++++------------------
 arch/x86/events/intel/uncore.h       |  5 +--
 arch/x86/events/intel/uncore_snb.c   |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 31 +++++++--------
 4 files changed, 39 insertions(+), 57 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 357258f82dc8..33c8180d5a87 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -31,21 +31,21 @@ struct event_constraint uncore_constraint_empty =
 
 MODULE_LICENSE("GPL");
 
-int uncore_pcibus_to_physid(struct pci_bus *bus)
+int uncore_pcibus_to_dieid(struct pci_bus *bus)
 {
 	struct pci2phy_map *map;
-	int phys_id = -1;
+	int die_id = -1;
 
 	raw_spin_lock(&pci2phy_map_lock);
 	list_for_each_entry(map, &pci2phy_map_head, list) {
 		if (map->segment == pci_domain_nr(bus)) {
-			phys_id = map->pbus_to_physid[bus->number];
+			die_id = map->pbus_to_dieid[bus->number];
 			break;
 		}
 	}
 	raw_spin_unlock(&pci2phy_map_lock);
 
-	return phys_id;
+	return die_id;
 }
 
 static void uncore_free_pcibus_map(void)
@@ -86,7 +86,7 @@ struct pci2phy_map *__find_pci2phy_map(int segment)
 	alloc = NULL;
 	map->segment = segment;
 	for (i = 0; i < 256; i++)
-		map->pbus_to_physid[i] = -1;
+		map->pbus_to_dieid[i] = -1;
 	list_add_tail(&map->list, &pci2phy_map_head);
 
 end:
@@ -332,7 +332,6 @@ static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 
 	uncore_pmu_init_hrtimer(box);
 	box->cpu = -1;
-	box->pci_phys_id = -1;
 	box->dieid = -1;
 
 	/* set default hrtimer timeout */
@@ -993,18 +992,11 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 /*
  * Get the die information of a PCI device.
  * @pdev: The PCI device.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
-static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
-				       int *phys_id, int *die)
+static int uncore_pci_get_dev_die_info(struct pci_dev *pdev, int *die)
 {
-	*phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (*phys_id < 0)
-		return -ENODEV;
-
-	*die = (topology_max_die_per_package() > 1) ? *phys_id :
-				topology_phys_to_logical_pkg(*phys_id);
+	*die = uncore_pcibus_to_dieid(pdev->bus);
 	if (*die < 0)
 		return -EINVAL;
 
@@ -1046,13 +1038,12 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
  * @pdev: The PCI device.
  * @type: The corresponding PMU type of the device.
  * @pmu: The corresponding PMU of the device.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
 static int uncore_pci_pmu_register(struct pci_dev *pdev,
 				   struct intel_uncore_type *type,
 				   struct intel_uncore_pmu *pmu,
-				   int phys_id, int die)
+				   int die)
 {
 	struct intel_uncore_box *box;
 	int ret;
@@ -1070,7 +1061,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
 
 	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
@@ -1097,9 +1087,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	int phys_id, die, ret;
+	int die, ret;
 
-	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
+	ret = uncore_pci_get_dev_die_info(pdev, &die);
 	if (ret)
 		return ret;
 
@@ -1132,7 +1122,7 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
+	ret = uncore_pci_pmu_register(pdev, type, pmu, die);
 
 	pci_set_drvdata(pdev, pmu->boxes[die]);
 
@@ -1142,17 +1132,12 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 /*
  * Unregister the PMU of a PCI device
  * @pmu: The corresponding PMU is unregistered.
- * @phys_id: The physical socket id which the device maps to.
  * @die: The die id which the device maps to.
  */
-static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
-				      int phys_id, int die)
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 {
 	struct intel_uncore_box *box = pmu->boxes[die];
 
-	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
-		return;
-
 	pmu->boxes[die] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
@@ -1164,9 +1149,9 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
-	int i, phys_id, die;
+	int i, die;
 
-	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+	if (uncore_pci_get_dev_die_info(pdev, &die))
 		return;
 
 	box = pci_get_drvdata(pdev);
@@ -1185,7 +1170,7 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
-	uncore_pci_pmu_unregister(pmu, phys_id, die);
+	uncore_pci_pmu_unregister(pmu, die);
 }
 
 static int uncore_bus_notify(struct notifier_block *nb,
@@ -1194,7 +1179,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	struct device *dev = data;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct intel_uncore_pmu *pmu;
-	int phys_id, die;
+	int die;
 
 	/* Unregister the PMU when the device is going to be deleted. */
 	if (action != BUS_NOTIFY_DEL_DEVICE)
@@ -1204,10 +1189,10 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (!pmu)
 		return NOTIFY_DONE;
 
-	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+	if (uncore_pci_get_dev_die_info(pdev, &die))
 		return NOTIFY_DONE;
 
-	uncore_pci_pmu_unregister(pmu, phys_id, die);
+	uncore_pci_pmu_unregister(pmu, die);
 
 	return NOTIFY_OK;
 }
@@ -1224,7 +1209,7 @@ static void uncore_pci_sub_driver_init(void)
 	struct pci_dev *pci_sub_dev;
 	bool notify = false;
 	unsigned int devfn;
-	int phys_id, die;
+	int die;
 
 	while (ids && ids->vendor) {
 		pci_sub_dev = NULL;
@@ -1244,12 +1229,11 @@ static void uncore_pci_sub_driver_init(void)
 			if (!pmu)
 				continue;
 
-			if (uncore_pci_get_dev_die_info(pci_sub_dev,
-							&phys_id, &die))
+			if (uncore_pci_get_dev_die_info(pci_sub_dev, &die))
 				continue;
 
 			if (!uncore_pci_pmu_register(pci_sub_dev, type, pmu,
-						     phys_id, die))
+						     die))
 				notify = true;
 		}
 		ids++;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 9efea154349d..a3c6e1643ad2 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -124,7 +124,6 @@ struct intel_uncore_extra_reg {
 };
 
 struct intel_uncore_box {
-	int pci_phys_id;
 	int dieid;	/* Logical die ID */
 	int n_active;	/* number of active events */
 	int n_events;
@@ -173,11 +172,11 @@ struct freerunning_counters {
 struct pci2phy_map {
 	struct list_head list;
 	int segment;
-	int pbus_to_physid[256];
+	int pbus_to_dieid[256];
 };
 
 struct pci2phy_map *__find_pci2phy_map(int segment);
-int uncore_pcibus_to_physid(struct pci_bus *bus);
+int uncore_pcibus_to_dieid(struct pci_bus *bus);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 098f893e2e22..51271288499e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -657,7 +657,7 @@ int snb_pci2phy_map_init(int devid)
 		pci_dev_put(dev);
 		return -ENOMEM;
 	}
-	map->pbus_to_physid[bus] = 0;
+	map->pbus_to_dieid[bus] = 0;
 	raw_spin_unlock(&pci2phy_map_lock);
 
 	pci_dev_put(dev);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 7bdb1821215d..2d7014dc46f6 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1359,7 +1359,7 @@ static struct pci_driver snbep_uncore_pci_driver = {
 static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
 {
 	struct pci_dev *ubox_dev = NULL;
-	int i, bus, nodeid, segment;
+	int i, bus, nodeid, segment, die_id;
 	struct pci2phy_map *map;
 	int err = 0;
 	u32 config = 0;
@@ -1395,7 +1395,11 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		 */
 		for (i = 0; i < 8; i++) {
 			if (nodeid == ((config >> (3 * i)) & 0x7)) {
-				map->pbus_to_physid[bus] = i;
+				if (topology_max_die_per_package() > 1)
+					die_id = i;
+				else
+					die_id = topology_phys_to_logical_pkg(i);
+				map->pbus_to_dieid[bus] = die_id;
 				break;
 			}
 		}
@@ -1412,17 +1416,17 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			i = -1;
 			if (reverse) {
 				for (bus = 255; bus >= 0; bus--) {
-					if (map->pbus_to_physid[bus] >= 0)
-						i = map->pbus_to_physid[bus];
+					if (map->pbus_to_dieid[bus] >= 0)
+						i = map->pbus_to_dieid[bus];
 					else
-						map->pbus_to_physid[bus] = i;
+						map->pbus_to_dieid[bus] = i;
 				}
 			} else {
 				for (bus = 0; bus <= 255; bus++) {
-					if (map->pbus_to_physid[bus] >= 0)
-						i = map->pbus_to_physid[bus];
+					if (map->pbus_to_dieid[bus] >= 0)
+						i = map->pbus_to_dieid[bus];
 					else
-						map->pbus_to_physid[bus] = i;
+						map->pbus_to_dieid[bus] = i;
 				}
 			}
 		}
@@ -4646,19 +4650,14 @@ int snr_uncore_pci_init(void)
 static struct pci_dev *snr_uncore_get_mc_dev(int id)
 {
 	struct pci_dev *mc_dev = NULL;
-	int phys_id, pkg;
+	int pkg;
 
 	while (1) {
 		mc_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x3451, mc_dev);
 		if (!mc_dev)
 			break;
-		phys_id = uncore_pcibus_to_physid(mc_dev->bus);
-		if (phys_id < 0)
-			continue;
-		pkg = topology_phys_to_logical_pkg(phys_id);
-		if (pkg < 0)
-			continue;
-		else if (pkg == id)
+		pkg = uncore_pcibus_to_dieid(mc_dev->bus);
+		if (pkg == id)
 			break;
 	}
 	return mc_dev;
-- 
2.26.2


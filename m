Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3628E879
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgJNVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:41:50 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:23392 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgJNVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:41:50 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09ELZvpN031497;
        Wed, 14 Oct 2020 16:41:47 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x03c9y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 16:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VakfzwPg+Qtp0fCkxycEx2c12ulMUaatZxDMOo56y9DS8i1LA95WCaSVEjzS6Zw9nWO8CIS3TtzzzKeAct5EAQ58yKxM29ShYtGFsDsFyD7Euc048qeLo5hgeN2vRqYD4d8qe+SdDRCuUsOmM0Crir4uFgrpYoo+wQ6z4c6Q0NYwuoxNi2vGIwPeHobhZDfnCg6j1lHoHn7h3N0uGRxvrcLPraVea63OEiX2D9znfjQP++fg/LS3JFnoYSEc3D/3qNVTpIiGKWU9q/O7jwKGQqH2q/15SjAd1nlbOfcejEJ3sNsuSZRHgM4Z5OBP1OGOKt6EtgWNBAQrDAmAQdbFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5phQy8R+BLbl4pRWSzJSrNfS520f6O+31reNQN3hxI=;
 b=NNQieCIT2glkAuqiUEI50pcs4UKjvMHK0qqHhU3nX5R33mjpF4EkqyKIm0WU+jTt3/lzkf2JgQ5+8Hl+l7tcTXI41vcnZK1X3a+VX6zIibW0YSXy46IsMHZyavYmtqJ2wMEdrHU+y7wsMT0gFc0Y3JCRMoSszIj87xtv+7R/X9Ql6FTpHDagUb2rHBOok4C0Oh7JTWZSDCayQiXDSTBD0qyTIyI+pf54lmTwrH+d0qOcvmS0yyNhxAD8R4c3TK8OwIzw9TG/ci7Ijf9Qvg3F76/gAwKvPFjjfZR6DXClokouzciNQ1BU+dWueAVXB/MdICDRFt+2A1krO78pVMbtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5phQy8R+BLbl4pRWSzJSrNfS520f6O+31reNQN3hxI=;
 b=mDj1GiFseQDypERdOULOprQfE/Qif16NpL0EQxj0tVI+yVbuPO9Q+9nBh3L2eRG6OAV+g00pmPQKIh0CNSkY8vA8r99xJbz7PClUWGE1Q0GlbkeYZqpJSasQQo5DwieffDz+pueRUj4xBI7di6e5pPcM0j1VuXJV0QqsD9Av0Rg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN2PR04MB2365.namprd04.prod.outlook.com
 (2603:10b6:804:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 21:41:45 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 21:41:45 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     srinivas.kandagatla@linaro.org, pantelis.antoniou@konsulko.com,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [PATCH 1/2] nvmem: core: extract function to add cell from OF
Date:   Wed, 14 Oct 2020 16:41:27 -0500
Message-Id: <20201014214128.1091738-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201014214128.1091738-1-michael.auchter@ni.com>
References: <20201014214128.1091738-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: DM5PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:4:4b::23) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR15CA0037.namprd15.prod.outlook.com (2603:10b6:4:4b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 21:41:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31a6cc3f-3062-4d82-d361-08d87089f26c
X-MS-TrafficTypeDiagnostic: SN2PR04MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB236550BAF832344F4702AC9687050@SN2PR04MB2365.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7CW4IgKWc3Dp3v+S9FpTDTZOLA5mgdDTikMGfCxorUDDBwfTcuOtbNQETMizOWs3uWJf9ym1JXR5CHm791D7UdCoNwBu7bOAYErOkb0BiLsFZKIXnggvV2n5XznOrS62AA/iPtzWcPolZveRfEeseso1gFk3mlRGJxc8PaqvpFwOd2iVu+yd//j11clOXzr2GHi+x0YqUb9I/6c2fCTyxwg8YOqFzv81kU3v8K2/mTyk+DRNuzq2PRinJBXjpBjb7+4P29wt2fr4eUYMtHXvWhCr4xUEBAuUwS/4JSmA/yEuDZf4GjhGPR5CPX2sqxEYIuqdE4dkvx1TJB2uZqOzZNNBgBUoMH/A387GIu8I7Xc2w/MFQxwNdlOTANnMO4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(44832011)(5660300002)(6666004)(4326008)(316002)(6512007)(1076003)(2906002)(6486002)(8936002)(6506007)(186003)(16526019)(69590400008)(478600001)(36756003)(66476007)(52116002)(2616005)(83380400001)(66556008)(66946007)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YbbZD68idFR0kwycUKUEEabyA4/AItFxd6pGGjAQKGvT+Qtb8tObmIM51okqbXyZdQ4plcMnSvk4VwTQuLzkji7Jy1AbP8sNYSJ4eaWY8ZoNvDJ4knZ/yMy6RBZHGziz64fqJAscofCHc/jbVhGBMLTO7J1hILc1wDsSI0eUoo35eHMeLi1PzHu+0+xjSRJO6hETROXOcVoHWg4OhZlZZGCgTlVQxWLGjJNhozGOKwIg3aD2uwPv434cn4rNoPONtZnvVo2G4k1emnCOXdkcMNpKW+DFtHRhpfZhtAbXHxdAvRz8CVhMDi/2Mxq6GlpXwMhkcn74cHRamKia5kJ6GmhYrbZDURCeOfBf1tzehXZgk1jbFzaaCIiIad5ys+NAdrd3E9nPYskwGAp1i/IWRzXGTdfsEUSbk8iudUYSWYs2/sAKK5+QvUbCGkNOl3DKnnViXJ9flkhsgZI2+8qWqb3C8/4VLcNM3juesqYzw+WCzd9tZpG3uzzswjS5ZLiTLiBBmw9E5p8Eol68zMe3NM25u7c7Mf1scW1lL2/sXJwg02s6RKLIyC48xbAYFL894Xi1Zs9cgg5onJSHrnnwZMk51dga0kNNlcXSlNV6sYyhrQGAgnAGaU3X35FvjZ7Pw+HRREBM7ZNdnSRGMSDRYeo21cZ9anwGGu+9LTtJnxYxJFG5sF5hdvxHjY5Us1SurOzlBqYafpN05yVHkKA3kg==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6cc3f-3062-4d82-d361-08d87089f26c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 21:41:45.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um4U1mwKZuPRIA+VZzYlYZdoJa8xRkYY12UraQleu8W7gwlpoipSolyK5OJ05+T752oxKpBsJzWEbrjHxZERVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_12:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010140149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the logic needed to add a single cell described by a device tree
node from nvmem_add_cells_from_of, and call this new function for each
child node.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/nvmem/core.c | 84 +++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..91979529cb07 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -518,54 +518,66 @@ nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
 	return cell;
 }
 
-static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+static int nvmem_add_cell_from_of(struct nvmem_device *nvmem,
+				  struct device_node *child)
 {
-	struct device_node *parent, *child;
 	struct device *dev = &nvmem->dev;
 	struct nvmem_cell *cell;
 	const __be32 *addr;
 	int len;
 
-	parent = dev->of_node;
+	addr = of_get_property(child, "reg", &len);
+	if (!addr || (len < 2 * sizeof(u32))) {
+		dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
+		return -EINVAL;
+	}
 
-	for_each_child_of_node(parent, child) {
-		addr = of_get_property(child, "reg", &len);
-		if (!addr || (len < 2 * sizeof(u32))) {
-			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
-			return -EINVAL;
-		}
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
 
-		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
-		if (!cell)
-			return -ENOMEM;
+	cell->nvmem = nvmem;
+	cell->np = of_node_get(child);
+	cell->offset = be32_to_cpup(addr++);
+	cell->bytes = be32_to_cpup(addr);
+	cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
+
+	addr = of_get_property(child, "bits", &len);
+	if (addr && len == (2 * sizeof(u32))) {
+		cell->bit_offset = be32_to_cpup(addr++);
+		cell->nbits = be32_to_cpup(addr);
+	}
 
-		cell->nvmem = nvmem;
-		cell->np = of_node_get(child);
-		cell->offset = be32_to_cpup(addr++);
-		cell->bytes = be32_to_cpup(addr);
-		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
+	if (cell->nbits)
+		cell->bytes = DIV_ROUND_UP(
+				cell->nbits + cell->bit_offset,
+				BITS_PER_BYTE);
 
-		addr = of_get_property(child, "bits", &len);
-		if (addr && len == (2 * sizeof(u32))) {
-			cell->bit_offset = be32_to_cpup(addr++);
-			cell->nbits = be32_to_cpup(addr);
-		}
+	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
+		dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
+			cell->name, nvmem->stride);
+		/* Cells already added will be freed later. */
+		kfree_const(cell->name);
+		kfree(cell);
+		return -EINVAL;
+	}
 
-		if (cell->nbits)
-			cell->bytes = DIV_ROUND_UP(
-					cell->nbits + cell->bit_offset,
-					BITS_PER_BYTE);
-
-		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
-				cell->name, nvmem->stride);
-			/* Cells already added will be freed later. */
-			kfree_const(cell->name);
-			kfree(cell);
-			return -EINVAL;
-		}
+	nvmem_cell_add(cell);
 
-		nvmem_cell_add(cell);
+	return 0;
+}
+
+static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+{
+	struct device_node *parent, *child;
+	int rval;
+
+	parent = nvmem->dev.of_node;
+
+	for_each_child_of_node(parent, child) {
+		rval = nvmem_add_cell_from_of(nvmem, child);
+		if (rval)
+			return rval;
 	}
 
 	return 0;
-- 
2.25.4


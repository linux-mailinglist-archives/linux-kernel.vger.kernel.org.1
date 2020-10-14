Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2795828E87D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgJNVlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:41:52 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:26720 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgJNVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:41:50 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09ELZvpO031497;
        Wed, 14 Oct 2020 16:41:48 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0b-00010702.pphosted.com with ESMTP id 3439x03c9y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 16:41:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2nRLz3gSLpiNFomfke6n06R8w3ZKQZcVgr7LjciihH/gl2F1dqYx07YibTD0zNEcEFZe/sX8zYf5MADQDIk2zPU2Oizc/pLyLd7opmtrUTmzUt8gusMXauA1baAMb2YnfiNN71PsW8QnYtyIPK5i3gMvJFwp1dJXFOCzCTFVNvKGzoRQq/gOUQ0bySOPrYp2Co1Cl57SVteLKYRRt+rhGvCLcIYLmL/x70Sz9gNEIfc6y1lnLepr3KHif3+bHrR+UNUZF5uQWIp9U5Tnx7Ff4nDtLG0rJT4jbz4RwaF5bnAH/yDGjXmXPbNdXn6+8X8ap49HZmz2LPB0nFecGwb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2pf/WT+um8bPSrSdQWBzZnyrPvQFcgZ+nNSGH+ru+s=;
 b=FxIH0Bs5oOWssIJgX5X9gelj6umNl1/B5evOmBN9mK51sxDBnOjuSSBwzXRA50d3QkrGo7KDrEZgq5J1mcISN+PJ+K6AtJ80Mjbmig30YcYFqy1I7TqRtN5+5NPjCs958/KVWGma8rarXqMSMboPDIbjOXdkgbMCTXd8csbELDKQJhJ0IK0c+ytkeyQAn+++/gyYWtxzskMrH77OjD7CxCkRW7qn3tXR8AZMy6Jzx3hAKI5i+ygMusgWa7aRT7wGEaNsM5gkA3swrAiLLPsOKwei0Nizc3T4w7uIKOIACfzX61ifIPhZqqVKZtcS1QWGKdsvbUNQ6ke6czrkXY/MXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2pf/WT+um8bPSrSdQWBzZnyrPvQFcgZ+nNSGH+ru+s=;
 b=otWlfzogwE8yjmJSB5npNzi59WrEikKpAeBynVORHYAwuBo9Myc4iJKdqMVWSG9V/6wQVgowcuPFC4+Pmbk7DcO40CeQ4VnrdPgDBcw2NO9y2p93yg34azu7vmlycjLTMvTKSae95Isu0LC3XRobCQ7bDkhlw2FEsQN3C/yTsVw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN2PR04MB2365.namprd04.prod.outlook.com
 (2603:10b6:804:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 21:41:46 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 21:41:46 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     srinivas.kandagatla@linaro.org, pantelis.antoniou@konsulko.com,
        frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Auchter <michael.auchter@ni.com>
Subject: [PATCH 2/2] nvmem: core: add OF_RECONFIG handler for nvmem cells
Date:   Wed, 14 Oct 2020 16:41:28 -0500
Message-Id: <20201014214128.1091738-3-michael.auchter@ni.com>
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
Received: from localhost.localdomain (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by DM5PR15CA0037.namprd15.prod.outlook.com (2603:10b6:4:4b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 21:41:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3c3054-d5dd-447c-6268-08d87089f2ed
X-MS-TrafficTypeDiagnostic: SN2PR04MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR04MB236562F299219DD1B0BC40C487050@SN2PR04MB2365.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r//Lf4UwREBdX0Nsm4J4dfEzCRZhh2rPiw2EZ+hgEVMJtr36gGzKg39GIz2dB5jG6XLyvyhGxS2534f0Vt9PP700S81yaQAwSdtu0YeXZs6BF6kLm3lWDRiTBmrZXs49TKaKcqKFiPERiS/KBUfJNKniJOWybsmkPHOHsxLt54zCKb4LwTnyIwCnWnTpcgU29EFHenYao2V+uUsPCBQFzNhldNMAlq79LdnRlzXXzaLZjgB2HRFtCoSL/bDyU4GjdqDEGfp1SsDm8GYv8rm4p4KIPa/1foP4ZLJIE5oIFQrpZKJxcwfO5WLVuV3ODappjbQWLGDFMFXRti+dbIp/1S1TdlPYrTXwxVAdOm+MhyoAbD0ERZuKX1VSJ4bkJOK7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(44832011)(5660300002)(6666004)(4326008)(316002)(6512007)(1076003)(2906002)(6486002)(8936002)(6506007)(186003)(16526019)(69590400008)(478600001)(36756003)(66476007)(52116002)(2616005)(83380400001)(66556008)(66946007)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SEWjSsSojR+8XJZ4LkuxNFKUaxolihLHHyUqzmrrc7W/HdGQiCpS+OKq2XB22Z0okxFBkzGKnDmAAIdKLJbq0N9Vd+FswSwQP/PClyfe1JuDsf/IdcGLdQXZGnX0I8bfRYKCLzmdCiVfl3ioX0n1proFQwoi/gOBgy7BOcrN4N+VlNcfG/wxETMCPk+SjRO6YDP62pw9m9weMdVFy/j1LizVf1r9tn4gCg4XZfTsh1GlO4A/wcdDD1St9C/Nk/DNvJ4DqdTn1oKGsuAKmTwGvOUiaRI2qHWpZsiPduO3jlXZor0XlKv8V+xbfvnKb7m6fuDLpfAQitMF7//+OEtINufLDDuOK1dmqE94YPaomIWUnkkr2fXSlzCdxF0MYI5WVTOocRvDPD/PpgbuzGquXJS20SkllFHEOtyGd6+O5JliSpaVv0yv9+830cBwhWfsqZ+3Vj5vqbnoDvgorjewLOWsCDEWdnpKGBwvEy6lQB5HybA6sD0h0wywUT8CoO7g0tsDnEhSGLsssW86yaoJowRGh7zqWRakr2FKZgXjuDEC2TSFASxPvJuJwWAG4kCMfLjloqZyWlrTQLMv3IK2ksI+PE+zUBnXN5hkBwL8NZdZ2zXHMr0V+sp3PHxf2CTwKB5jo3sYeZKY+VgOjDdskQWlgTUJpgWzwy7UnNm0Uyendbzkb76LzUdCycEgnSAgrln8Km3SouaKTcdjZ9PnHA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c3054-d5dd-447c-6268-08d87089f2ed
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 21:41:46.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pRcA2qBNoMnghJR+qtwJTNKWBdgU2bnDDcQ5pUpSJGYHnGEZulXSJw7SVzCLwxQzm2zzbcTOwmUYVDcQAMGrg==
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

CONFIG_OF_DYNAMIC allows runtime changes to the device tree. This patch
adds a OF_RECONFIG handler to receive notifications on tree changes to
support adding/removing cells from an nvmem device based on these
changes.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/nvmem/core.c | 61 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 91979529cb07..859431c15d5b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1629,6 +1629,53 @@ void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
 }
 EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
 
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+static int of_nvmem_notify(struct notifier_block *nb, unsigned long action,
+			   void *arg)
+{
+
+	struct of_reconfig_data *rd = arg;
+	struct nvmem_device *nvmem;
+	struct nvmem_cell *cell;
+	int rval;
+
+	switch (of_reconfig_get_state_change(action, rd)) {
+	case OF_RECONFIG_CHANGE_ADD:
+		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
+		nvmem = __nvmem_device_get(rd->dn->parent, device_match_of_node);
+		if (IS_ERR(nvmem))
+			return NOTIFY_OK;
+
+		rval = nvmem_add_cell_from_of(nvmem, rd->dn);
+		return notifier_from_errno(rval);
+		break;
+	case OF_RECONFIG_CHANGE_REMOVE:
+		if (!of_node_check_flag(rd->dn, OF_POPULATED))
+			return NOTIFY_OK;
+
+		nvmem = __nvmem_device_get(rd->dn->parent, device_match_of_node);
+		if (IS_ERR(nvmem))
+			return NOTIFY_OK;
+
+		cell = nvmem_find_cell_by_node(nvmem, rd->dn);
+		if (!cell)
+			return NOTIFY_OK;
+
+		nvmem_cell_drop(cell);
+		of_node_clear_flag(rd->dn, OF_POPULATED);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block nvmem_of_notifier = {
+	.notifier_call = of_nvmem_notify,
+};
+#endif /* CONFIG_OF_DYNAMIC */
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
@@ -1644,11 +1691,23 @@ EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
 static int __init nvmem_init(void)
 {
-	return bus_register(&nvmem_bus_type);
+	int rval;
+
+	rval = bus_register(&nvmem_bus_type);
+	if (rval)
+		return rval;
+
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
+		WARN_ON(of_reconfig_notifier_register(&nvmem_of_notifier));
+
+	return 0;
 }
 
 static void __exit nvmem_exit(void)
 {
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
+		WARN_ON(of_reconfig_notifier_unregister(&nvmem_of_notifier));
+
 	bus_unregister(&nvmem_bus_type);
 }
 
-- 
2.25.4


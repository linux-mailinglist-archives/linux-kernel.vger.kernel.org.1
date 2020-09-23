Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0F276260
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:45:13 -0400
Received: from mail-eopbgr140103.outbound.protection.outlook.com ([40.107.14.103]:21156
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgIWUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOiMu709MAaegMQCKKh3hVhcIgMaoTfHBfkLe7/hQnxrB3Y0ocuTHHOJPvdz4H4/ENpgEc6CeN91xRUrWYBB+YfPuiJsPn7gZdaEcnq5QqhkeyHXgLk2XNsYCSgAY3IcrWQnJdVO4TGTZ3QN1vMFHBAKP2vgh9sBD3n4vgiq5Kh8jftRpcca8Mxhz+oVxdZM/7xTgO9QgLTYqhnljKCTFIe6O+DSgQl/pOru13gEzmUy+Aq1h3rww/8IBlj+op4TExmutUQkI2tsew44V2oCknoF/V2+/D89KSK6AX7vRV1bRNRXOqLedae/Hss6OBL7JXTcmiXsm5g1Fr1VN1lVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAioQW4IsQpePGkSfkq4UxzWc5kATRubfzLWKKroMI=;
 b=IHRLklMjoTjFz8wTzG5Ykr/ckoXKfIGNN2aELoPxEaN5TBDVclWQpi96nuRTLrtu7psamQ/hS2Rphj81zCrQOWKCVlYHfqMNlwN8whiTp9BR225jFhJdYSsmU4C5fIRi4wRt7Cv0DoUQPXxM58zwH7K3TbEYc6dig2G4PzJwY0sg6XjYc3Ed19DlSSbRD/0qHReDE6JxV31u+yzvy/9Enilx8gfht6pf+s+9oWw4ECQ0OeeWUgpvRUXj8fgeSphg4EBJKETlM/P8iMEXK9naN0wdbO8akuxAba03aW4T80vDjZcXzV6iGefi0sIcyD7KMoCyNM1tI0jGRPqm081Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAioQW4IsQpePGkSfkq4UxzWc5kATRubfzLWKKroMI=;
 b=CYYPDsk4/mx4iB5T1HDT0rARV/gMI8/wBckrsA25ubxjNiqTpeMV7dptbQPwps2BSYv/ezikFsnqnxDMOLlZ7Fe3Kj7q7x+ZNPGkacoTYaa3rsftJ2VyLpLNUPHp0RFlK/Vdv5aE7sSM5P7X+lOUfEt0FJnvM5P1VJFbSJzqG2s=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0332.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:62::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Wed, 23 Sep 2020 20:45:09 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 20:45:09 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v3] nvmem: core: fix possibly memleak when use nvmem_cell_info_to_nvmem_cell()
Date:   Wed, 23 Sep 2020 23:44:56 +0300
Message-Id: <20200923204456.14032-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::31) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6PR10CA0054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 20:45:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c57fc2c0-5459-4ea9-2fbb-08d860018f18
X-MS-TrafficTypeDiagnostic: HE1P190MB0332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0332863EC33CA5E97D86681D95380@HE1P190MB0332.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjLCMqg1kSP4SRQUXNH3dcT3Hq8YYHSGlLfJa1h8HWV6AZkaKG7gQMYuNNtpfTvJq0JUpOilpSVHCcRec7KF/VQSucbMWdk5Pq3CEybQBzQ1SWOEyw6eZerEMePcLNPjIRvAhh4DuJU9ZaXWOlcb+45/y5LLLHgi4QUyJ+/iFWrf/h+vay/HWskK+S52uPIkZPZdrBUIBT04Ng/gZWsbyWqMbUeRey3ZhWZChDO24yTVIzsIZcwRjsXE+OLuFMENAO3lqXWjZMRIWWd3fNhoh+q4WKgISuQYAUeeDcQnNOLqoAd4fv55WNMofBVUtxRtPfRxVK71WOA7q/8rBAnYjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39830400003)(376002)(107886003)(52116002)(6666004)(478600001)(6486002)(8676002)(6506007)(86362001)(2906002)(8936002)(66946007)(110136005)(66476007)(66556008)(36756003)(83380400001)(1076003)(2616005)(956004)(186003)(16526019)(6512007)(26005)(316002)(4326008)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Wk1JwgM7ko1JSm6ijI8v2csWFcdjxI20Mh7GvPuQJMAqcOXlsvgmojvj/pSmqIutIYT1K5ahRvvNfCAIxqFuPTiAKNkPLWS82WvTbpPTIfwsKcj7ghVtLgzfB/+RhKnLeVvcsK93l3oQ5kgS8duGekVvq8B3ZqG9JkFuZDVEqay3e+zEkHEHcX+DsiXDZpwyyP4XGR+uFk9uO/fzhBV4v9SI85LfDcpmQjorOb6wTKBq9pyFh76mfm1D1u1TZh/HFquyHI8wHi8wNO4UQ1AldqXhYxWOMEoyhvZeoQjdXlqk/LBMeMpF3DUVKnU29XgzHvCvWGjKOVXg8FLrhR4eIlrXpPhjyOzy/VIblYUV5gac+BO3IWy5wI7G7h6vSvGCe5siB6WvEHQIxEzSWvgrkaoxVRynrBgXDOlzshnjq2SAF6JXq5C6FtHIj/YNBh2vhRxmP8O3W7ITAFSSepw3kfS3BGwTUKdHQeEBW9o8MNPbavzoznYMuJ2k4P+vkH2lxoeX3qEo8eiUwQ5pv1yVwFIL3c0e8BlyZTT0Szr04qL1a5NRtRlqLNK/TpJT5rN/A+1pYDteaqSsXxmyJkGmvPpY9pT6q20li9pZ9tKO8z+1e1g2H6JtA91vFjQFZaro/q1tXwyo21lgQcU6vvUNTQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c57fc2c0-5459-4ea9-2fbb-08d860018f18
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 20:45:08.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJnuRqCWjn+BynjjYcf9IoEUbGYvMqE0iLLgXCLvw4fXdZbApRoC4lgJZwrY0F0OUgq3xTGaQfYUV/eEfUHFI/RRW30vhZAvtnZqRNKi4mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0332
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing 'kfree_const(cell->name)' when call to
nvmem_cell_info_to_nvmem_cell() in several places:

     * after nvmem_cell_info_to_nvmem_cell() failed during
       nvmem_add_cells()

     * during nvmem_device_cell_{read,write} when cell->name is
       kstrdup'ed() without calling kfree_const() at the end, but
       really there is no reason to do that 'dup, because the cell
       instance is allocated on the stack for some short period to be
       read/write without exposing it to the caller.

So the new nvmem_cell_info_to_nvmem_cell_nodup() helper is introduced
which is used to convert cell_info -> cell without name duplication as
a lighweight version of nvmem_cell_info_to_nvmem_cell().

Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v3:
    * rename __nvmem_cell_info_to_nvmem_cell() -> nvmem_cell_info_to_nvmem_cell_nodup()

    * rephrase commit description a bit

    * get rid of wrong func line wrapping

v2:
    * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
      failed.

 drivers/nvmem/core.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..10cd935cf30e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -361,16 +361,14 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
 
-static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
-				   const struct nvmem_cell_info *info,
-				   struct nvmem_cell *cell)
+static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
+					const struct nvmem_cell_info *info,
+					struct nvmem_cell *cell)
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
-	cell->name = kstrdup_const(info->name, GFP_KERNEL);
-	if (!cell->name)
-		return -ENOMEM;
+	cell->name = info->name;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -382,13 +380,30 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
 			"cell %s unaligned to nvmem stride %d\n",
-			cell->name, nvmem->stride);
+			cell->name ?: "<unknown>", nvmem->stride);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
+				const struct nvmem_cell_info *info,
+				struct nvmem_cell *cell)
+{
+	int err;
+
+	err = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, cell);
+	if (err)
+		return err;
+
+	cell->name = kstrdup_const(info->name, GFP_KERNEL);
+	if (!cell->name)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * nvmem_add_cells() - Add cell information to an nvmem device
  *
@@ -1460,7 +1475,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
+	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
@@ -1490,7 +1505,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
+	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
-- 
2.17.1


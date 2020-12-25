Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD32E29EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 07:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgLYF7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 00:59:15 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:15451
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgLYF7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 00:59:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAMqyy1NYZ1RMoPmczIUQ8KHlxKj4xZNO6tSMU+Wi3mRZC+iBKm1Ftgazut1v7tbnFnzFEOxjSSeI5xBCWlAYig93SfCMBLZ+o8Avie3cER5ZpCGHTsGrryT5wj2Mz8aMOK59mzN0fwXCmU/LxYjyHm4DNcsKvYKu7U4KDABUMUOntsFUK/D2K1IMnrUnhO4SnoHGty5hTnipGdPhoOb/qd1NW04VTGRYG8NapWxuOHmn+PWwCBbEt5Q4hQ5IOezq1c3Yb2SvxDLD8ZNeZkDIYrHLSXqdzEbnsKz/l5omncI7Sa1szfS467Wskv3mcy8vsAC+54Q7j6CCFuzMpLmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEB/ZXNXqS7u8xl7Yld8/IXayIb+xtRKeiA1dPTMlpw=;
 b=FEm3vAIrnissfetckWY6AsFPXhevtJl6RHcWoTq6v8g1Lcp1cYumrN3PNaDHxVnGjjws0OB1ygmy/QiceGxS0EWaK07WuoA9VQZvqZsS/Ga56YJZBMZnn/yXcRN1j1KJKiHRfIjKpe449LoFsu64XpqWN+fy2iSH84ObEGOxlAFFMeBorwYa4Z1RcymexNFm1hP68Glj7Yi/dWcJQ/c9wwj+g6KWe0nsc8f8Y8ByM8v+Fxof/f3py2z9AQrMLTrh5Hk68tdSp+xAkAQMXve1LgqdlQ3+mGa9wmZs+9IRLdzBUviXSNdgDxOK1691FtWRQC8dumHL4ylTNsl19du0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEB/ZXNXqS7u8xl7Yld8/IXayIb+xtRKeiA1dPTMlpw=;
 b=TnAEagKh9Ipg7tPonmNxpQRBcsxUfO0H7TTtRLCACa0+ixXqNswIIvL1XHGcFyg502tRu+vNhb7lJUs8QFhn0/bl+kX/ie2a0+FHWa+8LNdoOlbZ9KJjdoA5jc2L1wxaDfKNiIX/E75fd1F1Vz+j86nc0DCVyt/gbS0wkVZmGuo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR11MB1566.namprd11.prod.outlook.com (2603:10b6:301:10::19)
 by MWHPR11MB1455.namprd11.prod.outlook.com (2603:10b6:301:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Fri, 25 Dec
 2020 05:58:32 +0000
Received: from MWHPR11MB1566.namprd11.prod.outlook.com
 ([fe80::c137:fa3:6b53:820]) by MWHPR11MB1566.namprd11.prod.outlook.com
 ([fe80::c137:fa3:6b53:820%6]) with mapi id 15.20.3700.028; Fri, 25 Dec 2020
 05:58:32 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        james.quinlan@broadcom.com, Kexin.Hao@windriver.com,
        meng.li@windriver.com
Subject: [PATCH] drivers core: Free dma_range_map when driver probe failed
Date:   Fri, 25 Dec 2020 13:58:12 +0800
Message-Id: <20201225055812.2177-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To MWHPR11MB1566.namprd11.prod.outlook.com
 (2603:10b6:301:10::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR02CA0177.apcprd02.prod.outlook.com (2603:1096:201:21::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Fri, 25 Dec 2020 05:58:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9c1635-2df7-436f-3658-08d8a89a1c44
X-MS-TrafficTypeDiagnostic: MWHPR11MB1455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB145584891031E48A39FDB6A3F1DC0@MWHPR11MB1455.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2VkWtQEppmXUEtKm8Re69NRuHDsRE4QfRW3f0wBAL5PJVULOSVIjpx0zbJzBlfPBlpgImPxLoqmJQfaqj+rq4numsBl1WaNrJ2DAQLkwjciNgpeRyK4StIl5w5RHY8uhoL9kblU8SfTEu3PVWE1OHBxc/O8JiwACa0AMXaTjQLzCxR3LxBrkgJq0Tw0LFZkUK1RyZugjvXqfnQuQYlE+lRxWu+BAjYiT22adIGqmI3gfHnYDXEjBdDO+0pWuDChsfkZC3n6mhupoV6ShW46s//t0XmlblCslvcBtFuikN1sGeJhKk3kZqzaRUj4KRT2OkPgeSarWqLJY3rf6lQDVK6hzjA6BbczGrj0lnkk5Bz0+KL35TBLg21torPp16ES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39840400004)(136003)(396003)(6506007)(66556008)(1076003)(316002)(5660300002)(52116002)(107886003)(186003)(2906002)(4326008)(9686003)(8936002)(478600001)(83380400001)(8676002)(6666004)(6512007)(16526019)(6486002)(36756003)(86362001)(2616005)(66946007)(956004)(26005)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8k3vDDRkSNxpkpeDmLhIYANgPltnMC1MiMprnq9ZClPyiaKfAMU52pfz5m5U?=
 =?us-ascii?Q?oJv6jd1CejrKVBNQq7zs1QoOUhpIzpEoHa6pOvrXWVg8coYjAlV5OtnAFmEY?=
 =?us-ascii?Q?amGOit57e8w7VnAPRI/vI/xTSj8xrLeBuIGQVpo6TXSiYh6DFRrv6HBMv/Ej?=
 =?us-ascii?Q?AIpsBPb72Gz8vW8Ao/3FgHytAQaq9oqII1iY3OE0Fouz+FiNQ7r2byWahteY?=
 =?us-ascii?Q?m/kgM3xySvisj9+Kax1wkYcPnz7IyH0DtYLQCZo2Jvqbdu+3O/9TSZhIcgJF?=
 =?us-ascii?Q?QQVCy/ysdbGFgzhF23f7eKZ6CN6x+6tTDd5ccDfyQbH/Dk6nKv25IZQYW622?=
 =?us-ascii?Q?De/y79jFEsF0yizDcrRmV3dcKVdYB5CtiMlBSUeokrZQlOkEo1LoramEJTRZ?=
 =?us-ascii?Q?/ryECDSYjPa43c4Cl9gS9bHR4x4Y9CpVg5rVM07YQ03UyXRLgvF35pz9XtPo?=
 =?us-ascii?Q?Q9Ul2FMWq1pc5+SQJIyINxx7W4vUvn3TdsrZlfHp41VR5hW6r+zSkBDv+ej9?=
 =?us-ascii?Q?X24FijoUFbBMSQfcdy6XxJaFx8oHJG6g2XHuCNe5vOTvIwpUDdnb5iS9CJ4P?=
 =?us-ascii?Q?FMglBUPc07sTi9OdJjGcVGZY+8K23/65dlbsylW7Q4Zv8IYQU3APZvLS86Bu?=
 =?us-ascii?Q?+65NZd617JX1leU9A1OQ41QgXBbF1hwxkIYls0sIHLqRNwjF3F/vg1wM7Lu/?=
 =?us-ascii?Q?oSXq37XjmpGIzcm/OpdIZhaCOf1m11P9OVlqBf6NRRzhZtL0zKBbdUcDUMqL?=
 =?us-ascii?Q?lhP24cEtQ9DC9dndXeTBV4WZuQLjX4a9cPqVjjZgpvANr7xYz6eCR0T+NmGE?=
 =?us-ascii?Q?CYHdzpFiswrY26fMwWcQ3KgczmytpBfIONAvMJjR1uR5PsZtBhBZRoZOTYg1?=
 =?us-ascii?Q?dWE3efD1oHkTomn2P0HgVyU1w8Umc+kpORkSO0sPwO4uwT9xzOvDl3KIMi+n?=
 =?us-ascii?Q?mHMFOLuH+HuoGoRk8eaZW+rLa8LLp+feaU3fp7fZMKn43SifNiDAXMtOpVIX?=
 =?us-ascii?Q?vWUU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 05:58:32.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9c1635-2df7-436f-3658-08d8a89a1c44
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhURJt00FTCEnyb3WZwqZgrKFuWvn2EsR36uIO4bXXHmmkph0IXBMBvQIUpoFjjntQdrlq5+iqbVnej17hQvGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Limeng <Meng.Li@windriver.com>

There will be memory leak if driver probe failed. Trace as below:
  backtrace:
    [<000000002415258f>] kmemleak_alloc+0x3c/0x50
    [<00000000f447ebe4>] __kmalloc+0x208/0x530
    [<0000000048bc7b3a>] of_dma_get_range+0xe4/0x1b0
    [<0000000041e39065>] of_dma_configure_id+0x58/0x27c
    [<000000006356866a>] platform_dma_configure+0x2c/0x40
    ......
    [<000000000afcf9b5>] ret_from_fork+0x10/0x3c

This issue is introduced by commit e0d072782c73("dma-mapping:
introduce DMA range map, supplanting dma_pfn_offset "). It doesn't
free dma_range_map when driver probe failed and cause above
memory leak. So, add code to free it in error path.

Fixes: e0d072782c73("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset ")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..8e4871aa34bc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -612,6 +612,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	else if (drv->remove)
 		drv->remove(dev);
 probe_failed:
+	kfree(dev->dma_range_map);
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3622EA5B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAEHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:10:36 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:38327
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbhAEHKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:10:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkZs/ABd0CItIA/fEx1yx6VH+UrKIwkXHp4is9ucqeMp68KikEniwjLCph7B4lPXPrCa87u8i1TKEdoDo+7vlAUj/+yIpVsciL+FCo7XRDLD5tfWbKbAVr84bIXpMACpoG+YuaJrr9efjRQzgi7yatyRvGstR1v50Ua1QEPiR9o0lZnfYDi1DtAWzInt8RgwN5gE0KmvwaEDUvBQXCzOJTohuks1qQpIsqqqOQBeH+CB/kJ+wjeKSf91iIe8B9v1m4J1AE9O6nZQZRClqBiUamadKuDwExyJv43fqknty/cZ0AxxSWZ2ulm0sPu+a+3jP7ngZc/aFuXHK36/CgICMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uds2PUKq8slRfAPNIQ2H7UGBb9JdhOPhydlG3zSfWA=;
 b=XDe7txTVyI0ANGTTWe4JxH2hliLMXNTfQBPn8KNXW3qSUzcREnv3TlAi/hE6HZsPD+D9Smpi8IM5PtSvOUkTB5ybb7voBmFlShjT5MsnA87dTADf3YJGfs6Qjritx+zWDpeDdgUUn4vPRhilRCDQ9TJm8ofHjfmWboViJbQwbSlp7B6WhWY86s9hr43yQAADPn4D4rPzNv+omfarbJkfuf5F3ry2TXbxma/Zv5qBe502SCZIBHDfIzwErz7SPsLMKQ0t5p+2Lm/MY2mV9tMjSJAQZMikuO8dPJjhkpb/Sz5Ghp+JbinSh/j5sEjmecKJEoxghqrlCSBq/37f3evnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uds2PUKq8slRfAPNIQ2H7UGBb9JdhOPhydlG3zSfWA=;
 b=e/st6aEP7Wm1MtnkDj83t7SZdpoQp79zqv/gB9itjuMXFZsj04jc0A/5si/PjT+ImsN5fZx3wmjHpeiJp1qpqppENwhBUNJ7fMXPpYKT33hRgjMfcbdnS8EYLsaw748URaiX2kw1NoHDBAWYIqYZxuCQh24ahFQujHz9nRl29VU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BYAPR11MB3703.namprd11.prod.outlook.com (2603:10b6:a03:b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 07:09:48 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 07:09:48 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        james.quinlan@broadcom.com, Kexin.Hao@windriver.com,
        meng.li@windriver.com
Subject: [PATCH v2] drivers core: Free dma_range_map when driver probe failed
Date:   Tue,  5 Jan 2021 15:09:27 +0800
Message-Id: <20210105070927.14968-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Tue, 5 Jan 2021 07:09:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4f47fea-3a3c-4866-54a4-08d8b148e386
X-MS-TrafficTypeDiagnostic: BYAPR11MB3703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB37030A9A573C5EB8D953B0B7F1D10@BYAPR11MB3703.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBsCTqMDHsVd3IfA5QdBil6H/fAgFUy73siNis5xC7ia8M/ZtAHbfs6E/kELgPX0/hLjKFAxCq0knzjvCxN83aSVDzox1RHnhCItI23V7bA/TgWtWY8PRv6xwWzP/+hHydMpvj7uH8fZ/vv9cG5U9YN34ce5EAD8J2jS4iBTEokR4/ljdaoKuaN384+iLLwFXLp/67vjhiVCAWYVCHuJOVpS4xqXIv6WNWj46N4bxL+Q6NptdZwnOpttQrgVGJZ9qYWoI8ib/z+DbuY2jMB6cVwHuOdDM0PQfN/+rEZaW371n2VAocDv/EjEj+Bgx/Mm1sHBdsWaNTfTIuWF3nblRrxy0ougL4gOVEo1ycSbzgFUokNoYoR4ZNo/BGgmdq75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(366004)(136003)(346002)(956004)(6486002)(4326008)(16526019)(8936002)(2906002)(36756003)(5660300002)(86362001)(2616005)(26005)(186003)(107886003)(52116002)(6506007)(6916009)(8676002)(9686003)(83380400001)(316002)(66556008)(66946007)(66476007)(1076003)(6666004)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bweaqVxnqX9vYLk744qg1uebQ2JRZ/z+WFZ/vuXF38h55tMZZgNGKh8Pb+NU?=
 =?us-ascii?Q?wKPEV1zEshHVmIdNWEJqsSEYqtx/q7Ag3S9EU7bsW9G7BU08NWM9aBYeamLh?=
 =?us-ascii?Q?G7SvpOG7kRQva8TEvDGAvachOeYdDRKv6OIH8i5bJSeRuMW04Jc3Kj+S2BT8?=
 =?us-ascii?Q?yURTyMGJ6bLHFhOUTdbG9VpLm6fTNhjhAG2OqnB0W+ufzMCaf0Rm/ZpXKEA2?=
 =?us-ascii?Q?HkHAkqhDNzD2GbPTKU4i5X7e3XwSA6m5NPnlbLhm5QdF0f/UiPKomIS7DEKI?=
 =?us-ascii?Q?d+cRS24j8N5/1+PWzkcYn5gpZhcP1P5hpnmcyzc8YGJcObX2kZTXjFo94+Ae?=
 =?us-ascii?Q?29Fn1l9pBO9AIRhjlGuB3rW/23hGiuXy3jL9j96fjnPC719nq7fyqvM1jQ7Y?=
 =?us-ascii?Q?PFNlB3nLKXAWb7uEGiUZwIWXf0KhzazUOaYL0fvNB5YpakMmvdnDOVxDIXmq?=
 =?us-ascii?Q?HnU/eRyacDCccNHtyFQkKscsmOr0b6PFLJpeWPXMYr+fpH0wFjfjL9JLI7FD?=
 =?us-ascii?Q?YW+A6CFzi0FF8sXSvwsMbap4piK4qWbXzNe3hUQsZwvxyXwD8zpPerbfuXE+?=
 =?us-ascii?Q?JTm9dz+KhvPGsEPUklWds9WQxatmKT7gqrzB3LbF7Pcb58C9nN1WBV6AexLG?=
 =?us-ascii?Q?hFeasXQrnDFtddYQhzL+ouu+02trB/B1NfkAcZwqFGvdmt15NFoZSWyUVfQH?=
 =?us-ascii?Q?cyczILc7OC4JoglHdvfXX3McoihkpbAl5QzoXhTUOt0rNf/UoFt3R8/U+zw4?=
 =?us-ascii?Q?71xB2Tp5EuCsuDVMTUUBKE/LvOhjrR6PYXzgQR8JAlgKSAJ1A/0yABv2HDYR?=
 =?us-ascii?Q?mBoRrHHUhsPEGtTN2DlD/O8pGmMiuJiZLBeDB3mMuFmSZ6Ar58FZP5QAaW3t?=
 =?us-ascii?Q?q+jbPuzIwGFUblW8fyyRqUxq3qNpIn1tiwiY2bUkSyg+LG8xuog1uA3I4HAd?=
 =?us-ascii?Q?DhQ6MWM9cQtAI1B0flJXS4MMWWI6/O8JjBxk326+M5f7twgz8QoKMDBbVhCZ?=
 =?us-ascii?Q?oxcc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 07:09:48.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f47fea-3a3c-4866-54a4-08d8b148e386
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+2TEzZj2UtVKmwbq8+6l5q4FvlMJxsim1CjYzvtvt2KUerZnn4YXDO0w+OseF9m8vvK4m/+0gH4zv0/whhyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3703
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

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

v2:
set dev->dma_range_map as NULL after memory free.

Fixes: e0d072782c73("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset ")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/base/dd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..3c94ebc8d4bb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -612,6 +612,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	else if (drv->remove)
 		drv->remove(dev);
 probe_failed:
+	kfree(dev->dma_range_map);
+	dev->dma_range_map = NULL;
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
-- 
2.17.1


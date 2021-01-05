Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4F2EA500
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbhAEFnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:43:12 -0500
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:46016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbhAEFnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:43:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjI774eTYrjfHSzsSLd8kGM/vPAqtYdjLKMkW4kV3x2+BWHc9nJ+fHEtCWtaorSS+rdtH/MTw9DPXMvPVbJ0JzximmZCtcHrxpdiVxfYB4eCVanbSv/EHtGr3nB0y82TAV61ISXiQphdLDchDC1LcwwBL7Hc9/JuJORlFZdhk7PWXIQb5LK76/Eqn6rP20I6gqsPsNsMtiowOZXCDL7FPdyTAlUEFn0jPQy9CRutnfgM95rSh3fsZSRmuIskrFitf9KFX+vVqyBIbes+YozGPQOiknGLbUAV795nRnp7uGsHZttYCyehlQE6z0MS4fcYBLU4kmuHEW8Tslj2KWBt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVRrqxlGv6/vU6vZLkGqOlLYVsjEZMzOyqZ6LbkcHyM=;
 b=VZ0EkQ6P5dEPXVBK6yGOstQHTXGBkZz+YDubiYnwAN4lnmGnjYgP6uDhe+f54rLvxcOIq4tCOKzNoRzhoDyVhHUvK/LQuz3WmBQD0PVLU8Cs0BhWOpy6erDfa9vlG0QD0MaLdy18dUeTrNY6O7KI0GO4dYg3k5m6cK05i/nW1tnpIHRE1mxf79lX4NmTkRtdU+xfDvvk5g6OYJr+O+e9zEvnYbzIDjq1IkNNdV+XJaDUrBqNKXxWUNH01t0FwQSBXqQ6JqlFVF2P6nPDqsrpV6NIa9Ovw3Z6oz7qBZAc2qsEZ3Embvjvlw49GnclnpL8p9D/w5E5w8u4xP2+2wGC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVRrqxlGv6/vU6vZLkGqOlLYVsjEZMzOyqZ6LbkcHyM=;
 b=dpT6YIj82pWtxR+4c1rTY4ZCDan8M4Oqo/v3ENbrLB1Wtd0lSOrxINnuJlaMDMwVWiLUu8X/EUItKkSGEsDL0f2sr70NZK6bvwa7SFU+Rl3OVB+zVQyKYFOBBzmMoFM7kdH+pose2nktvtjUUl3Vjd0mbLtNZxV1Ikl/iuc0Pr0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BYAPR11MB3336.namprd11.prod.outlook.com (2603:10b6:a03:1a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Tue, 5 Jan
 2021 05:42:22 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:42:22 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        james.quinlan@broadcom.com, Kexin.Hao@windriver.com,
        meng.li@windriver.com
Subject: [PATCH v2] drivers core: Free dma_range_map when driver probe failed
Date:   Tue,  5 Jan 2021 13:41:48 +0800
Message-Id: <20210105054148.13625-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Tue, 5 Jan 2021 05:42:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 925e0bf1-de34-4473-8a9e-08d8b13cacac
X-MS-TrafficTypeDiagnostic: BYAPR11MB3336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB3336CB5C4E3373521D0F8515F1D10@BYAPR11MB3336.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyPmvMdzEhXIL0HCBN16LzEhwa1rtsbpJMw+DVemDJo084wDY4wctVgHBeQ2huuY+LUaz+p03WlGx1NFel8Ew2m2hIoyxxP2iDvKCwFAnySRIhZZ4NaAF897c+VMZncSSBSpinsRWLan1KzFbNQ1ktOQO0x6HOPIwo+Rn97WPdWMZs5I3RYm//Svh8u4JvYfJibkbKUWOFXSDVcK4r6qo3eqPIZztBOseaR5tMFwPiIXfbjoIEiPn3TivW0SaEYIFjrNGMBDuew6085ugQe/VYr7kmkiEp1daHTgKZdWoBhPlGB87rbh4O1cxvtmh9TdKJ06zM22kxsO6O18rAXEvDYizKbarXboNYR822Ol0PAAbPwz/ITaiGyBrwARzgeU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6486002)(6666004)(5660300002)(6916009)(186003)(16526019)(83380400001)(107886003)(66476007)(9686003)(66946007)(6512007)(316002)(66556008)(956004)(36756003)(6506007)(4326008)(86362001)(8936002)(8676002)(26005)(2906002)(478600001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ohWMvk3iLpQTsJSUnQB4c9K5P5lqvGIFbPWqU/tXX87Xaf2pVvkvFm1JHZM3?=
 =?us-ascii?Q?qM2NL6XgtX0WIH1ZAlRdBIn4n/EnoBFwKnQEl3/iXPzxd08156p9Uhjs3G0l?=
 =?us-ascii?Q?HF8lL8YAs5vni3rMwh8QfZLE+qLQuMbBBCExQNF3nWRel6cl9Im0n3N7pL6y?=
 =?us-ascii?Q?NFLRqP74V2k6RMeIrT2wIzbHxgd3CjFOphZyh5s60wigNulkmO7zFkpQLRn9?=
 =?us-ascii?Q?UYXwAjTJSlxE78gmnYrpvtP44zwp7YFR1058z8OBYDa4ZBeQuW24+Yrm8yMp?=
 =?us-ascii?Q?JtwvPmpraRHzSLqlOeg84J+JULK0eAgWUq2BynEojDJaXZlsL0s45F/+Ym+v?=
 =?us-ascii?Q?DHnoZISxZbr5jB2ZiWTpFqK6lG1gIF1paMvvsmm+7wDah6unMLAVwIM+7xB+?=
 =?us-ascii?Q?Inq8oUZ0S46DRa5gbTLLguHrwDWH48cgLFj62BpUOaj3izIMf/cMS7fRaqzX?=
 =?us-ascii?Q?hjh6nKMdnbbgPmCyuLY5La85Ow/zY0Ixud1Sq/i3Ro8/eUHowsiVTh00h6vr?=
 =?us-ascii?Q?EPrxXaSgWdohL8bReVM5Ou0WNbYHZKKfB08JIuQcwSC/BtKyBuYEkQu2q+Ho?=
 =?us-ascii?Q?OB4CxMJ1otyIkFsm3S3dJf22aKBYah1Wm4BnqnmC8J/cyArNMUBNqkPh3RL/?=
 =?us-ascii?Q?2d4UEjEs5Y2p6yTjUpTtIXXDmlLVEKQfqCPugKW9SYgPVbAxOS4bUVOlz5Y5?=
 =?us-ascii?Q?PZ35lMolK+ZsHwUUj2FXIcPYt7Zwwwn42GtjNEWf3aEYzZJCFZXdD6ygjVY4?=
 =?us-ascii?Q?HXG9P6NKcU5VV+hQWYGmDNuDQm1qbgWW1W32YBKt2lg3U8zU6KEKTgMozf7L?=
 =?us-ascii?Q?YVJVlNNjnowsHpfa4QDbtSHIq55gQM+YBg+YnfG6vJkwIuOGa16454yRb8QK?=
 =?us-ascii?Q?AUBSoUNuC4R6ZsDscrIFUZCmrWllkhQO8zOBH7RGGwutSXPVEL0GzN1B1y4o?=
 =?us-ascii?Q?6cwfuvpoRaEgTzz4yV14MaTQU5CcLyU+VLRT9ilolwCOLVVNj7HFc8Ltr38w?=
 =?us-ascii?Q?reEH?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 05:42:22.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e0bf1-de34-4473-8a9e-08d8b13cacac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw9pT+D4utCWMgTqdJl8Y2oVy0IvyGtCUOYv3e9hex3FP0hkbnQt3DHP7SsXVnHsl9P/WQoTTofSsCYo5m+Knw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3336
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEB278187
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgIYH17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:59 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:61604
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/8rsNAVtArhN+cf6mN/rf0iT9jTn+cQOujpguY3ctllVIMktfI5UgB9/1vHdRb/6FOhgvUYnJZhj63OgHvHxlmGh1uP3k6BEy/MMVjI7JbcKmOco64c0ySvNB6zCi0CKVI8rWkoIvaatK+FHSr8i11OpM2XJ/SGwzY5QIbrNztapip4SqlK0N57qvfBftA92NgCaQCfx6GvOak0pdXrPmhD10NgddZeDRlgF/JMlh3cgNwqMJJxcqdBECAVYuUmLqCmCottvPikqFdAg0PyFlINHYj6Kdng7mpmy7qGNfjDV+DtZxOOCZvglWgfj+H9IM+EZvi8ZPkZo+4dQAlhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJlE94UsdtyAZCUv/h97MHNnaHacDeUgubWz1sp1w4g=;
 b=GNMkR6UbrWQE3c3p/vE97Aw0iCMno9TxMo+w+X3ajl9vcRN34em64lUJetJfmQJJT3toikaaYrzcig7GY6bCgmNamR7Gz2GnbEzzX92koF0pytrVqX9y0rLKL1pH4WLbU09mneMZIxQp0Ptd0RUnFZtYgCpiz2wvP4mkbMpJSgKSVMEVLGxJHTcvJySSR1uCuEtDTegD6bdE8E8Aa1lmxWXal/VE0F0EfZld8z01o4ncJH3DS1+XUoAYWr+1UMoz4Xc1UllLB/ORJpbJI0H9cIjar8OQuABXWZ0uc04qOYV4n7zpJTNQDhh8wGtMDQELByT9ZgJPvig6qtQm+YSR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJlE94UsdtyAZCUv/h97MHNnaHacDeUgubWz1sp1w4g=;
 b=j2GxSDWogInMQN3+xO2m/P6/AdzRfkYO7AkqVOm/aN4xMYbFO4tvGBocz7XG6osyG0eppJP4wm0bxFJ4nGRvQ0yJQwspFhGVsMJaNh+did+qI4R7AQhesp4R/VWlOVcBclV52x43SDcmVyFLgT4SsUr6sVCASnX6vCQAO/9sdfA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5216.eurprd04.prod.outlook.com (2603:10a6:803:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:27:54 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 5/5] misc: vop: mapping kernel memory to user space as noncached
Date:   Fri, 25 Sep 2020 15:26:30 +0800
Message-Id: <20200925072630.8157-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d1adff2-cc35-4d12-dcf1-08d861248412
X-MS-TrafficTypeDiagnostic: VI1PR04MB5216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB52165C314AD664C3FFCF753D92360@VI1PR04MB5216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVgUj5L3lG3wWukN4DnmeygMZ3WTVSkgbml9JbPiyUwlgAYgFLp1yAfoyKpQBXJc0VPELj0KjmQ5lc8cijFAabZsfAM3C0ijQMdQb5TFWfZqRSaSmQ4ZWVL3oatD1JzPKhzaofJF1KmTt00FGTCWqMcDAULwEADq74QJltMeayMTVQY8S/mARrRB9UuD4x3Xh3VhR3EIlWplp38AQqr0Pz0e6n13ZaUuUyQpFj+VrnUI/+ChclNowzYjmclEpYs2hHrNWC/bVv11/enJ7+aNNWiauV4KmDhqWXz8dREZRPWbY35hzO1ZMEtEXuHcmk7EOuwOJvyN2+SqTZyfrLk5FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(2616005)(66476007)(5660300002)(6512007)(66556008)(8676002)(7416002)(44832011)(83380400001)(4326008)(66946007)(8936002)(36756003)(6666004)(86362001)(16526019)(956004)(316002)(6506007)(478600001)(52116002)(1076003)(26005)(4744005)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /5PHRMDrlGgh7PCTjHbRqoJsBFtoNTTYo2jt+KfLBITjyYQ7cCsWQzgkCsD+HBstaO2ROZYlzZwo0m3kNe+5Qgg5nJg/kYEETbokNpfKBVlg8UZc+mGm/8iAQSYyN2lrdIznIc/jLd5jmtr+WY9V/GAIm4UrPUImZZPPXDAryK076NyAKS/GgRpxL4/S0kUAPedBvIY6wxIBdEhcxQwTMDRJHNN6jIWezNZcrZTWy0v2e7j6PSNf4jYf1L5jWLKVh4Xpz9XB62zrzOOqgCBhyKoZhqwgN3DYqGn9xCtEndtVHJ1gxzEt1D8QEMU2v3j5BlwMetf8V1tuWZ6fE2sMhlT8s9K9Of+TT5szqkcEmKBZNDbGDvikWBDvJtw2Q6cYBP520nVdf0jgIzWIEBXoZ0lElM7fM8+SNiimTuqTDFFFV+BdDVPnvfCnQk9PVMGGvw5zDap73IYvPznPkYgvNnGmSJNZuvURB2CjrnMnGTOh/Edj6jwy4vF7gEZ8PLOk87+CS/rHEXRwo0O5ddJJsCOUsnzdoQTkCHrfDSLYQI4JSPUcQRRVtZyYKXVeh5HMVqh5+SH2YgzNKRg3MvVM2yLy65jTHuSkctPfGKI7gFgmmwXcGt1/S/HC2P58H9N2OzHW7omy0NkV1FIuItr/6g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1adff2-cc35-4d12-dcf1-08d861248412
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:54.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4ICoqT7lsRRTb/IGZlTH07zThGHM2gl4jASEpkrBM8w09a9zxYa15173GTK2O5PQqtm9UBYQw9RVJvyu4/9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping kernel space memory to user space as noncached for noncoherent
platform, since user space need check avail_idx and device page flags
timely.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index aa2dd240c11e..9850515e8d21 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1139,7 +1139,9 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 		}
 		err = remap_pfn_range(vma, vma->vm_start + offset,
 				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+				      dev_is_dma_coherent(vop_dev(vdev)) ? vma->vm_page_prot :
+							  pgprot_noncached(vma->vm_page_prot));
+
 		if (err)
 			goto ret;
 		size_rem -= size;
-- 
2.17.1


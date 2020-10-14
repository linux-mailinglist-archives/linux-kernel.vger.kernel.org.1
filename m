Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3928DAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgJNHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:55:37 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:60576
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbgJNHzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UiFStfoEYrgQbp2/JGFd9OZzb3h76m/j4S/C7F50e04fUjpthg6as50jH9UXgK+PfjV1kzUa2DPo0YbYO2uRG7jy9K8dSLFYrEYx9qu6dpUXVdi5dHdc0eXln1RtU7jGAUU5MuvsRPMloZ61OODo1VblO9jee/rthbPzRqOYBEnfH2cVZsjKEiEcyimYYIFObcZY7FUDJ2vE83pi8Av87DBoVqkBcgp0iHyucnv03g/Zx8XqNBRcmNFlmNwoUMRKQg9Vc+jFly8wg5nStXaq0sI2HdZVCxq5gnTK4hzYEPJIGMGw1DZcIsM16R+ZcRJVXEEH+5LGiPOMCo0xF4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuJwmGaquEy1UX2tFjmN6OtHApjp0wNzSpAhOZy6gps=;
 b=b7D+vHJHVBlqbBhd9KlzlNABK4g/vE22NOB4rrqdKqyCl7Fy9NHxqW0NrYW49hNkJ42YBsaAKFkQjPA9J2B0VBuksi1HaMNXCexI0PClWUM8XdTGLMtWxY4EyQ81ySyMG93UKxPpwzJd86ZsoKUuaUKGZ8oWhiXKjc/7kSMEI0kc53s7BIBoHIqUk4QdXO/qyHr5ujWLdpP+6dJGKzY8ZdKvd5yHwzo9WhfyMQqxj/Ypo+BeArGeWMeLmGA3EXJUthOwBekqNvwMGUYmbaVFItPRWUbRRXbYZ/fCwLBx7ekonKLDBo/BuheMBAEmBj1a1B9td4VrPjRNLgO6nU61TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuJwmGaquEy1UX2tFjmN6OtHApjp0wNzSpAhOZy6gps=;
 b=L2WgQZoOa74bl0rBNRov3sgwdmmU+al9cc+sYqr3K27+55Q6RUy5DhbBD4ZOjV7SdBbMpRkp16FXv4E1/skSr/n5C+cHRQgAGLklRm+JII2t2wMAa9HY1SWrG1oCNCHDdDndc2paI5lY18lPxzAGbm1e2fwIB6vlF8sVSH4CdeQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 07:55:34 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 07:55:34 +0000
From:   Zqiang <qiang.zhang@windriver.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: function: printer: Fix usb function descriptors leak
Date:   Wed, 14 Oct 2020 15:55:23 +0800
Message-Id: <20201014075523.15688-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.13 via Frontend Transport; Wed, 14 Oct 2020 07:55:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aecd6417-69e0-450b-42b0-08d8701687d6
X-MS-TrafficTypeDiagnostic: BYAPR11MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3029A235C386556BE7F81402FF050@BYAPR11MB3029.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYbBfStjPb5xr99h/10JYPnLpRZE/oGoC4GrYhuLWwoGwtIAir8qvQWosZkA41ubJwFLEaJ8UdjRPAW0E6KMlJavFOVkVNp2HowKm7+B2H3BG6NK2Shv6WZtwVTgFcgep5IsgjSdFteDqSATDfvLqdYhffrHDLc26iJjpCrK5CSmed5+ro0o1078+kp2oF7kXSdRzZLQexNVTFlYViufCwKV1yuc/sq7onmnkoqcc51zcbiddnp+IUND/xVkqz/ZVAHdvZqMMnvMMlCRG6PVi3EV93BJMAugAiCbGXlxCS2+I5PLAafAqpNU2ROiEgiz/9RuXQgX6xWc30PntTxLvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(366004)(16526019)(66476007)(4326008)(66946007)(66556008)(8676002)(316002)(956004)(186003)(2616005)(6506007)(52116002)(8936002)(478600001)(26005)(6512007)(6486002)(2906002)(86362001)(6666004)(5660300002)(1076003)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YRelOlBNT7qEGGdkYd1ziH7fW2eyde4oUYAr1rDfxD6F8nbLDWGweUINpQvnrRZ5Rho67Tv3eQGf7hBDlMM4tXZ9IS4BmPWA9UrEuZsk2ItMPWfjLODHY0WjaXNOVzCFnx1uRoK2scbYxm4p3QqnLsQDlpvg9zGmivxHJglJee6kOC/XqAYTZYLAvZdafT4aRQTW1T+ztbZxP5ld3LifouTDTNsjrKDhSr32ytcJNb2c1NUUfPkQcxlCFx3R20T3+hoAD2QuO2oOIGiqO78BekOW6CJxKHarfHSFpPPl8Cxe10rFjXJOPLn/RReRPFkYdGe99wBnGOweUJvI+kQ0QWXZkCJJ+CHfRffbEdqVySAEL4BmvYAXTL4DwUd94/F0cpus0bFYuC33UywgIrx46/uF9RVfIU+mMhhNeThijmKLtf6E0miDeqrQyQmTsN2lisLVOUOqdXAs6a0enw/Y6tFubu2P1pwjPnG17QSSxdqI+yotz9roeE+ls08hazQctgHZzeReflpUPWopUgA681qQbpXmA1hUe2ZBw0fI7lXOTVIDMHummbs2/44LBaV8D+Fkxqlckpufgj77uu87L9XVlZEAKo+lHSqllstyLdvHxjNI5FxzFOD2pJWuc6yk+CMB0JhfCXyaE8M0sIvjZw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecd6417-69e0-450b-42b0-08d8701687d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:55:34.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4czeABXkf5krJN3BNAspTa4BRX+7LjssKiE5lrZ0KdFeFl1OER3TkJsnFj59CvZ+JNDl6fe3JgtR8TS5TidRxTGHq7hHXoA40u3wVeDdRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after call 'usb_assign_descriptors' func, the
'usb_free_all_descriptors' need to be call to release memory space
occupied by function descriptors.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 drivers/usb/gadget/function/f_printer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 64a4112068fc..2f1eb2e81d30 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1162,6 +1162,7 @@ static int printer_func_bind(struct usb_configuration *c,
 		printer_req_free(dev->in_ep, req);
 	}
 
+	usb_free_all_descriptors(f);
 	return ret;
 
 }
-- 
2.17.1


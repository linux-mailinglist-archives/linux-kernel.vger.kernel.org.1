Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2428DB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgJNI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:29:03 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:4705
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgJNI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZa4/mjP9MHXRkhnB3Zpm77lhvKM1GdXSfT65BDBoVXjKVGBqyGNwgbjBPEuf5o3pCeQQTPcdzmFWiZkgz789g2schkTuK0Zgats3E80evxXVRB0lisrsnuHkne1e/w4r7jCQVqLSttT8F4+GzzIzO3oGIFIzpQebH7xdyVFbgMEXwoYPpFDCO+8EuPwLdZpi9ou3xvoLUd3p+E9XJ4w+ODin2bG8WqqnYShYVWpoIM02Ltq7F2hm07xnFSjTDWU832jTbmz4JTp/LzUtSCqp1KgUYu+mztWfQ2eS9Giyc3H7Y+y0gLdPz0iw6hGJZ0YSY0HckU38gHxqzEy2ueO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynWEd2qSs5qCKoF9q52w/ebLJt89WhqzVwiL5pARPNo=;
 b=XIVONt2U8QLQvIYviF5Jp2EozTXpPrJzR01n4MdSGeYITj/DRepCNAon5pP/l4MKVjQ7u7C7Re9NOmgalaPeShcOkXg6gMC8odzd1ccPn5XoHTSRzXBDPuf2UM2QLrtgkGpzrr1RdHTxCpVT68hUCzBoTNNGiVqYzGw1HcSXKY8Hc8Ssg9zWglHuiAHqGPPPWOj7idTLgji3T+GskuQjavi0Z5VLqJUbXK5rloHcTtCno0en4oDZjRA6yXiOdmTOadClt9otzZhMirSzyrN8rFCJ7Xf9goTOdaSGWDjm82iPZ1SShiZ4zZbW81Olnkds2ku4Z1ohNeJTRaCqXXuRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynWEd2qSs5qCKoF9q52w/ebLJt89WhqzVwiL5pARPNo=;
 b=RH4FaDybnFKrcCIAdO0c1BxyJWPslEgEGHg6mc5Myzxadr+KoEslN4CPSFBPmiWClHqqS1O4rlTeA4lJfSK3e4JX9u5F8msO+WX8o01lh0T9udv7KcACehGPL6pN/aMN5Wk2Xe5EEAM0orJCTcDjvXltpjYkTucxqd1i1ixBdR4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2679.namprd11.prod.outlook.com (2603:10b6:a02:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 08:29:01 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 08:29:01 +0000
From:   qiang.zhang@windriver.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: function: printer: Fix usb function descriptors leak
Date:   Wed, 14 Oct 2020 16:28:50 +0800
Message-Id: <20201014082850.16838-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BY5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:a03:1a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 14 Oct 2020 08:28:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2355b02-78f4-4196-4825-08d8701b33c7
X-MS-TrafficTypeDiagnostic: BYAPR11MB2679:
X-Microsoft-Antispam-PRVS: <BYAPR11MB26799A7BA5ABE88BE6D31157FF050@BYAPR11MB2679.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yx1/iFpODhQj8N4/Gk90FOML3DklNt6GU+hK4L6piHuE8Vq1saNQGtNJYMHuXPHEbWTEbz6OjMh8km7VTTYnhKvV89nTGHab7m+jSNfRQnoiGhKUQ2WsmRmJFgJmDxqTD0nnEPW/8URS2sQOY4pZAFG9ORsSbupMT2686bjGSjP7DZeZ1fstMyWqZrGnreesInGPZJLccvLup0YWzDuQWJ4fELAy4P5wz6fg9PFZFkKboJ/UN8y3durtMWvzVqvzOqWdDBp3rSFXEokaWT97GgL+FytWqzET4Gr5h9yXdE3VlUxUgBjoSP16zAjmbHsab6HnFM4UIcCL1T/VAOs3VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(86362001)(6666004)(8936002)(186003)(9686003)(6512007)(16526019)(1076003)(26005)(4326008)(66946007)(66476007)(36756003)(316002)(4744005)(6506007)(66556008)(2616005)(478600001)(5660300002)(8676002)(956004)(52116002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hZ9YWAja9yV/RDDUN/m9r4DVwN+moxHuWqeFU3u0VCxwPo2ygiVGPrXNjEyLSOpESctn0QSFZQysZOi/Agsd2Xy8A40RfFhhNc3yBUgE0MJfp5Wme4aBpBXaP3WLC3CAwZnm8YYT6Bv+pm9+g7jwt7/c475t/HX7GgxavEQie2szHPAGtcT/lcIFspk1Y5exzW6BnPw6PXHGsOvqAhCTgJPCd4Yabgu6eWcZ+FnZX6qAvz+JK+xAfrBIsExTfiXX5uUYIDE0euxNiMSbOGFC3ovgn5lkYvB7ty9AOzcH2rNnyhimHVMgELjEQ0N1F00hDzbY445HW9J2FmxU2iwO1rA1F0EJKD0g50W/87RG8CcIPwtLXTDMic8TqVRu+cZDqr4Od6Zi8IebexZMy7azBhQ8090B9mGi9yk+jN2njOP2m0QIpMKKnYkX9SuZVDrU7RS67rkC+SzRQGOCw9ZIp4QLRwaKdNkQz/p66295x/3QPbGYRYAayw1VzYCI7j1Uul42yLrU8i4hxith9VG51GA6m8k5TAVH/yiUxeW8oHKkwuoR3W20wI7JfO6guWM6z51/2YXYZ01rafrQpfuleEZVjZJ2C+CpA0dICPnpEzWxdQKb8Yndy5Wm2cWJAKKMGC18NidNNmb51qYhGe/i/w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2355b02-78f4-4196-4825-08d8701b33c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 08:29:01.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Na3sV5l6R//G4PUQxrf7iFikuzVaXe+489oc1VzWG+hhsEW/32SuSliqDgicb1AJgt221q7JikuL+FMXC0Ego6Di+v08m0fr+BWrBLsgSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2679
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

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


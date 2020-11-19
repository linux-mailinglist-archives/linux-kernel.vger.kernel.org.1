Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43942B90CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKSLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:18:15 -0500
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:61721
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbgKSLSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:18:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK8CyCSVbVKEFiRFljx5oS3UlLv1rcwAkiGPzhc4WOP/PJ/nBrwy0UzARqebxTTchs0OnoYVCY66CeUttAYO+VLrX7vAXZQ0KDL+q+u3qUGwaiFwHcApjjY4U+JzgdRnhIV8VVmqiAxRFTqYs9GsbJtH9EMSRYlvgY+ALlUPhmitP+BVTPY9XCmVIsYGuLNiA0ZSstPTUbMMrwS2hTMaqhK67Z/5nnYTYeNBGiM1lQScH4aUHTZMg6KQs5SCyRDTgDBRQG7Y+nSVpJ67f6I6fHVil6GIW/ReDRv68sKXbTs1ooFlqTQrxlVPTdFnI/ATEb/C+iZmpvC/+2ugitaEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gQ5JRoT/fKJo916Za656pYn7tm1hOCXBVbgoFOOpFU=;
 b=eRbb1dnvMUKQ5ymixj9sQR9rA4pyXm/PGdnTzOItOFRE/NAoHLJ1v79de1dgtUT/Mk+k48U6cMkcQ71uPz0rC02jrBfrEFdylKN+ayKH4zNnJK4rW3BRp3Y9M1PaP+pjg50V+yekXJwOqgRy/EO/dbxTtoVAmZcwO7symktlRsGiYw3wHQ4kzLv3N+fc7X+yUSR+ZwlJhoGEyl8iE0mCqpJcZLKS7kHZK7C5WM4S+HcnnI+SDH7tF6bXAv9BfsP9AWPupG1LziABfPARLQ8RPOkEsob2lkSBrvMVwxtJJEw5uOtOoK+YQko4TJBjAnpeQix9zkbt9dXTvdu5S+POfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gQ5JRoT/fKJo916Za656pYn7tm1hOCXBVbgoFOOpFU=;
 b=TeNdAD+Hwscs+ONmIlnMDwrkmUh+in4DSeEqc0txmXdD2jBAd/CdQS37nhBzQkIcxhSx/PgCNwV8Veng1s8VSk0MLcnROujipHNbcIL4fV8vwYkDSAvGXA+6SG81WFioqaQPrIZ9ZIICCLKhNs9rjmA+9RQcjTfU7Z7zsQEuR8I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 11:18:11 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 11:18:11 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-imx@nxp.com, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] of: property: fix document of of_get_next_parent_dev
Date:   Thu, 19 Nov 2020 19:00:36 +0800
Message-Id: <20201119110036.19959-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201119110036.19959-1-aisheng.dong@nxp.com>
References: <20201119110036.19959-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.21 via Frontend Transport; Thu, 19 Nov 2020 11:18:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e309239-9539-4ebd-67d9-08d88c7ccca2
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7687956E205401A1F52DCFBD80E00@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxoOLjUEO/84jt26NPz9cQS39bH/TT2+8LO0+TBTU2Ve8tO7Pl/Sbkjl6EbNAZIFxtKn/hYnUSsy/TWED3lnLnG4LxX1In4EuvmyusV+JxYeE50G7fKKa8cH7QBiLDGZQ3jJCRtHA1x3lrtaoj3z6jXU0EW+tve98oYwL+CXsZ01GLHjcOWUxHad+oDmXWxprPW7JYrCs/rzPOvzA9rXJmHiuquZPn9ZhULAzpQ6C4rd+0KbD7vdk7d4/c8R9g64eJ+ngRdeeG3SvqzNXoCcLrUAiOHB1YESXtgxZ5VlmajigeCqmIpQm9zh8qwuIHqiK2nwcIv+eHmZxaQeZsJwig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(66476007)(66946007)(66556008)(6506007)(83380400001)(52116002)(6666004)(2616005)(6916009)(4744005)(6486002)(316002)(1076003)(956004)(4326008)(478600001)(16526019)(2906002)(8936002)(86362001)(26005)(186003)(5660300002)(6512007)(36756003)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O0MmoOAKWUXDRmgaAhLO6gvL7QLe/YopzmCiQM+vkzgrpkyweDH50n+QkEJgJNw4uVOwa/PpzRP+rW1cmvwP3qOYGfFfzWExauMW63dkvYdxj4xOW/nZyhvWa4d9Ox0alKKUlFH1Up+8HujAjK7RbeOeCifFllJJ55PL4sKkFk/kuUUVSNLARcLgZEiGz4CMp/VxsdtJsG5RExgAryOGPCMqZc1Or0FIHsUOmKKmw4WagDHbJmirZ8ezmdtXeBNX3va9i7NYOzh+s2TjVs+0dHKzITNwKKXJDX+ZBJ2NnVG0Zeur6TDwMu5yzBzXAA/7ZMLsr5qhYlGvjXAdWqIjlUCVmud63YdbgdFFamBCZ/iRo1zPzzG/p8VVPjf5ED6VVEbu4nnFxUS+6m/XNpm/r5TghNgnZS4IcJpecmfggMbQiQyON3LZ78x5+4O0w5TJEhuR8ytSzhO6aYGiQawXKqyrJ/RDIQJ+hO26XLH7/qfcVo+0hAEsDfT8Vs98gEhqljchqr9yXWAMeo6THpCtDt1O7ibO6ACfm95+cZK2E2EPNreW4XpaMPGoXMuvE22a1/rJE5pDWpMBZqu0E+Y7zb0KiPUvTncVWLGtq/vhv1akCBvNmQpck3t0zveZ3XthxZX3/+Ts1f193S3ftdepTQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e309239-9539-4ebd-67d9-08d88c7ccca2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 11:18:11.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZcknUpW+c4PI+Cgz50YAnBJEtStsN400+umTtVw1lRJfHbObCIu968laY9zQfjRjLxUf3nGAA+CO3zUz0EEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix document of of_get_next_parent_dev.

Cc: devicetree@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 21a854e85234..5bd4a9bead47 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1038,7 +1038,7 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 }
 
 /**
- * of_get_next_parent_dev - Add device link to supplier from supplier phandle
+ * of_get_next_parent_dev - Get the closest ancestor device of a device node
  * @np: device tree node
  *
  * Given a device tree node (@np), this function finds its closest ancestor
-- 
2.23.0


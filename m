Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA82D1751
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLGRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:16:33 -0500
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:21376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725814AbgLGRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:16:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CibmFSZc7jZrEqSDPz2sXwHdyuRNnYk+4BSh+CAQzfy3raXV5NA8Lqj/lxWjSMSFeM+AbNRVys8Cj41/ZYPE4S9usXf5bKmsXK3T6NE+xDjt6HyLt1V6hdIBvNPNj262RyB+N97M7/OHumocCS5cm/JXotE8rn0CizU9ncyQxbQbdt4KbvDghdiddXIv7+eixDjt9MJbXEBLf+1hfI+uyvRAuv5bpTSnQEbFDjuQzvO/wpHcCohxGo2RQu/JlqAvbZlXY9xKNxnEUJMFtZ7sBON3L5cn4TfKcH0m5SOSwhFwsDbdK7olAqgIh1v8+ZyB+sSxwafnEQe0ybF6Hj4Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df5skZVLzWVNxsqMBFh8DEQ2qNbfGjDR5LzyXhqVU1k=;
 b=Dj1oUjXz7W4J0Lg5gxK4EunwB34e+Dn776lEpE5rX9Nm5Fezj5l78vXeusjJt1Nr75ZBl/4qKln9MZCRYeVjWu1AoUYWFIde+PpJb7CU1rbM6i8RYQ4XRoBZ6XIX24eg7baUta6zr0+Xd3rJ1EnDvjGI4Q0k6Tw/AbPeXdDFYh1Tkg5Y1YaDeVIHA+KR1alMxL9woT1/a2L5DFnr/2uO+o6f7I2Z58gV+0oWv22PTTyDFNk/YKmKJ728kKwbOeFHa7e88DJsQ3dO8jFmjQgm+d5xbn04MKjQddOGMFLyCi4aIUJb56M4DZtPJSTPrT52MFkhEIRFY86QI3XPglubtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df5skZVLzWVNxsqMBFh8DEQ2qNbfGjDR5LzyXhqVU1k=;
 b=zpAe/Z8nZNjhSbBxvv8+5vMVX6y8CIQJVQruoLHZX+e3CZBUDYWLsNl2w6AL91xcczYfYEpAvQtuHTq2Gssvnq1plVoTkY5ghhh+uv2ZgJGvXnw9r8Jzwt0lVmzox72LTnzYpqH/rMwNx4fKBTymMUOAGKCyawNsquvRLc0e2Vg=
Received: from AM6PR10CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::27)
 by PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 17:15:44 +0000
Received: from AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::6e) by AM6PR10CA0014.outlook.office365.com
 (2603:10a6:209:89::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 17:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT033.mail.protection.outlook.com (10.152.8.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 17:15:40 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 7 Dec 2020 18:15:14 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 2325A3FBC3; Mon,  7 Dec 2020 17:15:14 +0000 (GMT)
Message-ID: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Mon, 7 Dec 2020 17:15:14 +0000
Subject: [PATCH 0/2] regulator: da9121: bug fixes
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        "Support Opensource" <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21be85a3-6410-4c17-600b-08d89ad3b9f8
X-MS-TrafficTypeDiagnostic: PR3PR10MB3897:
X-Microsoft-Antispam-PRVS: <PR3PR10MB389736E6D92A2219B2F3BE4FCBCE0@PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7SZfdbWV74ckhkc5zlcdsJzKzPqagfI+Lwl6lZBdyscjpN58wa8EFcTf5Nqu1EVYrmmTSrUWFBsE3wW7lJE7ewAfB8W4c5dSl/b004ZgFzdX0jdaN5/LFjx08MRfRsaIJ9t0ld7hhahJFVGc3LK0w0f5fbivl97CMtJYLmK13X7EZZrENO9kyZTm+TPAmoM+UDzlA69M84l1gbHl+8lUIIiKuXHB09j8i9c40953Ia2P/Szl8mpFCSkbK5wtUCDaw/sDya/Kv3Z9gvVdkX7qlSATCORc3dAh7IdXjfCRkb6ksh+VTGGpg+iMXPP2XHAsRAQBL/yzCed3RIyIi3VwEv2Aj1piUK+1RpoJeQxWqz+qQ5mKZvRNvHY2TLQcNriduVP/s3fZ87oEB5oxO/tZA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(107886003)(6266002)(82310400003)(54906003)(81166007)(426003)(4326008)(8936002)(5660300002)(47076004)(26005)(82740400003)(186003)(356005)(42186006)(4744005)(2906002)(2616005)(336012)(36756003)(70206006)(478600001)(6916009)(70586007)(83380400001)(316002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 17:15:40.7231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be85a3-6410-4c17-600b-08d89ad3b9f8
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3897
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of bugs in the DA9121 driver.
One in an uninialised string I forgot to remove when changing to of_parse_cb()
The other is an index for an optional DT property which overflows


Adam Ward (2):
  regulator: da9121: Remove uninitialised string variable
  regulator: da9121: Fix index used for DT property

 drivers/regulator/da9121-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
1.9.1


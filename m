Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E529417D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395511AbgJTReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:34:20 -0400
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:43808
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgJTReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ednHSXUdPY+ChlrXroFoqm38ctqTDDgnYwylVGUbFWwCcoJvNDTD/BpmtlYyOJyWyO8tHwEc4bZHirG5eHmrBzOLGE5wGostwau8GYDxkUbfdXEag8/kXZPds5FimeHP+QzI1iYekFDapvCchcsgRBguXEyqHDGKqIwtQKU4/Um/AfGmKJxGhu/BEU/77Yy0sBKoswNe53ANx99WSSS17kgCjCiSatmTa9jUrDvJthY+L81AjrrNZ6M8uh4jxt8OMAgK3ZKpVMw3DrNcxOUxT/X++ePbBy712N2+JZmd9ymsqTESWnvNeiUbdcr6J57lIOVLcnjtURPLGM6LEgEJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhKytHx+CFmYBZVnLB1kNatWcJstmsrjA3CuSPDERY=;
 b=Iw1KcOO8vjPqsV69Clyfd46eoisx3JbYywiVot4wfS203pM18mfhXs8/bYcgLIrZFJpkp4h45CQXoI1O5ax8aOX5Mg6oV0iH4KUb7GM+oapW/whR5Q56lWKeTFyglaq9hXBaXPvbnxjHtIQrhBTMPWcYWvYZkwb6Fh67ADdWBMd4uIj5AhR0rhJOvPBKsLWylJCNivu0QQ+mr0rb3r0IrrUCBB67/sX0grDNmIV29kYgbdHiNOWuk5Yrfusg8GytzBOcbF/FybwZrXV7aJOL93ZDEHYKLidv017AFyKcV5A/DKaQDx7k6PAYYJA87ApTMaE63c2hvPK9hj71LhJz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhKytHx+CFmYBZVnLB1kNatWcJstmsrjA3CuSPDERY=;
 b=VF7pAJR5VUBnTP1z/aNGGJV69G++aQTW9yEdny6LZF68cspigWqISRbfRr4iNuSa1suScnBnLOilvRPK6ryZt7IwcOsJZUdRC2KQCYn4uXj7/fUNoQvZvSP1WgfP2u+A8Lhw1QFf3Xt4bsdCFPjKRo4dD3lDfNqqDO/9MuLhjAw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN8PR01MB5697.prod.exchangelabs.com (2603:10b6:408:b6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Tue, 20 Oct 2020 17:34:15 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 17:34:15 +0000
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     patches@amperecomputing.com, linux-kernel@vger.kernel.org,
        Anshuman.Khandual@arm.com, Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Subject: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Date:   Tue, 20 Oct 2020 10:34:09 -0700
Message-Id: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:903:101::22) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amperecomputing.com (4.28.12.214) by CY4PR14CA0036.namprd14.prod.outlook.com (2603:10b6:903:101::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 17:34:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf0e1f6-33e6-48bf-9bf7-08d8751e5d6c
X-MS-TrafficTypeDiagnostic: BN8PR01MB5697:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR01MB5697FF2BFF91BEC6466175649D1F0@BN8PR01MB5697.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GsphlQKXBCQIUXQw4fjnCDC/HqnchU521yXsMsxK1V2cgoTCt6QkIsdWgDKrRzFMLrLRVzB9c/kHCaFt3Fmoq718f9VYYPyiWUvHinJ79JHlr6oLdXz6oxh7ebIxSUCgW6+DTVwfO1DuLlyJs43Pv4xXExr2gDq94mq+J34lY/RRAre/Uvx6R2cAdi9coEIFLoCBCr5oVPXhQKfaJXgZhPexbQi4FaGLjx6AdWdx4XxwVP+QAsc6NfHd9okPj2/xtLZfS5VYq/K9OYYbUQzks89XZPuItodv/y8FZHZZ7eTQiwfeMcYoAh52VRbf/+8jH/p31ypHclDV4h/o1fKbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39830400003)(396003)(366004)(8936002)(66946007)(16526019)(186003)(86362001)(2906002)(83380400001)(66556008)(4744005)(6916009)(52116002)(478600001)(8886007)(2616005)(66476007)(316002)(6666004)(26005)(107886003)(8676002)(4326008)(1076003)(5660300002)(956004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1MbEBmSWZNfmQ7YZqPHP3GInj+72jbPcl59CuMIIetxmYybumC/3xJClmP3WHqZXWuBOfjEuDOKA9WsocUA3IyoIh/JOe+hHKwfid5UIOPyu0K0cAt76TgG6owNqBNUf0gfIVOHO1Wujr6tIck2/maoFDrYKs2vJktCfEK4GTrmiXJ98GQ2c/kU9fL1UKFfJp8aXWXlvnbY4nqLUZrp8srO11e5jlXyWdgSNWbfXzxkYypYy/3wZ1gkRzMePBSuriAtvZ1nelnRBkoXXBl/DNNldoD/4Z27ITVBzb7vRZ6MMzG/Gzg/mZpcoEWGzPYhN/wQzyY1NxVr+NgKaiktqlEUY6uCL4HCl6R8K1l/NgwK1zpCWr63d1wOsOt5Qd8nx5LP7ear1miw5loBzNKgUPX3T780b19xbeXGg0UyT7L8nVlNZKN0jw7F/6x162/KfkfDUWLKVR3mz8t4KdttGURnNxLpiTJqsFUBkCHgs/8Ub8CTMBrJWxTbBC40BIoVlWEkudc7/rI2rpr3QNMnOXLT+iEkFAQH7Do9F2LqKZy00hDiC/4NtxJs5cY3ICudRynfzleqorUn06JaSSyIBPVG8jJOoJ59XZzopj1v0O8rE6FKeRHafafpKnMIy/1ywNpskBeERe5D2MY1CAPcwuw==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf0e1f6-33e6-48bf-9bf7-08d8751e5d6c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 17:34:15.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpUp6YgcveKlrZZiGra+6cVuTdWNr2Dkp9Kyo9xfWDFhgEjNBVE+VGfogWbouWdkwQLpRVgE+X0RCv8VUDLNfCkSw3eBNFvuFahqv9Oy6uLOEcpPa9EIiEzRfVKIefFj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5697
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
reach or exceed 16. Increase the number to 64 (matching x86_64).

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 893130ce1626..3e69d3c981be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -980,7 +980,7 @@ config NUMA
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
-	default "2"
+	default "6"
 	depends on NEED_MULTIPLE_NODES
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
-- 
2.28.0


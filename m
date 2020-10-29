Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA729F64C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgJ2UjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:39:10 -0400
Received: from mail-dm6nam11hn2205.outbound.protection.outlook.com ([52.100.172.205]:57889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgJ2UiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM9jNYzIkzXzOQBlV2dXrOF8wHwGNma76lmMpl8T+4ABQ0n1B96tMDvV+U9kWwmykHyGwp9B3tohCZQI9jUOeP8Z9nGUbWRPP5Z216Yek5qg8qwjwQwcXmycPeWjHwD3sj2qNzzx0fJeSPOvc9rERiblAIHgm6pEPvoTGExPnRdJrn/NxG06teDlT2SNESkGn+EchUAMZJ078FqViYWEhQzERs0EejxiwtZSnGgtnbK0KqzBi+HrQMyrqFCrgoUwpITO/2Mtf+K9aT6UUHUmFDTF8s/SSNWgbabAuWcxm3/xDYt0GxiBNoedb9U8LNmWfLMmIcwpj/tLYBmjR5E4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzLoeNu8C2fNqoQ/+4dYl0sl8zNyL2SuNKtyxIN8BTU=;
 b=hjTaGlXhmVGBgRmm36flhZqlkgn4fpBYakvspE1JjgFs+3ENrDw9mmOQLckZrRWnJqMjvAe2GiJuUd9HCwgdr2f+WyN2fj12yqyODkN+25PZxAHnbG3EUQVH4fWff3vS3jPQ1V17xvq7F4hle5NtuDy4iHfs8J37xJVsoyCoYfTENkKuDjLiNltb1eJSraXprq9qV0oWlUMGpd0ElOFTXGdVHbrfwMCXJGrGfnngbvfrMqA5K1fCpaY+FGj6huASR1nXyzIpQ5hDniZ2FMn9N5PwJMakfN6UjsAqhl2Q7eRth2osg8JMTIlbggmQ0X6S8kQr/Q7u3a9sQDZGUXT1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzLoeNu8C2fNqoQ/+4dYl0sl8zNyL2SuNKtyxIN8BTU=;
 b=GBupWsD96itR9CdIK2lWeTvlGYU83AQfUEoJhNiOH61krY5T984+QnT018bD4+eY/iY0pH3MLDbTKyZIehlOXxNKWP3044JRzh5/lVUjyYrs/ILW7t4z2EWcfMzdlTJC8WVMvDOH36IPx6zanourHSUUHXoKFND2JKzST16p4jY=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN3PR01MB2148.prod.exchangelabs.com (2a01:111:e400:7bb4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Thu, 29 Oct 2020 20:37:56 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 20:37:56 +0000
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     patches@amperecomputing.com, linux-kernel@vger.kernel.org,
        Anshuman.Khandual@arm.com, Valentin.Schneider@arm.com,
        catalin.marinas@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Subject: [PATCH v2] arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
Date:   Thu, 29 Oct 2020 13:37:52 -0700
Message-Id: <20201029203752.1114948-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:903:dd::18) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR21CA0008.namprd21.prod.outlook.com (2603:10b6:903:dd::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.5 via Frontend Transport; Thu, 29 Oct 2020 20:37:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea13c18-aa2f-4717-b159-08d87c4a8441
X-MS-TrafficTypeDiagnostic: BN3PR01MB2148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN3PR01MB2148D188008CC774E1D3F2F29D140@BN3PR01MB2148.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guvClOSrchX9JcyNZFCee6WyvhA42Yl61t7+FTd2GfvFkJgCnxow6DZqN0JWHeg3+l/ISYdv9hnvvvpa6v4pr7cqKb9egplKOGv4T4o8nNVJvU3HzEUWm21Ux+aMRjVkyRW/Nd0gJVNhgT6vWxLDpP5u7YHg0JAJVWHnRLES+QoOLO4NvSIdKJUFMAD5GgnQcYQpEvAr8sMdn4wYZRIO96OzM1+aoT98wA+NaLnyb8T5JX+JwuC2HUbKq/sEmTUCw03I63JVtGGXWEqIriQHpwCTc076uUAqFLSAtfgRVk2gzsIOUIY+W3KLQOoivfzgc9VVQd/ZL+cGkVitgEph76gb0zOIAbSrU+N3gw+9/XgZI2or3NL/+BA0zqpPaThXTuy2uuxEyUOs3VON0Bv7Q9CbsQ+S+b+kD7n+IGTViwWttVMpqgCtIubi7/8KwSDKpzcEV4Dy30k7Zl0UT6gNyel0l0C/hx68qtj8IevBC3mNoFDWvQ7mkNZWLNr8/RoO4bE0OxQOKSCXJcnwRkSWXkOsfeP3mLPGYCRJ+A6YXbtN3ZJjRh4NTOnR4G9aN5DdxIFujR/68/qwI4gJ9XmcFSvQdXDgChXLDfT7l7MP4lZoMiGpF9104e2p4sIJZyhS8OsSAuUV+RwmRGUbdirS1iygqbQhNTM0shyId0mTmTwUJrad+oFJqrhiz7KYvBYJUvmxzwAqbS4MStI3+Ddtmrim4qMaqNW6bQj3555jNCrNpLrfRZkQo8dFZkmITKk32A/Jusyu9M+aRKILpwNMSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(4636009)(396003)(346002)(366004)(39840400004)(376002)(136003)(2906002)(8936002)(107886003)(83380400001)(66476007)(66946007)(6666004)(478600001)(6486002)(1076003)(316002)(966005)(5660300002)(956004)(4744005)(86362001)(66556008)(26005)(52116002)(16526019)(6496006)(4326008)(6916009)(8676002)(186003)(2616005)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: GNAfxLgZDxPqSGOMB0sRTTBgj14Gh+OG8rT2QBZAWS2RnutvcKWXqp0yni8pZ2sm/0lpnPqZ1gFtToGLx1Ykm/Zcb6BnNqyx7yIeSda0stqaxsA5pdpXDtx5QCtUZuwCjDMbxyGAJXYj/dKKXrdl4RMLJ4iGAh4GKovo/avnE78psKnM/coa1O8H/AoQjsqvtlWXSmPFAJCE5jKGmA7Y12Lqz1JGIVKooS3Z8FehFXyqSGTLWUkUumGIOwMTeJa4k821pw2aHPYVfaV3yv2k69YClf1VGRAkPEcDd+0QM5pTYs4SJ0jYAlx5w4vSD8wpMHMIUM9tlvARBXrVeQIrzdA/DIQto5cr9TuvdzBFiDJibsfidv6QNdqlPYSxOcnQ6+81qu0r1bwvrxtHdkNI2c9dixOxBCdC3xfLs8LmgRRTjAczX5NxRQamMLo2oajaVn4OLb1r8ipLGfjpwNJLy/CfIfEc5fp3C+J4sdWa+XFTsSOL63mChzAMlpeh39sNuhF2NUd501eMqNIFpP2SsO/fI8QemZHztd+xNiUCCFNnHivI5jFwj5mhS8aN8Q1uFGgHzu3hYz5GoOGEq6Wi9cFymqX4opoMvNui1KoPXrFbvPGM7lVSxM1i+LZx5o/Dph21Crqz3jqrAaGtv2bbYQ==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea13c18-aa2f-4717-b159-08d87c4a8441
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 20:37:56.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlKQUEV22jcNaRogPyM975OcoWz9Kzu+UYu1VlJC6GBmCiDXPU7gX+EUf26WsulyTPC8wfYHyO8UrX/DmC9blpLfdPtvFX2Ng5rWVv/1MhnVsmRLOKOq1dwOTEwWDxXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB2148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arm64 default config limits max NUMA nodes available on
system to 4 (NODES_SHIFT = 2). Today's arm64 systems can reach or
exceed 16 NUMA nodes. To accomodate current hardware and to fit
NODES_SHIFT within page flags on arm64, increase NODES_SHIFT to 4.

Discussion on v1 of the patch:
https://lkml.org/lkml/2020/10/20/767

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f858c352f72a..cffcc677011f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -982,7 +982,7 @@ config NUMA
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)"
 	range 1 10
-	default "2"
+	default "4"
 	depends on NEED_MULTIPLE_NODES
 	help
 	  Specify the maximum number of NUMA Nodes available on the target
-- 
2.28.0


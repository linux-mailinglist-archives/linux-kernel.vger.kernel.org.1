Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43692A0C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgJ3RbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:31:03 -0400
Received: from mail-bgr052100132043.outbound.protection.outlook.com ([52.100.132.43]:8713
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbgJ3RbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:31:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COdptfEV7dVrBtckHJYX+DLnabYsqcWupKV5inCYdZUKWcsGgt4+SLDKuvcpOCNWf/rWQtniAE1wfT4jsIBZJ4pJgPLln6C89ZKVEdcrX2lzizZyRwFTRCU2HBhTqhPh7751h1kSPLI6Fz96ymjjhmP5TcUk4KkHgRqHBUzvYLXbfmkqVaA8UMG2VELwBdQG+zzcX8palWo0kHm0jDe7FbQ+TCIAKmrAtl9+AC9+G64kXMD8ZVtXLSSQSBpmfiSYqq5sS+6IbKWIcUcw7tpMLvcXvhdVVlbdt7J/MJG2Bzsto7fqwdUH7TLVq63QjV/4E0EPVLJ2g6s1AT2RNYCK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/VyqFz6qXX95csenBfJ5UgKTcU2C1b6ecBPNgCsLno=;
 b=YfgJJVxUmWxyzqwq88EAoqGcOygfrD8O9f2pFhPu7J9Amea1BVX17hRSWQrc7ZTtinQlS6MWrxGY6fRwhNDxmh7T9iPFYlbjrXvdiZt/cjUjydveY2m1c+e4cu1lpdOvrQxvK9ZsH2oHrdnyEdSRz3SxGqm7q5BMg0k2BUMWCHZF67OAIVmcm4ghEg2XtfhQWm1g/WGvhxS0GLVg2XAmh53iW7a2uLOqRfERDyCktpHfCEZxTM34IrMKEmizrvZwYNyJh7ChkCu70dFHvMn4k9VS0AdrXNGVLrhF7lU/EpxFm5qB8H2R6v3R3XqZ4Ktz8BzKyne3rTgAkOrOH4IODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/VyqFz6qXX95csenBfJ5UgKTcU2C1b6ecBPNgCsLno=;
 b=iQ5tti1L/vKB3Mo1p5PFhQe+CYWkuRn9AnVFWZpMm/eZWAGEm2yX1k7liBOfNGswxd+Au5L7q+WJuU9nfbauC14mE2XpA2EmCVGfsdvDm5Qc6FF69YppBRMW2ekDyMK7Lp1qN6UeegFEn66VnhzRV5EHmJPXmSzc7HIjIeCmrLw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN7PR01MB3715.prod.exchangelabs.com (2603:10b6:406:8b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 30 Oct 2020 17:30:57 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 17:30:56 +0000
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     patches@amperecomputing.com, linux-kernel@vger.kernel.org,
        Anshuman.Khandual@arm.com, Valentin.Schneider@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Subject: [PATCH v3] arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
Date:   Fri, 30 Oct 2020 10:30:50 -0700
Message-Id: <20201030173050.1182876-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:903:103::11) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR19CA0025.namprd19.prod.outlook.com (2603:10b6:903:103::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 17:30:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1cdb5da-578e-43ff-8966-08d87cf98f2c
X-MS-TrafficTypeDiagnostic: BN7PR01MB3715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR01MB37151381FF4EF0F1A5E7BA8B9D150@BN7PR01MB3715.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8K5W/AX6pybL7/Sofi9hBwQ8HNkTQcMi0zHQJ4FrEmXQEMWeWXgcCSOO13fBkcELeuKapVw4lNJlg+Pl3mq4Lrm7Y3YCBbIG2ohP36f+CPxW9xDcD7zuVoY1RMOMfnGZxjzWpjje26FedSGyE3r2SDwQ9HZGBCG5gjKZ1ZU/t0xs4c2wdwVJCZChoLMngV4X9CQyWWJAMb2ji1RUzdlEe6Zkrt9F/AOWpiLuSMqKKo8jb4OZcW8dd1ip4GMRZoeqwJjaUnhD6r97u/BX1BTqmuY8A/qR5OElcExEVCLu3ho48r2TLEHb6H0zLTjmlmrXKviUw7dd5jQIAACGSL+CLPZ6wfNobuU61ffbcXDqSFV62Z0GH/c5F2RxqGObKraANHTzSoEXuYnbSsBID7iRggQl+d32+HEwSghS3vfJ0BoHvwXXwcFgASq/tf0AmvE3kFm6v41YpbiNnPyiEHBGtFvXia2m/ZlpIFlnBo2izibZxrgPix1MsPkvhEsa/12MmJmsoC2vODDkXFRhgA5PgSrnSQlxKk16LsGDqMoTCfgDQlrUR6YqEYV8hMDC9lPhBR4raNwxg1QB5zIlOfmvIOR+458kR4bfd/PYbKQ6UfLvvBLNbVR8kVRpCMS1fOjGZMbwehQJyu6axB6AjCkiZqD2VH2U+IH7j8FdRV4Ou3SM6KPjEDGn+OOGGiOgnqayRywl2DewQKkAZD21VhSFYhaSK1NVOfgQ7tp2aPRa1dC34ye/gJqSwtQePoH4mehIH27BA8S47wij/LOl8f+Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(376002)(346002)(39840400004)(396003)(136003)(107886003)(1076003)(86362001)(2616005)(26005)(8936002)(956004)(66476007)(4326008)(6496006)(966005)(6486002)(66556008)(316002)(52116002)(5660300002)(66946007)(478600001)(16526019)(8676002)(6916009)(186003)(6666004)(2906002)(83380400001)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: 3va9hGnyvSPGRCu4pykxBQG49fF5HrRO/IROtnjV/NfSsr8C1dEMX9wAl5uSRuHQiCmnt9h9geYmCeTNdOK1sRud+UoXG20dJM5wAIKZ1tOnuYiR56LxzpBiBI3DMUcyLDE5mA6wV0cEsnYfrv5eDWPBUbQQjV6VykYzWCgmYbYAgZJhocZmXohm8WPxviXEcwM+GMtiA/oCqo4+fjPo13YJvnNK+0MgaIOxOxIMQHqAjbE85zN/IQzGauu2S8zSrHvvFr7ZddMN4P5hU6kLcPLLK5OcijlNwuKM/Hos+17XxNYWSLPMvEs7jMihbmYT602DR+B4ADSglks9aUuGlIzwrzW6xZJLgYZb7WqUXQkJaaVM4is/P85TOBomoSRH+BtxZZ76wd77CPROuEKDbnQVEnQfq5EYK2HptRjZkT8a8IGIIOA2pE6oRiQtEG0mU0qahbNle6/w3yoaX6Y7ygSSKD+3V6Pj4nY2WLQYMn1WhsQFePqC0GM+BMQuLpsfFXgathobIDCFUg5ODhCzzh9FXMWCWT0YiXggoAsmNmHtMkKrYRRRuXhEpAWErpJ797+yKuJofypHVDnqbm6D9QL5rILg0fLQzuyV56mTrzWELEjLqUjd3YiBONdehIoopl0TyZtblYMVweexHNqO+w==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cdb5da-578e-43ff-8966-08d87cf98f2c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 17:30:56.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2+bDJhARpXLNWiiXqLAb+LKoqc9ALOqTd6hNLhDOEzUM2Hw+6kv1Ma1A3eLW02HuZjZ0V9NOBp/sbOwCHfYGaraVSZcKC1+m7GWay2H/N2w1EgJKPzWxObChXIytme8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arm64 default config limits max NUMA nodes available on
system to 4 (NODES_SHIFT = 2). Today's arm64 systems can reach or
exceed 16 NUMA nodes. To accomodate current hardware and to fit
NODES_SHIFT within page flags on arm64, increase NODES_SHIFT to 4.

Discussion on v1 of the patch:
https://lore.kernel.org/linux-arm-kernel/20201020173409.1266576-1-vanshikonda@os.amperecomputing.com/

-v2: Updated commit message based on discussion
-v3: Updated link to v1 discussion

Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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


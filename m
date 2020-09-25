Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD62789C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgIYNjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:39:42 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:55435
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbgIYNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqWVqTj2oUh5QWJyeX3d3q2pBect33YKNllwE00ooFjqNO4WaBuZN4FuU8j817Oeiuh1Hfi5tLyuFWuCqMDOpdp9Sl/unNjleV0qX2BLAH43/ELYXMGleaGaoL37YHBnIlJsDUMEaBrAYFDVW0Ip3KiVnsSMzm9IAyCxBTHSuPSv5MnfIWavKGAx2nbhD6R92ND7lEMI7t2QfNksYpOnZ9XT83Ct0JoJjQCPlsEF1JPbgR111mHNCEyj6ubhOxZ/R9Rr7YbNtcqDkHHPjGuJ5APKnnZBtt3+uxnp1RmHvnxDnCpOGF8Ti3bBpxOTUkf1ZBXzR/Z+Sg8d0Bg4WLaY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+67ZWPcXjp3vLKAXuQjqqY3uYd0slBVsiDe9v1kpVA=;
 b=fkkY9deIpuoKAxhXgaB3hEbaZTj2UGf4Ws5dTHevSBUIGqTGwloNGHzz2s5t+TF880yEiYlESSf6jOt7BpuNjG7jvr2OiGHeIjub1aMa6WL5MxAYBmbrLtYgGf5Gt+qtiANcQWMjyJrtN6CbGVSkGfmQ+xdtEeT1VofaRp2TmeKjJbnkGgKwSt4Qg+/IFykmSdI/qKDYqs6KWv3oWknUoQSbQSUSThmibZgjqnqCuMvCd9tUo02vkqDrQdOyLnUnf6mpOKnLGUfyYWLc2pkBMdh7VZ3hxvsBAn34wrnlNDJwCsWOA6QaePQNIliQAygWGytAxpDx525OxHwH6QiPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+67ZWPcXjp3vLKAXuQjqqY3uYd0slBVsiDe9v1kpVA=;
 b=J5a44l4dlCAA3bFlKvvwNIcvdS4A9wYMAn4wk0eJ4XvVCHEyh/jtGX5nY7eLrCGba8DkA4a9thXwi/s+ydqueBI1jG2RVMRLuLZFS+pI5B+PJQ+jmGEWoY+F7600/ULEYXCiokAIaRKtQF5jwiFvcHoMR8LBEyHLUBFdHXcf/pg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23; Fri, 25 Sep 2020 13:39:39 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 13:39:39 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/sev-es: Use GHCB accessor for setting the MMIO scratch buffer
Date:   Fri, 25 Sep 2020 08:38:26 -0500
Message-Id: <ba84deabdf44a7a880454fb351d189c6ad79d4ba.1601041106.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR14CA0133.namprd14.prod.outlook.com
 (2603:10b6:0:53::17) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by DM3PR14CA0133.namprd14.prod.outlook.com (2603:10b6:0:53::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 13:39:39 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de6a2a0e-96c1-4c75-05dc-08d861587366
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB451602B67C6A63DF22383E4BEC360@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkLw1GFUTR24sZiYHGkyA6SZi24CKqntCTJP8atfeyFV4vAUFzmAfbLpyaEQzpEpurg+QfulvqvSDYDDP+rhJfanMypyVLRn37RiEdUNaKHcpatgBn1WXIm3JK4SUiEmuH/l9LuKb0f9MFRmDpKIBYJoIhYtIyGvub/oCU4XIKsUthPpIBSRk3wxO7X1HxhZ/bRPwkgME05Crjb9aruZ9DFKcnhdtHwLlSGSYAt+b4efb3xeO3sRQPssJkHWwP69qYtiBoOgydOSxPuZVMvDrfLMWo8qYok/32MEZ0G287pV4alxa1QF/Urbj+uO+3cwrWwYONOLLPmE8mM9epqlCqFrWDp+ZO8VB3tdwKECGxbkE1g2G4c2L9/vss+Dkvan
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(316002)(86362001)(956004)(16526019)(4744005)(54906003)(6666004)(2616005)(83380400001)(66946007)(7696005)(5660300002)(478600001)(8936002)(66556008)(66476007)(26005)(6486002)(36756003)(4326008)(186003)(2906002)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: op+6wDWk4E/cg+to6fX6vr2Qsllc4LNZi1LH8EjOcU9fP9pzXo+vHq/PvL20TBnV+A3bRDZpP0tUAWtra8ut8/AEDf6++K2A96kEQYE+9ZlRahthlaiESsxdIWzbZRiF0ndBzDSbVBdIVxjtlT4dYCKvLlVWRFlJpFFUBWj/aF4QpfBWfLD+jB4Yqf5v6oxw8knS9BPeuo9QLl+9IGD6q487LzCin/Z3/qabwhmGDF95ezr5+9fA82phbkxyiO0q1ffpvorNAQAs1fbgCP23CBk+LjUOANE8kcLuVFHLAAnjRDA6kvh+dPOmgD31b7vUrYP3WW6DykYyGZQPR65ChsTNSGFXKZLgRLr3UnJ4uEL0jkhqse6G/s6eYIWDQpCgfGuig8snxp2nU6NF8sSxV+dQjTROJiw8Y7qPZvHev4LqCzBCGaSuX8xmVx9CsVnnm8j+bRGxiOGssTBwFgc1YQdcGAmbsiibRFHtfy1rJCo/HfIUdwAY5/NsEy5VjpHQrLG56M7cicsZ81irz4Qd/3T2FJeunWOxwu3L4970cnIwPkao7iNiZUgVgf3ndmoaJ7ii4jhzsesWSNC3FUJroVKhTFGQy7SfzZjJsdeBkF1xly2ecjglcLXNy7pmIPV97KwBdKXM47Iv02GlQUcM1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6a2a0e-96c1-4c75-05dc-08d861587366
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 13:39:39.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mDA1fUdH2FSxCl2LjqHJzrGedW/OsdaCc5S8uvmZCpUk7oLW1Z5mq9qkX8BgWBl7WlsbNyieTgUpyw6DgOkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Use ghcb_set_sw_scratch() to set the GHCB scratch field, which will also
set the corresponding bit in the GHCB valid_bitmap field.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6fcfdd32769f..4a96726fbaf8 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -751,7 +751,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 	/* Can never be greater than 8 */
 	exit_info_2 = bytes;
 
-	ghcb->save.sw_scratch = ghcb_pa + offsetof(struct ghcb, shared_buffer);
+	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
 
 	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
 }
-- 
2.28.0


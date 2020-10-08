Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D00286F07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJHHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:13:30 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:46048
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgJHHN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf8j+qKXihXVa4xZb7a3a59cqP0pnluVX2J6ZhkWrsYYoaOJQJjeuNk064tcF6RFJo9uu1EHeI2CSVJUmLpI5BEMNksijbeskyMpYFk2WS2aTjiaavfMUC8f7/Vwwo/KKjkwKKRthozptb7DorfbHmh07oeGXGRof+CyGZB3GL96GamG5E2h6x1VpojcLcs0Ub3faDSKRQpqAB1ewI/kL68bRmHXUWhLu7sUvk2wMB3Hhsj92S1pwiuuMinHLOxnk9Wsho2fIXmPj6FP1EbRpSDAnamwtr+RMkqnYDKs/025lzoOSvNN4QRXgO2QiqYC5D+or5boGnSAUbne3o7MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjKPt7VEK4N3aTEixDVGKAlZfqXdTQyQF/3MRm20A4U=;
 b=H/Yum29N01r4291FtEmDEteqTdjk9eTh4fd1aKL9bg8GH2CqPiM2fBIsIDee+PQgkhC3xJP6HFock2Dhj3F3D4dV18h5bHOPXkgc2HIa76jdh8tPRNgyKkvrlzjzu16nmaNBOuy4L0bNRD0AxrS53eYhkPxCMp0ZMRcmmEqOLEBkYAg8gLrg2nhSKpdoiZvb3356bOd90m2QiZeLM2wh6yvzXh3J9Gs6nITd5Ctr4dK0SDq1KoFKz0MDfx8uopXO/Fd+F/gLSP5js353zTC7V3YDeAfQAZIkXuP4yo+fItm99fVvBPDBna5Pq8Rz5NKJQOzdKq1rPFkGFYZi5VC8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjKPt7VEK4N3aTEixDVGKAlZfqXdTQyQF/3MRm20A4U=;
 b=JVZMSg7Ry6wK9HXc1cghvvW7Swg5H4E5QA2EQZwc8K2pJGfff5hm9SJdClahkt55F7nJFbboh4IDJIp/viMz+nNZUSUVR1dgd7k/WOjibY156BVR1V21A6qDdYcymK9kf2dnIZxQvWs8uTqt2te1g/ShmuOgS53QNxISULJu16c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 8 Oct
 2020 07:13:26 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 07:13:26 +0000
Subject: Re: [PATCH] PCI: pciehp: Add check for DL_ACTIVE bit in
 pciehp_check_link_status()
To:     Lukas Wunner <lukas@wunner.de>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        linux-kernel@vger.kernel.org
References: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
 <20201006193830.GA32510@wunner.de>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <7309c7f3-a895-e4aa-578e-444c5d5734d6@amd.com>
Date:   Thu, 8 Oct 2020 12:43:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201006193830.GA32510@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: BMXPR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::26) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.253.16] (165.204.158.249) by BMXPR01CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 07:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5feada37-4d4e-48dd-8900-08d86b59a678
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2884200307808AA62B6545C5E50B0@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG+YVOsRayHTgmW6K+44Y15B++s7CBngiwlFlIW8Ei7McSdd0qEjuklnS4KDENCkM599hx4GMQnSVujWze1fXumTZqHXFBOs9D96SQmFj/lJ3FzXtp7Q+hBcbLYvJKtYfvurQCEEZ+6+5OzXLPOpDCf+P9WL0W2iqAS++iP/K0hL1JlWNV0s0aoXMFQWfDlp7qsP0OvfMfGAJ2/QA2EKH9h/a1DkZHE4YUeB8/xXSpMoiexC/mmL/x1dz93bJpZyGu/fsAxGYDI4jbWFyOaZr30PWYfQDkeIIiK445LZ9+z3SRbpn+2r2OJLrg0oAcv0XChM5Uuip+f7SXdjguEeE6Fb35DxSFvE72+KRt8/UN4Idhx4BrlZkbyWdLSqSKB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(66476007)(956004)(8936002)(16526019)(316002)(31686004)(478600001)(6666004)(53546011)(110136005)(6636002)(16576012)(36756003)(186003)(26005)(8676002)(5660300002)(2616005)(4326008)(2906002)(66556008)(31696002)(83380400001)(6486002)(66946007)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wuwMUQXgE3pAsnZsPmJMlG4nY3ogNdBcIoMwVE0KSvXOseIYdvdCitx7XSWHcnBGu/Qje9HxMPpi/Cv69F9rc3y7+l0nZtMFgwFWymSQYSXoZ7/s6oBVf+DDOfYhZZZgBqmcTVUi1mpvB3Gya9nwC/WTQQnlIKO5sddbZwvLuAL4rrZoSSqiA+BJg2YHmJYdy9tAutb5rF975a3uU3DVRBxgXpZ9AYRsOmRVf+iLhDM6sOQjmIIbkvwqTl2Y4QOEi6Yf8Pz2rOO9LpJGnhqT5eLctceaz9DLofWxCGwl9RZ54q5kG1Is5CoRRh9VqaU6+U5W7pIuQartlxAeEPuQEYi9nLsGaeDhI0mZGtIsjLL5mJttUJufVV7G5mi5yWdslBYV5ilMaMaNi2m/h8XycjxD2GONOlMHk9cIORny8NMagoK/3fkqNy3Z0/OJHkwTRBpEzZ41rUdoXTwhe6aOVtHREcTgrVxSWlYlCZWck15NYe0nVBKz1z8eygMb4pitEsoJfIacIWgTDF2MYCwHKaIFsRIGP1r0pu+v/i03X4W+S5S5iHn1/apkF5naiU65aMMynp6/UT6LZ4/XfENoRDD3RF+7Kkpa5APLf9rd0e7KNzCT6P7MhKAyK2raAPL6NWMhnVwzuBRXnQ9+pD1Ulw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feada37-4d4e-48dd-8900-08d86b59a678
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 07:13:26.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxmFogMYtfWMPF4ZMxS3/TfPQx8/Y/oWkPR2UJRMFs+yB2UYbKISaHcO31UxGDWyc8vBv+KwSCn+cmNEV1VZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2020 1:08 AM, Lukas Wunner wrote:
> [CAUTION: External Email]
> 
> On Tue, Oct 06, 2020 at 01:24:28PM -0500, Sanjay R Mehta wrote:
>> if DL_ACTIVE bit is set it means that there is no need to check
>> PCI_EXP_LNKSTA_LT bit, as DL_ACTIVE would have set only if the link
>> is already trained. Hence adding a check which takes care of this
>> scenario.
> 
> Sorry for being dense but I don't understand this at all:
> 
> The PCI_EXP_DPC_CAP_DL_ACTIVE bit which you check here indicates
> that the port is capable of sending an ERR_COR interrupt whenever
> the link transitions from inactive to active.
> 
> What is the connection to the PCI_EXP_LNKSTA_LT bit (which indicates
> that the link is still being trained)?
> 
> Also, the negation of a bitwise AND is always either 0 or 1
> (!(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)), so bit 0 is set or not set.
> However PCI_EXP_LNKSTA_LT is bit 11.  A bitwise AND of bit 11 and 0 is
> always 0, so the expression can never be 1.
> 
> Am I missing something?
> 
Please accept my sincere apologies for sending the wrong patch.

I am supposed to use PCI_EXP_LNKSTA_DLLLA bit in my patch but have used PCI_EXP_DPC_CAP_DL_ACTIVE.

The correct code should be as below,

-     if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
+     if (((lnk_status & PCI_EXP_LNKSTA_LT) &
+          !(lnk_status & PCI_EXP_LNKSTA_DLLLA )) ||

Is it right? please share your feedback, if I am wrong. Will send out V2 patch, once you confirm on this.


> Thanks,
> 
> Lukas
> 
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 53433b3..81d1348 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>>
>>       pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>>       ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>> -     if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
>> +     if (((lnk_status & PCI_EXP_LNKSTA_LT) &
>> +          !(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)) ||
>>           !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
>>               ctrl_err(ctrl, "link training error: status %#06x\n",
>>                        lnk_status);
>> --
>> 2.7.4

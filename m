Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66E26CE08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgIPVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIPQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:03:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97CAC0A8894
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDdfsFaAFw+mj8tOiYRxH8URu47xY/+Ya8LFrGBHjxgMsaUDG9NIUqwDv6IBT1DnK4FMIk/oSMJQKwS57fTQZxZnmClSCMSK++n7N98x4b0N5TO7UQIHRDR1oCqxFl7F0cNcIEWOosgTwm17ZpXKUYV/hFbdyrjyzHJutpUNkvL8gPK8vJFV6R9Z5wd0tM4QpiG3fNLBFAbGYlm1avGxJtmW52CW2YKAGGog7/j4qKC47VJwmIAhyThgzzb5BZqEBC/kMlkCKxpw5T8PRcfZHVIeE+6aRJTBuV3aYc4Q4dvUaMYSyV7j0COKy5KUxzhx/jgw4pZo/iOaKRwpGjIOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3O9y+S0/8tqXro5HSEPbfeNx8lpmKp30M9HB8TRz/g=;
 b=V8MVGe+j6lNDQTtgAWamIK2GCccru13cEyBCpk0Zt8VfKCkJJr2J/r06TckcAOlffQwQpj0DgbyF5aQgru9CnoBOGoK/hCJwZSSLxVPnZWJY2Y6jYcWmrT6zZue4vOzy8eM8z3F49d9Y9tSUS5wAUMt+VvLPqffPW8+zZBCCYkN7Khr5MGqwPcwkF9/FqFccRNeZj8PE0LZorL2A+R5dJsha3fk9+2bEv8EOfoH+0YvnB6wCryqxrcMg2g1fr42h7t1Nm5CB9Ca1Ab7MOtXFIG6QuGjmQhIgT39Zp5MUDr9wSUlgnQS6N+HSP3bfoVWX6isXM5MLaXshpplcqW5Cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3O9y+S0/8tqXro5HSEPbfeNx8lpmKp30M9HB8TRz/g=;
 b=11/GsadYlvMu77LBTMePeyJy4XKnj9ifPk+q/E7p/GyIbe70peoyQ2ff+99jSnQpzYnwvYKrRF/t9jLGjoCTA4VYhHDuBUBFwDcKGCBNbD7Q7wlTxqxb78CCOR9YbGorXJQqf1fztlI1728tYJbhB3iI/Xz+HAoaWEYNLQvUeuE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 10:38:20 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 10:38:20 +0000
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        "Grimm, Jon" <jon.grimm@amd.com>
References: <20200913124211.6419-1-mlevitsk@redhat.com>
 <60856c61-062b-8d92-e565-38bd00855228@amd.com>
 <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
 <dd0b9a98-149a-286c-2793-8ea0e8b60e2e@amd.com>
 <b323b9d5-8149-5e6f-c24e-43b64bc6f2f6@oracle.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <41a32d50-63ae-a8f3-bc2e-eee28e9e1c08@amd.com>
Date:   Wed, 16 Sep 2020 17:38:09 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <b323b9d5-8149-5e6f-c24e-43b64bc6f2f6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.140.250) by SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 10:38:18 +0000
X-Originating-IP: [165.204.140.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a47d888d-64c7-43f6-70b2-08d85a2ca143
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42199800073222FB73E539B7F3210@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZj57iadkN1FZ2kLtd83vW6UUnSQoUmAob49fkWy+qMBnSjtTXyZLTjKtKUN3SibxRsidQye1w/Thu9LddHI64BE01IrSJ56GDDbD7QU7cT/0N5spLUMKtVg9Vk5nnQx7gbGckRUCbsQ7yNpd5y+8BDL66aIlcUC+nYXVSXtaBRnj/6y8c5dkSJvBclpX5yhP79Lc1s9VDWSd3Q4wxrkE9V+NUP9mfxx1mOFPQ1gURCtkLUi0Uufxyq0A9aDDFeM63JfSMGPblDtWKz23m7pNyHDzBdawo3dgLNoXuIfjwq0ge54f0B5nzpC/i4Fx7eEWhr4nIdQ0JAXRt1RrVoz+TRTGVTsIIJhmbMqe7cR2fLrDgFT1+u3LMm6henchHHB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(83380400001)(36756003)(31686004)(4326008)(86362001)(8676002)(6916009)(8936002)(6512007)(31696002)(6486002)(66556008)(478600001)(66476007)(6666004)(5660300002)(956004)(2906002)(66946007)(44832011)(2616005)(6506007)(316002)(54906003)(16526019)(186003)(53546011)(26005)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: T6q2YvIUdRDulTXMoT/hjxZy2CCheeRMMw8moL8NCjnClylTLuskqi3zEdMbfuSyjbuC1n+J/ia2SblTfo8NdyGC9MpXKvYP1AYkUOKEkH5uIlnUibiFpw3FAKywftp5OHMJNeezcDAxWXgXqbbu+9DO1ne3Jb2KcAq+mevTH/Lc+lZrTFqPPIA/hF6NvXu93NlG7UAJr7V+S7i700MH/u8hilKICpKxcgnsIFI0zTt+jaiiXuwbgU0tKs4QQRNUM58kO3icqQUsBpRqUwl7W5xKiyLlyZKzURZB79Ovn2EgRza1Qnv31SN/a8UNvGsg8WdDlS7rnn+gxqSnHKWMt35HD5jgd+2nvFI/Pd0Yg1qawtJfy1eGBPR/+Iw8F/spUPRJHJKn67eOrH7soMKsAPqmG8xOsR5Rvo/Iv8I+sknl1di+szhKgGhLkzGHZHBfEFCA7aln3H4JCfpoBQWsFkBvGmNlCUjUmFp7iK/aY47VGs5Xq3www2bMFrKaCjGFqub4o+UZ2OqCG6KKQLCuSA8XMFw8ztIrdiTblB+u6t5HFyY/XLDlViMSrmQQT9gIKtDvH0YHXUpp9pRKicdar+LuNgl6XaSEmZkV4Kq0T9FRNJcU60H02H4b9vbD0VR9fFSP7tf7p6ZUQZ2+u2USxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47d888d-64c7-43f6-70b2-08d85a2ca143
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 10:38:20.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQWT225PvxYfyIj5KIF9Kn+4VU5Jy/fmHk4BmFJo5ZSSLubkK+zRakE17uM4GoQyVSh7GQxQZRhJulJWnjEUoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/20 8:19 PM, Joao Martins wrote:
> On 9/15/20 1:30 PM, Suravee Suthikulpanit wrote:
>> On 9/15/20 6:25 PM, Maxim Levitsky wrote:
>>> On Mon, 2020-09-14 at 21:48 +0700, Suravee Suthikulpanit wrote:
>>>> Could you please try with the following patch instead?
>>>>
>>>> --- a/drivers/iommu/amd/iommu.c
>>>> +++ b/drivers/iommu/amd/iommu.c
>>>> @@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
>>>>     {
>>>>            struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>>>            struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>>>> +       u64 valid;
>>>>
>>>>            if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>>>                !entry || entry->lo.fields_vapic.guest_mode)
>>>>                    return 0;
>>>>
>>>> +       valid = entry->lo.fields_vapic.valid;
>>>> +
>>>>            entry->lo.val = 0;
>>>>            entry->hi.val = 0;
>>>>
>>>> +       entry->lo.fields_vapic.valid       = valid;
>>>>            entry->lo.fields_vapic.guest_mode  = 1;
>>>>            entry->lo.fields_vapic.ga_log_intr = 1;
>>>>            entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
>>>> @@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>>>>            struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>>>>            struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>>>>            struct irq_cfg *cfg = ir_data->cfg;
>>>> -       u64 valid = entry->lo.fields_remap.valid;
>>>> +       u64 valid;
>>>>
>>>>            if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>>>>                !entry || !entry->lo.fields_vapic.guest_mode)
>>>>                    return 0;
>>>>
>>>> +       valid = entry->lo.fields_remap.valid;
>>>> +
>>>>            entry->lo.val = 0;
>>>>            entry->hi.val = 0;
>>> I see. I based my approach on the fact that valid bit was
>>> set always to true anyway before, plus that amd_iommu_activate_guest_mode
>>> should be really only called when someone activates a valid interrupt remapping
>>> entry, but IMHO the approach of preserving the valid bit is safer anyway.
>>>
>>> It works on my system (I applied the patch manually, since either your or my email client,
>>> seems to mangle the patch)
>>>
>>
>> Sorry for the mangled patch. I'll submit the patch w/ your information. Thanks for your help reporting, debugging, and
>> testing the patch.
>>
> I assume you're only doing the valid bit preservation in amd_iommu_activate_guest_mode() ?
> The null deref fix in amd_iommu_deactivate_guest_mode() was fixed elsewhere[0], or are you
> planning on merging both changes like the diff you attached?

I am planning to send a separate patch just for amd_iommu_activate_guest_mode().

> Asking also because commit 26e495f341 ("iommu/amd: Restore IRTE.RemapEn bit after
> programming IRTE") was added in v5.4 and v5.8 stable trees but the v5.4 backport didn't
> include e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE").

We should probably backport the ﻿e52d58d54a321 along with the fixes in amd_iommu_activate_guest_mode() and 
amd_iommu_deactivate_guest_mode(). I'll work with the community to get these back-ported.

Thanks,
Suravee


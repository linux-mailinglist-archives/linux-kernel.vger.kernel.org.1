Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F32AF9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:31:01 -0500
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:33552
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgKKUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:31:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR1jj9nJMEy3DRCkcvfvijAYU0mFMmps6FDdEeK1NRrqMbPiECNW1xNgno9VopTv6Sr8AR/i+CwsbQAjTWaGvFea3Ib68qYob+eC2tiBb7h7T6qcBN5tgXge+VO9YqUWnArtlI7K2H19CoLRcPyeUxTNClJbFu3qyGJ1ACkXktUeGXUUeE8Gf7qeXRkFZ5x3xv/KMG4dDtl1pk3fPJwV9TCZhGKG61FxDTx5x2xu8kSoPt95DQz09QyqRod5Z03ZxRVfNw8ab4at+ypwoNhZqYSIlouUCXACF7QTy/0JfAi8QLdD39bgxdgUUvlfLc3oHf8bBbS+gDYa98wu5otpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbqzNVvpFSCs/tq2OV3CyjkEFPCbU9b8S4+0Q3trQEA=;
 b=nksHpV0HV9TJ1RCfM9SZoGCILdZVTIqt4nuLvYu7xmJ54j1QdSkKmCykw62s6AG9XPnzmFy2qSxuG+UcEdnHHdpT2iT91AKfSAbWHMbcqXWAJLXAlQ1DJ53GVhzAq4e+b8fcAKKX/sHtfGh47Tg3MlbrCYe4dLZ3vVzOGdiyWfllAF8cJjDA2qK+M188f2UG8Ou71usfgts0hqCcVNYRuSg0VGD10IOjjedb0XdeVtln+F37YzRhVMxhk0GznXcsgskD8yqCYmZiaSPX197fsxyjgGonAohVcVTiMDlx0MqnKZ8fesCO+QPRkTrn4xm0pSfWQmV0eH7eB17a9BThyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbqzNVvpFSCs/tq2OV3CyjkEFPCbU9b8S4+0Q3trQEA=;
 b=0QRM5jEhoe7gP/tiCiSpN821e/db8aYrw4Oy/U03lfaVnW/M7bQ8yVSH8IPjbrtCndyI5SRs46jDrd9VDK9zRMwZIejqstYMwWI/8GlfyE4DEGemI+57LJka8fLHBVTuH4OgcJgnnSouO8IyE3cZ7cEAxse8KIXPyf5Y3emBHZE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Wed, 11 Nov 2020 20:30:58 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 20:30:58 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
 <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de>
 <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
 <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
 <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
 <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
 <877dqtgkzb.fsf@nanos.tec.linutronix.de>
 <874klxghwu.fsf@nanos.tec.linutronix.de>
 <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
 <87y2j9exk2.fsf@nanos.tec.linutronix.de>
 <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org>
 <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
 <87tutwg76j.fsf@nanos.tec.linutronix.de>
 <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
 <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
 <6b44a048de974fb6e2ecb5bf688c122b3107537d.camel@infradead.org>
 <20d99e1f359b448d042d27112e55f8070bf460bb.camel@infradead.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <13f8cb3c-713e-c26e-b2ef-4700f9f6ceac@amd.com>
Date:   Wed, 11 Nov 2020 14:30:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20d99e1f359b448d042d27112e55f8070bf460bb.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:806:a7::28) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SA9PR10CA0023.namprd10.prod.outlook.com (2603:10b6:806:a7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 20:30:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0200e07-e997-49d6-2942-08d88680b247
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02173256C8DFEA954923300DECE80@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXN70k7il12XFzHUAMOvjKaryn+Q+YAul0SV36LWtBrj4D4NFbW4+7bhZUSZotVKEoMW0r/kmTRB4C7qNRQ+SiZdwcn4hWUn4Eaw4shD+ijW/AtWLiQyN7W9J28Um/JzfJPMWGV6qG80JNQ42QC164qN85ZASXeQEX60AAwiyuCfMorSSbkCLh4ZIrD44qW2zLjrRzeTwFWirKPkCBO5rf/CPMa1hHwIrNQvvr5pnqKeHiHdyFD1rkpr3wPYPxGFUwQ/ikAIiSWUMCSEJbUepJvllMSvWvSwUcxxBAOUI+r5+IkPP6xSkHUCmJ7RAAqCHXdwCVBYNnFnd8Kb7sd4csbJ0mRvwtm3yNZTKqmscWG51NrXE3rMDIyNrNS16Dp/NO9kuZADsdJBUS50du6dZqyGhep9kTK3xLH47ywNAJwjXOCOyWOeMyLZ1Ngu4I7CR6Txt1u8vk/PhF85SUcRBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(5660300002)(316002)(4001150100001)(52116002)(86362001)(966005)(478600001)(4326008)(54906003)(956004)(110136005)(2616005)(16576012)(8676002)(4744005)(16526019)(8936002)(6486002)(186003)(26005)(53546011)(66556008)(66476007)(66946007)(36756003)(83380400001)(31686004)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4DLlsh5VYtufZxGZsM/IHuCgL5kBC8i/DXzGPcYZOJ9cL40wKY+N3VjpcFRI8jWfadR4ZqBfQs0clLHEO+XU/USY9fwkc6Ra6tD198etgRPe0XWnvZESFweW5WW0hzBBOz2V+X8DAjPY7xCpEZfN6PVtQo1xFmbypcm+uNiUn2KBcDmm+T0Xew1tpCzmmoebsmfiqYpop0N8UeiyfqgqXvfmZ3HeQXrPMiZ+o0/Gi83KIaOHmu1+89baDU5d2nl3n+cK+XPS9zEVvRJKGN4pIzzj4v3ABWbVRPDwnyQBl/iZgmtIZa466dA9sWiclkZHoKkmPETwB5q8nPk97h0scH+gQarFjtjzdQu7BQMDKnYXdjHcMxYIy72vIq8+ipkNufDKgNvZTE21yid4wM3G5Ih+s/AEdAkBVAmZw5fXlzseTSbRvV5/9DzmjvcA+I+psY/VkUOWDXYoWwovsmEUQJxtesd04BFN5s+AumYWooWSRFm+UymAt/NQ747XtFeYeybluBhixbt8FJWOfuhKYRJtPKTwf0DTaztEs0KSwzPUG8mVJBtxqKqcCptGkYHEAhtjdjytql8CaAg4l7ftjU6M2uqKn79D/OPJ7JlY7w0J2wmSe0dJvx3v/zMiK88FoclQFZAExSHK4mugo8xDOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0200e07-e997-49d6-2942-08d88680b247
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 20:30:58.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qRyHThbJXsQj1aKLgzmlePiyjEiWEa234d2Pq8i6l8B/i7ZCVaN29M6CbH+9KU7GIyshBZks/3Lns4ibVW8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 6:32 AM, David Woodhouse wrote:
> On Wed, 2020-11-11 at 10:36 +0000, David Woodhouse wrote:
>> On Wed, 2020-11-11 at 10:46 +0100, Thomas Gleixner wrote:
>>> Looking at it now with brain awake, the XTSUP stuff is pretty much
>>> the same as DMAR, which I didn't realize yesterday. The affinity
>>> notifier muck is not needed when we have a write_msg() function which
>>> twiddles the bits into those other locations.
>>
>> I kind of hate the fact that it's swizzling those bits through invalid
>> MSI messages, so I did it as its own irqdomain using
>> irq_domain_create_hierarchy() directly instead of
>> msi_create_irq_domain().
> 
> Please give this a spin:
> 
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/amdvi

I had trouble cloning your tree for some reason, so just took the top
three patches and applied them to the tip tree. This all appears to be
working. I'll let the IOMMU experts take a closer look (adding Suravee).

Thanks,
Tom

> 

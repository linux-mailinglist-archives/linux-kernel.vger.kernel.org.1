Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB92AE3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgKJXF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:05:57 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:47072
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732240AbgKJXFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:05:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi50aJhvoSaujNjtvQ4NURzpzBTajczcE1Wg9RojsvD2etYKKcvkzbljw147KTxB5kfLlyXk9pvYmqVjkZJI3KKP2tN1fcnOyZSCozFXDyfCe9vUEIp79yFRQIZ62CJpXL894CC38rd8GWRbOjU1Z8RfkQ75T/G0Z8/GxDyFGik1p7F5KfAn0fh//g3NuyhYZCKrp6np6usTllUNDvYBHdemRYNfE0B74w0Irm2R/Y7KlXLVlmudf8vMrIFdUuYNi23GuuoyBXQ4PgIYKBOMAtG0Qr9R+i97k7bDXz0RFjgQfrxHPUwYWLxH2axHJ5CMNOiB+4KBx0sNET4G/rbT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eOOKFpHfw3I+fcCCpoKDpU6SzNLKGmBD4jyyn/lpI8=;
 b=bTh2R5ASe1uEUn9mHAH8bxwsO3i18EwtTwZtaa6HyexbegUCdfG/A3829A3RbgbfAfLQ/xYgZC3oZuXmhsPvkHcWjYt0DLKKrK2wnsMo4k6mhOwc6+FS5QCwBmFPIR/FtMtCAK7uiVSA9BjGIMZj4OsaCwCqtxXGo1vJpa9bhIHJUV4K8jwDsy9uU43JOCX+1hkjINeP1zQvQeYcS7koLZA75REdaJRFQOFazzQ8MR51Gte4ZNjhG2i89dfXe0r+KNl61rudhQbv4a+7lZElzJvbVAa3UDGSjhvOhuZDhnsu1xlfKCaJ5jXCYk4FNrqJM0inOE1C/WmbKWvSYtqvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eOOKFpHfw3I+fcCCpoKDpU6SzNLKGmBD4jyyn/lpI8=;
 b=UEZCG7Jtp5eaPKh4PEDUlNaqQ/JyYs/46dGwX4XksemV0TXs+zE3J7xaEJoD4cFgU1ovW52sH1UnBSEIKpoEYsLzt2mRuDBXCPAPjhZuxv/41M1ZYnWWgdLRpa9LhOAqZJMcPkADnQTvP8m9QF0r2YIGcczMoRBIg2nKK7HIf+M=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.23; Tue, 10 Nov 2020 23:05:50 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 23:05:50 +0000
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity
 helpers
To:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <504f099c-4159-eb1a-3447-fe1a18f6f32e@amd.com>
Date:   Tue, 10 Nov 2020 17:05:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87tutwg76j.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN4PR0401CA0038.namprd04.prod.outlook.com (2603:10b6:803:2a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 23:05:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b613997d-28c8-4318-afd2-08d885cd2a54
X-MS-TrafficTypeDiagnostic: DM5PR12MB2503:
X-Microsoft-Antispam-PRVS: <DM5PR12MB250325B0B9BA83E138F906A5ECE90@DM5PR12MB2503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gzZxDUKOOe+UmgjCM+bReuTHJdCQ7STCmTtNIn9gwtTY2/EK0D8xA+05KvTKimWaeQ8yNLbZTUPbvj6PREZpIdmqqkRef22YtSG28TvyxEoLUqX0l4zntV8/x2DmaM3TumPjLaVqik7wOt2x3nL7JxfIRATH9EprISOk1sPSPhe1foRI3zXz8dgyOyOogy6kMZ5d+P9J25Ksdh+feii8XvfdJeCHF6p9TPSrc9Vvaa0WEoGyX68KFO5z+1lpthw90dqXKKXZsX2ckbxhCUXy2KNdMUWdQwLRRkiciowpZKrkuaKZ8KKzpzWtuzMvcv5pIxjHgihbGdhpWdHizjRKVJW5Exw+OWGFcp2HJQqJdR2+wI5OpQ52oZ1Uu0jU+K4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39850400004)(396003)(83380400001)(31696002)(31686004)(316002)(53546011)(66556008)(36756003)(66476007)(16526019)(16576012)(66946007)(956004)(5660300002)(26005)(110136005)(186003)(86362001)(4326008)(8936002)(6486002)(2906002)(8676002)(54906003)(478600001)(52116002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bK1ZDcT72YNP8Qb+M9o327YnqVcZzLOCK2EOWLR7bezPS/9ob3BRuVKGOQHgwTXAoftU15Ov1q4E80ejL9yajk6Fnrk+YE0n1OL3JpnIi3o3os8ohY/zHh1yHRvz+7Bgzp6SJYr6fpLxhR2CWU8hsTLoeH5V7dPBZbkEeJTSY+T+SMBH+EGvP6NCSSf/3Z3vKO7LvRybiUrWS+MiQIOYj+nr6hSlp7aSWUVWbsgxVqLW5w9z0doAOsOlHEUHZTDIaaE0ZCs9Ha6+9nWZkCTZhSDoDc0McwzezVjAU8x/3toXdO34lFg0MSCgffflKWHHvNHDO0KSM/+ZUJGjqM9p4y/UtJO7K1bVeRY4Jdx4WSUU6DtKPryhtLE7wZevNPpD38I9e5kgWXtEau7s/dZJZPLYBxH/W+LwJ9i3JNHkZpHSGyWfXWZiH/U/sFAjqAcDBjxzWy9HBgk2NQNwGumycwyGGxsROVd4oxpZt/5ODqFTscJmt8ycxnK0xurbRjcm+TqcBey3H2Z/UoXyVwh6gcjrRrV1O0Nj6ItZCibBIADvXCWoHuNeCYoSoMCxZDOT3T6qgQFlgnrcAHNZLb+3bcLbLtSwwbkg+SrE7kQTIxbgBtVdEMWhQltjqloeSs9CVYQaRPpasc7jfhKVsg9Vuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b613997d-28c8-4318-afd2-08d885cd2a54
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 23:05:50.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cr39WtxJe6xviruykNT3Sz4bfvUiF/s+q1wPwWQwq+VXfsYB6aa7IKvyncyOVl1BKej4ZLtdeoPvPGZm4a7/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 4:48 PM, Thomas Gleixner wrote:
> On Tue, Nov 10 2020 at 16:00, Tom Lendacky wrote:
>> On 11/10/20 3:30 PM, David Woodhouse wrote:
>> [   15.581115] WARNING: CPU: 6 PID: 1 at arch/x86/kernel/apic/apic.c:2527 __irq_msi_compose_msg+0x9f/0xb0
>> [   15.581115] Call Trace:
>> [   15.581115]  irq_msi_update_msg+0x4d/0x80
>> [   15.581115]  msi_set_affinity+0x160/0x190
> 
> Duh. Yes, that want's some love as well. Delta patch below.
> 
> Thanks,
> 
>         tglx

That fixed it.

Thanks,
Tom

> ---
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -24,10 +24,11 @@ struct irq_domain *x86_pci_msi_default_d
>  
>  static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
>  {
> +	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
>  	struct msi_msg msg[2] = { [1] = { }, };
>  
> -	__irq_msi_compose_msg(cfg, msg, false);
> -	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
> +	__irq_msi_compose_msg(cfg, msg, chip->flags & IRQCHIP_MSI_EXTID);
> +	chip->irq_write_msi_msg(irqd, msg);
>  }
>  
>  static int
> @@ -271,7 +272,7 @@ static struct irq_chip iommu_msi_control
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_set_affinity	= msi_set_affinity,
>  	.irq_compose_msi_msg	= iommu_msi_compose_msg,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MSI_EXTID,
>  };
>  
>  static struct msi_domain_info iommu_msi_domain_info = {
> @@ -310,7 +311,7 @@ static struct irq_chip dmar_msi_controll
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	= iommu_msi_compose_msg,
>  	.irq_write_msi_msg	= dmar_msi_write_msg,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MSI_EXTID,
>  };
>  
>  static int dmar_msi_init(struct irq_domain *domain,
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -567,6 +567,8 @@ struct irq_chip {
>   * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
>   * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
>   *                                    in the suspend path if they are in disabled state
> + * IRQCHIP_MSI_EXTID		      The MSI message created for this chip can
> + *				      have an otherwise forbidden extended ID
>   */
>  enum {
>  	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
> @@ -579,6 +581,7 @@ enum {
>  	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
>  	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
>  	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
> +	IRQCHIP_MSI_EXTID			= (1 << 10),
>  };
>  
>  #include <linux/irqdesc.h>
> 

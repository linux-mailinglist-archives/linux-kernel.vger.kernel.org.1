Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82F296F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463960AbgJWMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:41:14 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:47538
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S373127AbgJWMlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhObiSWYItNLEPMjMppaK5aS+yPrz6doHwj3Te6uETaejRSFCT2GS1fhIWaoypTsNSlx/VxVkdklVkBzTFlwqZctZ1yL3eGKmE/jC2hYucQa3yi5dLpxUvXxOqFwiAQ9QeOItssQOxbp3CgStVCYHux9itmsiBOPEXCB9a39I40LkZIarz2i+1L6PvqTyFCG3rUjr25LpcBdMQ/nfYCysG74v5xrAuMj2QB4bfx7FlKiXNC2C6r9CDW7ZMnGdPC/yyOvMbmyY8itpE9vLngJ/J8yx0WbUg9vuGrW8BrEEybu7vEzhi45DixC9iIaOvKaEP2RFjz96+Dyl1GI42AKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26qbeSOlmsQe0uWd79gvYEefW6eNAYKcKd/L2UK9/TE=;
 b=mtseFBo1TQhIHT8uIb2QgLR6XQL0qc4Hy1zAG1Ts0EGXeeBJXZ7nqQk6ZAdGEP9r7FGJhlooLB6XiH9QMJsYTq1puyhHus35QCOFiCen0z9BgEsHCUKOT8Don3v/uNztEaWJoC55uo4WIW5TUrIEo1neQhYjvfAC70jRPomrt09W9QBlVu76q9rbh08OJVgRUTQ2weFE0EorsPer+pVUtpLfIm0o5RhMTwWkywrKhAR/LQHU5mei//zEZ7Pl2Nzvi15j9QfDFLDLl/ds4PcI9ZHAEoMdVT8fWM9/QwpT3CY0GCR6f1WcFUzq5xwrKAqyDBgu2ot4K4cnFGjEAK1LAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26qbeSOlmsQe0uWd79gvYEefW6eNAYKcKd/L2UK9/TE=;
 b=oVXaS1e9oBe1Vaz4j9qIbTffUG1DtoLPPDONb+lBKfQGS2Mpb8A9alCfS0aXqNzITsW5RTiBebMsmHcR+ya+H8xJqBl5TahVJJnh+lgIkEm9ZTjmhiXf0C4iViIQyqZF8BERcR40edBP/F4zhVs29x08ItKiIGW7hKORWFY9lqE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 12:41:08 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%5]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 12:41:08 +0000
Subject: Re: [PATCH] usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanket.goswami@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com
References: <20201023122713.460551-1-Sandeep.Singh@amd.com>
 <20201023123336.GA2493208@kroah.com>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <07d421e9-e98f-18e2-cf05-a12c55890ca3@amd.com>
Date:   Fri, 23 Oct 2020 18:10:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201023123336.GA2493208@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::33) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.223] (165.204.159.242) by BM1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 12:41:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdadb92f-5e73-4406-f9f2-08d87750ea63
X-MS-TrafficTypeDiagnostic: BY5PR12MB4804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB48048C8D2AD0FB670AAFBB19E01A0@BY5PR12MB4804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkjwAJTsJ3Owqte0pNhW+K4D74AGG4aRirKL95WlWABj+OBrzvOZZ+4NBfAF7zfRnKmtWouVwElCyG3TScNMJMD5+2SyPnH307tltiQIv5R0zHSnZSgDw4Fe/B3Q1q2gDA2R+V7fXOkz/BThC6GiTgXYvwLYH3wxmj6Q709bmg45rclW6KWigcFZUMWUPzHCYJ+2u8WbSyEkxFgMV/c/lkcivFzDUlCUZLHuQYx2Xt83eI6HJSxZHaOFJLVrk5Ul60+gsqWU50GGUa9RzJO1KWbZKZhCvrM9UfN8PLtxLTa2MjXwGzwjlVv+xLsmawW4z3I4sigPKjcZv3FX7WRyo9dLLe6vMYXerdkU0nQ9PqSXGTCHhyim1A6JG81HpM0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(31696002)(6666004)(36756003)(2906002)(66556008)(66946007)(53546011)(66476007)(52116002)(6636002)(110136005)(5660300002)(83380400001)(316002)(6486002)(4326008)(16576012)(26005)(956004)(478600001)(8936002)(186003)(16526019)(8676002)(31686004)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v+AMr/J2SDvJDOOvFUHAy9g+1h2aFNrboIkNEMWzKrbuDVx/2pAgWrTYUQcQeOuuS/BAaQQIYFZyeDKpVrS8w8BO9u50rk88q7SWRCkMUdnkVBl0VV7N12cnY3xpHisSjxNHLYlpNB88GBghfMZidx6PtXpLWSPDWfJiJVF9mulk3rYBEJtTIEh9EeP32Dew1Gfcs1jPzsCuRTZFrU9XKzT5i0nqNVdlTnwRLKKKPFpXW0soMhIsQZrkK6OCSK4T6OyO1mWCE+iAXHt52mTrkxKm3wUmm0lX7Q4cij3T3Z6rYdtrAJJJ6wmZDoGqUlVgGxb8UYSt8wp0y0xO5aRaY+4aL5CHsFIvceEhN8iHSqk03o/m8jyykSmuywzYBhm8/VdCI7UtBPPQuzcakb4bnf8/6RTyxDGxJeTmlu+zWXe82IEAzSd3yCvWGbTj45Mq68KU6UblqpbkRj0YJhHXRLq8OpKT0WukbqKL8u2TId/FJgkmsXGbmML2Sma5E9w8VDvBRROBFhA6CiFLISPG9cEvYgJ0rXrCjE/GPCJSnb0RD0SFoAOW3RwCX4SNUbxjQxS706cOGfO0CLX58vD26tpXbNCFJPCxkF2oI0gakVK5oHN4GXe4T/hVZR8BYfNJVGQh9s2oJjrnHgLvCCLIGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadb92f-5e73-4406-f9f2-08d87750ea63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 12:41:08.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdTR53gQpLVqtj7q2iQ4WKT6OfkmRnPOTRpRsLDLiYumuR4r6Kgvugx+wuO+t1lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/23/2020 6:03 PM, Greg KH wrote:
> [CAUTION: External Email]
>
> On Fri, Oct 23, 2020 at 05:57:13PM +0530, Sandeep Singh wrote:
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> On some platform of AMD, S3 fails with HCE and SRE errors. To fix this,
>> need to disable a bit which is enable in sparse controller.
>>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index c26c06e5c88c..bf89172c43ca 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -23,6 +23,8 @@
>>   #define SSIC_PORT_CFG2_OFFSET        0x30
>>   #define PROG_DONE            (1 << 30)
>>   #define SSIC_PORT_UNUSED     (1 << 31)
>> +#define SPARSE_DISABLE_BIT   17
>> +#define SPARSE_CNTL_ENABLE   0xC12C
>>
>>   /* Device for a quirk */
>>   #define PCI_VENDOR_ID_FRESCO_LOGIC   0x1b73
>> @@ -161,6 +163,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>            (pdev->device == 0x15e0 || pdev->device == 0x15e1))
>>                xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
>>
>> +     if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
>> +             xhci->quirks |= XHCI_DISABLE_SPARSE;
>> +
>>        if (pdev->vendor == PCI_VENDOR_ID_AMD)
>>                xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>>
>> @@ -498,6 +503,15 @@ static void xhci_pme_quirk(struct usb_hcd *hcd)
>>        readl(reg);
>>   }
>>
>> +static void xhci_sparse_control_quirk(struct usb_hcd *hcd)
>> +{
>> +     u32 reg;
>> +
>> +     reg = readl(hcd->regs + SPARSE_CNTL_ENABLE);
>> +     reg &= ~BIT(SPARSE_DISABLE_BIT);
>> +     writel(reg, hcd->regs + SPARSE_CNTL_ENABLE);
>> +}
>> +
>>   static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>>   {
>>        struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>> @@ -517,6 +531,9 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>>        if (xhci->quirks & XHCI_SSIC_PORT_UNUSED)
>>                xhci_ssic_port_unused_quirk(hcd, true);
>>
>> +     if (xhci->quirks & XHCI_DISABLE_SPARSE)
>> +             xhci_sparse_control_quirk(hcd);
>> +
>>        ret = xhci_suspend(xhci, do_wakeup);
>>        if (ret && (xhci->quirks & XHCI_SSIC_PORT_UNUSED))
>>                xhci_ssic_port_unused_quirk(hcd, false);
>> --
>> 2.25.1
>>
> Does this build?  There is no XHCI_DISABLE_SPARSE in the kernel tree at
> the moment...

  Sorry i missed adding xhci.h in this patch i will be sending v2 patch.

> greg k-h

Thanks

Sandeep


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9B29DF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgJ1WMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:47 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:41953
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730663AbgJ1WLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:22 -0400
Received: from BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 11:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPB7Z4v3ywt5E5jlGZiHIn6E5GmRRqZqxlbFbP/rcEU8Up+bduUrlvdvEdgFkI7d/6T1g8Vv1NcnifRkR5eobMkVxTYYEJD6HqCZY5/tmCKazonVkowfoIQdBaajkywfqKxgW5s9LVfUl17kSLDjDTO24qEPavzE+bMbva804Yz22YIzA46XR0AeNYNEu37c5SJ8eTkw26pd5b4NtTkaRtpXuGvM5kIC1/2uX/VS3GmMct95I5YOaYF5IhbOPiJ0esvMT/H3BTSvXT25+GbRD2BqFSIQ15AM+lwfyCj+m+401vcHGCnjI+oCkdMW6ZY7regzFJbmYVLJIZ0VMOo6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtZjaBDdML0N4hBw+duHucW7MmZH8UwFnukmPiUabU=;
 b=nltPwd1vydBPPPIXm7a69DEoI4q8NLsCSWW2y/35vvU/xMysXkm7V492nPntm0F+oKEpPx2XfTl22ZOckk9htRiNtOQJGXmUaKbMSDQP23sDi3X1C6Cn746f19ZJjHNOLov2+QrYTjKB6QvOMBxcT7Bh8sDfhPHsF+ybDFFmR0ngRLZT1zB0Jty5M/ip/Gnll/MFJH5Qi/BeMM7ymBzYkn100ntHZMuVaQr5GlVGbDUzpF9LaHWjMyuAgDhqc8Upk+Il0CaZW9B8cyOKoj8Y1HZcGqV1LjJXoBG+2Es0lzod6VUW/X3bWOfVmlnyKJsNzStRBzuuYke1evqAU2JOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxtZjaBDdML0N4hBw+duHucW7MmZH8UwFnukmPiUabU=;
 b=ZaKU3VosP/3NDbqzPFT1NbLf85Gty9++xDdAKzOqD3l3G35g+2XzSaO00CA129hCfgmJtovkU4uAm1vW+xW2DbsquRJRhRvYkYmnx8X7q+E2Sfmvtgke445UQa5LWZmMZ5q0NiFr1d8h8J3hlkqbxy+oObXGIfP7ebWYmZ0dEMg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 06:31:40 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%7]) with mapi id 15.20.3499.019; Wed, 28 Oct 2020
 06:31:40 +0000
Subject: Re: [PATCH v2] usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanket.goswami@amd.com,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com
References: <20201023131503.759671-1-Sandeep.Singh@amd.com>
 <ed3847f0-f219-547a-e887-cd0d48f77dda@linux.intel.com>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <8ebe6707-5f83-58d3-b895-e193a191f48a@amd.com>
Date:   Wed, 28 Oct 2020 12:01:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <ed3847f0-f219-547a-e887-cd0d48f77dda@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::34) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.223] (165.204.159.242) by BM1PR01CA0140.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 28 Oct 2020 06:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57d01219-8642-4a03-fa25-08d87b0b212a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4260:|BY5PR12MB5015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4260A194B10128375C67F080E0170@BY5PR12MB4260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQrysYvnEFNLKgggg9rB9NIhjDvGt7vc5pZef20NRTolHrXQ0pA0+A7+WKQsfap6Vku90yLA5jWTZuKHQs0WK7a//AgK6EGs0v24FvQJqeJ5X9795vfvXETJqvskoGiUBGT5omF+eWWeVIQ7/XLasPXYgaUAcrlYrjY9ffaSSeKZv/7OaaYKNrWpqSHDpOSOo+rErEe+mTYrwE+CR9WBBfEalsVb7tIyvylK+2YRqEVYK+Lc2R060UqEzmbnFe1+gVVBzfVW74jHUcGyaoE5+zQnSSGO9E+hjqI33unbQ84E2o6Vy7adgHtLHaPDp6cHmZ+LfunjCoHFhtbwiACA9F5D/uCvWaRSm8RqGse6a00KkBx8vpvwW34/q85FLKf/kyk1N7NNXN6V0VWdyj2az2RQ6LUu8HspxPaXzVj4sekEEEeqnWEoJPyaHzQoiyroyyHDVDmWOSqe3EbPg//dow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(31686004)(4326008)(110136005)(36756003)(52116002)(2616005)(6486002)(186003)(53546011)(8936002)(316002)(66476007)(16526019)(66946007)(6636002)(66556008)(8676002)(956004)(16576012)(31696002)(26005)(45080400002)(2906002)(6666004)(478600001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CqtFt/zOzVbi25pUJ/Clmcm5TW0dwmSVR1xy81uVzxWowjkIHbEnTSIkl5/INJGaGSYItrAIr12H6qZn4lX84Jw++KvPNyqefXp9AndV9jTjeUJwJkjDTUJ3VV8MiqeU/+Jsxqd67ZooSXJYl0znb5B7beycrWidamoagTSTj9JULU0ETpzbMDpp+4ZplSpp12fYk6tG/EMAWMg/zi2XfxrjL6cqHxI9Iuf5j7LGwhykzptW96BoFVT0qxTS6H4KxYBxmx+UJdp77/yLSHlAP8h/rFcRxsRqVkM/fBlrz3cdHK0TPAYjmPmFLZ9Dy3Jo6uEkttEVNgiAH5Opxg0I5bX62OYfoYCB96eJuYPhRtsgzm1T6v9xO+UJacZDeXvVeC+gxMAR3GDvfbqnC3O65PAfiS+PgvFB9yMbeORO2mJXshMb0JwRUA5nUUB+xeBjcNIV7/kvTTLQe/mS7KiXckOorT9T9SokI2B+/ndBygeIxTU6/Nq0Q51mFIgGSXDQUCJOF0PKfpQij3gd66gz1pYpaEPloBhPrTio7ad9hoiRA1NAx7BvKHVm7oKlAI1PPUanuFrbYs+bcC3Z75z6zFF7ZkvW6toxOhUWHRC7InARUWRe7YaLEk560stcwYrM6VtINoWEmcosPqoY5ftRGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d01219-8642-4a03-fa25-08d87b0b212a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 06:31:40.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFKaqf/AdCCNsXuty+60phi6exBZvDCJRXhPbjUNrmh7/p23RpNJGtCB0q8cchjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
X-OriginatorOrg: amd.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/2020 8:16 PM, Mathias Nyman wrote:
> [CAUTION: External Email]
>
> On 23.10.2020 16.15, Sandeep Singh wrote:
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> On some platform of AMD, S3 fails with HCE and SRE errors. To fix this,
>> need to disable a bit which is enable in sparse controller.
>>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
>> ---
>> Changes since v1:(https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2020%2F10%2F23%2F368&amp;data=04%7C01%7CSandeep.Singh%40amd.com%7Ca8900bc99ca441507cc408d879bdc5e9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393203258053573%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GM7TXOawh6nLZaX1ABZLlptYeyoUSMHnwhCxbY6zFZI%3D&amp;reserved=0)
>>        -> Add xhci.h changes
>>
> Added to queue.
> This looks like it should go to stable as well.

Thanks Mathias , please help to queue this up from 4.19+.

Regards

Sandeep

>
> -Mathias

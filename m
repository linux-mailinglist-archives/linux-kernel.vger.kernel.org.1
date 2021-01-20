Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4752FDCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbhATVqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:46:53 -0500
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:54753
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725271AbhATVTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:19:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLhyq0/rMFOttSV4+Axq+NSb6ev32I5G2zo6LA8FRzIw1tsy6T+OZG+PW3C221+eGwKIoxPC6g2+WBBSGEWYLQ3Hz6ypOIWCZ2BqwDDfJ3ecL8ub4l5yeJaSCR2eT4tqO7jvb+TPGpZzNHuK6cGuect3S8Qgnh/uCwkwONB00tmILZeED8xYzVtje8soCYaTwbmSbiZJr/gkkReas2idviQp32usVE5hPHgoDIbpxqtaDiwsxiQ8KfdnuUXtbCVTidXDPQoE1ennMR97MfjgliRgsEqBz2GSjTEbp4aSHJwncWJXhJvsDTVm2WzkEUWWD46EQHguAMUah7pW38j4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbczUGf6gkoa5i0TTGQfKKGWpQbG6BncOnl7lC7jrhE=;
 b=N5PqwMBo6ehbxCMHzNTMT1fC5SRfERVnZdwipontynavA2JcEhzcxAt3AAIBcJmRlFqwdpVfSl7SfX8doD6mFgrcvoMdRwUVY76QrbQmmrXqgbHuKnk11yxf4/C9VPAvOUYfALV+hoj+vRqxZ/EwvmFBe3/vQMG/oFS14b+m20YxhFmTcoBhhQK4VQYGsgafQvLkUcaoeZGLxODFkfCVkiLo4IE+aKnAgz2uUjICi0S5gI+/O1frKi8sJg0259OrxtcfZbXHelY0WnQ5qGJ84/wBjduNCAUvIFU+R4/y3NtD7bhTX9bR08Yb8ZpIGvE6WQVSZqx14QxB6/Rewz6jgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corellium.com; dmarc=pass action=none
 header.from=corellium.com; dkim=pass header.d=corellium.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT1575309.onmicrosoft.com;
 s=selector2-NETORGFT1575309-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbczUGf6gkoa5i0TTGQfKKGWpQbG6BncOnl7lC7jrhE=;
 b=rkVyyvNwQlecvd0Bf7zgMxGAnft9AbqPqgYm8thSAIL97dRgRE2C2IOH/QImxIhOv81NDDYpuub/sqkCJLWSWg0z6DM24kcOzkVGurypjVvOTWJr59hMo+FmuZv1ilXMRPmg7vyGNDxFCzqQ9D6zHl557bgqtOVvzQC+vp05GHw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=corellium.com;
Received: from DM5PR15MB1595.namprd15.prod.outlook.com (2603:10b6:3:cd::22) by
 DM6PR15MB3816.namprd15.prod.outlook.com (2603:10b6:5:2bf::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Wed, 20 Jan 2021 21:18:10 +0000
Received: from DM5PR15MB1595.namprd15.prod.outlook.com
 ([fe80::3d11:6159:1c47:2a5e]) by DM5PR15MB1595.namprd15.prod.outlook.com
 ([fe80::3d11:6159:1c47:2a5e%8]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 21:18:10 +0000
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
From:   Stan Skowronek <stan@corellium.com>
Message-ID: <ce74bb29-1237-b0e7-b397-99b44c8b653b@corellium.com>
Date:   Wed, 20 Jan 2021 16:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
In-Reply-To: <20210120132717.395873-5-mohamed.mediouni@caramail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [68.160.250.214]
X-ClientProxiedBy: BL1PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:208:2be::6) To DM5PR15MB1595.namprd15.prod.outlook.com
 (2603:10b6:3:cd::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (68.160.250.214) by BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.9 via Frontend Transport; Wed, 20 Jan 2021 21:18:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e04f98d9-0544-457c-b421-08d8bd88e3a7
X-MS-TrafficTypeDiagnostic: DM6PR15MB3816:
X-Microsoft-Antispam-PRVS: <DM6PR15MB38162061A25819DCD6C2BB49D7A20@DM6PR15MB3816.namprd15.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /C6lTU5dPjum9A+/kmNNg8PbjD/th6HULcrHky5jBchZ+JO1DoAmNbM5q6APRVEhnJu+5WUFmCx9tgKYqki1j6iJyj4UrkBcZRPtgqtPqicdEC5oc+Fl1HL2wrNyF3iylNe2saxAjNIk4P/o0SOWoWF3Eb2EuWitb83ozfTsGJEWbAYXwTo60lwK9lpr+VnqRDE1fFa2250sHSiSpAsz9koxTG3JS/hPVNnFhdxz0ZWsdd06zjqmZce6oP9z1xH+rojq5s7YhaHtEJlXD3ARgz9bUHaBRSR7I7eVCuFEYbA9MrDvKWA6Z04flF+qTQrW/+mgc84fnZ+7+HNvAe4Ys6e+GqwfzOBJkbn6XqGBn+kO6tBrsTgHvzdFSTnTmr5cxpOD/Ug4AsKhUBRMMBPw9PmC9CgeYjOl+wSIGC2sJJU7nfEDFvV1bcIsbM1xfOq2g0rGDRIFdQ6NqtCLDldQ5/xfcHBHUcLuQQUr033sa/eLvhNQxczs7f3+We3S0WdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR15MB1595.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(366004)(396003)(346002)(376002)(47660400002)(8936002)(478600001)(66476007)(16576012)(36756003)(5660300002)(8676002)(956004)(2616005)(2906002)(66946007)(53546011)(66556008)(4744005)(186003)(316002)(6486002)(16526019)(54906003)(26005)(31686004)(4326008)(31696002)(52116002)(86362001)(46800400006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDFEbTNRRWZ5Y0M4Rk5XQys4M0F4dU1HL0ExTHRxQWE3Y1pmY201QmxORjVW?=
 =?utf-8?B?OVU4L2JheS9hSHptTEtLajF5VXZveHVkYWZOYWhqZjJpV1k3S3VSTVZ4dDhM?=
 =?utf-8?B?KzJPdGtNK0NXbzA0d1Jub1o1ZGdzRXFvS3dUaWUxaVI2K2Rjd3JyWThZa2ww?=
 =?utf-8?B?bnQvSktWM0JIMTZPWUJ1eEFDTUFSUjNtVElJQ0ZuSHlVK3c5YVh0QkNPMENy?=
 =?utf-8?B?YlNZOFhNRE9MeURFWFNWZC92NHZjSFJNVjFuOWNRSEdGb1pEMWZZYzhFZUJz?=
 =?utf-8?B?OG1QNDFpblpNSER2TFVGZzVTQjFscDRXK1o3TVEvdHhnT1ZCVnJBdGF3WnA4?=
 =?utf-8?B?R3lpdnRsb0dYaXU2UVdTcnplOTV4QWxFSzdNS3NSbmUrNWJxM1p6eWU4YytM?=
 =?utf-8?B?dmJYUXR2TTU3UFl5OU9sdExieUh0SnBhRkdZR0trK1hJZzIvYnQwWkZiZTRB?=
 =?utf-8?B?Q1ZQUlZsa2xKSzVSRm1mcGxVU2JONkNIWTFHcC9GT1lYQ3IzZnQzWDNVYUMx?=
 =?utf-8?B?cUZ1N3RRSy8zaVU1YVc0c2ZzZUYwUVdFMVUxRmJGWGwvY3p2aW5ZS1hoWFhu?=
 =?utf-8?B?SGpHUHl1ZjJCMzJWSFhTNWNtMWhXbWNFeHZvd3YxSVBWc1dmU2xOYklSUTJP?=
 =?utf-8?B?WWNkbjBCbFZ4TmdmV3RrajAwK1JJUnVLSUhqSVUyOUJnK2J2MVFERklUL0FW?=
 =?utf-8?B?RGdwa2l4alZvQW1IMjdhaXQwUlozTjV2SkEvRTNWTmorWFJHVktBWWM2dlRi?=
 =?utf-8?B?bXlQQ3VOUXF6M1dxM2U4ME4vSkU4cUl6MFg5cVVqakJ6c01wc3VnQ3hkUTc3?=
 =?utf-8?B?QjBPT08ySngyMEt1SmdFejBwbVFpU0lkZWtSUndqZUgxQXdiaEtVcHpiMmMw?=
 =?utf-8?B?UzBEbjV5aGVaRys3aFM0WmwycWVIdUtPaU1yQ3d2b1ExMXhzV0dzZnVPR1Q5?=
 =?utf-8?B?WE9XanJnSWZiOHpKbmxwdEhaWU5wMWdNZE9LWGl0bFMwRWtQZkFySVcwc2hj?=
 =?utf-8?B?L0tJT2M2RzUyemZYVmNHa2FiMURqVVBYbldPdDM2VU5yYVBuWGFpUlRORlIv?=
 =?utf-8?B?dDZCUGFocnl1cjhmT3p4UUtpakdMNmZVYm5QcmZrY1BHRTBpVlpSN3ZpWlB0?=
 =?utf-8?B?Z2tRTDRyZXJyaFd5S0tvT0lCWGkwa0J1Q0hFTlpDaGhUdVlDdFhncUsrN2RW?=
 =?utf-8?B?Vi9GdGxaRzZBVUJDK3MzTGhETXdLbFdSR3NnUFdtM2tsMkdYSUJENFRRSTcr?=
 =?utf-8?B?WTBPZFJuc2lBaktiejJNa28yam1NVndDTUFDZTdJQnl5eE5yRzU1Y1ZJUDhZ?=
 =?utf-8?Q?+OMkrE11mAZ1U6MzohAGt9DGpjMdEHYMZC?=
X-OriginatorOrg: corellium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04f98d9-0544-457c-b421-08d8bd88e3a7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR15MB1595.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 21:18:10.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cb8b7e88-0f9e-40ec-b342-a8686aa25f69
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt/g/eIp0ydNG4R5l2JBLlzgO5DwsnR3I4CDXdnl2LSNp3fWkqvOphOgrRCMhEqQVHbPfQFM5yW9ZHMTcolOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3816
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Stan Skowronek <stan@corellium.com>

On 1/20/21 8:27 AM, Mohamed Mediouni wrote:
> From: Stan Skowronek <stan@corellium.com>
>
> Apple SoCs use the Apple AIC interrupt controller.
> The Arm architectural timers is wired over FIQ on that hardware.
>
> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> ---
>   .../interrupt-controller/apple,aic.yaml       |  49 ++++
>   MAINTAINERS                                   |   6 +
>   drivers/irqchip/Kconfig                       |   6 +
>   drivers/irqchip/Makefile                      |   1 +
>   drivers/irqchip/irq-apple-aic.c               | 211 ++++++++++++++++++
>   5 files changed, 273 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>   create mode 100644 drivers/irqchip/irq-apple-aic.c

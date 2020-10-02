Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89FE281487
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:57:01 -0400
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:57440
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgJBN5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1HnvRsIKDex01VEqunu0W5XL6YKXsu3RmjG4bwBtwvmn5ED00fTttBY+EWSCq35b4qPIvX8f1I0ekbl7RORnGG0xFY5oDBNvdQ2dqOppj95ZTCw6LGhLJOML/f3jLOGowOldNA0u5qSqicaU8nhjIo09cJD1fr+aryjKpoBMBGYIsB7djOuXSAuTOrVHAHkK5Tawv8aUaRAE5LnXXEadKPgUtvnHIz0GDu4uUZd2UDVSib5kVOpfz4csMVjYmZgqAWUWtCQicCDYBD8IvrdlWJiRmaD3hRWWv7LlVpMenyJ+B5f3U/w/972zejNVEuDvVWOTDe/FioGg/s6PSsnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwrfoe6CGz6MmmubdbXzHNtNOAaPI7HOoZfM1dQhAuA=;
 b=dQA+a2pZUF71r6a9l5O5IcnbFm6bAv9kc6p6iF4sCQficB60+NTJwvtPXrmq6tPH77Lpg8wAj0omPzT6Bd487DPh+HsoDcZ6ZvC+WrhvZXhbFrKnPb/DhjlZqsL+tvEoBrNr/0dVEwn1so2RGUidcuWjLuLsWLEBHpHBIKs0ygP6MeYXR3u9q93VpEPo1gl0xMfabAtMK4Uz5P5VK251STiDnqjfF6bXdVg+ndJ7B01TPmH8PsYmYkdY+RKAEjHVtPnOrD4vdM6KoZBNOlFqpZrI8axtTpZW8vQ9SFygEnw+3PFRqS2qkX2d+nAiORbr+iBZ6xPIDCjFBj/zLzvZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwrfoe6CGz6MmmubdbXzHNtNOAaPI7HOoZfM1dQhAuA=;
 b=pVlRUAX8tmjpSb3mAemNTOVdOCzG/sPv7P4qiD+BI9JvGLhZciNsd8ER3ySq8+aS6W7QD37dfE9IGYOXHNk9xruyn2V/S2D+jt7Y0PorDX66CEo9hkG2RnYjUpMYDlb22bL3LHj7hvtGCbK4L+5wecexkIxyLNq6jJJNstI4Y5M=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB5584.eurprd04.prod.outlook.com (2603:10a6:803:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 13:56:56 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3412.029; Fri, 2 Oct 2020
 13:56:56 +0000
Subject: Re: [PATCH v5 00/13] bus/fsl-mc: Extend mc-bus driver functionalities
 in preparation for mc-bus VFIO support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
 <8b3c1222-5dbd-5c51-ac10-8b1c1a69d2d5@nxp.com>
 <20201002135512.GA3466738@kroah.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <9e5576fb-6e42-4216-286c-7afb7979ed0b@nxp.com>
Date:   Fri, 2 Oct 2020 16:56:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201002135512.GA3466738@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0030.eurprd07.prod.outlook.com
 (2603:10a6:200:42::40) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.106] (86.123.62.1) by AM4PR0701CA0030.eurprd07.prod.outlook.com (2603:10a6:200:42::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 13:56:55 +0000
X-Originating-IP: [86.123.62.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00bf8fbb-79ef-455e-084a-08d866db0660
X-MS-TrafficTypeDiagnostic: VI1PR04MB5584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB55842150AB4BDE4966E166EBEC310@VI1PR04MB5584.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiVhfkwbVFQlzrfbP2O8kwwYc7vLujjFGvADDPiFOBIt2mCIFDR7AzF/wfkdUT0Vxs8ZuYGXYh3pWEInNQQM4mu3JzCDNC41R2MoJm4GaM114Pe/QkR0V4BFoHNjocEGKQFotlrEtXoU7Tqr9RxlDGU7rgASvOTt1ZskdBWS+QAaYi1BAEevoagK1l4dH094FHbV7l+1SC45z8Tbj8BJWdfBv7X5sruXPlL13oP4v7MYZBXyfBDksmt1zlGbCCHKz3VXGrKVjn/6IhB3E/29pRAyeSO45mT/Y7GBPIRJbjiAGmmvVGGMQQ2Oa8FXKWzYonr8ty7ez+XTt4H19GYyPwXfe540hSm/NrKIWo8YBIYuwtqFwJ/pliA2FhtU4V1W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(16576012)(186003)(31696002)(31686004)(86362001)(53546011)(8676002)(66946007)(478600001)(316002)(52116002)(16526019)(2906002)(4326008)(8936002)(5660300002)(956004)(2616005)(83380400001)(6486002)(26005)(44832011)(66476007)(36756003)(6666004)(6916009)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SHwBNqntTeIFuTJ8YaHyeVyuWo9nEHkikhVgdyGvNRcKtSQPQVi74x7M+786iQ2VlHeceRlskZro4uju1anpUC1dGmEfCK1fB10RcEIChLM4XHgBtu8fjrEi/+TFPyKpo/vY7Wqi+7BHjbnCiQC8Znk9eDeXyzaCQAvmckKabQjZA3RSDdhDXHQ4UYrw/P17+zLBDUFDuAFuRAOjqZpwACAH8jGep7+Z0DFrDjBEliZ7MNz33HTbTUdr801S1yowH+nPuTdzenXdtuSsnueY7yd0ywwN/sWWwJx14vdwJW1fUTZAGAOCYRgZ8RFwIC8bmMChPlyoykSLFlquw9GvSa1N10HDX0sBDK3OrKLWyTJ6ysxkyJKXvq+oCbZgflFSml6uhG9KgFcMc589hzKfBGqloCJxkfWe35knUIsOGusK2EE5yclfFy1rn87vJKW3d4b+CxZojaUTTewu8aGeHu4N0b895d1gSW/SIVE3r0ELGlVcE/qPZkfqm+ysQ+ttpZhndmgYGNBwuflpXj1HXQLMV+yk4Qr66ANNnQ2MP4QCL/HMs8S0nxuxJ9njOIiD0g8SGF94nY9bMRy0RiB5/Arxv3xgA4E3+fR0nYvBmQOwOPP7bdVmzE+Ey0X4zWMxmXeQ1Cl1a1MsCys73hcGxw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bf8fbb-79ef-455e-084a-08d866db0660
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 13:56:56.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC1I3lEPZs2sLBhC0iOh3gsw6ZuG0K9UvtoMEKlr1NEsW8BtgB9ZSs2skZTU+Nv9lmYOC8SROWLPrr5zC9CUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/2/2020 4:55 PM, Greg KH wrote:
> On Tue, Sep 29, 2020 at 02:06:41PM +0300, Laurentiu Tudor wrote:
>>
>>
>> On 9/29/2020 11:54 AM, Diana Craciun wrote:
>>> The vfio-mc bus driver needs some additional services to be exported by the
>>> mc-bus driver like:
>>> - a way to reset the DPRC container
>>> - driver_override support
>>> - functions to setup/tear down a DPRC
>>> - functions for allocating the pool of interrupts. In case of VFIO the
>>> interrupts are not configured at probe time, but later by userspace
>>> request
>>>
>>> v4 -> v5
>>> - dprc_celanup should not fail
>>>
>>> v3 -> v4
>>> - Rebased on the latest kernel.
>>> - Exported a dprc_remove function
>>>
>>> v2 -> v3
>>> - Add a new version for dprc_get_obj_region
>>> - Export the cacheability bus specific bits defines
>>>
>>> v1 -> v2
>>> - Remove driver_override propagation through various functions
>>> - Cache the DPRC API version
>>>
>>> The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
>>> devices" patches, but the series were split because they are targeting
>>> different subsystems. However, the mc-bus patches may suffer changes
>>> when addressing the VFIO review comments.
>>>
>>> The patches do not address the comment regarding moving driver_override
>>> in the core code. I prefer not to tie these patches on that change and
>>> address that separately.
>>>
>>> Bharat Bhushan (3):
>>>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
>>>   bus/fsl-mc: Add dprc-reset-container support
>>>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
>>>
>>> Diana Craciun (10):
>>>   bus/fsl-mc: Do no longer export the total number of irqs outside
>>>     dprc_scan_objects
>>>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
>>>   bus/fsl-mc: Set the QMAN/BMAN region flags
>>>   bus/fsl-mc: Cache the DPRC API version
>>>   bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
>>>     multiple entities
>>>   bus/fsl-mc: Export a cleanup function for DPRC
>>>   bus/fsl-mc: Add a container setup function
>>>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
>>>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
>>>   bus/fsl-mc: Add a new version for dprc_get_obj_region command
>>>
>>>  drivers/bus/fsl-mc/dprc-driver.c      | 190 ++++++++++++++++----------
>>>  drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++----
>>>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
>>>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
>>>  drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
>>>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
>>>  include/linux/fsl/mc.h                |  41 +++++-
>>>  7 files changed, 359 insertions(+), 127 deletions(-)
>>>
>>
>> For the series:
>> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Do you want me to take these patches in my tree, or are they going to
> Linus some other way?

I'm prefectly fine with you picking up the patches through your tree.

---
Thanks & Best Regards, Laurentiu

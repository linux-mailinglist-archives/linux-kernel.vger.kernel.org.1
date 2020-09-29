Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6141327C38F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgI2LGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:06:55 -0400
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:21183
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbgI2LGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+lYQb3cHsabndDlGXpe9VpUZi89ItKuZ43sS63X28iRmCXI8crllLZPFyFdLAdLkVmasD6VSr5LDpI/ZXkBjJAU6/Ge5FRl2FQ65TwcdbWXjyBZjstKR+ys1VW93XVLM6P2KP+qsqEcG1+qkRrJv8EA6LZGG54n7a3ssIwH77tViKn6n8rVYIH/+lhZigEvwnSjki13B0gI8NfouiQpNBAK2C2PZU68EgIS+NFcj74QLZ7tgYjQ9UXp34tZIIbdylwJ2znIOifD0FhTuraY40jfLvGJEfaN8l1V+Up5lzCvVRIDkErNidwpKbWzdABYfJR7S5MV/LYA/RVMebr+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1UYWqi3idshcF5UE2PpLX96WpJPHA7XSvgFZ21h2e8=;
 b=X++v6cDacCsdvIf5LTkbE+wTc8CDAwuOi2m04VCTepm/RHVgUekQWoLZ5/crqYzE9pDUxJgLwMBVh6YLvcfejOwc9MYW8rDs3eyx/Fa4gSd4eXxL28E16e0BPLeMImPQpINDoYUHKkwxj1xBwFG0dTeL5/AfWWrCNA3KUhTlExoWo8tTbZ3CRzR7jt/bPnG12mu8qgAgYGz9eSS2XscjEBiL0unVw2ZYOycpv3c/p9BLml9UdsaTvJvtkytO+VJnf9SJ//fi1bbXIIyb8VncDKFnSX6X6QSHjZsHv7k2A7i2ENlQ7qDeBhJNerXP+olrIjXpG1CaELpkg26g41X4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1UYWqi3idshcF5UE2PpLX96WpJPHA7XSvgFZ21h2e8=;
 b=WX2mEmJ6t2H25OOxdn3KvZfU+fGt4Jqu5uXCZAdjLHddJ8jrHtM3EPr8aVH0zW+ArYUNJhbyDgk7dlauHsoIAvjp4F54UMMLVtuz7vTOaMAvC8C36GAwkG75XlUrd+kDyJbgSkiEwxr9OXz8MPqRAm8GQuZgJQY946E8pIv733g=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB6351.eurprd04.prod.outlook.com (2603:10a6:803:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Tue, 29 Sep
 2020 11:06:46 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 11:06:45 +0000
Subject: Re: [PATCH v5 00/13] bus/fsl-mc: Extend mc-bus driver functionalities
 in preparation for mc-bus VFIO support
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <8b3c1222-5dbd-5c51-ac10-8b1c1a69d2d5@nxp.com>
Date:   Tue, 29 Sep 2020 14:06:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.106] (188.25.97.249) by AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 11:06:44 +0000
X-Originating-IP: [188.25.97.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5677841-999a-4a62-fdff-08d86467c103
X-MS-TrafficTypeDiagnostic: VE1PR04MB6351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6351545EE559E00E6E57A5C3EC320@VE1PR04MB6351.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWstUiOhFUuLryF4ykPGGFP2u/58ayF+QcRcMm127wk0MUwv4xtZ5gsdNt5RnocDWasUUG04i65uvtFK27nFE/6LrqzSwsCQVuLYje3KdVK5I4Worg2xpvN9FERupvugrExB8P+aJxLP5El/Zk1PfzbxDcVj6F1HL/ETtutI3DzjzoifLtAdhBszN+UVX7vmnjRtHquyATTfRk32g7jM5zxEc4LpgjY6B0KxJ//jc1j1qGDI/qQyTzTJ9BU+Sa5J51sxHdk4AiHZmIKbHGakEF0k4M2WRMd/yRCkkUxQHp7zvmORt8HIi5mG2t2HqfxRwPN2xlmsPbuJ55EJP2vA01FWmK5MLPAWi93tXgHsMWFdO0x5/NI/8T99L3momlb4+RadxSUgu1SCN2dv3zo7sy1SRai/qNiLSJ+vODZbNwJp90pq5NTf4kVurRBY6edT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(2906002)(16526019)(186003)(26005)(36756003)(52116002)(4326008)(44832011)(53546011)(478600001)(2616005)(31696002)(31686004)(8676002)(956004)(86362001)(6486002)(6666004)(5660300002)(66946007)(83380400001)(316002)(16576012)(8936002)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GMWPBTNWTuL1vxX5PKAz6cEivv4wMGTQf3Y9WmouBszmMuHKq6Mjb4HnHjKG2hIcdzAkQ5JBIaberzycF16lLp8kVPeXnr7RklzywUt3LfJ9OpSrTGf8uGbWLLnl6jkrbdJqssoW43I1DOGIryOlg2TlNIrwor9/NunVBYW7FCVDsnVnGs7WSndG9tl8a6QKVnKQS+5KXY7aia4h1drkMSNDF2YzkcolzrzJ4vvJvzZs09mhGEWsCRmGvsOb02hn/88cpPrAaPMTtA6xA3PLMzd+EsKALkM0G/mOoyAfMxWiuU6IVmiaIOYg2abLHvDGqD3qKrorag3zn7DN+7XN/NqavG+6KPArzQtmUddzhLTDl/vkHkI8CX9PvC/QjOc0w426Z11y+YDdKHQJ3rNgoiEnoLZtY8QJ6kDF0zT6BXfIGkczXzg3w9odgAhbPvLIPsIBk0JKfLI0NRMA7Wsx13mUMWYSmkO06iTLyYMtUlHW2BWcWiAHFatBxau7JXfmGqYvLDIUuvxvs9/geD+L5IiYHYb4ju7yWUvK2AOYHXm90P8nh8M8F67XEzzgZ2LHcq5aWaGxFDz6AtMKp3+3Zby8gj6r5voxkxIrOMDXJ8PaGg7OGYjX2B4ra9CCuwQtsoZn9oz8hNMJqFoCWaASbA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5677841-999a-4a62-fdff-08d86467c103
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 11:06:45.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhem0PmiZWksdbdYPS7BDOlGWjxskg4vALBqED2DOa86iloKsQvX44581EgQ3kIWhVi7i9yFbOUX30iE8aOcMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2020 11:54 AM, Diana Craciun wrote:
> The vfio-mc bus driver needs some additional services to be exported by the
> mc-bus driver like:
> - a way to reset the DPRC container
> - driver_override support
> - functions to setup/tear down a DPRC
> - functions for allocating the pool of interrupts. In case of VFIO the
> interrupts are not configured at probe time, but later by userspace
> request
> 
> v4 -> v5
> - dprc_celanup should not fail
> 
> v3 -> v4
> - Rebased on the latest kernel.
> - Exported a dprc_remove function
> 
> v2 -> v3
> - Add a new version for dprc_get_obj_region
> - Export the cacheability bus specific bits defines
> 
> v1 -> v2
> - Remove driver_override propagation through various functions
> - Cache the DPRC API version
> 
> The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
> devices" patches, but the series were split because they are targeting
> different subsystems. However, the mc-bus patches may suffer changes
> when addressing the VFIO review comments.
> 
> The patches do not address the comment regarding moving driver_override
> in the core code. I prefer not to tie these patches on that change and
> address that separately.
> 
> Bharat Bhushan (3):
>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
>   bus/fsl-mc: Add dprc-reset-container support
>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
> 
> Diana Craciun (10):
>   bus/fsl-mc: Do no longer export the total number of irqs outside
>     dprc_scan_objects
>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
>   bus/fsl-mc: Set the QMAN/BMAN region flags
>   bus/fsl-mc: Cache the DPRC API version
>   bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
>     multiple entities
>   bus/fsl-mc: Export a cleanup function for DPRC
>   bus/fsl-mc: Add a container setup function
>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
>   bus/fsl-mc: Add a new version for dprc_get_obj_region command
> 
>  drivers/bus/fsl-mc/dprc-driver.c      | 190 ++++++++++++++++----------
>  drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++----
>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
>  drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
>  include/linux/fsl/mc.h                |  41 +++++-
>  7 files changed, 359 insertions(+), 127 deletions(-)
> 

For the series:
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

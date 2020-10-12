Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FD28BFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgJLSkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:40:11 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:8161
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgJLSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3GaJTw1OWkmg8c/mKeoWmmVNOa58OZWMgthMlh6kueMWsYx88Xx0AsZBnOSjbvo4gxyHEYaJfJdCj9Tp7gKl5UUUQ/WJT5xQbJmk8TbKFwf++xXiWi0vr8gYkqYwueWoTMV1cIOybzXnKEGRhI+J+yctZbsdvZioDfIpPjz1OjnZ1WBuv3rAhbTAtXH1RZ4QvJ34heWMyNQSrn5+yToZg4R2G6bc8aGf5L4ipTyl3/G2WMcHvZ0dbwXx9jfbGlIK1yPBJ4kcNMv57fP1yUe2nGHQp9CeKDyNdAC+B3huvLKcrnxwTzq79soYtlszurj5YoRheipGo0yMZALQLxXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31i4SNWqwPFTdmBQtKfIfb7T6Pej9sty3ionhkbbG3M=;
 b=VpibVomVV6CTSkYQ6QBWCL1agmYLS+g5JaMXBSDi5yc3+vmj8jTG5515ZeTKcXcWAiQVzJIxHRQaShUVcFz6MHbeVRoDZlur1LWeeOOGbJIsFShw3LcqZL5Nd96ckg0ln5UqSrknKgYlem0XaWD3fWoKPjM+cFC94j6u8Oa1xoUzNRIvJXDMKMZsBdKWOp++9bGMTBp/hPPRAJi2Mw6padFC9/a0fD4YKfjzUvIe3fBSEnvh2nt2P+c8TqAZwKWJX24b4WbktqChu9NHJPVB8zearbINeD92Uf8ZTirz04g6Pza8xfar++KKYZBk2oJpiqa+qPxSn2RgciUxkqpvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31i4SNWqwPFTdmBQtKfIfb7T6Pej9sty3ionhkbbG3M=;
 b=n/EXAvPU/p0pnCD1uo7wTpW56uAMrJRkkpTcDbVMolE0R1i15Ymrzi3d8YFoKQCXApQdej21ODHigyoB9gt3aJXtWQsvRNvkjNwTDVVBQONqoKAPRicOAuGfMnU/yalldBMhAgKzDzWdqqd4Hwgs1TP1n7+GAYpfzKxfp/W5IUI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2743.namprd11.prod.outlook.com (2603:10b6:a02:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 18:40:08 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:40:08 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: IRQs in /proc/irq/* that aren't listed in /proc/interrupts?
Message-ID: <c74773ba-10ff-ba3a-b144-da5c2a34c74e@windriver.com>
Date:   Mon, 12 Oct 2020 12:40:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by BY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:a03:167::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 18:40:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3983b0bb-c2f6-4794-b05d-08d86ede3dfa
X-MS-TrafficTypeDiagnostic: BYAPR11MB2743:
X-Microsoft-Antispam-PRVS: <BYAPR11MB274341DE97C68B9855335669F6070@BYAPR11MB2743.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7B61/bCAqlCKO5FC17k1yk63U8ynyf4L6qV66gtQfxn7udrzlcErjyIGNuqyotEWBPrmM72ZYRzerdKPAhqO9XCnk9NNrnT2V5oMuqoa3xAX66OJXyTOxgyB1qQQrTd43HtpqDfyxIHCzScE+W5X5b90NywNH4kiAL+c+iqt6ew3HKwAw7C/sqw1Sik+sGBXJUBGXqVFGHTlUCOvomlJ1jmNp84IgNkkS5tMwtW2drXT8u4TadQ6XO8JjB9x/iEts6j/Hrl3u/TYpb2N4TaFSd2hJi1ApeI3KVy3wbhgDdnbuF+4xyJk82Qbz5ULDgA+xRGjJ5dJ4qr1nEUXjRVzp12MtfjU/cCDYHrK2unjk7QufqkO+5D6xFcCt3yGh3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39850400004)(16526019)(36756003)(66946007)(186003)(110136005)(2906002)(16576012)(66556008)(316002)(86362001)(52116002)(8936002)(66476007)(478600001)(8676002)(31696002)(44832011)(6486002)(5660300002)(31686004)(4744005)(26005)(6666004)(956004)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cAJMNfYomPMCDpCaOjNFbeeblcqjTRh19xP/vE3LKL3js1Vm6XCg22SB0MCud06xf6CNsrz3/fS+lBftx6TQfY7AlPLpFsJ1cUs5VgVHBs6+O85a5p/7jcZ7nXSWAj5yIHMCjtEa7PkTavmIcq3zEhPwd6UVlbFvivOF7AkcuHMfPJISepOs8XJlIxMuwn/yaFnpm4EJrXkNmMUeMzdWNy1bgFlMQaur3Tx5z5VuPK3LsftoBY+cs6Oww5HuiLSKct2R2Mlr8wc6SubkswQsitnFiELg8HpTjzutvWW7XWsouA3Eo1O9ceQBd9/21GpW6uZR/qoMOOumBu2YsxKqIi3kJX6lfiVHLeQQSORf9Q+7gZcTKk4IR48KAzbQnwk3wT1tDGaWe/Bp1wmegctBOLT9MM+u+SBfUyAhPg+NsFNW6YoR2bN6UA5Q94lrbXp+WWYQsgzAbeIq+RIXanSTFCNhV124X74HXBEK98qpa9NGLaBKb1mZwgRwvjt1bwAvk5DxZXlQ6mbMbZBmtH4aUqBSI7VR5cXM4l66FDL0+6QGUcLl/4lI//WrqpoM2X9tDNw+CVSqOhg4dYUqCBsJBu+CPls/u9lHKiYjDEl/D/uZSP7EDNDc5JDXMrtJVtw0mWYe6lRD0fbs+rWGCWtk9g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3983b0bb-c2f6-4794-b05d-08d86ede3dfa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:40:07.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObKzT14OGpQDu1+VfAnBkRRomoxG/kzFF4P6SsIYwJ1U6ttH2qFHvp2rsXzD5epwJEgWiz4TNZKG6TpabolbgJ8HxU544lGbr9+hZ8T+2s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2743
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On one of my X86-64 systems /proc/interrupts starts with the following 
interrupts (per-cpu info snipped):

   0:      IR-IO-APIC-edge      timer
    4:      IR-IO-APIC-edge      serial
    8:      IR-IO-APIC-edge      rtc0
    9:      IR-IO-APIC-fasteoi   acpi
   17:      IR-IO-APIC-fasteoi   ehci_hcd:usb1, hpilo


On this same system /proc/irq shows these interrupts:

0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
17

Is there any way to determine what the interrupts are that aren't listed 
in /proc/interrupts?  Six of them are affined to all CPUs, and I'm 
trying to affine as many interrupts as possible to housekeeping CPUs to 
free up application CPUs for low-latency operations.

I'm not subscribed to the list, so I'd appreciate being CC's on any replies.

Chris

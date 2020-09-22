Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E1273F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:04:28 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com ([40.107.8.93]:59342
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIVKE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbYnGbdHS0AKIQppSQy73EGA29QwWE45BGKi33NMsPmhcquzfJmvXg3RfDWzsoZtER4+3vbAGCy/EWP3FkgNKcJaYp2w6xXkkVbuXkJwim6GD5y2kXaVQMko3jWqZG3eD1M/oC8nzZTG7cDd5pLCszNtIP2tisenmPO+X+3jGDJEKOXEqeItNlKq/4mHpUtrUzbNdzdHF8E52XUXCIPngl/McYH7/3Munub0gar7t7fw20Zz0B/UXoiPvF3+MM3s9gJW90GYxIsADoH5Jd5hlM4xGyqgjZ2KBCShfp8gD48T3PhEwdTC4VwTM9alBSoFpBLA9s0ydE/6hiV3ji38Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJmrjXHhhW+HkbePa7ww4lHaSspZvpUpzgfDAZvY33U=;
 b=Q61jqxSx8KjDXKeWZwmhW/SQYz9Ewhm9Dd3whurQcJuKD1n35R7UweWCAYsGMUb9xI8inWLvvdmM4vWcplwDKrQ18zMzSgZhijO6iWp+RC1HYSjop1GKvPwKoDYjoaH31jslRMaTJRjHc67DWqnsSkieqrcKnj1a3t49OeUZWnZ/jEbamU/hBNDMRVA/pnvURwh/YVzPU2Ck3jT3oY8t7hQpLAqC6+Z4cHgwtJKw6qe6G+Qjfcjbg5XL764HANgYWV7LsgpRPVInRrgZLRKXLdWQo6PXJbyOgr6RkZCrxo3F+ZDYSaQC6lJcRlUH9hcXxwir/oW9qGSJStPFLXzb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJmrjXHhhW+HkbePa7ww4lHaSspZvpUpzgfDAZvY33U=;
 b=AIYNa/MNyOBsssKSITcFpX606kq1Qm0q2ktdg7JtpTMeHdmycwiyefKRaWcDtdJxlXOOlliG95qBi8tpUKG7sEc6v3IAwJrMHDT+oowONS8dzCmWUXA6HkuoYTeOP13YbFTH8fc3rV1Oz6CyVxJzaBE1+dpI9CHSWBRlhgC7w9U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0330.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:61::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Tue, 22 Sep 2020 10:04:23 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Tue, 22 Sep 2020
 10:04:23 +0000
Date:   Tue, 22 Sep 2020 13:04:17 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] nvmem: add ONIE NVMEM cells provider
Message-ID: <20200922100417.GA22590@plvision.eu>
References: <20200915124116.7196-1-vadym.kochan@plvision.eu>
 <20200921235641.GI31031@plvision.eu>
 <f7f47794-2641-514a-8905-3f4c800f199d@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f47794-2641-514a-8905-3f4c800f199d@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM7PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::13) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM7PR03CA0003.eurprd03.prod.outlook.com (2603:10a6:20b:130::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 22 Sep 2020 10:04:22 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03107ca1-ec8f-4054-720c-08d85edee191
X-MS-TrafficTypeDiagnostic: HE1P190MB0330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0330F0C824BE2CA8A8382724953B0@HE1P190MB0330.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDragZo8HI9NQn1plQtJMzQ8J5IHFAOzr7I5CymCZqOZWRo3F0BCpUNvqCL0Lar3V4NfNO6nfME2J4dbVVFX9QYjTpbIu7XYrX1pdryn0AI/H26z3X6IVl+yqQ9eB3+puAmRqTbDRn7jvDu7s6XXEwhh5DAajYgwyVs5s/WSqck6V9Uod9/c8lGZYWOsbe1qTrxsWlcQ9pj9yBU3FFFrbmI13JMUOOq0G1+kDHxRGPqJo/9/35xp4yt+kH/fU4N2N9PeEOsVU4RgXYYLJcNCiYX4k/ayUdzNP9Zle6uPp+1w0AefdxbdjuXGjvSn2q6E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(346002)(376002)(136003)(478600001)(66946007)(52116002)(2906002)(8676002)(86362001)(5660300002)(2616005)(956004)(36756003)(4326008)(1076003)(66476007)(66556008)(6666004)(44832011)(55016002)(316002)(8936002)(8886007)(6916009)(7696005)(53546011)(26005)(186003)(16526019)(33656002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sSPeVgXqV0P6L2mZZ2u2M0vkK2xWNMZAMsZ9grcWJGKcVinDRZnI7jTu6nYxJhYU4DAG5Zbdt/T39blNPKkLwn0FnC57Ho6B1egT+Kgy2FubYFUXTb9D/dPE3h9t3obMvhvZr9lVa55bP1hh/V1n0JvyMPwwzZ8tulf0NumQGvt2H3mj8K8h9/GtY3F8mCMT9kHEc8KCrFkiqJob3/LyN+QHqUJ7jlTDam7gWTruzQNNvJ1K3goBmLihCa05eH1b29aGmi1xNgwxuH+/zOlIsFrzePenmU4F6BSEn3kwoJyCgDKXQZyLDMlhfVt3Swhxbmk2VMkXrfbihmN9XdpRfd6AtRhTOi5luA/s4WjbGlQGx9D7zd2+pld0+z6Hu4IzmvtQU7AdJ1hqtqhxIkfvlqwl8vHiYSaop7SWR4X0oZi8Q4CUP+regJCqpVLTDi5TgzJ/Ge2ZSEyfWp2RLbQt09kEV7kqIsV0l0yVew7YbBcQjlwfpyfkXfetoEHgwwvZafakaYBd9LT6FWstdj/rrhH1cu7gUyXL792PTViI3balTDhv8kTo0b/zfWfVa/knn2KHNXMkfGSZ6j8pGajVGxT6EQH7kyxXUajJ2qSd1tpPp2BzFq6fKfo5Wj1bJauOxY98nCAy/YHVmvpY0w9Nng==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 03107ca1-ec8f-4054-720c-08d85edee191
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 10:04:23.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ/q+KbOfFc8CgXnjVSYxKzXOLmBOpjlP0NKNVMbh4YEhSioNpSwqhMO3t0s/EeCzIax2XTvrlhdlSMT9JAn4C4j4EmGdfPIiIFoM2N4gzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Tue, Sep 22, 2020 at 10:48:23AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 22/09/2020 00:56, Vadym Kochan wrote:
> > Hi Srinivas,
> > 
> > On Tue, Sep 15, 2020 at 03:41:13PM +0300, Vadym Kochan wrote:
> > > This series adds cells parser for the ONIE TLV attributes which are
> > > stored on NVMEM device. It adds possibility to read the mac address (and
> > > other info) by other drivers.
> > > 
> > > Because ONIE stores info in TLV format it should be parsed first and
> > > then register the cells. Current NVMEM API allows to register cell
> > > table with known cell's offset which is not guaranteed in case of TLV.
> > > 
> > > To make it properly handled the NVMEM parser object is introduced. The
> > > parser needs to be registered before target NVMEM device is registered.
> > > During the registration of NVMEM device the parser is called to parse
> > > the device's cells and reister the cell table.
> > > 
> > > Vadym Kochan (3):
> > >    nvmem: core: introduce cells parser
> > >    nvmem: add ONIE nvmem cells parser
> > >    dt-bindings: nvmem: add description for ONIE cells parser
> > > 
> > >   .../bindings/nvmem/onie,nvmem-cells.txt       |  11 +
> > >   drivers/nvmem/Kconfig                         |   9 +
> > >   drivers/nvmem/Makefile                        |   3 +
> > >   drivers/nvmem/core.c                          |  80 ++++
> > >   drivers/nvmem/onie-cells.c                    | 370 ++++++++++++++++++
> > >   include/linux/nvmem-provider.h                |  30 ++
> > >   6 files changed, 503 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/nvmem/onie,nvmem-cells.txt
> > >   create mode 100644 drivers/nvmem/onie-cells.c
> > > 
> > > -- 
> > > 2.17.1
> > > 
> 
> Hi Vdaym,
> 
> Am totally confused with this patchset, There is no versioning in any of
> your patches, you always send it with PATCH, please add version so that I
> know which one should I review!
> 
> This makes my mailbox totally confused with all the patches with same
> subject prefix!
> 
> Please note that maintenance is not my full time job, so please be patient
> and I can try shift gears as an when possible!

Thank you!

> 
> > 
> > I sent a newer version than this one which actually registers nvmem provider
> > and does not require changes in the core.c
> This is a NO-NO as onie is not a real provider here, at24 is the actual
> nvmem provider in your case.
> 
> Why do you keep changing the total approach here! what is the reasoning to
> do so!

Well, I though that maybe anyway it also better to show the code, and
try different approaches.

> As I said in my last review we were okay with this parser approach!
> 
> I don't mind having changes in core as long as it done properly!
> 
> 
> thanks,
> srini

I am really sorry for this! I was really conceptually confused about how
to make it right by design. I will use "parser" word in next series
subject update with a versioning (v2) so you can identify that this is
related to parser approach with which you are conceptually fine.

Again sorry for this!

> 
> 
> 
> 
> > 
> > Thanks,
> > Vadym Kochan
> > 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239E828EBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgJOECU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:02:20 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:30844
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728576AbgJOECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:02:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPh8roRG7MJSodAf0ohZNcX2jWVSuqq33h+pIZrtrhI7qiUyL35pDapL9rHfll5WKZh4jFc+RpDzTPVqButwXpPQF25t3pAtiP79vf/o9Uc99s1T4aPBYmLmAxnEp9559h8TUeIpVlc6xKJLnjkLPk4shDoPZbm6KL0Y3wX8/aY7MRBKNRD9OhshiZh4uQyzKHMvo7NL/6p3cNw7fD9SRwqTNL437yrycEWuGzlr8qYx9ZXcJNQNjnmIsJCv600L+f0kGGsr1qMWcMH+oV+k79UgGy12oA5qS+ux4WLj/Lb/y5HefDD72608Jb9dPvS4LMi+80qn00+H6ImdxZy8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS/93Lz2wRDzjoOAMvuot7TW0egRI0Q/qdC8slEHKYI=;
 b=VE+4mMAiaWkM8ZFKat/F5P0SMADvHTHoebwWxHq4WFDQz/tK5tvjLmh/5pliwiOPS8LhAoLY2i7DdrZ4hFYqNMxJJBFhFwNsoRfn9/a6LIvmwbMmsuyg01ATdXkHLg+fAsvTTfH4UwdSHVhFmDHKTtF2T9Yf17oDs024krIyrvfUpvMN5faNKzctAjZCAiQu50JTZVcbY/DnQDm8PPS4+5af1PbwZqg2HgR4Xr6CayVTstf6zIcjGzYDmmLmrCLL+N7+d9LgmiAOlbRkFaG96m56y2zRcP5YhPvaVRXuLF14F5wxz0u15AZgyIGLIqp1zJy6u6GnqguDa+ky1I0yoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS/93Lz2wRDzjoOAMvuot7TW0egRI0Q/qdC8slEHKYI=;
 b=BKyj2wiZ2scu7/+I+aJHktWgK/OCTRuPdtBUhglQD+eUdPDP/5NyA+u9vy1+Sjg7SptXfTEHg7hc9H8A56Fq0gvIX6M1elkq/QnUq6mN6hwxZosTe3EgZlULYZu/45UpX+2iMa25FvpmAbDPKUxrZOfCkzWvBJNLVBFxmoewOlM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 04:02:17 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 04:02:17 +0000
Date:   Thu, 15 Oct 2020 12:02:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: fw_devlink on will break all snps,dw-apb-gpio users
Message-ID: <20201015120206.41b6a454@xhacker.debian>
In-Reply-To: <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
References: <20201014191235.7f71fcb4@xhacker.debian>
        <CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BYAPR07CA0033.namprd07.prod.outlook.com (2603:10b6:a02:bc::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 04:02:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533e699e-0a96-4b83-3c20-08d870bf1b4d
X-MS-TrafficTypeDiagnostic: DM6PR03MB4555:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4555247DFA59786E93F27AD1ED020@DM6PR03MB4555.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUW/h1hvj1lnHOWQrHtplsIrcf01L1ekDim2X3lphRwbsqSCmAP2G48Dnqm88inroyQlIvO9VNY9f78OboM2I4BxxCvoifAwjPHY+OKFZtSSZ3Ws6b+eJTRMi59sUhTQnLp9X64lw/rZff5JJSaB5bVASSeCqLkOc+FdoPX/QC5JoHxLcE6gNWTvhZtp4EJHud/r6uwLrmXXTyzUrtASSHiFXs2cDjvsd+eOdMMjf+Td3tuRjYHc7KVyqnP+yIF1s+j6AMm243PojydS2/y4pkgtG73+ek4TowkZYfyUJLiYOn9uQ3cvIiZLx49N9v5fuxi1ZJzp6556L9AGrjJcw3y3lDDQ0BwY7OFHlmAFewCZskJ3Qb3/5nbCIk/OUO/KsRj7XnjEcBws+qoqaBWsXO1L2mB7yjq4KmEUTKjCmA0NmSNwkUr3H3sGD93taOgA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(83380400001)(4326008)(316002)(1076003)(54906003)(7696005)(478600001)(52116002)(55016002)(86362001)(2906002)(26005)(6916009)(66556008)(8676002)(6666004)(53546011)(66946007)(186003)(16526019)(956004)(6506007)(9686003)(5660300002)(8936002)(34490700002)(66476007)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ra09PAA/DW4yVidZgn/N9Lo7YoDzPlR+gdwfdvrcXdqv8CGDhqnTPPD1Jwjltv7gYmBLT9ljCw2yfgyeU5T7SESYJRiYsqm6KcGPiUr/xjd2OEj/gdr96dzTtEqovMbNX8SjCxWF1XD11kJZ1FEQXUy8TurInKJmoUeWDQCMC9hv/ZtdSetf1yC3NI38Xa4i4ExbbVJpvnCozaC7cvHJaT7zshHxNzwYvIVm6MzFJg96k64uIk6EOaq+l1C5/XJa6k2T0LPZBJzB1wvZqNMQzKJ43E5RcggiGfWQhCrgvIKoVaIr9G4IOyowFTQXWaGaCec7gjVYVmRycDQCqJNSpQfDNCKOe7gTF6NuaNdsUGUwOazG1vKSBegZw53wWTrhSYCXlrfJcGeEnLVe/H2Ba9DLewppWewdt/0tQMK0RWKQhLLcpWy7iiQofK/ZRKUUT1vKrrEXRtuDDMGXiLevs3HT/VwwIS8MGx3oP/8x78aagN16zWc9xn0OjceO+BYElQWqUgnBtYky/TGYLX3G5BQ2Prqkvz7spA+Fp56qUwgv1jWv0CZZx5hrY/MKDE8SuntmCXOy6lxDp8QbYRWykn+Ij/QU1C3daqYG/oenrRz+1rN7BoDzPHB0INjWj+ZbOfXUVFrfpTxi/L5ZxBRT0A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533e699e-0a96-4b83-3c20-08d870bf1b4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 04:02:17.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brAM10G6GIRmjWnlDGz5nh9Wwixj2NwDPNY7cFuAklCEx6y/kQXZW6BOcsjBJ7qb5NlRUeCB8liEkP6F6AIf3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 10:29:36 -0700
Saravana Kannan <saravanak@google.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Wed, Oct 14, 2020 at 4:12 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Hi,
> >
> > If set fw_devlink as on, any consumers of dw apb gpio won't probe.
> >
> > The related dts looks like:
> >
> > gpio0: gpio@2400 {
> >        compatible = "snps,dw-apb-gpio";
> >        #address-cells = <1>;
> >        #size-cells = <0>;
> >
> >        porta: gpio-port@0 {
> >               compatible = "snps,dw-apb-gpio-port";
> >               gpio-controller;
> >               #gpio-cells = <2>;
> >               ngpios = <32>;
> >               reg = <0>;
> >        };
> > };
> >
> > device_foo {
> >         status = "okay"
> >         ...;
> >         reset-gpio = <&porta, 0, GPIO_ACTIVE_HIGH>;
> > };
> >
> > If I change the reset-gpio property to use another kind of gpio phandle,
> > e.g gpio expander, then device_foo can be probed successfully.
> >
> > The gpio expander dt node looks like:
> >
> >         expander3: gpio@44 {
> >                 compatible = "fcs,fxl6408";
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&expander3_pmux>;
> >                 reg = <0x44>;
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >                 interrupt-parent = <&portb>;
> >                 interrupts = <23 IRQ_TYPE_NONE>;
> >                 interrupt-controller;
> >                 #interrupt-cells = <2>;
> >         };
> >
> > The common pattern looks like the devlink can't cope with suppliers from
> > child dt node.  
> 
> fw_devlink doesn't have any problem dealing with child devices being
> suppliers. The problem with your case is that the
> drivers/gpio/gpio-dwapb.c driver directly parses the child nodes and
> never creates struct devices for them. If you have a node with
> compatible string, fw_devlink expects you to create and probe a struct
> device for it. So change your driver to add the child devices as
> devices instead of just parsing the node directly and doing stuff with
> it.
> 
> Either that, or stop putting "compatible" string in a node if you
> don't plan to actually treat it as a device -- but that's too late for
> this driver (it needs to be backward compatible). So change the driver
> to add of_platform_populate() and write a driver that probes
> "snps,dw-apb-gpio-port".
> 

Thanks for the information. The "snps,dw-apb-gpio-port" is never used,
so I just sent out a series to remove it.

Thanks

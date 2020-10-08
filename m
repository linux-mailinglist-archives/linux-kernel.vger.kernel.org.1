Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD31287109
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgJHI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:57:47 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:19690
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728980AbgJHI5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyRm+nMopV5LS4J99nXaJzYuuXIVVwK7i0V5I+rxOJ8=;
 b=HU6qRxfbYFFseu74TOV85v6mwyzMK4JS8VJ5qqfPSvtEV/rm3zWJGJuBnu0y2fG879mLf05AkimRZnix1hfL4q+hAOc4F+GRemkYC4i/stC6zzTTtFMs8wK6gwkcU8SNXZI4A0mv4K9v+mC6TPWPoDXbhLV9+0oHLzOvec+YjeM=
Received: from MR2P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::16)
 by VI1PR08MB3437.eurprd08.prod.outlook.com (2603:10a6:803:7e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 08:57:34 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::5d) by MR2P264CA0124.outlook.office365.com
 (2603:10a6:500:30::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Thu, 8 Oct 2020 08:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 08:57:33 +0000
Received: ("Tessian outbound a0bffebca527:v64"); Thu, 08 Oct 2020 08:57:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f94c11bd43ce5c0d
X-CR-MTA-TID: 64aa7808
Received: from 0692db9ec377.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DD7E942C-A56A-4335-9ECF-9D26E01429A2.1;
        Thu, 08 Oct 2020 08:57:27 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0692db9ec377.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Oct 2020 08:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVW0q9GNap8eGTH/2/RAQ7fUSPEToROP8Udqex7OBcKlIKIFT/fPBNUlYb/u2ukdVKG9PTzFEokd++z0shgDMi/3rA7g0NiW4DIb5Xq/LLgQ3hhxBGqrF5pGCT2J+syzAolIYKWDuPwRQFauBT0sS9CBr7mJIijwTWIU2Xc4sjLkf5enmS3sgKO2FZ1kNNCfYh1g6BMnhpCOa+t2IjBnlm5P+FoUnGZgdhNdHBJTxvVsNKsSKtkJ24bQFx70hcMoY7T3+zrmCeu8KcQ093jIGtpfwmeP1K1m9RAL1Aln30D8rhNXpqyCwzB/tMNrRW4O905mIamqO5B7So/gcIr3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyRm+nMopV5LS4J99nXaJzYuuXIVVwK7i0V5I+rxOJ8=;
 b=jzr1yyu7fV4oCIqVWsRuMovpBrhH5LzGGXOIcfTF5r5T0N8jItCWK8Xza3sA0QgjRleVFfeUNCzZGZxy8gF55XJzJHQcqjnZwzmdF+akG3oIDpcEG5mXyV0aKUZX7XGgMYA3pkq0blL+1lYc9nd2gUMVKIpYRr8W378Bn86EdOpmsMmpIugKaOu3/6N6kqWaqcTbwwLf06+w8IF+UhNCK/s5UFu4tQCsqKb5O48Gyi/DEi65vF+7Puj1794CBMgtOFPSZ9lAB9iovbDuhqRx38Piq/0VVDC5l/uaO2YlWPiy7z+dShFzXnzW8x7OIQ5O6KwwWWBRYTxQzV5LeewMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyRm+nMopV5LS4J99nXaJzYuuXIVVwK7i0V5I+rxOJ8=;
 b=HU6qRxfbYFFseu74TOV85v6mwyzMK4JS8VJ5qqfPSvtEV/rm3zWJGJuBnu0y2fG879mLf05AkimRZnix1hfL4q+hAOc4F+GRemkYC4i/stC6zzTTtFMs8wK6gwkcU8SNXZI4A0mv4K9v+mC6TPWPoDXbhLV9+0oHLzOvec+YjeM=
Authentication-Results-Original: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AM6PR08MB5175.eurprd08.prod.outlook.com (2603:10a6:20b:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 8 Oct
 2020 08:57:23 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 08:57:23 +0000
Date:   Thu, 8 Oct 2020 09:57:22 +0100
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     Joe Perches <joe@perches.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add AXBXGXRX106106106106 format
Message-ID: <20201008085722.GA30778@lagrange>
References: <20201007092725.13300-1-matteo.franchin@arm.com>
 <dee9c91dd38f05eda86eb126cc54679408518562.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee9c91dd38f05eda86eb126cc54679408518562.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LO2P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::23) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (217.140.106.53) by LO2P265CA0155.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 08:57:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18019969-6e79-44a6-db3b-08d86b683214
X-MS-TrafficTypeDiagnostic: AM6PR08MB5175:|VI1PR08MB3437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3437C8DB7EB0F36D3940FADBF40B0@VI1PR08MB3437.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OivuEaWswi9yJltwbX6N5itnvnTJ1Q24gBosp0ZztqxM8L3zd7ZPOPCpw2yFREMzf1Cpth2oSV41kHfV51yRJT0G0gD7zkO+ERqzeqYSZSCBKBk9FHvjfUQaR7MgRdAHGd8/zgn/Fr+xEm84FHkurDJkHn+8hpGP8mlDS4CRdRr+sp8cCFL7Jmi3H5uOZpAHb/GyZFYNlCjSC2spV5DNd1fH+SAOvHAAkoMwfk+N8MH9+tVGq8ZOTlCs6cQPBw4EjTY9UnRysN6Jy3hfaghTgaUheLbcpcMPGqVs0iILPJoOK+nyw9KzEaMcCUIIy+q/TIKqrfwXpwlK14cGhLAdEk6mIYJIFyRMu9xYqNd54U8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(9686003)(6486002)(956004)(478600001)(4326008)(186003)(66476007)(33656002)(66556008)(316002)(966005)(2906002)(54906003)(66946007)(16526019)(52116002)(8676002)(8936002)(6496006)(5660300002)(44832011)(6916009)(1076003)(86362001)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +fTBmCFAGha052oPueWy3PJ67Iqt7qZtNnLx4zXl0D/vCwCYOTesJrlBjJXpO/rIrupUh6f7M/Zlpf1UfwDgS6s64XiVPYJcSc1CcVcVr96CuMhAtjVLqfauWBi30c4qvvGCbfDzlpYyt+H44U/usVWv0lrSYGMMzCuJKFki/5vq2+MJQYMuqBzg1lpzf7jm6ETzSYQYfcua2TYcdKykjgeX6pYNhycFMYhYIiLyfIJRk9P25XyZQAQVl+Wmvlo+X7lu9LPh9YCCEQ+YhtMrmwg0lu6/EHZ98mJ6MTUeXvpJGgOOGYjrqqe59TRpuCIU3zfh5cX/c4AV0NwkG6OmUeRm0M9BjSfZejEWb2+LuuKS9418r9sGphtrOy3XL1KmqV47Bipag4Zke19HuByPfr5KQWNm7qH775oSsVsEssF2UDlShI1y/vavJp7a1xfQsD1Ebeg1bhgFSuDzjbCi8qUFv5TrV4m/Mc/7phD1AmAeiYEnGHxXXskJGrDMWTyIqI7pYmB5w/KVZ7f6oT/oZQEbArWM7REn6ZHGzGmNLdEqj+FoxNfBlmavwFKg9F/QpGIWn1r4Jg4SEy5byBNDh7TyQ5suZOeLcvYNqDxKf6UQKCkFpazvi86Qh2I4IO5DbWINhQoytsSwS22uD2YQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5175
Original-Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2c67efc9-bf09-44df-860f-08d86b682bee
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvzU9WSg4fOvNGEqvRdJpeicVcloLk152ZYIDXvePxkwqHcTyWAOMR8+oUjGwLeRvsqaJebCooKmyUsa8i/JDsAWpOFaoH0OskvICIA1nEAWtZU8BqpniSvQAjEWVOt2ecVJcUGaKVNRk/w4gqN5l/IqkbFfRkcaoqNfTIg3hCvmx9NGxuhhRD299i/V2JBf2hQlxCuvrHmrgt2TNgjnM3y4x0ooblIhmaQ9E1WTPQixxEsM/G2QMcZyLvbl2cMlzEkWLsHPhdSdobkhenqpPbs7vGSn8AxwfMkj8S5HYDY3J2/eau6VRmlB5jsfCxw4lYBAa8/LW3GRM+/cv8KHYKzUX4GPm/tWcifuH75xiB9yu57fxLD1DAwP252eeKZSh7LTjBZtBdN4H6AFXDK8/QChCtxa6md2nX004rpmV3v3bNJZ7bLVgv3//7bXYe43
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(396003)(39850400004)(46966005)(336012)(44832011)(356005)(316002)(8676002)(54906003)(70206006)(81166007)(16526019)(478600001)(70586007)(186003)(6486002)(6496006)(966005)(956004)(1076003)(2906002)(4326008)(26005)(9686003)(86362001)(5660300002)(47076004)(33656002)(82740400003)(6862004)(33716001)(8936002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 08:57:33.2794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18019969-6e79-44a6-db3b-08d86b683214
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thanks for looking at this.

On Wed, Oct 07, 2020 at 11:47:57PM +0100, Joe Perches wrote:
> On Wed, 2020-10-07 at 10:27 +0100, Matteo Franchin wrote:
> > Add ABGR format with 10-bit components packed in 64-bit per pixel.
> > This format can be used to handle
> > VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> > architectures.
> 
> trivial note:
> 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> []
> > @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >  		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
> >  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > +		{ .format = DRM_FORMAT_AXBXGXRX106106106106,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> 
> My is to separate this into 2 lines so every
> column including .depth on still visually aligns.
> 
> +		{ .format = DRM_FORMAT_AXBXGXRX106106106106,
> +							.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },

I think this would make grepping less useful though?
Do others care about that?

> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

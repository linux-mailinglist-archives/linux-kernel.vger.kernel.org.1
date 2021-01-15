Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950AC2F7157
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbhAOECb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:02:31 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:54657
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbhAOECa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:02:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsY0aWpYp15eMqCF98KHzgAkYehegY24FVpKtnJzqvY+1smA8HQrLHbksl6Q2d2SunqkwoMOcAzUD0RYex5iEXQwzD7UXW8QAPd+E70A7ucw8PLJa5ES2tyTaLhxp2Swc0c5ZMPaOwsiEH+a7SzutTWGxdM6LCnbx2mCD5zfJWSVoccUzXQtsiGmKkdP8KNrvkzJxQuFTqvEZNvI5AL2Hhe9mxY4fhoFPNb2tooDPE5X7WLm7H9rVNOVU3hg2lFckv1F+odCB23I0xGgLk5U/li7B5NiKl12HtGTLudDLrR6LLTnzlO1Ci7drmIhrFURfTP5V3C2mSXM4tpocdmlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKT2lLQZ3lWCILspoVmlT3ybA3MvNCYdtB65poNwZB0=;
 b=kX1r3CjaSTeKY/xrUzw7SH4kg7QN9C6/UoZiMigBP/SBTcKI5vfSEXqyLkku/KbsloEU0k4jNxAfjvdOeK8PS1cQ6j9VbIj6Bx1n+J5MNzSktxeaIcVSluF/fEKcAFfEc57H23rQKVWMs7p6QW07f6/drwdstopXNV0M363FkSr281rMlOxzRWXwwAaQhLtm75/mgHlHg3Eaf3XH6uRVo+mZwg2UP52gVpGAtrC/NzAUcXDQkI7CLTJtLCNRrjVAE7Ift43+POE3eKevmbjxE7xFXgNSYuzSX15mb4qynIgeDe2wY2m0FhDHjnJ8QnzMczThEYynpg60GzQpE632Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKT2lLQZ3lWCILspoVmlT3ybA3MvNCYdtB65poNwZB0=;
 b=qtd2+GrGgCNk5z8XKg9WGZrmxXBgICG2JXEHzQTP1QYwURznU5T+pO89AItAZon7mmtsmBqX6cy7JBB23PgvVPpQ6AzULllJYm0MvsPr3hgBsBGWfxiHwvC91R9GvK+7IGDl2fgMKH+tcMOvYtCCmdtvvVp3nxx0/GpVIu84cvY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB5296.namprd08.prod.outlook.com (2603:10b6:805:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 04:01:36 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.010; Fri, 15 Jan 2021
 04:01:36 +0000
Date:   Thu, 14 Jan 2021 22:01:34 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mfd: iqs62x: Do not poll during ATI
Message-ID: <20210115040134.GB27243@labundy.com>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
 <1609707369-11297-6-git-send-email-jeff@labundy.com>
 <20210114101711.GM3975472@dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114101711.GM3975472@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN6PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:805:de::30) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.173.128) by SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend Transport; Fri, 15 Jan 2021 04:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af4b5e5-5db3-4316-dd72-08d8b90a40de
X-MS-TrafficTypeDiagnostic: SN6PR08MB5296:
X-Microsoft-Antispam-PRVS: <SN6PR08MB5296A687C50BB83EE6C22011D3A70@SN6PR08MB5296.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ90NBDzZSFPG5wrSV2hml0dPHESEnD+LiEZ8SHTfpMXh/jN5FqDDnrMxDbc1Lkyxx80FsFH2UtF5vmZPrhO8AxTdqt/kGTv9ZV1qqE1hMZsf0gvQEcj1B6+S9a3qPW5hWpleJrpnYi/6xB7Q2D0ryi4GzRtRpPs6SnRxTtd/UtX9UviRW9AvzNPo7V/yI0TTiCvQ6mORQvb2E2BQVdzMManogqZUv0T4R4VUb1q+j5BXuRdAyfUiZeuTevaMVQVtUjPmuea54hIE9xnIrSHoaRqrYQLcJRwTcGslf6FJuJ6gy7/Ra068rJG5mUll0QpArcw7VtBdmHBSmnAlK5MiauJ+zTu0agFkDpH1gGGGK4Rm1R2M1jJXsfU5tdqrLCO+AgEjqMwztcPQO7Isbb3OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39830400003)(366004)(66946007)(66476007)(66556008)(16526019)(956004)(8936002)(5660300002)(26005)(33656002)(1076003)(186003)(86362001)(478600001)(2616005)(2906002)(8886007)(55016002)(36756003)(7696005)(52116002)(316002)(83380400001)(6916009)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bOxVqOIe1yftFbClU/y/M0XpmojlR7DVIaXAqL7+BnDcta3CdQZa3nOUvcGL?=
 =?us-ascii?Q?cdXQJF84QjBdF1WbkVEGQ6ST5uerIgYjxyg7xsqBWBMskpMokb/I1cBq76IA?=
 =?us-ascii?Q?NFqJLVXwQH3/zUrU7Wc0WXVHghIw2ffXQ0E+9/dplidHW5GmB2fnd9CVqeZQ?=
 =?us-ascii?Q?TwQyHzjGL8KwePmbvwsVb1fcIgtZU2Tom365Zjd5YfQQ1gHyS1wrNAWuc1It?=
 =?us-ascii?Q?WiPil5HZd/KvekJpl9LnpDlX8o5mOnQu6AIQ7z1o3dBgGzODnQajZS4iucdv?=
 =?us-ascii?Q?PpsECkHjkji4Z2KDvdjL0jV8CDIYt5P1+q6RYzoqiGyrjXxKt1LXxuziE6bd?=
 =?us-ascii?Q?lu9BVkLPCRounc9Do2jm/9LQzB3zCOYgGXFKk39I4bs66RbjmbPlBcYf2N69?=
 =?us-ascii?Q?4Pt+XEJwo7/mTnlxohNBYh27ESgXIUnjWG947KDxHhiw+RpYpSzRBaoJfT0Q?=
 =?us-ascii?Q?J6gnxM+uX18bDCRcpQ6iwdzeiN/A17zIrdZzRvq5bG5PyCtMzx4WX4NfKnYH?=
 =?us-ascii?Q?AgZp31hYrHfOqgcGd3yMYSvF97nAHCQjhWpWuL30m0KQvinmONEljhiiZAya?=
 =?us-ascii?Q?3AkGGbSk2TLaKmmZi2qPoRhkn2EjQ08jPDSURPlG4eFOa01fZq6GAXXA6chh?=
 =?us-ascii?Q?HcMIhV1rnDuP3uNt3Espb5VVzXcR2fs09imLebrS/z7jkIT+7aVKaGT5GlIC?=
 =?us-ascii?Q?LNYIQpiSDzVKjOy5IFDGytr700rVMt4zw/XkEZFNEi81SFnOnlj5ZpjI/6ea?=
 =?us-ascii?Q?J0NIjiTFA7Wvbd86X8SqcyeFT2PxwYbetGUfUE4Br/lBDniUSZ+Cvf985Qzo?=
 =?us-ascii?Q?uysFBMRLaSJjSWfiI1VFSIA7RkGh5EVfPW4NfFmA3APpLKQurmN77syNTW3R?=
 =?us-ascii?Q?9e3SSHLNmXDzc9+z9vAGO/wCPXhS6A+CoXOks1zPx5XfhGBjDNYT2ImCnckK?=
 =?us-ascii?Q?DIthv3og2r3At6qsNtkYgh1DiVz+nkXQoPpvNzbgx3zW+1f9aPvDn6jFrexb?=
 =?us-ascii?Q?phAO?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af4b5e5-5db3-4316-dd72-08d8b90a40de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 04:01:36.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ5t6mvqkQU+1BvxWoQnULuvXzweLPI3TuJKqpIT9Hh+n9hVoa9FFiRS9kgwqHD3FuvmqxB2vNeWOGzlpxlNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5296
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for taking a look at the series.

On Thu, Jan 14, 2021 at 10:17:11AM +0000, Lee Jones wrote:
> On Sun, 03 Jan 2021, Jeff LaBundy wrote:
> 
> > After loading firmware, the driver triggers ATI (calibration) with
> > the newly loaded register configuration in place. Next, the driver
> > polls a register field to ensure ATI completed in a timely fashion
> > and that the device is ready to sense.
> > 
> > However, communicating with the device over I2C while ATI is under-
> 
> This doesn't line-up with all of the others! ;)

:)

> 
> > way may induce noise in the device and cause ATI to fail. As such,
> > the vendor recommends not to poll the device during ATI.
> > 
> > To solve this problem, let the device naturally signal to the host
> > that ATI is complete by way of an interrupt. A completion prevents
> > the sub-devices from being registered until this happens.
> > 
> > The former logic that scaled ATI timeout and filter settling delay
> > is not carried forward with the new implementation, as it produces
> > overly conservative delays at lower clock rates. Instead, a single
> > pair of delays that covers all cases is used.
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> >  drivers/mfd/iqs62x.c       | 103 ++++++++++++++++++++++++++++++---------------
> >  include/linux/mfd/iqs62x.h |   6 ++-
> >  2 files changed, 73 insertions(+), 36 deletions(-)
> 
> [...]
> 
> > @@ -567,6 +600,12 @@ static void iqs62x_firmware_load(const struct firmware *fw, void *context)
> >  		goto err_out;
> >  	}
> >  
> > +	if (!wait_for_completion_timeout(&iqs62x->ati_done,
> > +					 msecs_to_jiffies(2000))) {
> > +		dev_err(&client->dev, "Failed to complete ATI\n");
> > +		goto err_out;
> > +	}
> > +
> >  	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
> >  				   iqs62x->dev_desc->sub_devs,
> >  				   iqs62x->dev_desc->num_sub_devs,
> > @@ -763,7 +802,6 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
> >  		.prox_settings	= IQS620_PROX_SETTINGS_4,
> >  		.hall_flags	= IQS620_HALL_FLAGS,
> >  
> > -		.clk_div	= 4,
> 
> No unnecessary double-line spacings please.

Not a problem, v2 on the way. There are a couple nearby instances of
double-spacing within these same structs so I'll nuke those as well.

[...]

Kind regards,
Jeff LaBundy

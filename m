Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2AE2DF9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgLUITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:19:42 -0500
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:19777
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgLUITl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPuMrEc7vuNc9SFXhJgTo6goSFxgk1J1ESmMXl13DZYPrmjyhULv00VeIh0Bgh7ZYoVBcvaJCQSNPuFvjJDEqO3KCCVjSEEhm+4gl3EBuZmpKTLOMIAGW4opiRcn4AQteob4Wxsnh2iko4nc+6iFJmk/qe1a2Is74UFuONF2w44km/M9NRvVMjo9w5EUVauH+ZxMaAStJrZpdJ8EmeEatpHvAEOJe+Jici6AHHz2vf8wqn7YI86h9PHocbQK7N6pZBGi838sVrIKxahKdC7xzKhyePr9ZeUJ3X7cSBJ3cmjFmrTC5t3OcIDFpQgVdR4N0C7qyj5DQkIxFWbsJN2T3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGroRQ7kMQ3WIvqz1vUqM0lyWNEpsyi4xblcbHvJdE=;
 b=F0uzsHBsuNtHmRwbDfXbPoNQxQ6dzz9zj90tUbn2vqaYyYmtZK0iwR05GTsXCJBsJslyR/LhIF7Ed19EJxE897g+zGm/oa+BJDM1Qx6Va6rN7WR0zcqZsOkcYHZNWlyiYIhq7Wgb+g25y6379MJ8vYBskrIsT81Y/j59uU7gMbnK7s+OEGmWHf2HfRgeN3sUAnq7WYcFsin+sXrW1Nu7Z5f2N1oekqW9I766nKQFMNGTTl5xtGAuVi9TRp9u4uvMmKl/ACqXIP9r3BURrrAUUd/xSX2yG4Jw8gDYOMZeh4NKH2WTjKQnneR4j5kDz1wkTPymj1/R91RH3krKL0JhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnGroRQ7kMQ3WIvqz1vUqM0lyWNEpsyi4xblcbHvJdE=;
 b=WKPj6tmtV0Z2JGUXHzrjtnfnFsJg6Xk/6Q5riqPHN4wNeL+wuXKFIyfWo2JmQizaLsk7lfwv+Pg8vrbSTGlUGo25vh+IptQCR/DCBoTP64yX0sVIXD847prx9fBcBoIicV2fMHlddr9Dwe6ynOWLm+uip2qw6qkawVves3P2l3M=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN6PR03MB3252.namprd03.prod.outlook.com (2603:10b6:405:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 21 Dec
 2020 08:18:51 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4%5]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 08:18:51 +0000
Date:   Mon, 21 Dec 2020 16:18:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
Message-ID: <20201221161822.572e5cbe@xhacker.debian>
In-Reply-To: <20201218031703.3053753-1-saravanak@google.com>
References: <20201218031703.3053753-1-saravanak@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::35) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR07CA0022.namprd07.prod.outlook.com (2603:10b6:a02:bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30 via Frontend Transport; Mon, 21 Dec 2020 08:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38416836-7ab5-402f-ccd9-08d8a5890ce5
X-MS-TrafficTypeDiagnostic: BN6PR03MB3252:
X-Microsoft-Antispam-PRVS: <BN6PR03MB32521AD4C709FB12B6C2E3E6EDC00@BN6PR03MB3252.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onfnbbGBTCs3xNaVKi1awJWX4iTa5XilvpUFJz0ruEFMfOZn/PWidAuSPcGxiT6GnCFAWYA8GzdfQxmJgYU28CzxZMyzHfWgWgynik0LDzHSA/8PEWETjLnyhj/NNoisM3rB//DLZJJIvTRyXoOhiNWRWtNg2FHnRybKj5WK/bCUXGteuRTx10ewk349yu4RN7uIp4kUHnKHhLKXjqg4Oml4O2H3vkNtNrryt0e2m9b4+rk93+AoYFCss/nqwjpMnHgPKZ+j0aHKchY0mwg1HC/4sLWZyqmqVY864XS/Pxr1AkD1o3/OkhXxRt0WQ1zC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(8676002)(8936002)(478600001)(26005)(9686003)(52116002)(6506007)(55016002)(66476007)(66556008)(66946007)(16526019)(7696005)(54906003)(6916009)(86362001)(2906002)(186003)(1076003)(6666004)(316002)(956004)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FB7qx6xRCMC7xf98n9BGVILdpY01M+aXWgxAmxqsao+V3657fGj/tzfVjxnK?=
 =?us-ascii?Q?z/IPEOwD781xT1XurbTwRl39AEL7fSxFHD8UxmulsA284GabYKw6u+Pkk9Nn?=
 =?us-ascii?Q?RZiIqjFSkW0L4hRg1i3qEigz7dhvu36qcVQC9iFW8YgHxAL78l2Clg1IQcvK?=
 =?us-ascii?Q?AE74CVktJyoIE/tnMvVUNhOkutkUUWNuy3xZllG74Kli8yJctxo/8tN8BKf5?=
 =?us-ascii?Q?qa2saNA3sJGKkWfH5SuOfxlxlEY5ZvPVbLxJHzmtpvoTMZIn5D3zbKT5A9iR?=
 =?us-ascii?Q?Z/0lYFjU7N/HrNQ8ORqQlAhTcz87o/DTH0zK8+kTnVwsH3iLY8uRXsIAdfEY?=
 =?us-ascii?Q?n8Z3tCA8n08Jip2OXv+is251ns/iVVQ5nEmljpCWXxqA2cezsauSwGSM/XSv?=
 =?us-ascii?Q?5BBGc9SsMSVxm+Wuhx10S6J7+SoUXE+Rjvti42hpxu8FRox87h/G6gq0UaRe?=
 =?us-ascii?Q?bnUlXVYiV466tt+IlMSHTsca8TcyxwsEt+qw9GzMMScitNuGka9RbTXS8nqq?=
 =?us-ascii?Q?XAszlJzlLiFa6Zwrle/9NKH6L2G5/oE3JubWB1VIqxtdRqfXVG2spAEMzTfd?=
 =?us-ascii?Q?Ae6SVPelerGBjdI+vbwfZm+I6T9oK6ICxX/C9SoYOAxLZRXy0WN5Z1tFDbbR?=
 =?us-ascii?Q?bd90c4IyJrA29CCt3oLtX4rDp1JyiI5dnGDiuY1Gu/48FFUXDK2UONxQ7XsZ?=
 =?us-ascii?Q?iUsblQm3LRLj5MDg0VLooxakCNNDl7bPa0AXydEKpC8TnOTUJLgwprlbE90G?=
 =?us-ascii?Q?acJF4qkJZK/A2gq/Ckh2rWs6S2SN+qR7ItQQHUzPiIpRXWagt6+kxgC2yZY7?=
 =?us-ascii?Q?3M+nsBunJloI0Lo/hJcqHdyYFZhmZDJy0SUgNcv0F25fusNmTRajhDL/KmJY?=
 =?us-ascii?Q?UUatLzSeKWeGAPR8Q4Jqn1dQYoYBbqgSwvuvIec3jDwOxCsSHgTRBDH7h0RX?=
 =?us-ascii?Q?fw3i2cMky5jR0engjVg4PEVVmavb86ER3AeWkoXcVnxdsY2/uW8kn5KER7cH?=
 =?us-ascii?Q?ljV6?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 08:18:51.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: 38416836-7ab5-402f-ccd9-08d8a5890ce5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptrdYWckobv3QcIk6ocWFrdBa9Bj/t5mv4Ye+muV4WnWpI+vQgReDQvPDO3NODQ4BN1j8RlFE1spX6vZj9L8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 19:16:58 -0800 Saravana Kannan wrote:


> 
> 
> As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> be broken using logic was one of the last remaining reasons
> fw_devlink=on couldn't be set by default.
> 
> This series changes fw_devlink so that when a cyclic dependency is found
> in firmware, the links between those devices fallback to permissive mode
> behavior. This way, the rest of the system still benefits from
> fw_devlink, but the ambiguous cases fallback to permissive mode.
> 
> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> only for systems with device tree firmware):
> * Significantly cuts down deferred probes.
> * Device probe is effectively attempted in graph order.
> * Makes it much easier to load drivers as modules without having to
>   worry about functional dependencies between modules (depmod is still
>   needed for symbol dependencies).
> 
> Greg/Rafael,
> 
> Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
> see some issues due to device drivers that aren't following best
> practices (they don't expose the device to driver core). Want to
> identify those early on and try to have them fixed before 5.11 release.
> See [1] for an example of such a case.
> 
> If we do end up have to revert anything, it'll just be Patch 5/5 (a one
> liner).
> 
> Marc,
> 
> You had hit issues with fw_devlink=on before on some of your systems.
> Want to give this a shot?
> 
> Jisheng,
> 
> Want to fix up one of those gpio drivers you were having problems with?
> 

Hi Saravana,

I didn't send fix for the gpio-dwapb.c in last development window, so can
send patch once 5.11-rc1 is released.

thanks

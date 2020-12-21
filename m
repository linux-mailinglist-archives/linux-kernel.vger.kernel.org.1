Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35372DF79B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 03:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgLUCAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 21:00:42 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:50753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbgLUCAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 21:00:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+BFAmsiL+qoPRBMCrNTjM8s7LwGWp1dG18lM4xItuNjKGUGDzEHoVNIFSdAwN345tel0LQY5kBOHhHy7bpB+3bq48Ezy4WsWACpt4rQFZVtHpv68RpD1pV0gdldQvVtve49PN57jaqeyJpKO/4Dgw+u9UmQn6qe93FPYHw4OBKD9RerxImVVpc4oVNDpR8kW4Isn//qPKukQlQAeCVUnnRy6Cnwp5Z8Zu4nXS55QY7kTZ8Lv3tbxIdJiAfUCgBQSXL2M1gNdMGgY8agUzVVgmrnYwJl2PRKou4h5FWwEnDQPhFpjMHO0dZ7bq7sgsXlAfVV6qktM/v4iZXWw68awQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
 b=hMiiMCmeYbF4ymqa7j7OSM1xtf5XLWPeExAuQMwU9UXG72Lc1U1E73ni/h6Zq9sj5v45ydyg7IhrujmQA6SYrJGexSzLs+1aAQ9DwlCJuC/Mu/X9DU5BKE0LopDIwhiajAEM+9nRNxOHxddPadUJ9E0HiQEVD1GpSXf6rLScIT/eHBvyK/+MV0P8VrJHCTRXOrI9fmyhP7qqC1FKKNlzDqNSwJRvcx9fjOS24wNrL0mPKNXL1ij3CyGMmuXyf49GMIhOuKPB83hBpV0zWg/fLPfPrI1+lozEtli55psfXBoeEmG/Ltw6x84s7jeCN+dn1/RYBIqkFB1hlluivQKdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
 b=mkokRQQH4cCFYEfmWH5zG3+kwyDrJcOaCGjfWsCdLYw1MHpVLAlsqmUCsuHQHCxxzxAFxBRiHd+44MuqvV+2uU57c4fRKMpcnNn63VsarIhkY7+U4gezv6GnbsywlUtql/np0Vxdo6iWYDdRlVw4TZcSI5NTqZMbJD1KcU3JcsI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM5PR11MB1674.namprd11.prod.outlook.com (2603:10b6:4:b::8) by
 DM6PR11MB4155.namprd11.prod.outlook.com (2603:10b6:5:19a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.29; Mon, 21 Dec 2020 01:59:53 +0000
Received: from DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7]) by DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7%10]) with mapi id 15.20.3676.033; Mon, 21 Dec
 2020 01:59:52 +0000
To:     linux-kernel@vger.kernel.org
From:   Yahu Gao <yahu.gao@windriver.com>
Message-ID: <3f8618f8-d508-1d0e-77bc-497158b481c9@windriver.com>
Date:   Mon, 21 Dec 2020 09:59:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::44) To DM5PR11MB1674.namprd11.prod.outlook.com
 (2603:10b6:4:b::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.155.99] (60.247.85.82) by BY5PR20CA0031.namprd20.prod.outlook.com (2603:10b6:a03:1f4::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30 via Frontend Transport; Mon, 21 Dec 2020 01:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1327fe0-8457-40b3-4462-08d8a5541b83
X-MS-TrafficTypeDiagnostic: DM6PR11MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR11MB415582D7125F8107ACFC147E99C00@DM6PR11MB4155.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILsJcEHD1dM1tW0BCal6REDLQVlUQyyZPMvQODBXhvY2aMIQ9wJogJJRBCX5vnT/M5O4OVH39xQZS76CRtKy2kqjgoVIh0Fh6dCD+MfAtiDDkxe/g2UAbnO/mad0uhAqd0p3aN6C3wXyLy0ObFX6xpRscaca/lEg1h/32dqA0tc3DSs/RBD7+meFXwJBGmT595vgNlj/K+7WlOjo8s9sInUxD9e9o0mXRNGjeM6802KrcvBpjenDvcFopPWYsR9gVxNzxWFXGU7DOgY3AE3JYONBnMuSCB4owIjOe12IeahMeCM06HajIzdwmzDIzIcH83OJC07wfdkTzr7OQ7RiqdH/XDoRcxdvtirPldehpcBR6/1znEFnpA67f/QZb/C6WW6I/UdGwELVMqGKuib/+KOCPdtOSkAk701Fo0uWvSImedr7NGZEkYgsgZCuCup85NvdpWZCJcQs3lLc7vzt3juh+TtGhnaBFl2HMrV6No52CA94Upp2IbfjUSfGPlIy8+W9/0lj5x3dfxdIkdWkVe8viaflTn3hRpz9XXUQGwOZFJN/jov+IXMbsYi+tq+2NmzjAlCT/bzrbEJdO+0g9T5+p80T6DV6kdaxX8vxHLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39840400004)(376002)(66946007)(6486002)(316002)(44832011)(52116002)(31696002)(956004)(66556008)(86362001)(558084003)(66476007)(19618925003)(478600001)(2616005)(16576012)(6666004)(31686004)(6706004)(186003)(16526019)(8936002)(2906002)(6916009)(26005)(36756003)(25626001)(78286007)(43740500002)(45980500001)(239884005)(425394004)(19559445001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eGx6azdLMjUxSDEvdjkwa3dVU1JMVHIzbWFOWmdOU2xYV2Zja1VZemgwaG94?=
 =?utf-8?B?TVU4eVVmVXQvTXpkRFZuZDZ2d2lSdlhXMElQcDA2ZysxRStUOFBuWDc1Q1B0?=
 =?utf-8?B?UkxyN1VzcEVSbEpjVkJtbGxxM05xNTVaQWVZT08wSzJvTUY5K2FvSVBMQXRj?=
 =?utf-8?B?Vzg5Ymo5WnZjbU04YmRvUC9zNllkRUc5RzdiVjN0bDA1OVNGd3hNd1pMVlgv?=
 =?utf-8?B?ek5Qbm5UQzd3dzlWWU9IWExwS3NJY2pMUWE4RVBxdHpUN1pUUGpJbmpmY3Jk?=
 =?utf-8?B?cE5lZEwzaU1DTzVBc3IyaVRVQks1NUUxbEZMQ0pxTHJ3SXRQc1RxNTE2QlEw?=
 =?utf-8?B?bjJrVzkrayt0MlY3THdJU1hTWGUwZmcyNVJZUjBMd3UvS3hnQjNUdDBLS0VB?=
 =?utf-8?B?VWF5VFBUUDFwa1BUdDNkejJwZjhXNWJBTHNNbXVlbDJLNDMveWh1dDdmS1VK?=
 =?utf-8?B?SHU4QldmeWpPSUQ2NzQ0Kzh2ZmNXZkgvNEIyQU94OFJjYnFrYTFMV0pNM0R0?=
 =?utf-8?B?STVCT2JnbStBa2tTSStEOFVFVmloMWoya05UTEtnREtHVjBZanRVSEVaRmFF?=
 =?utf-8?B?dEJmeG55UjBzdFJvY2VYS3pkczNnQVdnNlBTVW5JeEd5ekljWGp0Z0pzc0lY?=
 =?utf-8?B?RURNZERyaVBOOUJJVVNtRDFRaHVEL0FBZW5lek1Cazd4YVFoQkczaEs5ZlFp?=
 =?utf-8?B?TG1FbWdsV0ZOV0twUWNYWmoxaFVVSlhXMGJKbDFJU0l0K2t3ZytLYVJucGNZ?=
 =?utf-8?B?TWdqK3JqNUg4bGdqcHdQV3ZMSEp4Z0ZkNWl5TFhvOUJXQTdkbk5ZaktOWlNM?=
 =?utf-8?B?THpDRTVwcGRMeXM5ckJQYW1Wbm9BYlE1amFqYjVSeC9nM0RoenVGMGF2UWla?=
 =?utf-8?B?U0NyalhvaEI1TVdqNHNIeGU1SlpRNWJrRW9jUlVQaUZzNkMyZzlkdVJ6eW1a?=
 =?utf-8?B?YnFTd0ZNYjEzRG15Z3Mvek8wd25YM21kamx6M0dzN2F6ck9kelk2ZDMyOFNZ?=
 =?utf-8?B?TUkya2ZQeE9Uc0dEQWxHZlVzODZiUStKMzNRK2lLQVpVVExLelBDbzMxcCs0?=
 =?utf-8?B?OGFPaGpkNU10MkdiYm01R0plQnJaYUZGL1lFMFVmamo0bFVXbHlYeHpjMkJv?=
 =?utf-8?B?dGcyY1ZNZ3laOGxkaUhLSW1WOTBOdXZlUXFqVHd4bTVIVHVKa0tqWGx1ZVBk?=
 =?utf-8?B?aHdmbmFGWW9VOFY3ckJhTHJGaUd5eFhGMXArc3Zjcm5aODB5SkR5WjdzNXpB?=
 =?utf-8?B?SnJieTl4MEZUaHdWMkw2bDZqTnJERUZmVFl0UjJpZWoxaFREWkU5RWROWGxR?=
 =?utf-8?Q?5PGHCNsB2MWfk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 01:59:52.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: c1327fe0-8457-40b3-4462-08d8a5541b83
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqbGxj3O0oMC8Gj9XVNC8p3MIvZGViAQjT1L3PSj3jYJqXkpnI8tDl5PEllK8rdo3TjZaB7gjVxbBdM1AcFxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe


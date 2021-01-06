Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60802EC56C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAFVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:01:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54958 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbhAFVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:01:05 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106KwVs1002284;
        Wed, 6 Jan 2021 13:00:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2mmPWe96KdI9oLvR5eKK6XkdU57haQneNM5a/ik2ulY=;
 b=W/PsvskuMicU38CH7fSsmWFip/WdAbO9nw8C/+8p+MrCttqOw/vCsy/Qt4SM6yD/z/T+
 hsoLfwOez9lKUUaZhrwxTiT1pbThLS6FTU6ZUi2eYK5vLXy1gWZaCrpDFOFN4C3z68b4
 EOjk+SfWWaq/pr7I873oW3m8cTOVL7esej4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35wg67hqpb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 13:00:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 12:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9ewg6Sefs0Bunv3/ljO97C3UwOpBm6xsw8PqeVGwCvWnW4DLoYEAAPPbs3FsYAQmbgUTp3tUlj71Cvsa/m5lOM87BkxgIQQuDmYy5+jhIlVVqq62it/yKfqxMTQ7rjPnz1esuxNnbmNkUwx+cARHsf84V0YeG5mgp38UvlGMtSXtltKWgh5CNp0vRJGVDSb35sXwXyEN68rV2EtWbfFfyTpGmp/ZExQwIWFWzI4e/+xH9h7N6Hr1xdWRnPk8uLALfexCYKCxalmkkbEQy/MaYwoIBmduXu054tut2K5kFygCRrpEE1MV9ofm0xS1vgeKH9QHuZccDm2jMwBxEtG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mmPWe96KdI9oLvR5eKK6XkdU57haQneNM5a/ik2ulY=;
 b=EbfnUgazFi5+VkKRk02NA416RSTaFPFDf4+2wNY9eNqvjHCFNiMcrizG6uBcPOZcPkFzWUYNspHiRRSnluYoTrPRKfnviwbB/2uVDbCwZ4qJUvMjGUgZ7dWI88p6P8O1P2dAphxWSMFbei2Qspn5wsoE7C3uVt/KMZj/HLc074SImZEn6+WUsDDv13fxJMzCy+K27er7mvZFJlsAfKtaHxlupK5BokirM1tbuBrpLAW76ctcZo1sf1dQg0YDRXEqY7os2VRlfiOCgAb1qtEAW4uyPOn2sob6/ZPXp4ijhaKZ5HAPBVSwijBWfrv7C6Q/ORQ95wPQoJNoAWJk2UGdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mmPWe96KdI9oLvR5eKK6XkdU57haQneNM5a/ik2ulY=;
 b=OyWPQYrOHM7gvDymy7TC6RdXAlfJZy6u5i8CbMOY8H9siZZKri8cAzj+OMCFbg4MPtT2afYe2Urdb5HMz0zRA2HsaZMNL6e9VXxzTzGD8eL8O+XFZFx5xJI84YO2RT2dy+EZTNohZ6+jz/FZCM6XZr+6coS/RAMuhd1hRoqcTfM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB2591.namprd15.prod.outlook.com (2603:10b6:208:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 6 Jan
 2021 20:59:53 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::f528:1e2d:ec25:9dce]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::f528:1e2d:ec25:9dce%6]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 20:59:52 +0000
Message-ID: <c7cc57a247747d164a870ebbbedb1b8b756c73fd.camel@fb.com>
Subject: Re: [PATCH RFC clocksource 2/5] clocksource: Retry clock read if
 long delays detected
From:   Rik van Riel <riel@fb.com>
To:     <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Date:   Wed, 06 Jan 2021 15:59:47 -0500
In-Reply-To: <20210106195321.GC2743@paulmck-ThinkPad-P72>
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
         <20210106004134.11467-2-paulmck@kernel.org>
         <edbe9ac5fc3f76601f752ce2c5a8052dc05fd4f6.camel@fb.com>
         <20210106195321.GC2743@paulmck-ThinkPad-P72>
Organization: Facebook, Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:bfeb]
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To MN2PR15MB3327.namprd15.prod.outlook.com
 (2603:10b6:208:fd::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from imladris.surriel.com (2620:10d:c091:480::1:bfeb) by BLAPR03CA0123.namprd03.prod.outlook.com (2603:10b6:208:32e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 20:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca91465b-4c26-452b-dcb5-08d8b2860320
X-MS-TrafficTypeDiagnostic: MN2PR15MB2591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB2591166D81AFB100E446D607A3D00@MN2PR15MB2591.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bocIVftNqRDLJhmRV9BW7XMD6R0WID5j5f/9R5ZUzGnrrBmxqRc3tujLmh/GKbkttO8Wq5TgOVm/WglEeuMocXonfwRlIvHHHn1RGFeQY5yAXYUP+HT57k3edMvPblo7c66jd7xLCpjwpL0cOv+KlwJdbSmiM5hE+tSBlF+zLfyMIS6VobMGucQ5chdtv9g4KrZqO1afOs7EY2AMZqe2VKwluppTSHL9nEASdTxmyX2A4sALms4KqU4uNvTZU3SeSLiMXii/24iR80uerxyLDr3/cHsLz6v9/5fhkzZRo1jMN3EVhd37u3vDXNdGKogCq2Zvo542GmDlx5Z7Ui9axp07NiSvlEKN+bGs8UvO+AvVK71GKeY/njNVY3yDup7MO5Mj4pdgPzJq6WXChGHRfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(4326008)(6506007)(16526019)(8676002)(6486002)(36756003)(186003)(6666004)(86362001)(83380400001)(66946007)(54906003)(6512007)(36916002)(2906002)(6916009)(316002)(5660300002)(66476007)(66556008)(8936002)(478600001)(52116002)(2616005)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmhySEpVeHM0ODdwbTdaeXU1OVRSeURYcUFkOTRSZGl4UlliNm5kWENjTGxt?=
 =?utf-8?B?TmRUejZuZzN0K0RsSnBianRDK1FXTzVocFNxa2J3cGZSQWRZWk5pWVJ3SW4y?=
 =?utf-8?B?bVVBalY2TzQrS0NHR0ZuWk9oZ01lR2J4L1lZM2RKTTZSdmJGUEpSZDdQZU53?=
 =?utf-8?B?emVZczlyVm1ZcFdKWER3THdhM1ArZUFiRHpOTWtpTmJZaW1UYzRxbTJvWVV1?=
 =?utf-8?B?UWkvemJuUVZvelZDQnlJZzFkK0lETzNGSlFYRk1sQmlYaWt6UlE4SjBqSW9E?=
 =?utf-8?B?WkZZTE9rdlhSTGZCT1Y0cTB1aUs5eGpFN1B1QldNU0JZNlRiWC8xdjF1MTEx?=
 =?utf-8?B?L3o2WDBVVkZvdk1xZVBQMm8yQVJRQ2tWSTZwOHZGYUxCMHdrZWFSS3pUN1dj?=
 =?utf-8?B?ZkMrQ0NLdklacG9mUnU1YlJNUUp0N0dBMnZPcjlmUTE3QTRVVDdpa0JsREF6?=
 =?utf-8?B?ZHVmUmhicXZHa2xuQk1GUXJkNldFWk9vSFdUbnpJS0tBdS9CUSs3cS9ISkJj?=
 =?utf-8?B?RzhIaHdUWDhHWCtNNzhFWGMyaDZDNytsbFcyZzBORWwyM052bDA5eVpVZklD?=
 =?utf-8?B?Ujg1Z2Q2cUZlK1E1Y3lseGxmeHNFaGltR1BCS3Y2bUcycE1MMmh3M3JGREg0?=
 =?utf-8?B?ckwxQnlzZVQrUEpmdjFxNUdXVU4vMEdEWkc4cCtmckdaeEpkbFBwNElpeVdj?=
 =?utf-8?B?MklaMWphWTh2TzNBWStndGF2dTVJWmhsV2h0M2pFOXRzbXgrcWFpMmF1dE14?=
 =?utf-8?B?YkhJV1BsRUVLZFZaNFhaaE1oZzNNdVQrVGdkSU56ZGNjL1kxU3BYU2FJWlBt?=
 =?utf-8?B?dFQ2ektFdTI3bWRDbkdZTkJuc1RqeTNYR2haK2UwS0xHYjhZNDRieGZUMXpP?=
 =?utf-8?B?em5PaTN1SE95ZkR2U2orTGVraE5iaVY2WDlxbDY3bXQxNVVXWVBjOG0wUTFS?=
 =?utf-8?B?WSt3N0JpTWczaytwajBvMmNZRUZzZE8xeFY3dVo4UW15YXFaOFFWK3VIazMx?=
 =?utf-8?B?dG5XWkcvcGlKREFuQjZsODM3ZHRqWFozdUlSZFZ3RVZQWER4ejZ2SFFyTUQ2?=
 =?utf-8?B?Szl4cGxJQ0FlazBTZmpJMHFtQjJMWnVtRzZkR3NHTVVnOExFSzl5ZjlCM2RJ?=
 =?utf-8?B?K1RsY2U4clVjZU9FMk1ETldNcGZ4TDF3OGg5OHRiYUVjaTBFOFg4SFZwaXVL?=
 =?utf-8?B?L2Y0QWRlS09nYmVjcWQ0ZUQ1RGVIS2V2ZVd4YzZxRnBYa2pnenNmUitnYy9B?=
 =?utf-8?B?SERyWmsxRjVSZVVHS2dvVWgvVElPMm9qdy90RXVNaVNxSHpML3ZCNERDOU5J?=
 =?utf-8?B?VVNWKzVYVWRBYmJyMFZpbTNlcE8yeVBodFJCMktTSGkrWHQ5WkM0RTdxNlc3?=
 =?utf-8?B?d0x0TU1hSGZEaUE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 20:59:51.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: ca91465b-4c26-452b-dcb5-08d8b2860320
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGswJy75SgBvOW9YAHTRWzaRsJTIcC0OGpnCQXkXBjda0xsvjiqdf2fU+H3WSybN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2591
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_12:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101060120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-06 at 11:53 -0800, Paul E. McKenney wrote:
> On Wed, Jan 06, 2021 at 11:28:00AM -0500, Rik van Riel wrote:
> 
> > +               wdagain_nsec = clocksource_cyc2ns(delta, watchdog-
> > > mult, watchdog->shift);
> > +               if (wdagain_nsec < 0 || wdagain_nsec >
> > WATCHDOG_MAX_SKEW) {
> > +                       wderr_nsec = wdagain_nsec;
> > +                       if (nretries++ < max_read_retries)
> > +                               goto retry;
> > +               }
> > 
> > Given that clocksource_cyc2ns uses unsigned multiplication
> > followed by a right shift, do we need to test for <0?
> 
> I am worried about the possibility of the "shift" argument to
> clocksource_cyc2ns() being zero.  For example, unless I am missing
> something, clocksource_tsc has a zero .shift field.

Oh, good point!


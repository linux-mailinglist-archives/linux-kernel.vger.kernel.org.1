Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6E2EC135
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbhAFQ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:29:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50120 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbhAFQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:29:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GIakN020427;
        Wed, 6 Jan 2021 08:28:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WlULuIYb8/xwQIq4MPQmCvhdhUrPlz/VicAaEuRNjkY=;
 b=chEpsHvAgSMDZxyHqhpH0b38vnjgGZLREZfSn/oPNliSLye8dHyZsr8416X7bc2LMf4h
 jQlNnltbcKIblQZMlJH9KdqwUhf/tcvVaB0b6zhoLi+h6D/zsPpvClMwr4VDsWNSH1zJ
 Nwy9+GCfiYWkn4pJW+p3rbKahoSsgVSNjDM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35vwxmmua1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 08:28:11 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 08:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDl+jQ1bQz/JMQOHKGaxG+fp8WUoICxXr6ARcHobXA3V6Y6J967dB30caV8SdIbuw+aKuzn4UZZ10sT6XwzQudeWi/tcVDHmZYMhAlqPMGJe+bvJnjdJYbJoKm79tyM+gOhTXjWgIlz+iFMDGQ/bIYmqBD1/LkpSJ1ydCXlih09ri9sioT6NxfWYMwiYAZ0PqEbma32dSQPBGKqFa5xwL9vpBa+fiWRBnIQ2nI0Edi+Zqy6KqiRqDY8uxp+W5DPSiSSxto73JTvGd/OUSJEKJDIX3uN55cz8wYFFC0bPC+d8L2G8IesbJhi07yA2YHR2JmRdVqiKz/wQKPBxGuFTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlULuIYb8/xwQIq4MPQmCvhdhUrPlz/VicAaEuRNjkY=;
 b=XUJ4D9CYXjn2cwtmAd0Wv+HJFsuvPp2am/CgppX7vvPZQ8aCzGW6oKPKL6zJx9m3RCNF5lOBbxExJqlpMvFPc3Q1SF7L5qnEad/BUFE85T+AU6AIlXpKSFzgxcxlbQbnakr+aRMaNeeQrTWTRt9cqW4sIgV3yVL0CvPG/YCY4NPfbME+4cZ8/BnHdAoNjADoXV7iNqPehVc7JTMITdSzsy/CLgbaPmiQPQchPKdB5LDG1CegEb5GUvMG+4I4tW/2CEvU/p8xJ6ddWAW9thI56t5MntzK6E8JmXg88CNJZWXbiaSRQp14mweW87snLLlhFW2N0tZ/mhURM65JdIz/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlULuIYb8/xwQIq4MPQmCvhdhUrPlz/VicAaEuRNjkY=;
 b=Leq75JkY8dK9ck3x54P7wI8SgcWK+b1mzpzGatndqMvF0/bfgwa12+CgidbaFMBL6nsurDrk61ut1b4skE72v2z5yeGAdohAOF1YWV9PbaksQa0iq/nTSCxz1hv+8FPToDSORxkvVFAx1a6Dd2j+sBMomzwUNkZjkcKQ6XiRdK0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB2735.namprd15.prod.outlook.com (2603:10b6:208:12a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 16:28:05 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::f528:1e2d:ec25:9dce]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::f528:1e2d:ec25:9dce%6]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 16:28:05 +0000
Message-ID: <edbe9ac5fc3f76601f752ce2c5a8052dc05fd4f6.camel@fb.com>
Subject: Re: [PATCH RFC clocksource 2/5] clocksource: Retry clock read if
 long delays detected
From:   Rik van Riel <riel@fb.com>
To:     <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, John Stultz <john.stultz@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Date:   Wed, 06 Jan 2021 11:28:00 -0500
In-Reply-To: <20210106004134.11467-2-paulmck@kernel.org>
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
         <20210106004134.11467-2-paulmck@kernel.org>
Organization: Facebook, Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:bfeb]
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To MN2PR15MB3327.namprd15.prod.outlook.com
 (2603:10b6:208:fd::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from imladris.surriel.com (2620:10d:c091:480::1:bfeb) by MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 16:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3382c060-7996-49ae-2b55-08d8b2600b7e
X-MS-TrafficTypeDiagnostic: MN2PR15MB2735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB273513F19448C54F4EFBD902A3D00@MN2PR15MB2735.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4LXBeRa6IA7ih+4pSheUi9XijHJu5omBW0yLW8fmq3EIxIyDrZbd/Ds4oJvtL1DcE0RVlnrCh7oDszA8D/in2w8EY85OuDd3IMzACbPLdni9G9XcnbU42GLZsDoRN11sCzpXj2ZbeKY2i84Z/pSnxKq5EZWd1GmwnbfEvYOoqJCA2bsCksqumi+hoNIUlTxd0gzFr4+I68dfhcXdVufc5lilqSC61TXOV/tNZYJr2tgjtoeg9sTO/qEAQYs96rk65haIftbhPM4Fq2KCeC2dI2/WO7v/rDGm9kNLN2QXRi+4KVdFPKJ6L5+7b8sb4uoWPZoDL0TfFNu20oc21cikfb47r8NkMfSv/roTvuJzziDTRUZZzdAMnR5ThEM/cCMV34ycA5VD1vSxAqEURiOzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(316002)(6666004)(8676002)(5660300002)(6512007)(52116002)(2906002)(36756003)(36916002)(8936002)(478600001)(54906003)(4744005)(83380400001)(66946007)(2616005)(86362001)(4326008)(16526019)(186003)(66476007)(6486002)(6506007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVFUdUdJTXFYSTF4YURVNlNkdDkwRWQzamZDTTdEaU5CeW40TkVIRTV4TXNK?=
 =?utf-8?B?ajE5dkdQMnN2eElMdklRVXRHRE1wTEVaYVhBSVFlUkhDU1lrS3FiclVDRWJ6?=
 =?utf-8?B?VTBCUVplSFdKTmI3TXo2QjRDdHRwRmc1RFNSa2VhVWZiemxIaERyNFh3Q2h6?=
 =?utf-8?B?cFRiRXhya2VEZUw2MGowcWJ0WlR3eHNGbk81NW1wWWJPZkkwNlY4cFVHQk1P?=
 =?utf-8?B?UmQ3b2FEZ2hGS2ttQlZid0ZnUWtldkNIUE1TTG1FekJSdTdIZzFYdGN1cktz?=
 =?utf-8?B?NEhNalNxMGRXZW12dlpGYTRyODk0NHlwUzBobFFLOFRnTkdZU2M0cStJWHNY?=
 =?utf-8?B?bjJ3V1lnTEU4aXRoTlFyU0FrVE56MFBlTXNrb0RXNzAxc2hzTjdPTk9sTGd0?=
 =?utf-8?B?UU1BdThsUy9MR0M1aS9XZmgyZC9teHIvMU5HQnJvQzdLek1BWDdTY05SdWl5?=
 =?utf-8?B?a2FKaE9BTnkyc1NKR3BUeW1NY0hSZHdQOTBjUFU2eUZEaUNWTTFOZVp2cnZv?=
 =?utf-8?B?cytibGFmQWdpalJPS1h5ODRpL293RXV5TTRBcmFlZVM3Q09mR1JlUllmQyto?=
 =?utf-8?B?d2Q5WW1CL01Ud3RidmFYVkVXM1FQQ1BzSElLZHFMTTRsWkRBalJUVW5mWEd5?=
 =?utf-8?B?d1pHRkJZRXVXT09kUlUyY1FHNDRGS29kc0lYNEh5eXU3REJCU2o1dVFBaU1U?=
 =?utf-8?B?KzFncVltNzhsK2ZzWUpBNmZYOCtlYWtBaDRHRXBCaUxadnlIRmJkRElQTjgr?=
 =?utf-8?B?SnhrYURSaFp3eUN4enRldHh5MlRjZ094WDA1eU5RREp5L0w5MmY5N3dhL3JX?=
 =?utf-8?B?K0xxNG9TTGRXY2Q5UWJtYjZoM3paM1RHN1BZQlZMUlJtMm1XMnVTWGkyYndk?=
 =?utf-8?B?aFlYa2tESHBDWENLTWZKS3M0d1puZGltZHRWa0lTYnRacGo5c0JKcmZDNWtq?=
 =?utf-8?B?REk3Rk5mVmlYeGRGSTFEalg4NzhNNlZwbEFGZ1E4cG02VlkraVlDNmpQaFZK?=
 =?utf-8?B?S3QwcnhKcjhlN0NUK1A4eDFxN3BNejFNOGpTZ3NuQkozclpOTnc5UWJBbTc4?=
 =?utf-8?B?UXp6OE11SlNGNVJoUHN5QlpHa1VjdUxJbWk1UmhSRE80WS9IbVQ1QmRLbVBS?=
 =?utf-8?B?SkRUaUdOYm8rcENxbHYxdVNiS2ZhYktPK2tISEFjd1BPdHNSRVp1S1NpUWhN?=
 =?utf-8?B?d3BGRS92YVAwTEhZaHp5Y3BmNVZZbnAzbWUyMXVCdWdYSStPdU5DYTNGcE1j?=
 =?utf-8?B?OEx5VHo1cWJCSllFNmk2QTQ1VGJoNnBqNThvMXBHOHNVL0E4YjFQcDhJWmZ6?=
 =?utf-8?B?WjdpWGJTdzlHb2JJRERVNytrT3FQTW9yL1lyb0h1d2k4cXNPZjZzM0lMKzJU?=
 =?utf-8?B?LzJGTHJiOGEvdWc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 16:28:05.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382c060-7996-49ae-2b55-08d8b2600b7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlTAP2kx9mcBUA85fJ/SyPVlJ6kRJ5w3mi7ElzzjG9tCmEos+7b8ad/BY48hOhMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2735
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 16:41 -0800, paulmck@kernel.org wrote:
> 
> @@ -203,7 +204,6 @@ static void
> clocksource_watchdog_inject_delay(void)
>  		injectfail = inject_delay_run;
>  	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
>  		printk("%s(): Injecting delay.\n", __func__);
> -		injectfail = 0;
>  		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC;
> i++)
>  			udelay(1000);

Wait, patch 1 just added that line?

Should patch 1 not add it and this
patch go without
this removal? :)

+               wdagain_nsec = clocksource_cyc2ns(delta, watchdog-
>mult, watchdog->shift);
+               if (wdagain_nsec < 0 || wdagain_nsec >
WATCHDOG_MAX_SKEW) {
+                       wderr_nsec = wdagain_nsec;
+                       if (nretries++ < max_read_retries)
+                               goto retry;
+               }

Given that clocksource_cyc2ns uses unsigned multiplication
followed by a right shift, do we need to test for <0?


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7C2B8501
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKRThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:37:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgKRThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:37:11 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AIJU1PK030309;
        Wed, 18 Nov 2020 11:34:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FUYJPzMbl2eKUzC7jzaqSI3PwmjCsTtweno9JRQx9NE=;
 b=G/XuTtEWxRc+HI507/nSIWkbq8HRksWwL1aPkqeogjbQ5vXnDzN374W/8ZeYuBPOTVE+
 1udMKLjfeyv4Dm2Bae8HnUq4SaSg5G0/EEYUl70dx+EhW5dkhtst8n04YmjAY4dalBUY
 Sz23JQfkiWs9+jvCgbTCcBLF75LDrGTX0yQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34vb0atyrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Nov 2020 11:34:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 11:34:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBU3dNv2dhna40NsmJjpn2/Uu25/STy+E34GVbsx1NL4hsaZwC8Xwwb9Q3CIV/lLyBLPRVJwEwcYTr3h2wIHh2T6eVsN12oeYsKc0EYgvgx5zaJqvrrPtLuFZmKB+5zELZWk1vSs5Zw060rSmXyA98T0S3DDhDtGrmG4UIU6GNx+T3KkC4K0QMeRMk5D7xV+vghoiXfwhZJ7kD6lhyDFnNQOKx5y36KyzaGs3dDdDPz7Rkok0tn5i4tV8TcmMjKG0cvMsCrcptCYcx7cwC9/fsoqEiLGrmXctIcxHahBrfZwQjXzFnYYrdaiGjDBwK1dp3oBwnMjC1ZzJSBrSmSV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUYJPzMbl2eKUzC7jzaqSI3PwmjCsTtweno9JRQx9NE=;
 b=lQLT4aMXpiRL4anxe1E6sgeFoYVgOpr/KXuTynflPvU7AxLib3EIgxA9X2Sb6CWXP5cOLbBmrbXdWS0rkCzdJK3ZNswgwd4Usat7VL3txlAXwT1I0A9LXnaJI+r5EWSWXk+Y/HNWIYpgSOihzWPbQHocGIDNQ2ch2u8jyFDr9SAohOWDmhRArc2kW5o5CwFTWrnzfDHvSz0l0YYBAMn4VaaCcNa0LMJbX+1SmopEdlYb7FYBKFy2ZUod0dCVpdMFUYNBAXKl9kdFLysgY0vhTuRCill7CouTyOtY4qwjZ3xzrnHanM2z9aA0/2n7/VJzewTSa6FRAjLFi9KFkxo3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUYJPzMbl2eKUzC7jzaqSI3PwmjCsTtweno9JRQx9NE=;
 b=UCktqpOLTtNB+G7rvwl38CGdkAfRM9yyvqSClnNgwqW6jF5enswabW+uK07ooZBbFj79cMAkevdbbAMDaoqoo6u7JgfBjbSvNYK9n4TY6ztJyRLfb8q5EPojFhpFCuofgNdj4UoAX4tpHoaNgEnyAeJSsKbwDavtHjK+YAGDAwQ=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2277.namprd15.prod.outlook.com (2603:10b6:a02:92::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 19:34:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%7]) with mapi id 15.20.3589.021; Wed, 18 Nov 2020
 19:34:52 +0000
Date:   Wed, 18 Nov 2020 11:34:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cl@linux.com>, <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20201118193446.GC186396@carbon.dhcp.thefacebook.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <9e1a2e2b-1b3c-9587-9b74-8ed8300fcb98@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1a2e2b-1b3c-9587-9b74-8ed8300fcb98@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:508d]
X-ClientProxiedBy: MWHPR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:300:ef::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:508d) by MWHPR22CA0011.namprd22.prod.outlook.com (2603:10b6:300:ef::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 19:34:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c8bdb5-1f3a-4d62-534b-08d88bf904e6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2277:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22772E78E3270CEDE8AEC490BEE10@BYAPR15MB2277.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWbeVQLSQXQzTCzJCENonMfnA34C1vMjnJljlFVMHJc4Zhsk6Y0xaIVHNl945B825DhocgRcho+UsEuF1orSwrMjYZchBOJeF3OQ/I3LMPigQpmvI7F8eO0BS0KIBB1A0/V6rU/unQaM0tI/Dn1UL3F3Vrk0hpnWe6sXqm6hzRwrnBSHf+SQxOb6N78dwWB8PIIh2m7V11/zQab7HEHP5ASWOEEvkmFSz6tanmxt/5lMLRkWANIeOWFUMkt4t+VJtwu3U+K9Bsf2bc54KJVg9zRqOdNQraVMdn5zid3lppKxTL48h0hPEwZ5Y3MALDsVrs5trUKZ6mcBnCWmB+wADA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(478600001)(66946007)(2906002)(33656002)(8936002)(52116002)(8676002)(53546011)(6666004)(316002)(186003)(16526019)(6506007)(83380400001)(66476007)(7696005)(86362001)(4326008)(5660300002)(66556008)(55016002)(6916009)(7416002)(9686003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pVCkQTwcY6jYfcv1jcK9CT77WT6W+hOqxb08PoOJXVyagzGVBsD2N12ypGDl4+f4gF/91uJzOriPf54nhCp11ZlvxqtLKVFCF4JJsfQ2b+A21jNH+CWL2N5jDtEJq6KnTsk84IEP8Tjp4w3ULG00trc7t6Aalc6lNbUZEmVVd1GDgD9FzY27XIWaGYauYSuAnqlti8h98YAgxd8xDOl16ya7xv+yH6GDF85CEHJHvuWHOUPo7A+/0/tlEX7kzYJu3TjTG/5HJK+WjWWwnAzpvMMmq68NPYZvAe5BK5/3cm5q/h5NE04A0pYeh1cFmhwMHk8Nb+w9MrLzavR0aSX8ubDG2EAUttnCmmUu7+68B4xriUor3cFpJ4HS2zf/ofBtgX/562BxAwEviTzYTesvMB+nr/qp7BUG/+8Hz2RqVA4IzlRstjkuo0U6/4gI34MK5vsehbAWNH4Pdy8RyE/8hgpooCWRwTisSOXbx5euQrD1TIx3HSuKbkQt83GIgMbWgQ32Qo8NSuAew8+3ckklrUFOi8SfRLR7bAdVdmrdbJZOFigig8UvHnQ8t6b9/58qmHPre37QQJlvHUQkzl/pz0+l5IWPs3lyf9kfhcTIyndn/EPjXwslblyEyeTZ6YJ1mbkxGl0CleGaBUO+ypaLG1ra+ZCWN2qA9YHMBx+caqw=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c8bdb5-1f3a-4d62-534b-08d88bf904e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 19:34:52.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzDLtOcuMQnZjTz0eYLNqjmQDZ76ZsrOMiDZ0U7Nco/lxz4/j3k0flG1i2APw07Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2277
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_06:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=1 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=996 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011180135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:25:38PM +0100, Vlastimil Babka wrote:
> On 11/18/20 9:27 AM, Bharata B Rao wrote:
> > The page order of the slab that gets chosen for a given slab
> > cache depends on the number of objects that can be fit in the
> > slab while meeting other requirements. We start with a value
> > of minimum objects based on nr_cpu_ids that is driven by
> > possible number of CPUs and hence could be higher than the
> > actual number of CPUs present in the system. This leads to
> > calculate_order() chosing a page order that is on the higher
> > side leading to increased slab memory consumption on systems
> > that have bigger page sizes.
> > 
> > Hence rely on the number of online CPUs when determining the
> > mininum objects, thereby increasing the chances of chosing
> > a lower conservative page order for the slab.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Ideally, we would react to hotplug events and update existing caches
> accordingly. But for that, recalculation of order for existing caches would
> have to be made safe, while not affecting hot paths. We have removed the
> sysfs interface with 32a6f409b693 ("mm, slub: remove runtime allocation
> order changes") as it didn't seem easy and worth the trouble.
> 
> In case somebody wants to start with a large order right from the boot
> because they know they will hotplug lots of cpus later, they can use
> slub_min_objects= boot param to override this heuristic. So in case this
> change regresses somebody's performance, there's a way around it and thus
> the risk is low IMHO.

I agree. For the absolute majority of users there will be no difference.
And there is a good workaround for the rest.

Acked-by: Roman Gushchin <guro@fb.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB292A56C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgKCVa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:30:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61622 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732086AbgKCVax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:30:53 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3LSN4U025642;
        Tue, 3 Nov 2020 13:30:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LP6opMSWxNcjDSqFuR0gqv8A3mmPzOUlXucNgO8B324=;
 b=FM1yuchRJ14ocZYSD5GMi9CMn3AyoZsb1UQL06aLQbjbsJmOXGy860gfZTl4WnB7JmuR
 pXxKhQl+EuoTWEDZuU750qjoRp51uqwyFmP5j5MC6rbI99Alcw3YrF+mQ+G9BmyN2xoF
 HMyVYy6L9bCltoZnOJ1PLqZweMjpmhuPbpY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kf5c008x-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Nov 2020 13:30:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 13:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYBW33r9gnXPxR5v/nIhx65jVwblg+4sXOvb7e8CJ8de8nt65Nf5CgdvgKODKzMSYlzbjxTMJtMpFmM8+XkF/lev64yBLgPyBWpZlPvWoACdGOfHlRlnQcCzT8YBvRNVxphYfu/MSD+XavUqQCg/5MnduQgM6qpjgaZe2T2YQe1VFwzd+dHxHdhF+MAJeXAqatP516MvyEXGdnn19Cs8p+dakWX/wDHxqrWWahC1EmF3e1pLTjVJ1a54+pMIdRPc4pnNaMz+13JizwaWOpcvcGSQMjFjXEly/eG/Mr2dn3oDbifwUE9ui7gu4c2OT/W16qs6wuoO069DaYZvcZxPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP6opMSWxNcjDSqFuR0gqv8A3mmPzOUlXucNgO8B324=;
 b=c1yt7X6DvmKFNLaAUHZNNtofUbunzN3pq8V9SyLb7cZ+uwPQg3RxVlWc+6QFkn/Ffhxo1pHjO38NfYruTcjNOVeHl3Q5oHDj4mXhl/Xl2/9835Gn9Raj4Fv9kecBVzfe7Rg+fAACFim4TPdiBUAol5CSeUKm3adaHkkeTl8K17Dnw+HT3nhDZHgneKPaAGNPzv8kZ0cq3UYBz/c30i5VrSQlTMLe7ZxuiXSnE5xW27zmy3OiFu9rF3doAXoP0HwYmTtMwk4OeS/HJLVqv5j1EYo8xi4xJcUgtjO9xz18YjdZ9aefV7WxnU2XI98nmn0sH5o3kuVfoD4CPNTOpTzTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP6opMSWxNcjDSqFuR0gqv8A3mmPzOUlXucNgO8B324=;
 b=EsHQqAkpfIcvaqzYPYVceEUUr6ovyUPaOT7LP+a5dM1MrAU5L0Uo935bzN43JfqTPzcZmF67cgk1vKcqNUaNH1MowRtNkIKbN62VA7o0Dvvk4EHDzmeT8PFkp83/uZEOjLuJ4lG9RKYzq2+6xeknmBs1+gzaIcwxyEuX0nHvgrg=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3445.namprd15.prod.outlook.com (2603:10b6:a03:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 21:30:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 21:30:17 +0000
Date:   Tue, 3 Nov 2020 13:30:10 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201103213010.GA1938922@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
 <20201103132221.GI21990@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103132221.GI21990@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:6cce]
X-ClientProxiedBy: MWHPR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:300:16::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6cce) by MWHPR13CA0022.namprd13.prod.outlook.com (2603:10b6:300:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 21:30:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8810314-e3eb-4bf9-68bd-08d8803fa857
X-MS-TrafficTypeDiagnostic: BYAPR15MB3445:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3445E6D33CF0F727E632A90CBE110@BYAPR15MB3445.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNjctyuogJnAmdSXoC9xUHlkL1IOrJZEOSibiG/Rc1LC3KQJ7VDLMe6jloOjakOrkg7Z7yBdUYoCFrQauLmmOR4fTYXy6IIa4DdslL4GibJ/7da0W1wSspsC9dloYSCSLWpSRSx34xnB8KRFu53vln4OpvyqkRZfnC09YT7uSD4gCj26/j5mIc0ZMtEC0D4RbjzFFcBPlZ0IUwH714qGJqyqc6KUNWYU8BrnuttLEpUEiLFhOzrx/cPiqACXOu9lKp2do2x7nX038+UA25pTLP/okEUaWN632UarnDluFf8Q83KJah+XddCFv8tmYUATRuJ/udZ4ZSp6GaBGXp7dJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(2906002)(5660300002)(33656002)(6916009)(1076003)(55016002)(4326008)(86362001)(7416002)(478600001)(54906003)(8676002)(8936002)(6506007)(66946007)(186003)(66476007)(66556008)(16526019)(7696005)(83380400001)(6666004)(9686003)(52116002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: V6Cw4kJsQr8OftNtXkyOtb5TrlcP9upQHN1mYs7p2cEE8DzMJRK1yNhiKzYIR+TBUR7/UFTJ6Fnr9GOjRGmBaJ0IpMlpo6Ff1+mA9kc3IVIFDdW1VMJe+OtC2JENJtQcvJ3XekU8ISKfZE8Ryd+C1O8sq0tVell5R3WEB4pofqwRHycGyihtFSHfV6bNwzVD3rj7zhq//VwZ1RVGoOHBtzQczNG91Q7vSP8vZE+4ROapPVWk5IQlRCi0ZafMo6Yjw257mta0jyX7Ax14Ym9zkmWIfxPjSu+im70mB+CrZpCnxi/zKoVNIoKS0/ezKBdZZCVVOQoXjHHGA0Z8AUvlC63ZyqoGIz2cB6c95TLhIf/5dMKJOkZVT4xnqVNIRiDZrTFUbCWnZzMJFMo803IVcax+CMGEbb2Ibj0AaFTCdVxLUMtex9u0yyO78RUeFq1y9+T9v3cn4a6N84q+LmgIwNoyw2K7wacgQKhCUd4C/WRCBHJ6ihhgAXbpJCfRGXHnZ+hk/Cf97+zFO++Ofz0wmXMFbNrtU8hy9d8nEpEk+hshwfrAd/KA4D3/sBCJWfZ3qqQSJ4LCVWlurmT7p1Cqb6Uo2ifOhKMuLHXGvzW/eQ98/JGAHZ7F6bSKn0LyE4Bk0Am5Ish1D+lNZKAuE2UOXP2XxrrbsFZfLLfxn3jMMSo=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8810314-e3eb-4bf9-68bd-08d8803fa857
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 21:30:17.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8ggpXwjuVTy6k6lPOTM5Vh5J3y1ADGNABL6xkq7j81HlMupoOCaPuItL5vHNYwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3445
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_14:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:22:21PM +0100, Michal Hocko wrote:
> Hi,
> I am sorry but I was quite busy at the time this has been discussed.
> Now that I got to this thread finally I am wondering whether this
> resp. other root cgroup exceptions have any follow up.

I'll address a feedback I've got from Johannes and will post and updated
version soon.

> 
> I have seen the issue is fixed in Linus tree by 8de15e920dc8 ("mm:
> memcg: link page counters to root if use_hierarchy is false"). Thanks
> for taking care of that! I do agree that this approach is the most
> reasonable immediate fix.

Thanks!

> 
> Btw. we have been carrying a warning about non hierarchical hierarchies
> for years in our distribution kernels and haven't heard of any actual
> bug reports (except for LTP driven ones). So we might be really close to
> simply drop this functionality completely. This would simplify the code
> and prevent from future surprises.

Just sent an rfc patchset. Your feedback will be greatly appreciated!

Thanks!

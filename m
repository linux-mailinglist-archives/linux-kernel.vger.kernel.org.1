Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CB277A89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIXUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:39:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:39:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OKdPFs028203;
        Thu, 24 Sep 2020 13:39:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CLkoNXmnezmja9rTXPvRvgX8VNHZB5QxUggARHsfr+0=;
 b=O8QZGZ7DzyCv6taCnQnV0IBwubmVG1158+VKziuUhW3f+CSfVVhS5/ypy877Le9al7le
 E5bN0LpB5aeh/HCy9qWJyIK0DbkKXvtSfkS6M+ODgac1ctePogJNc6Ergn5aPKNyhTbX
 o/OrajHao00+UbXsC1HpTQoah1CvM3ljrtk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp53wxx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 13:39:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 13:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b415ZCZQLaBIqH/Mp++bxGOn9freRvwsxPyV8YGIataOCt3+oT2s+6dUWq3gPm1x0+6sKlqODwhTMZum5Yyg5EgFNy4OhX4BzghPLAwAN1RvHiCi+c9XOnKckbC1hSqpomrbXc21h69X7wDNsx3RkJHYf2Gl0VDGLl0FsnUGcM4/wnAS8hhZ8eOBUrLCMJPo7n6VV+0ngfk3cgDyrVgwDptTr3DlUgMiJa/q4kxZMGWeDrY4KNDftYfke6WTPK7cPJBt1B0sJkHv6mpwtqCWQkf0KNOP+Y8JqDb/OIhda6HjMy6TzU5PzbWYvttGkriMyDsSiZn+SOAIozxc0WSW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLkoNXmnezmja9rTXPvRvgX8VNHZB5QxUggARHsfr+0=;
 b=A7O+h2lpzZbFKeHLzMkEQx24jzejKVwIqQSe1VqaAwi1gAKmwnplj0IE3p5pBdYkYjTzkHrwk5frNR3qjns3aRmpuol0KewZusLXfGoRalynA0WOF2iGSQwlPiz5jSokXH6LAbR+WtMDFr+5tftr0+J/gYT3dgM7BNY3vLHvk3M05eiACum19JqUXSN4QxBdtKBXO5mQT2eXNKA5S2Ioy/PGdACrQpR6jtEubRwIEhDXrD4I905V+x8nsDs5ygqLBM5HdRURqtZn70r4uJgT+JdSM2NIcaLEjO+WwEV7JkUtL7VNGA4TdKlSDSDyVsnOJKAuuSiqUCEAbkq9Dx8hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLkoNXmnezmja9rTXPvRvgX8VNHZB5QxUggARHsfr+0=;
 b=lABW85CoMcCIfli3GhekxrxW0xnIQhcYYSPT15A6WxZ+9KXf2ejVZD6hU8kvxoT/2Wl+v6G4TLJJ44Ze0QNpwdiCO8DgV1tX9WKMSX4/o2xf6XT+S7jBDHzUwcc8PUMRbtlGoG1xoZ1jXxX2U/IujvR0JZKgexrH+86FV3KZ/L0=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2438.namprd15.prod.outlook.com (2603:10b6:a02:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 20:39:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 20:39:10 +0000
Date:   Thu, 24 Sep 2020 13:39:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
Message-ID: <20200924203905.GD1899519@carbon.dhcp.thefacebook.com>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-4-guro@fb.com>
 <20200924200122.GC329853@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924200122.GC329853@cmpxchg.org>
X-ClientProxiedBy: MWHPR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:300:6c::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a448) by MWHPR04CA0063.namprd04.prod.outlook.com (2603:10b6:300:6c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 24 Sep 2020 20:39:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:a448]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b07ff72-627c-4c15-184f-08d860c9e380
X-MS-TrafficTypeDiagnostic: BYAPR15MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2438DEB27F92EEDBDFABEB07BE390@BYAPR15MB2438.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZryXtDGI2qtTGJ5Qwc6cGns84uVKeXZVZ0aG3kOo6My5qF4pTkh0y7ypHzkKaalLHk+y5qQM0LvFR1QD9XdhTejlX7pRicdtWc0gl0vECETFZveiw9ICqVVQc3PsUdMzuUk2U4mKgkISvvELrdbBpscFHaCK+PSdu6yx7N35swAnuaxoNnZ+GNfVNKAgwmW3DTP2XSqqWg3sVNQnUkunXNIgLf8PlzFY8kD4Znvmq6IC8JMwhlBIBKOyKpog1/2v6YiRpzXEmgPOT8zw6HMkKixrDODW4MbF+nFsx1bmUwdLgGvwezi/9y7tFlAHpseWhFst6hu6O+cT6qHxP6UH9tF8N/98CZlh76MB2Lg1Mex4sKgO1RmIHec6HkgrILN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(366004)(136003)(316002)(33656002)(1076003)(478600001)(6916009)(8676002)(66946007)(55016002)(5660300002)(2906002)(66556008)(9686003)(8936002)(6506007)(186003)(83380400001)(54906003)(86362001)(52116002)(16526019)(7696005)(4326008)(66476007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xPbC2dIkzIJby1jpJ94v8bpsdzpdTS9aqeufic1QmSrJ3P6qmR47nK26wkUyyyk0v+Cj8lFv0n3XPLdTguNiidF8lHA+OL/gLSOeyughtcF+KSUayR+0pOt+FxJR+nkCa3tONRRPcljJxnn0SuTiqFw4frRmqdw2U8zESA4Pnj7LaumxhtTvFQzdLOt3ippGkIrKgeviD+d7OZxiqZTVYMHvgda2onOVSA0t/KUbHPF/dOvKoLdpiTN8in05sPIlTglTpnuL5kRPNG0HP2O7Q+W5Q534OGBXlFVZa6HRCQagox35skoLbmKwF2sFDJrfFtzLBFgnuhL0igDsFS7XQJ4MtTe5iZyyPeCmmW+M9oZVIWRMabjUFMNfPJ+zUqSsmU33Bx/lwlfb9LJgnZcaOk7lroNTGvV3ILVp0tku6BxAleTRHSGjOv4Bj5Er8MO6ELYPe0UWzwJNjDxKll0kn1duBvdYPdbptmwsFTdLSHkEuGy+/PNHPghl8TY3BQHcDGZDB83p4Qc6dqS3/81AocXBSOinTBrala8wOt3ZXtRmhNI6Ts7UC0yGtHXmf1rMqd1bmoYSfBePwcQkMffn+7B1DLcGgICOYhYQBdC8TuZI6FI/MSxzZmxRruSkTGZms+9nRTkNPUwp5pnBGuysru/OgAB9WAchNekYV+rKHzg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07ff72-627c-4c15-184f-08d860c9e380
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 20:39:09.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L71WkWl5slczURkkgJnM9Lz3s0RtrA3qmvbG60NwMbgjBQWEo57oPiKG2MTkJoYE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2438
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_15:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=936 suspectscore=1 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 04:01:22PM -0400, Johannes Weiner wrote:
> On Tue, Sep 22, 2020 at 01:36:59PM -0700, Roman Gushchin wrote:
> > The lowest bit in page->memcg_data is used to distinguish between
> > struct memory_cgroup pointer and a pointer to a objcgs array.
> > All checks and modifications of this bit are open-coded.
> > 
> > Let's formalize it using page memcg flags, defined in page_memcg_flags
> > enum and replace all open-coded accesses with test_bit()/__set_bit().
> > 
> > Few additional flags might be added later. Flags are intended to be
> > mutually exclusive.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  include/linux/memcontrol.h | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index ab3ea3e90583..9a49f1e1c0c7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -343,6 +343,11 @@ struct mem_cgroup {
> >  
> >  extern struct mem_cgroup *root_mem_cgroup;
> >  
> > +enum page_memcg_flags {
> > +	/* page->memcg_data is a pointer to an objcgs vector */
> > +	PG_MEMCG_OBJ_CGROUPS,
> 
> How about enum memcg_data_flags and PGMEMCG_OBJCG?

Honestly I prefer the original names. I'm ok with enum memcg_data_flags,
if you prefer it. PGMEMCG_OBJCG looks bulky with too many letters
without a separator, also we use object cgroups (plural) everywhere,
like OBJCGS vs OBJCG. PG_MEMCG_OBJCGS works for me.

> 
> > @@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> >  {
> >  	unsigned long memcg_data = page->memcg_data;
> >  
> > -	/*
> > -	 * The lowest bit set means that memcg isn't a valid
> > -	 * memcg pointer, but a obj_cgroups pointer.
> > -	 * In this case the page is shared and doesn't belong
> > -	 * to any specific memory cgroup.
> > -	 */
> > -	if (memcg_data & 0x1UL)
> > +	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
> >  		return NULL;
> >  
> >  	return (struct mem_cgroup *)memcg_data;
> > @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
> >   */
> >  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> >  {
> > -	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> > +	unsigned long memcg_data = page->memcg_data;
> > +
> > +	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> > +					       &memcg_data), page);
> > +	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> 
> The flag names make sense to me, but this shouldn't be using test_bit,
> __clear_bit, __set_bit etc. on local variables. It suggests that it's
> modifying some shared/global state, when it's just masking out a bit
> during a read. We usually just open-code the bitwise ops for that.

It will be way more bulky otherwise, all those memcg_data & (1UL << PG_MEMCG_OBJ_CGROUPS) etc.
I don't see why these bitops helpers can't be used on local variables.
Is the preference to not use them this way documented anywhere?

Thanks!

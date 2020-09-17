Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7566926E3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIQSf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:35:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgIQRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:25:49 -0400
X-Greylist: delayed 2170 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:25:48 EDT
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HGZr6p022757;
        Thu, 17 Sep 2020 09:49:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wjlAm6090lStdC7q1vlaSK+hAL2vFWP5F2rcNU6/7d8=;
 b=rnIyxb3KO0INvpO8QaDxgeLv3U/G/NsqRxmJj2TpyZxGVxjiJ+g290zEX/XIvHy0yJ+V
 GbMN0H1GPex2CE+r0ot2Rp+We411/m6O7d8rEHlnmgcBVCwH1/jSd6boyqlKcBFv+udl
 8nHuqQhso3DoQpSE/4J3p6OxRpXiuV/JHY4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5q6atdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Sep 2020 09:49:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 09:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+aZcdypp9mkHmYHFcxkFt09iQkqkPH064hUCZQaSq/00mUAXG81yyqRQhPeldvokaI82qu909IVnOLBzBWUItGu5cR4jCb1bgsgOmCwWQA++10As4GrriOXkjasN+JIKIfIbp0CvboMbFM6uTaPcBBwJToiQVOiCeFxHqWTisVJe58TJGWZMBHKtr8sQJ5S1ZGzFYML3GRGoyIxyrgwxQ8fYq0MgZoON89Uuse26SDxQzeGMFke5p6iFGs6q3j8bdhDJywJFDZFYEWJr7mgwcNohKNJ2yJasRjmcKGD8F58BhE49qlLunhhqIH7MCImtaZHBuSIGVjPvD7fOtthfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjlAm6090lStdC7q1vlaSK+hAL2vFWP5F2rcNU6/7d8=;
 b=Ap8wwTdgFhDMR9WfUtYAtlDiXH2Dem+bcliDzhVI1IZkpTfAU5cqUuJAyj2vrOA0D/M5orZxbdYbpucTNnQ/G7rQmg7QK0iZmYG97+MwKAVMjxsSnB2+v+o4Lc+0opPI4uycxjGDv9wuZJJk3d//048frJ8gr05N7xeNublyP/xkb+WL2fy/jGq8uqUzWhhcO1GPB+qUn1ygMf4Mbhv9iJmeHBms0pTs78cxWqEKllL7EwSZ/SwOV29RCDlJGL/T8KII0qkllG0dtCfKyj4zWcCwAwvu2yztJLJ9wG/UmKhnoeIB1dsA1B2CyMfZlUYpCyOUkrQzCQq7H+ZHnII5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjlAm6090lStdC7q1vlaSK+hAL2vFWP5F2rcNU6/7d8=;
 b=Wh+cKorOBVVW5TWp1bYGNPVmd1AW4OcBFFonBw+IrUdxabS1naiPLc9m3JoNYy2xPaqzcZVFVEU0KKXpzf2DWU1Lny1S3Q86aJXVLXytxaYhSsmQ5oh5GfEsCOygnywmT2IRNSSOC/r3sKPw+vNr5GrIF+nnbOIimOXgq0NC46w=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 16:49:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 16:49:22 +0000
Date:   Thu, 17 Sep 2020 09:49:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 3/5] mm: memcontrol/slab: use helpers to access slab
 page's memcg_data
Message-ID: <20200917164916.GA1583192@carbon.dhcp.thefacebook.com>
References: <20200910202659.1378404-1-guro@fb.com>
 <20200910202659.1378404-4-guro@fb.com>
 <CALvZod7qbM8iM0eafOWXEBjyK_K4HZLztyh0wtsVncnmHrotEg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7qbM8iM0eafOWXEBjyK_K4HZLztyh0wtsVncnmHrotEg@mail.gmail.com>
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a2cb) by MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 16:49:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:a2cb]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9f3d44-c426-4e9e-8c43-08d85b29a056
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25985E6604E744723712ABD5BE3E0@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NUL5L/h3ekzZZqXTuIse6sClqdZiW18oCbEIS3hZOQjy2NglONRrHqNqL62mAytQqzge8K1VKch0Pqw9c4ASs25Ori1FFJ1jbDLUyUcTK27vwGf2WXb/5m9oAASoa6OiOWRAv1hNVFN4vBCXPsLP0g8hv71Ie2Pftpo0yjJ7QSTKb/+bhunyVA7IlHXj8bGzLdKmfrZ8z6LDDe6rACMSpmY7nOZ19EQm/GpLEMOKlVjNSNcosooVJlYJs6nAFVDL2npJC9DmlRUoYZ37a+XOrzKsUbOQmn15PSf2j2/qLchWrKFhR9xKhEjV7KdQ2e/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(9686003)(66476007)(5660300002)(66556008)(83380400001)(66946007)(1076003)(52116002)(54906003)(33656002)(8676002)(2906002)(55016002)(6916009)(86362001)(316002)(4326008)(53546011)(186003)(478600001)(7696005)(6506007)(6666004)(16526019)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nVFqyQz9v3xSF4kB5qAnvq7XXEM+xwqb6ryiFCWPc5MW7Q6cIpv81u6eeeh6FWZ9xpVmdRTLNTYru5Tsbp+1Yj0/81ZzNCvrh6kdkmpg77QV2HP2AL+htt48lej2kUL1dCjlFzUXfVjhek68jVwshNWwB4ptKFmqLkIXT+uLg25wRafwBGCleQZ9wQUL6tNuMyVQNkpnZEyLJUHaEwaRWppnI0aoxEgKr5+RM0BDKyDXgcs4z5IttWxJi74PYXllHtq4mNWOJALpta79nTgse69vKeDwMqL+DIqcgWtOSh3yh2Wye6ppU3pLmgFAbu9s2BFLQngOGDyR5C7DKnMFAYvTzOaH9gMI+WxDD/0K0Tenb6DlCv/Ag5qd2M+qSDSar8KL1KMX++bwiRFGFlGEWvOtzWk7/mP7JMZtBdwxose4J6gnO6s5GNRP+F/4jhdGdR4apLAAOTcm3ZnuvipWGsptqNQx92EvxDqcLlmCoNHQ+xZ8mUWUKLUAVmPLDZRHC25cz+of0kpZB0OiE61stIvbuPO1ksJknls/gsbtQZ1CLllBrNYUWrBIsZnIv4ER5QNG3xFB1xZ2MwGWiq6onXgHSZg/3bRtghyXlQgEwZOPuqZ4KrTjwpVuY5BR42HtRk1y6vkUNysqPVZQHFXBFitVyO30bEtTP9LqgShdn34=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f3d44-c426-4e9e-8c43-08d85b29a056
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 16:49:22.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA7pJ26jIMflgd4OCd2jWGg90zh28Y7Lbqqp33cbtwccVeCGPEADm8Szv+Daw4m0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_12:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=1 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:12:37PM -0700, Shakeel Butt wrote:
> On Thu, Sep 10, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > To gather all direct accesses to struct page's memcg_data field
> > in one place, let's introduce 4 new helper functions to use in
> > the slab accounting code:
> >   struct obj_cgroup **page_obj_cgroups(struct page *page);
> >   struct obj_cgroup **page_obj_cgroups_check(struct page *page);
> >   bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs);
> >   void clear_page_obj_cgroups(struct page *page);
> >
> > They are similar to the corresponding API for generic pages, except
> > that the setter can return false, indicating that the value has been
> > already set from a different thread.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Nit below.
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> > ---
> >  include/linux/memcontrol.h | 48 ++++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c            |  4 ++--
> >  mm/slab.h                  | 27 +++------------------
> >  3 files changed, 53 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 0997220c84ce..48d4c2c1ce81 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -375,6 +375,54 @@ static inline void clear_page_mem_cgroup(struct page *page)
> >         page->memcg_data = 0;
> >  }
> >
> 
> I think adding comments on these functions would be helpful.

I agree, will add.

Thank you for taking a look!

Roman

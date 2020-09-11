Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B70B266A20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgIKVgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:36:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgIKVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:36:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BLR7Qv031713;
        Fri, 11 Sep 2020 14:36:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aLqTTjQ5NWV2mSbfvmY/twTYytoZQtJttAAsTr17gCg=;
 b=PfV95E/2tjPKQlPFL6jUj8E2jp2u/4oksOa4BtzfE9zZFX5GIxAy8EPBw3ulgwUTk/Xl
 4wsYMO1Kj9YdvsH61z7MCfmAm2jzJfPWJEojbJub7svsyRJEJBIU84EruPxRZ8ym+EQR
 ItcXmu+60Ex0NkyyuaQj6wqPlH/Aaha9aC4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33fqeeyu84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Sep 2020 14:36:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Sep 2020 14:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH89m/efh9XURRTRMTZT+Tcv1LtDeE9jwhNc23fdkzeRSKTTwEj1L2oJbtzRpS0wG5sknxJPlY/j7nA7eSJwyiOKiaNORzKHJyRFRclvYZmVvRB/WPk37K/w881R8Fr51scvAd/s8X/sCnmdbbIeuRIy5pa/uwDFe4/XnS3O+LArL1kR8/kz1jTIbt4VsTdn+DeHGajLt+Hrx5rnM9moFfiMXCa+fWFq7Jn2Vu9X5wPMmKNOs9jXwLqNdGYCEwId5eRH1tobpLpap00Lz7tCbJkqUfB1jbttTLkORjTPcurBfN9KQAFi1zbCDEt/gkWK8N3qwntM7v3wlnIdLPJ0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLqTTjQ5NWV2mSbfvmY/twTYytoZQtJttAAsTr17gCg=;
 b=L4rGXZDMXf7j5Xuk8WGO2ICK9b46Vn+pM840zX21RUi1nuukTty3gCxDZgEgk29mDEJ6vQe9mpRyDfvPjLyqHGycpHwqtkZxF97fH3SwzLy5bpVJOiv/RmMEcBf/cEwKyHbMKkmd1dzMKtzHIaCEKB3HYaDtGambbcrw2t+aRHJNFlF9cZdVWqB2kLEDflYWqXUi7PpnhfB3VGQ50kmjKY3JVQfACn/6mvOYZKamGmQYZ9OSdtPuyVW/zjFBUy/JALoQwoQa5CmyNKqjQhacTQh27vbjZD9127sOCMvZ63GBT8S/jfWY9pHOWYKDSgiSJFZ/GfTnaTFNUTqVjScB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLqTTjQ5NWV2mSbfvmY/twTYytoZQtJttAAsTr17gCg=;
 b=GFZfGZdHESoZDrBJQGMNvrRB6QIExE1EeKWwH2Q5OrH9IhJZvnSGyk2T+zPSXoa9gw+Jqp3FNnctMt0YvZSJsRDz2YydcTpPoJPwdMJrI8iX1Yck9htdUSN+mqqprjWlzNH4xudB4VyJjM3fOncuzcBMunYpNGRd9bgNfIN84TE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3652.namprd15.prod.outlook.com (2603:10b6:a03:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 21:36:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 21:36:06 +0000
Date:   Fri, 11 Sep 2020 14:36:02 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/5] mm: allow mapping accounted kernel pages to
 userspace
Message-ID: <20200911213602.GC1163084@carbon.dhcp.thefacebook.com>
References: <20200910202659.1378404-1-guro@fb.com>
 <CALvZod4-kiW6ZsL0EUuomrxxJqhYzmbsY7phqBs2WcT_A6Q-Lg@mail.gmail.com>
 <CALvZod6BWYo7fy4f23e7CnkoAxrjwx8QNFPXZ43pHnzcKBWgRw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6BWYo7fy4f23e7CnkoAxrjwx8QNFPXZ43pHnzcKBWgRw@mail.gmail.com>
X-ClientProxiedBy: MWHPR12CA0052.namprd12.prod.outlook.com
 (2603:10b6:300:103::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c003) by MWHPR12CA0052.namprd12.prod.outlook.com (2603:10b6:300:103::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 21:36:05 +0000
X-Originating-IP: [2620:10d:c090:400::5:c003]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc45b8f-ae0a-496f-3b4a-08d8569ab0af
X-MS-TrafficTypeDiagnostic: BY5PR15MB3652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB365271DDFC6C754622A2CCF1BE240@BY5PR15MB3652.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgbccoXXXs0pacY13+9XUy4f/8oQ60YdOAnB40bvE/VK9VqSrthJjoqEJZVj9qoI/sYRcdtP8kW97oxiuLagL33tXuP+HnH0hxSgmQZc1sAi7aPZ6yBWehqt/dS+yrZc+lF826r7IFJ9vOP3bB2qWYtuAfaThCbRTjzasFv7U7TR27QJERbQjGs+nlLN47e39Sbc04kpCtxR6JSe+1aWMvoDT5g7vJISvdWxDIGFClcUoAEwTadG6BIAMuvwGUDdTjZ9xKtQ6Psjf/+IWqDpu3KZIsu6yPhFSa2RAEEJWHDPLs3/1Q/3kbjMlTl/kBi2OBG9Ogc80jd4qROoznDeP8dMvaYHjsnTS9R2UZk9mMmJ2iZ4cf5LAyi1qvmkHjAhJ4iC4XqOLsV+TnDIN6TD6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(4326008)(5660300002)(53546011)(6916009)(6666004)(33656002)(966005)(66476007)(66946007)(1076003)(66556008)(6506007)(15650500001)(86362001)(186003)(16526019)(83380400001)(478600001)(52116002)(9686003)(7696005)(54906003)(8676002)(8936002)(2906002)(55016002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CAk/r/0LCCSh0Hh7Uznr8OvaZohgoJmFSPM5ozQxO9ku2kggAdy1jocIZxXIdJPcc8lj7klCRHUKFvltXfKoWFp8ovmKxpKInM6kHgMlsEIlBm7Uj31BejhzfRhvDgRRp5JaStEmhjvZ8TxOqXAVVJpcwYm+Sq1JbpSF5QFPl7LSXSycwYbuTeiRk7dglb4cdHDvrkzvdsibzh0Nb+fKL8ZwP1PLjUWC6boDgd+IXng/7BjSq2vy+iI9sos7n4N/F1nWlFWNNWTGTqjV5PTwoXS943R9xs8POrH4ui//PhfZ5YjkiYV5CIcbqsp5YVS8J1Tydf+piqtqZLCCNp1v4HbS8NqY6kLUgoWh9LqvXJcY5/MnCJa1+Hi2OQ3AnhYm4EymPPZkNck6fdWmGXlnLMAW5A+4sBCYAFTPbo4EZgsQjLpExddDUjskOgsuSgxheE2oAX0rae44/8hE9FXmC8H438h+dzbkXPdxU/0JTqlYV40Vdhnn4o5EdRzN+1w5/by8F1dEsZ8VEE/VrIJ+Fp/sXqU30CGBcTF0zsSjc/XItxJ+PbjqdDyKb6g9Lxjd2jTaOvs2gVnK9R0cg0wcStV+ctKby6uBxvO/4eUwpV1BEvGgHxPAkAXOQEPl2SCqA2FPoe7V1Nvp9RWMJcQCbIvLpQ12UUj3JzE9pmZGtp4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc45b8f-ae0a-496f-3b4a-08d8569ab0af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 21:36:06.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Xt6PG8AygG2lEZi3zOHqw/A32x3SblwBsxRwyAHwG2r9odoH/iBWYYRNnZJyO0A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_12:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110175
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:34:57AM -0700, Shakeel Butt wrote:
> On Fri, Sep 11, 2020 at 10:34 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Currently a non-slab kernel page which has been charged to a memory
> > > cgroup can't be mapped to userspace. The underlying reason is simple:
> > > PageKmemcg flag is defined as a page type (like buddy, offline, etc),
> > > so it takes a bit from a page->mapped counter. Pages with a type set
> > > can't be mapped to userspace.
> > >
> > > But in general the kmemcg flag has nothing to do with mapping to
> > > userspace. It only means that the page has been accounted by the page
> > > allocator, so it has to be properly uncharged on release.
> > >
> > > Some bpf maps are mapping the vmalloc-based memory to userspace, and
> > > their memory can't be accounted because of this implementation detail.
> > >
> > > This patchset removes this limitation by moving the PageKmemcg flag
> > > into one of the free bits of the page->mem_cgroup pointer. Also it
> > > formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
> > > using new helpers, adds several checks and removes a couple of obsolete
> > > functions. As the result the code became more robust with fewer
> > > open-coded bits tricks.
> > >
> > > The first patch in the series is a bugfix, which I already sent separately.
> > > Including it in rfc to make the whole series compile.
> > >
> > >
> >
> > This would be a really beneficial feature. I tried to fix the similar
> > issue for kvm_vcpu_mmap [1] but using the actual page flag bit but
> > your solution would be non controversial.
> >
> > I think this might also help the accounting of TCP zerocopy receive
> > mmapped memory. The memory is charged in skbs but once it is mmapped,
> > the skbs get uncharged and we can have a very large amount of
> > uncharged memory.
> >
> > I will take a look at the series.
> 
> [1] https://lore.kernel.org/kvm/20190329012836.47013-1-shakeelb@google.com/

Cool, thank you for the link!

It's very nice that this feature is useful behind the bpf case.

Thanks!

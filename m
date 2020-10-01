Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888D12808D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgJAUv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:51:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53848 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgJAUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:51:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Kf3nn026084;
        Thu, 1 Oct 2020 13:51:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5p8vE2YoaEli3xIwppcllzWwwCDVPaBLf4x84fbPgHw=;
 b=m1SKhLiPuXgKFrA5NxVkEssMTKRJM9NWYMZHuD4RqLYr8zRMcLlAUTHUz7jf41OU1ZqM
 ipmbvX8M5/auOdi6Bh41YvTeXa05ZAns7jq+XeDbiYsKxklI9umlffUbyAxmstq7jMrx
 dMEhgNjXG2fqn2Kg7ENVxwLy4NqPmUFbtdA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33v3vu7bm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 13:51:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 13:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZg6eaNQvg3heHQN7PjAvSHBm7yW5DTWSnPqJjK9q0v0VBmEKRK5fke5SHAIGUBrHCYq1wJCi8ChLiRDyKUsanSXIuOSvIWEfZZr6ajEvuRDjCzklOUs1zZWFLRYC3xsqTdsdLG+qhZjF3V9m6DwffXowDUYSfC48jDONzAcE0ytNjey+M3sDSQrs2v/TFIPxVWiw6XLjZg2+b8Vdl+QPq91V7KeV8w6yetwmpEhJ42v6m8KKeZFoGQJE8O0cqo+HVWKpFJw4YP6HcRKhJuKaJQO89JwVmCS+ToEHjumkhqQ1zn+mBicXWat6tpWJ1sa/SOqK7KB8ZWsBqmGKI3M3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p8vE2YoaEli3xIwppcllzWwwCDVPaBLf4x84fbPgHw=;
 b=L37aSSVdQmXqxHbYwqsUS0R+fhkgE+l4KyX8XhNxtrHsiHz/mvGfNA9C1nA2NU6E64p9kVrOfeiyjzrjnRf/1k4qDwV1919sk7anFyG13+Nj2wN0vgOY6iLYNrn6TAqnflHu4+2Qo6Uf74ikv+TO6RHN+VEjhPg+6qRx+9lVBM+A3ty5JMGn+gj4Esw3t5DawckECOYdRW/cehmTIdm5IC8OzQNvCF5kx2NZwHp/mWmA4/QL2ez0BgV0s25lFTYMx2iASUT3sf4MSDXjt0xC1VdLvPnnc5gEKbpE7/4R3WpE/DmbkIevKirIDWVYKX2R44jAXDcvoDx2A9VV0u03kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p8vE2YoaEli3xIwppcllzWwwCDVPaBLf4x84fbPgHw=;
 b=dQS/cFfNQO2/vf7YX8WuzZ/vRRQU7FL6TcENCXFZyPKQItgYgWP1+3Pk2z1thrnHTWag0l5kdHnm17T8C0x8hGOqfANFkNuVxf+k44qOy4afZQkTdM4xowXgpELWtegYTsRQB84tV0ZlLyQ61HNxAIPh2/cVLJSAbFo49etCNew=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3791.namprd15.prod.outlook.com
 (2603:10b6:806:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 20:51:48 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 20:51:48 +0000
Date:   Thu, 1 Oct 2020 13:51:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v4 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20201001205143.GE2706729@carbon.DHCP.thefacebook.com>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-2-guro@fb.com>
 <20201001134638.GE469663@cmpxchg.org>
 <20201001182739.GA2706729@carbon.DHCP.thefacebook.com>
 <20201001185950.GB500308@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001185950.GB500308@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:9157]
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9157) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 1 Oct 2020 20:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0fecf5-fedf-43af-74be-08d8664bd0a3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3791BB1E345232597F043F06BE300@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8L7r3Qzm5Duawh0Zi5QJ14PSD4myZg5UBkrEt72fw5+0U/DlgulgQ4IoPGP7aSPP6IQGn3MR/wHvUeTtWQxRfaKtOxPoT5/0hpXy825qk8FLg4o4TC+9I4xuyQ6RuEcAqRd5ZNUJPhSmAtfsE5ogc9WvAIM7K63FcFcKfU7FMscvKQoRRXWq7x1Gri1ruI50wPh/kz+GGjGqwZiyw6JzLzm2p7YUtEJIwFi0vw02jIBbotIjYnbK1as0uTdxqhEojdo2ByjHQoMH/fds+a1sKiFS4gjFJBtGTBNW8Ns0PT1E9wfgdXbJX0M/iXBnjA0XzK6uTk+nUJVSFK3zsJLdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(4326008)(6506007)(83380400001)(8936002)(52116002)(7696005)(6666004)(1076003)(5660300002)(478600001)(186003)(86362001)(2906002)(66946007)(66556008)(8676002)(66476007)(33656002)(6916009)(16526019)(9686003)(54906003)(55016002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /ZUBXfizEwn98rEBo67ZMfpV2f6UzD40dYggjJd6DlM/BmRKQo/ti7yODXIhFlsaJbHl5RFlm9fdltP1ewSXfpZWlJyn79YR8Yi3ITrZaYirPFUS2P4Geq7T3tiF0ZKHk3MieRJ85RLuuKPX0HpGkbmlo/hnRHcSNCfMbmKvgFF/Iwiz9R8P0ayU+4fxLAuXVx8kG4anDuctgO1VLQADq0c4XYlcv+cUiBKrFG3WNzCTUAx3Iv70QcWMw7IYhj9jzlIRRZcoJtEMJahAX8OePYMuMdqNDL5hxowsS92fH99fo/EF6rrt1MaxTo589Pp8aM88aZQQWoZOdmWz5YkKq/TG0UxzT5Wax9VmsJtjUJBv1Bw8x9zWvZn2axUS7eYtGskU8tJT3JjvfxQy+UwBulvYevKzMM+48O1K7ZhKWOVQ/5dtvaWG/XB02M9pG5tntUqbHltlafkpHDqERvZhcDGEVdOam2Cjk7+636+w0JGglM9EykzhF9q3Nn8gQ358EV0LhfoUELNWOjNvjMmcbV3K0cz2zXxm3YfjVZidjEB1I53jmsmDlPbm90IL8ccJyAILSWDO1I5fEzNtvLotykkKn1nsoF2W552mltHR0pXHSBSv+pd5K6rKkTIrkRtV+tLUEuDF/SoP+VKcvfD/+/VCryVccmUCR1nl877flv4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0fecf5-fedf-43af-74be-08d8664bd0a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 20:51:48.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bReomKAtbaIIy/bxmg1WOZxyNnfsL/tcJE8XoBHIVO85JHYPVmzKudomBlIiLV1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010168
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 02:59:50PM -0400, Johannes Weiner wrote:
> On Thu, Oct 01, 2020 at 11:27:39AM -0700, Roman Gushchin wrote:
> > On Thu, Oct 01, 2020 at 09:46:38AM -0400, Johannes Weiner wrote:
> > > On Wed, Sep 30, 2020 at 05:27:07PM -0700, Roman Gushchin wrote:
> > > > +/*
> > > > + * set_page_memcg - associate a page with a memory cgroup
> > > > + * @page: a pointer to the page struct
> > > > + * @memcg: a pointer to the memory cgroup
> > > > + *
> > > > + * Associates a page with a memory cgroup.
> > > > + */
> > > > +static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
> > > > +{
> > > > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > > > +
> > > > +	/*
> > > > +	 * Please, refer to page_memcg()'s description for the page and memcg
> > > > +	 * binding stability requirements.
> > > > +	 */
> > > > +	page->memcg_data = (unsigned long)memcg;
> > > > +}
> > > 
> > > Please delete and inline this as per previous feedback, thanks.
> > 
> > Why it's better?
> > It's ok for set_page_memcg(), but obviously worse for set_page_objcgs():
> > it was nice to have all bit magic in one place, in few helper functions.
> > And now it spills into several places. What's the win?
> 
> set_page_objcgs() is a worthwhile abstraction because it includes the
> synchronization primitives that make it safe to use wrt
> page_objcgs(). They encapsulate the cmpxchg and the READ_ONCE().
> 
> set_page_memcg() doesn't do any synchronization and relies fully on
> the contextual locking. The name implies that it includes things to
> make it safe wrt page_memcg(), which isn't true at all. It's a long
> and misleading name for '='.
> 
> Btw, I really don't mind having this discussion, but please don't send
> revisions that silently ignore feedback you don't agree with.

I'm not ignoring: I thought you was looking to remove clear_page_* functions,
but it wasn't clear you want eliminate set_page_memcg() function. Please, when
you asking for some "style" changes, please, provide some rationale, it's way
less obvious than you think, what exactly you don't like in the proposed version.

Thanks.

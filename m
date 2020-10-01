Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8BE280694
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgJASal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:30:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46170 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729412AbgJASal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:30:41 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091IOgAM016495;
        Thu, 1 Oct 2020 11:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QywiLy+GoFsQX5t2c9RiwK0yDMi63PjmpVFdJbe8qpg=;
 b=nFvjD6J6O2TwrlgiHYdHmOtjMCL8iZtSktmSo2bQlW4paUhAD5IfLpQNAGXjE0PXK7P1
 Ep8EGcEAhvE/EidH+cFdwrsGYu9E+wCqnISuRo0/w6vt2aBMHVPB9wPsEbfgZnFmd/7a
 BKVkm9bo9rwgAgg8FV+tEckmFmgfK7ykaF8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33vpwcs79x-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 11:30:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 11:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8uLApN/ckTXhwd/NQDJX7bog4AA2gZLJKwS1wBWqT7k83ld+KadcJ4ihurnz9jkBk43RkWcdIwoMFBQdhtkhFBBtxLapLNU3wjEsVgFsXhCL6IEYWr0aI4zKSa4+4MgtD7fKjtoqNpmvJEyj+dwomQC72GiU3PcKFaB46/hwjnjlo2+wSikxgSqJIpQCNx+JjTfjMPATn28UsPJieXbtjjzoL8m59r3vH5AjjyADWBGSLjOFv30GzCh91W1orxKSz/vfD++nQrQKN7GR7tvlcBCpmBK8xq2gptZSVYG0GPwMN+Re/XldhFud1kK2ldphXq94eNTXPEZXtVC2iHz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QywiLy+GoFsQX5t2c9RiwK0yDMi63PjmpVFdJbe8qpg=;
 b=RDKf6tZSzp5ABETpxZBs+YM9KnXi1BFPZ9PX9TjkbgJ1myKeBPWPePyfPEQJO3ZZLJaJU9LnzDwiptsSuQJ9yZcpIANw5TOhttL/CbnzAAj8T4q0lWinLupJ0/0g369wIgL4NeLgizopmc8lh8OdlZfXixZuyGd34u6WckIEnMiSJ9Lb0/XhIOorRrb9v/PD9bd1ET3ld++WjcCV2MfZB2z8WUZarJTJDNTgWXiB04vB2VKM6sdMoTPdDET/lnBA+o4AFlZ/9Skh3GjDz0Jd74/fTn9RxB6ZgxPxm6OoiMDRYhZ90BNtnlMSSRNIylLyX27zby/cwyIX+24ik60oKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QywiLy+GoFsQX5t2c9RiwK0yDMi63PjmpVFdJbe8qpg=;
 b=K2KLznPNo0JPqo+SpaKJa6itYXlbCmOerhl1yeT37kZFkDHRPew6Ol4LffiewdytnEcVABUAT8oRGsqAaQ+mXuQBWi5fyZ6BCiBwQZkVKyCw+Eq+6hVLAo47+ThE0qLYo95JARSexnCv/8Cd+6gaCAE3YP2+luzKYlSGhMuMrHc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3872.namprd15.prod.outlook.com
 (2603:10b6:806:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Thu, 1 Oct
 2020 18:30:18 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 18:30:18 +0000
Date:   Thu, 1 Oct 2020 11:30:13 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201001183013.GB2706729@carbon.DHCP.thefacebook.com>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
 <20201001170036.GA29848@blackbook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170036.GA29848@blackbook>
X-Originating-IP: [2620:10d:c090:400::5:5d5]
X-ClientProxiedBy: MWHPR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:300:93::30) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5d5) by MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 1 Oct 2020 18:30:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a81dc5c-43df-4648-971e-08d866380c00
X-MS-TrafficTypeDiagnostic: SA0PR15MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB38725AFA2D3D52B3106D693BBE300@SA0PR15MB3872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAeFTxW7XoEunADVqv4v5ajmsml4JhypcyCUstDUdwiR1SSBol/sRRwSW7dpIQjyKlPAliqwYuNhyvb7H9gPi4PQWxGCA4SMaoewyXkrG4iyEb3lCVodOzXkGiq6cfyhe6wI9TDmVQEBlF0Ll2PdGiVOJtQwTPhN/ZgDpRobDbLKJoEl9ocTSAN95N2vUQ/OkZyuPPMz7nvQ/0hnWdPEUQ5WJbW33ZgpTiaqXEq3tqGoquzn3OuUwUAwBro90i7e94wjqGyGcwh6wNYKQsYaniwEI7vq5FT8XPTeUAY6Ze4+hvhUh8ccbtFM3R8xPRRdWtp86y5SpDc1R0I4+KB6A0xORvoG3mDzLwyxTg98ejJXptOEZ2dsU+ZGjB6qYj64
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(366004)(136003)(6666004)(2906002)(16526019)(52116002)(83380400001)(8936002)(186003)(6506007)(66556008)(1076003)(54906003)(86362001)(4744005)(55016002)(66946007)(4326008)(6916009)(8676002)(5660300002)(316002)(478600001)(33656002)(66476007)(9686003)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rIvSkFu6AirNDWNZg5q/IUsdh5Zo9brlIUvGPoz7ebBFtGoz3mnN31tUtWa1ExRRMNMQMq7XeLTNjhdwhs+ZUtEHIvpx3r1e7GwOcx5wiLGcY5u9T1FD4weju/XLMbiBt448ezLvCTzgzCfWv2jd7gkfL3fNSRtL9DZcr4U0g4MMytGHOid5L1EUhSsc6pJrvX0pkigvv8wPn54MeWeAjQAZd3M2kFF4qbNM4t/8kBirj+gAdkiuZKmHnAPxTY9AxFxfX3vT3xKOFAKwxj2YRVhdPqUwGTBWV9jvMGQWMpvwzRHtzbV6fqoeC7BJeRyyGDwkve+U4sEaQpj/42TbwI/MkjG7Z0NdPvqea+nKrhkCdhhn3tZB5wcu5jBdb5wJoo9O2rBUI5rubRFJeY+c3gvoXyx98P8zB/OWyHRovdi+YNw8Ai4v4nKyLYWcq4trBsOkhPWD/Cc1aKmEreoKIimz8wGOvdtBgN45+/c+S8QXUbKRntdn0DNg6E5iLRE3Zg6xO0+0xnMmrhA43P5D8pYBSaqmhRoVxUf7c4jsKxOfs/x65OJkCK9XSrpbY+j6vR/N1WsNzSt9wcuUjVoi3qSEQiwKghU3tHxWeb9DG7oPKJL06birLJ6O2E4pWWSWqKRuDzXI5lVmCt8uipGibBS1WkrJ3QZHy2WdzMLV/SM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a81dc5c-43df-4648-971e-08d866380c00
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:30:18.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVmwyY4lUp54LsXJacvIO8QPyW40LEXd9H92xFSllvZPybS7B39hEaTHOcbzd+uo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_07:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=1
 clxscore=1011 malwarescore=0 mlxlogscore=986 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 07:00:36PM +0200, Michal Koutny wrote:
> Hi.
> 
> On Wed, Sep 30, 2020 at 05:27:10PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > @@ -369,8 +371,12 @@ enum page_memcg_data_flags {
> >   */
> >  static inline struct mem_cgroup *page_memcg(struct page *page)
> >  {
> > +	unsigned long memcg_data = page->memcg_data;
> > +
> >  	VM_BUG_ON_PAGE(PageSlab(page), page);
> > -	return (struct mem_cgroup *)page->memcg_data;
> > +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +
> > +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> >  }
> Shouldn't this change go also into page_memcg_rcu()? (I don't think the
> current single user (workingset_activation() would pass a non-slab
> kernel page but for consistency sake.)

Yes, a good idea, I will add it.

Thanks!

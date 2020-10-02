Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45F281A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgJBRwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:52:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388330AbgJBRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:52:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092Ho4sp029994;
        Fri, 2 Oct 2020 10:52:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kvluGJLJlqNCam3D1dG/JC/Tdeahwln1fGq3Ika+wpM=;
 b=ECc6/AVDlDfTz1AT2SHs2Ah8SsWCHbp/6FneaIj3AxCh2fAI5c/Wcvv5kl2NjCmOHMrS
 1UPgAszc7pI2ZV/etxLIry/5urDElWPf4ekjEjecZKRNaYQDPpErT7ktW50TsTbhksAy
 +vfLOrvspI6g5gb45x9zukMpAIFJdfqvz+k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33vwu3mbyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Oct 2020 10:52:42 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 10:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4CeTkH/Ycer+oEcqFn4stYAfoyaw818aVtO1vd30YHN9NuQBQJuIhwqvUBC07WBuOJFnsuSZRnFiecprV169v7IojwaVZLzfSfgDO7apiPZhzkjr+rGPpUmkklFwbQXbfjsyDl9qqk3g5RIfd1sCNAluZJnBYVMSs2lMOChDTc+FjVfG1hbdp/2YJa0xRMpyzdY3T2LCfsvX4+X+2p7g79D6h8f6O8jzOzfVBVz3W3geWD3B2G2SkBQDZDNp1Z6sC/yEITHPowExpO/B40fRHdxG6i/a3KK18WxdOW4rgNVPGyjtFbKmxa4QkCQv19lSrffXrhh1ubghEAgk4Z3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvluGJLJlqNCam3D1dG/JC/Tdeahwln1fGq3Ika+wpM=;
 b=kQB4fP+HVLtmrqJ/W9GDXiUpN/t9blWVdRNqRx6UXCwCSiTVN3lc3fJbndpxA6JexcIDmMab8Egf0KNEknLbWwx3FqkO7yZ2oRjMNzaJgATv1Y0bUFRgk89auDUmSgEBCvRZzAn962hhFlJMEw5kn0tAivSLW3xUiISwqD5Qi2NgJOuPgxAkmgeKpEzrFKCUY3PSJsLyuGjDBtsBZWGp65ywraseAI2myEGVijXhiORM1eNq8P0ODBXK57+bg0FelGO3q7/e1oLePiChbHSkjBsTsXsUqbfVtZhkxW0M/10Ggao1M+o2qTMZsI/e6/SmwwVgsFOyukRuNK4UWN1DyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvluGJLJlqNCam3D1dG/JC/Tdeahwln1fGq3Ika+wpM=;
 b=hbCfkC6PQtCDBhQ1BR5IarYlXeiwbTAeeHyb6vgt6qYC8uCJDqazS6VIXXrmCsxu0ZIWM+yu6I9h8qCG/RC84xQgTlmxtQfFloO8jHm4hEki5sj29qL19er+Al12fQ/R3KJa7hA0mte5+uc8N7lXKrhaX/VFg2JLEG3xFbXVBok=
Authentication-Results: npl.de; dkim=none (message not signed)
 header.d=none;npl.de; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3774.namprd15.prod.outlook.com
 (2603:10b6:806:89::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Fri, 2 Oct
 2020 17:52:41 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 17:52:41 +0000
Date:   Fri, 2 Oct 2020 10:52:36 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Bastian Bittorf <bb@npl.de>
CC:     <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported | Patch OK
Message-ID: <20201002175236.GA2954069@carbon.dhcp.thefacebook.com>
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
 <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
 <20201001195610.GC2706729@carbon.DHCP.thefacebook.com>
 <CAHk-=whwbrbZbdqpXVd9LOG=J04BEVZcT+vT=nXry=XP1JWqYA@mail.gmail.com>
 <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <20201002070114.do3xmia7sbsnrx6h@hp-nas.internet>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002070114.do3xmia7sbsnrx6h@hp-nas.internet>
X-Originating-IP: [2620:10d:c090:400::5:a91a]
X-ClientProxiedBy: MWHPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:300:d4::11) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a91a) by MWHPR19CA0001.namprd19.prod.outlook.com (2603:10b6:300:d4::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 2 Oct 2020 17:52:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf51ff91-4b35-4cbd-7602-08d866fbf521
X-MS-TrafficTypeDiagnostic: SA0PR15MB3774:
X-Microsoft-Antispam-PRVS: <SA0PR15MB37741F4CD57FB53F84FCAE68BE310@SA0PR15MB3774.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbHbhSU7iK/vGyWpMa1y/Dr/9UHOiUMkQ0OOHReCJUOoF7X2OJB/ZFjOaIIOzsE140gPYXeUZuEI18o4jgs0JShuRYEzr/0vfciLy+rX4cYmq5YHcnUescpPG8f/+wyC4Stzb95n3U11edcSVO6kAQX5kUh2vQBETPIlfXcoXqAZeyZO95Zfw1nUvt6YqRkVDDHM+7QlC5cImiv1i8ZCnOhq0tuI/Ph5vOh5Id/1OaJEgiDWUtvABnEudTn1p8It/479v6XjaKVmFtvk5OcXEac1NBHbeNiws1txFJrK4/Ne3+aTcqH20fG1zuBzID3I4J1jqJJ50PKqlcYQFpnoPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(8676002)(8936002)(6666004)(4326008)(6916009)(55016002)(316002)(2906002)(478600001)(33656002)(86362001)(52116002)(66946007)(53546011)(7696005)(1076003)(54906003)(9686003)(66476007)(186003)(5660300002)(66556008)(16526019)(6506007)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: en8YHU1+ZJumqAMZu/heWaHbZiN6hxEr5rLIX9ymQ9kw92x6uZJes/4lT7pWjwSYG0ACGd13WdgykyBw6IhavYT3s9QZCFFv6avCxURSmtU7nL190r/ulRHlHKq1F7Z19//mDTF2+raMorhYh5T3jP/wGN3oDD0sHTBEbXwHFyhySMOGKHKhhRYlHv0ICOlbamrIcksSiOhj77duJ+MHlBAnv61e0KrNyrndAMp3dkB1xcoV4udtPYRyUjxDRmWScjtrgu9MHRqgKMjY0uV0JBYuM9Q8o3jBzlK2G5OUNezf/XFPRiwdcL2otJbRq387E6BQZlaiQb9+Xq5sr0F1vWLDa3iQ7rWy3OvKqyeGFX9of1O5IZHwW0bgzXUl7cFO36eJHrFogW9G9ywBDakZmkfglA2dhKEt/Iiwbel/KhhuDTPd6/SKkzdOOPZka+dBtU6wNrxW3sifN5qbj30sVHV+o3olShZmyeuTQ5SMGaXNVbQK6cv+kYXYA2adc//APdDT8rcwt0eGzDSv4rkqoOuLvJkQZ8qOxcts09STX+SrJa11V6t2wzn7/HhVLLpcWxxyfk/R7oKwrZKSxZ3ouQQbpczovwEJhFcevRER4bNQi8Qs+xDM52AWA0LjaxHnf3Q0ihd9wTu3zcWwGUUJLvltjQNyiFJqVuDnqxDfv2k=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf51ff91-4b35-4cbd-7602-08d866fbf521
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 17:52:41.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J89hU9/m0fRtrdWfTe3Pz5Zh/CdloIcH7NKTKzK82i8mDoGr7JHUM9mqTmR7uDpG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3774
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_11:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=1 impostorscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:01:14AM +0200, Bastian Bittorf wrote:
> On Thu, Oct 01, 2020 at 01:39:31PM -0700, Roman Gushchin wrote:
> > > # Processor type and features
> > > #
> > > # CONFIG_ZONE_DMA is not set
> > > # CONFIG_SMP is not set
> > 
> > Yes, here is the deal.
> > 
> > The SMP-version of __mod_node_page_state() converts a passed value from bytes
> > to pages, but the non-SMP doesn't.
> > 
> > Thanks!
> > 
> > --
> > 
> > From 3d0233b37340c78012b991d3570b92f91cf5ebd2 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Thu, 1 Oct 2020 13:07:49 -0700
> > Subject: [PATCH] mm: memcg/slab: fix slab statistics in !SMP configuration
> 
> 
> I manually applied your patch and
> this fixes to issue on my side too:

Thank you for testing!

And sorry for the hassle.

Roman

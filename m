Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ACD281A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbgJBRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:55:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51946 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgJBRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:55:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092HmcRt012325;
        Fri, 2 Oct 2020 10:55:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8taaSQsiwnMFnmks5LX1aMKeJdKpy3vnkzuKa9oK2Bk=;
 b=YIKfGhWyncAx7pbUg7+/OC4DJvitIYB1658YvdOOBya2asosG2R2OzGHTw6J2mpS81QC
 Jp5qZxLnXKL5dXS5Fax0IoHciP0AQbSbhLFWJeIW5xZkvxOupqeD4aioUUcGhTU+cMNi
 LVDHsQnb71VmvSNGFwjWmN+9Y3xRJRyKnlQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33vpwcxq7q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Oct 2020 10:55:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 10:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja9YoMmn9FX5gK9nDm0sXDtWYgF0L/f7u2HwwrDkiM/d+zRskGzH7lWVwSrpScqV3IYiynGZlyUo/DdL5kitNZYZ/R8aqRSwdR0FE9ioQDqjsm4cULUn9+I/ldLmquIAuz9FNBkJfIR8Nzxk0QF7dN7nqyj3bzXlgQr47xg1LDTHXWIs3swcyJoz+04iSvBY55QtLBuyUPBCG3XFLlpBVIB6KJYhwu5eKpWuPHglDFOLhC4KN9kVD0YMfp27ImAg9lrYbgv026a82XBdHckyR8WuoBo2zgy1N+76w+bW3eLAgjC+hG+/hh1XRPpDlFMfXLnFG5BfcGQMv5u6avu4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8taaSQsiwnMFnmks5LX1aMKeJdKpy3vnkzuKa9oK2Bk=;
 b=Jna71oPP/Y2Wo3KBwnJ5GUCXkt+BF+3EscrVyPebRrdI7Mb5yenU+GkH6Loako0sO7E0QwLSTfvfkq8p19G3Fzy1H/jV3XdkZBSbxa5hWRyWU+yeWw9oGn20QGoo7L9RRBIt5CRulupd7/fD3Z4ViIelgaqPNb3aqMN9SjCtNVI3SDOXrOclGTanlKpI9VZmTRjpfS6EifRZGskrHU58eUFrYaquYzZN9dI51aghoLDTe0UdveSBDMgqCDbXaCI5riLFfkUNMnM/Dhsfql1Vxxry2Qrq29TjAypwvQqnoRZYVogYYvycMVwzxqfLQ+gf2NI5psWVZQ7NUyBBvRp/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8taaSQsiwnMFnmks5LX1aMKeJdKpy3vnkzuKa9oK2Bk=;
 b=ecYOPkFg1lB3PPpAD12ze15f3fSJaQo1+Rb3sAl8ysbw0AeoZlzD106lcsvhYq6jscgP90yUB55uMfLEpfVFuDA4mS4HGJpjosfPwWCLqZmLBObp7aoT589P0mk2CnDFIE/IcX8nE0qYHglbyAuf4M5hbQj2fjvK5isAaVx8fL4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB4144.namprd15.prod.outlook.com
 (2603:10b6:805:e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 17:55:12 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 17:55:12 +0000
Date:   Fri, 2 Oct 2020 10:55:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Philip Li <philip.li@intel.com>
CC:     kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <kbuild-all@lists.01.org>, LKML <linux-kernel@vger.kernel.org>,
        Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [kbuild-all] Re: [PATCH] mm: memcg/slab: fix slab statistics in
 !SMP configuration
Message-ID: <20201002175506.GB2954069@carbon.dhcp.thefacebook.com>
References: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <202010020814.M5nb692Y-lkp@intel.com>
 <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
 <20201002053405.GA30771@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002053405.GA30771@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:96ed]
X-ClientProxiedBy: MWHPR14CA0058.namprd14.prod.outlook.com
 (2603:10b6:300:81::20) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:96ed) by MWHPR14CA0058.namprd14.prod.outlook.com (2603:10b6:300:81::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Fri, 2 Oct 2020 17:55:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e23ea4-1865-4980-8ec9-08d866fc4f34
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4144:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4144B18A7110F496CD6F065DBE310@SN6PR1501MB4144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzgSPtrbZ4dt8qqiSMjeAX7dTzl3xg1kofukIsrGMR4r0Xoi7Gn2f0IqqG+oRY2P2D1j46F6hSWhi9s8/hFJO06QAtfsHeD3j1Ss6VOEN2Txg8elQEaVXACdtLBc87sFzNgaahTkhq1QcIU2EGdl4E61FVsZt3zYKJRAbCmWlVYqia2/dxhX9aCUv4jHL27LUZGwC1J1vN7B7q/VHjJm9fi/+Xfi+9JRmmPdxJrXyG2/njJC77sAd2Ms6761LMrjgLrpeOL8xKOr54G4XHw0ZxT9bbszKk+AvLVkeRdl1Dkn7oe8vBeMvJ/6VYf1HptvxK4JcZBI7cFnJb9sWZPDiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(316002)(54906003)(86362001)(5660300002)(7696005)(6916009)(478600001)(33656002)(4744005)(66476007)(66556008)(66946007)(52116002)(6666004)(1076003)(16526019)(6506007)(186003)(8936002)(4326008)(7416002)(2906002)(55016002)(8676002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: h/q5VH6l/0eNNWxQi5yUZ1pw6DgFAXW3Vx/K8t4Y2/3NpO5m+lvmu3bO0Qhf4LldjggVApd1VoUKVY1qyy9S8ZTaE4gvlcNr8Hl6Iq/IUJtLApvEZEVsadYcYirisCIbneBDqj/Gy8O91KXINWschUR0Bi0eM8oZo2TnBsi9bzPMeHRW7IZT2qJ7hyiHg/KqysYzKvFITQOF+KKF582PhDhn2uG+dAGwLnyRDJd9hdY/0Sp+ELQB6Ph+Nr4jLfbqb73U3w1C87sCZ+6k1mjl0HkardGgmQcuixSPbZ/jP9FalU24XCKQv+/EsnAQQ9slqpaNAn7vhpwOoyhybzS4mjyUXP093fxIoyqN1ZB8viYn0VsbQJsHCrLPVsdO764JRVHflV6RQvIG3XJq0NHA9y1BO9uBsNqqHCXza06+J7R0qepAWLs+oIl5ZyHyIBR3RVc3bCNngbRtBJFbcJ0mbDgphk5jOKLnf+jQBci0hFEzCyjIHyHwM0u2mVXu+c/6mlyeISP2beZ08CfKgypJ9xshsl+4MiaP3SCubEBtPPCqbSP8A+IClvvjlCe+VnBkZ/LCJe1qD9k+vojHx3kO9ktvP7HQ2kadujDDcCnVefrQxQEevsz7xRbWDi7VXm+zqS16h8DXdtU+7y+6Ua5zlJ3TEOagU4Z+eV57cEuIi2Q=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e23ea4-1865-4980-8ec9-08d866fc4f34
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 17:55:12.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbYLtpUbvY2jOaj3oq+P8vKpSReqj1OpAXa3OZEnbL42l64RaoKe6pjcukhJZMyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_11:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=1
 clxscore=1011 malwarescore=0 mlxlogscore=939 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:34:06PM +0800, Philip Li wrote:
> On Thu, Oct 01, 2020 at 05:55:59PM -0700, Roman Gushchin wrote:
> > On Fri, Oct 02, 2020 at 08:08:40AM +0800, kbuild test robot wrote:
> > > Hi Roman,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on mmotm/master]
> > 
> > It's a bogus error, the patch was applied onto mmotm/master, which doesn't
> > contain necessary slab controller patches.
> sorry for the wrong report, and thanks for the input, we will check
> this to see whether we can find an appropriate base for this case.

I wonder if you can look at the "Fixes" tag if the patch contains one?

> Meanwhile, you can give a try to use --base option when git format patch, which
> helps us to have more clue when looking for base info.

Will do.

Thanks!

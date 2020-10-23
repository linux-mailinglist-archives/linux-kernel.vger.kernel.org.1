Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09D229682C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374111AbgJWAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:48:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26064 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S369352AbgJWAsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:48:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N0hDIt026836;
        Thu, 22 Oct 2020 17:47:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=T+gzfg5oHh3TqNNMBW/NWc6o5peHtrCZx+0NB1sn2Uc=;
 b=OMxFuue1WZdTre33Dn5FPHMC6oI7NBkAIZioIPupz7AWMzaZ93A9uqsFB9KcVCe0a25n
 GmhgU17Ry8pL1MG7gQI6QwAF+ziLmCDtLvqzViukVAq30oXEC4dg5fwtRaqva2QjC1Og
 weENXG7flwIUmAyrZkldmA35SO3usozRh6U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34bfu71pj1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 17:47:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 17:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpW/34w7q/2GNUifGC97JgGSU5f6CxWyHOc0KiLcAUJt2WwBUeWDVMrjZurX0u8nHbB+oRCy7rRqrcjZvYNn44ABenRAhObfKoEv4Xm+fhBn0MbXDL2sEmh8khVVzik4HdwOaH9n60QSt+b5WIpk/bQCiP7ib/m7nY3ot4lTemNtrBXHjzPl33CDGCaAwmrZmaGXfvGS+3K9qPrXAznhC2Ci48pINMz1cjwPP0OLn/ydzK7WnyFJbL45TTKeder9JHO+g6GPMT96yXsJTEmKcWULzlVcfeOAWGjQm8XsDcTr5+hb8k/xXbzen07O50jrv9s1a4bY/EJ6HjAYj3Qopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+gzfg5oHh3TqNNMBW/NWc6o5peHtrCZx+0NB1sn2Uc=;
 b=XjXK9/guA5ImBlAP1zUXV3oJABRQZYwMBp+8N00eZPPtIFPSxuGhNORB/7sXAYlY17uWcI9dPyFZQXrq2VOMG+Sco6fzGavNrH6xKluZSUTHmTU0pd3qlYQq7TMijLPJyIM7yKBjr2TZlasg7iQWwaU3dz1mLLqq0FeiaxmybOFz9ZRWmZI0Gndd1KLue7AW2KB2bIKrTfiqyIEobMDedtdWYIomgaBdPlCXUfbhxOAVaQW38842uBT0heBijWd7Agt4j/82fW+aW52a22qUU4ue0hL56nPV/ycDF1ZUBTpN+uFN5nIijakrU0LPCISqRgyv9bv/+ljZ7KMYoWXXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+gzfg5oHh3TqNNMBW/NWc6o5peHtrCZx+0NB1sn2Uc=;
 b=eJIW1P/9y5EniNhswCYFMHZb16smDv5rqhxTEjjjS2x0ynfSiM9VkTSbwIZSnJR7pSkXLQu7742XLPiWHGWdblUxbpVPTsn20CV4+VVEE/cEuSKpYcFZAVAZh6xzjy4HY38H8n0sGP5BOMlQ/n9XNshY3KftLY57dNMZ76PHu74=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3683.namprd15.prod.outlook.com (2603:10b6:a03:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 00:47:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 00:47:43 +0000
Date:   Thu, 22 Oct 2020 17:47:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v1 0/2] mm: cma: introduce a non-blocking version of
 cma_release()
Message-ID: <20201023004739.GH300658@carbon.dhcp.thefacebook.com>
References: <20201022225308.2927890-1-guro@fb.com>
 <F8551A10-E254-44FC-B28E-9E7F8AC14B57@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8551A10-E254-44FC-B28E-9E7F8AC14B57@nvidia.com>
X-Originating-IP: [2620:10d:c090:400::4:3243]
X-ClientProxiedBy: MWHPR1601CA0014.namprd16.prod.outlook.com
 (2603:10b6:300:da::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:3243) by MWHPR1601CA0014.namprd16.prod.outlook.com (2603:10b6:300:da::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend Transport; Fri, 23 Oct 2020 00:47:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56e5684-7190-4822-58ec-08d876ed409b
X-MS-TrafficTypeDiagnostic: BY5PR15MB3683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3683D5B43FD476E0E6EEF873BE1A0@BY5PR15MB3683.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2fjPjPdBUAl28C80AOOTNe/cTuzVlK6mTn8+M8P/Qx/jreZCjxlbogReGhHMbS+KXL/8ejC1QWxhlgtfTLiSeoMoVHyrkdSnDGFdPED4OytOB3fuzgw67QNauTqrO3+CIIRC352LkWQyAUKJL/IgEfxWz43l2ihScJSRO6YHHExEdumHZZG8YAHnTSlC5sApuVntuDjr7fxfotyuMNgwNtpHFcHL0zpPO+xvsT6Ac5Je+mZuBWOoWbB8QA11W6CWlF388YVCTzxqda29ZoAQf5a4NX1Ghchd7KnddJl/gogMQMSFpq25scsTXEzq0AAmJdd7Ic7GmdrAinsk62AOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(478600001)(83380400001)(55016002)(6916009)(8936002)(66946007)(1076003)(33656002)(8676002)(86362001)(66476007)(6666004)(2906002)(66556008)(9686003)(5660300002)(4326008)(53546011)(7696005)(16526019)(186003)(54906003)(6506007)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2qRMNXhQz4coEe1nQXNLApYUE8HUOqnuZj2cHdLluIBoChtrY0Cpyk9TvYUaN+VS12X2D1E2bM23yGCNEWq2orzgi++BAMBre6DFT9R2YW2rJOTizLUsGOnr85x5dzEisHQufK9SGeBJK1Bav7ITYLl71X/EpOb5L8rfoRNpYLfQw6EAjbDPfw9MvNxS2FObWceKILu65Kb2ttZVLjurA6YE/U6lcheKNFL6Wn4KL18J5g8EClGsZnLht2YAmm6OIg0ftcntMUWmmRP2w6SBR6cn5QIPBrUwC0lreHHFbhhyvYiyJMOD67Xcp3E2alIbF+I6Jgbhhlue6F/l0wtyxVNm5KSSxEWt5fDa44IAMrzwo6moUZuDKm0XrvBOC+2/uMsMaXxcRo3TeymzohIcYI3wiKt6ju5Ek2To178vpoNXfhIlks/pXYNkjpgwdoeO6Vttzw4fZlL22cAg4j9Bnlh3ffkwCjLw585NvtW3p7g7xYN3iV4EwhGQIbEsA5Bs+TL1Vm0bBu3XWb9URsF4Rcb87aAIZwbHTf/i8F6DxP7djjpk0OwwVmjxsDUUsybDFhrpHOJjWQMu3O9r6VRNm0jHPLEi36Eadrs9Fbj3qwJ9wFWBJJoWnp+R6n4HwBDLGMIzAooR31Ms7iqq6J83vI+DnZtKxBAirBUMgGUCE5I=
X-MS-Exchange-CrossTenant-Network-Message-Id: d56e5684-7190-4822-58ec-08d876ed409b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 00:47:43.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOMJmFKed7UMNsv2x0IKkB39jl1EwTT1WSphsdbC2GnFaQnLWVRzvb+ZzEB+Lelp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3683
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010230004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 07:42:45PM -0400, Zi Yan wrote:
> On 22 Oct 2020, at 18:53, Roman Gushchin wrote:
> 
> > This small patchset introduces a non-blocking version of cma_release()
> > and simplifies the code in hugetlbfs, where previously we had to
> > temporarily drop hugetlb_lock around the cma_release() call.
> >
> > It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> > THP under a memory pressure requires a cma_release() call. If it's
> 
> Thanks for the patch. But during 1GB THP split, we only clear
> the bitmaps without releasing the pages. Also in cma_release_nowait(),
> the first page in the allocated CMA region is reused to store
> struct cma_clear_bitmap_work, but the same method cannot be used
> during THP split, since the first page is still in-use. We might
> need to allocate some new memory for struct cma_clear_bitmap_work,
> which might not be successful under memory pressure. Any suggestion
> on where to store struct cma_clear_bitmap_work when I only want to
> clear bitmap without releasing the pages?

It means we can't use cma_release() there either, because it does clear
individual pages. We need to clear the cma bitmap without touching pages.

Can you handle an error there?

If so, we can introduce something like int cma_schedule_bitmap_clearance(),
which will allocate a work structure and will be able to return -ENOMEM
in the unlikely case of error.

Will it work for you?

Thanks!

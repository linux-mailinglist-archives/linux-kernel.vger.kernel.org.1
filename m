Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D912A70DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKDW4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:56:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36346 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727483AbgKDW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:56:45 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MseKX006340;
        Wed, 4 Nov 2020 14:56:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0S2KAY39FW04TAw2iQEZcjpqRhg6TPe20srg/ErLEiw=;
 b=hbuqRHZCfNwz+ZSJU9jkCysZYCj1eMq4lbdApaFc2VKNK8xwbvwZyqPnPIPMnxQQQ9SW
 2ESDibficOg+AXHW+X+Mh/q1MsoiCBI10mhh39iHgLqt9VR4HxynHO2Ce1bzS6MJ9zDO
 pDowI5b5kyCJycUp+uZ52cOWaWJKamJdLt8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kj8kdprb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:56:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:56:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/r+1Rt3q1D+5tCmqB9s/c1nh2zibHUnVbiVv1KH1YsICQQg1meBr1aqsQTO3RF2NgJ6QrWZoNhzjxk9J5d/VJNuR0uPWz08n0xua92dOm++Q3U/awBEqoxyBHAPbgpO0wZ7Z6smDy1x6gdAzhk2hfXEBymLXSPgvmZ4dA0um3EeJFy+ErVcI8ZFkY4q55SE9hocVLBZQ6hrPtqoHhlhCVVT7pHbjA0VA3T3FCiLxRV1tZa+TYeXyur/UKKor+g20lDDS1ISUEUpnMphSBV1tkgk9sxbmI0GZ3N8YXOEVTLZxeu15+YmrND9K1TU6wBeEjkEKQEU4M+oIzyeBjCsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S2KAY39FW04TAw2iQEZcjpqRhg6TPe20srg/ErLEiw=;
 b=N/n5AInoXkpG3C6BqqpTyqI8oDr/U8i9lyQMslP+HcQsXubID5RddJiV4lBBrbYGZbKSk5rP9q0a4oMTxDDs5oN1xIScwfo4wIr9gLX418fa/GnE/h8BpMrcseBPozu73Jpv4wW0ywG9z1VlkVSvKCFMuay7g6X7Tkn1d7pt6jg+Rs+6HLpa2ZX7W9B2BEQ0BFM6zyRYXb30SEHnA9N+YIaVo8H1hjGzjuzo+z4WyzZUKbtdNvkslBkVsapDEmQcAr47UiWNoyD5CHJ6A8xFcT1pvtL9Z4JgqxvtH/lCPK1o40j37rn/6KQeJDHuoHakMdf2WDSC75gjRPwpD6tYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S2KAY39FW04TAw2iQEZcjpqRhg6TPe20srg/ErLEiw=;
 b=jK85MoxihNyODExmcWVfhcDZewz2/CjBX0KWA25jgpsWiRE+8Cdp+Jd/XF2bHdcs7AGQK/KuEGu8WVSo3sMC9FhphOY2o9g79VJ9Rmfdu3/6QU82r/1CORWRtlplmd9IGHrZSZuxfbziQ0ahLIDfNCAqMbsT3YUOAroux/7R4KU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 22:56:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:56:17 +0000
Date:   Wed, 4 Nov 2020 14:56:13 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH rfc 1/3] mm: memcg: deprecate the non-hierarchical mode
Message-ID: <20201104225613.GF1938922@carbon.dhcp.thefacebook.com>
References: <20201103212725.3716088-1-guro@fb.com>
 <20201103212725.3716088-2-guro@fb.com>
 <20201104083746.GC10052@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104083746.GC10052@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:80b5]
X-ClientProxiedBy: MWHPR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:300:103::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:80b5) by MWHPR12CA0060.namprd12.prod.outlook.com (2603:10b6:300:103::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29 via Frontend Transport; Wed, 4 Nov 2020 22:56:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b74eba2-5dc5-426d-f7db-08d88114d6c1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22157066D8258AF96FC92014BEEF0@BYAPR15MB2215.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0YjG+P2P4l7NZj0KF3jiSPWV0IboOdWuMAkeR+m3qG1Nt2P7A9ntulUDgGeIeepAM4k1ElMQinvj5xOKAANrNiMx+bWf009dbiStO2yPpXNlY6x6WXm2UDAMn5CAzkF8PebHtES43vCxhlr+sQFgllSVf4NjLpZpYQWDayNiag+bWZf93ptbjNXIjQ7kERSXWALqcA69aYw32YipzRso3aJtdJwU9JCWbVEFNHZEpAL66xOJbYB8ZckrZcqt5m8MZMr62+0phYaACqscYnv/6m5vexPIVclCQsnKDwlV45IdSi+5jlMJURRDB3u2YOVTB9jayxq458pGGrMhjJAOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(316002)(6666004)(186003)(54906003)(86362001)(16526019)(55016002)(66556008)(66476007)(4326008)(5660300002)(66946007)(478600001)(8676002)(52116002)(33656002)(6506007)(8936002)(1076003)(9686003)(6916009)(83380400001)(7696005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vSg3t5fczTAss6SRJ3qM9ymTvZ2Zl96CiM22LDrl8sU+Oc7WcEo9/0eeGjjvH1AC99stswB1wI/gZPoPlsMMNgeEnh9c5QXmrNMckCbxTj6qTp91K9QWY95ZrcnnAJUdpkVuFT2Oxk4agPQqKeDW+fHYudhJTElniN7tgt1Ag0v8qeeBwZ2Fmiu30Hw64zvp1Vv+JHEaqjRcslj9i0mRMQU2twicrHs0QT3piYRjNxWtrup2V9N3NC9ql96R004E6njgEMpvHZZaSqMUBBknBTjksBXnqh+DA4sC9uNAbDApqwFNv6baZOJX4o9o5gcL6Byt1ztGyHZuxD7e4xdVGi6N/V4UI+wHM0eKSpP8wNKVoLHygwP9QOLs4PDkVIwOLvNjqC9QYh9ekJbDU5LsH99h6W9dxCGfms3OIW71InU4CTcClAHLcsvKyjo7Yd1OL4+ZUCEDLgM42NJVp1U8rpR4zui5+udh/s0OkuTFt90WoNpWNAsjG0miepb169+oNlAqU79TNuDPicD5pqVe32qsGdMO19361HnkAq7/4P2WsZuF8Cx+YddrjhE/vkKB9leRfF/9Bjbh4Nm407jkzXBYBofmyGPAj1dxxWpYmF3Uzo114wikxV4Y2nSvciHpk5Htr3ro088U2qx/NJA1hKhUvH5BU/kk7mPGj3BGLY8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74eba2-5dc5-426d-f7db-08d88114d6c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:56:17.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2SU2hvlv2AEmnjwWWFJX9b9t3mZxLMk+ZCV0ZrV5KQGuS+9tUGUBOt/1RLqeP+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 suspectscore=1 bulkscore=0 mlxlogscore=770 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040164
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:37:46AM +0100, Michal Hocko wrote:
> On Tue 03-11-20 13:27:23, Roman Gushchin wrote:
> > The non-hierarchical cgroup v1 mode is a legacy of early days
> > of the memory controller and doesn't bring any value today.
> 
> This is a bold statement ;)
> All that we know today is that we have a warning in place to complain
> loudly when somebody relies on use_hierarchy=0 with a deeper
> hierarchy. For all those years we have seen _zero_ reports that would
> describe a sensible usecase.
> Moreover we (SUSE) have backported this warning into old distribution
> kernels (since 3.0 based kernels) to extend the coverage and didn't hear
> even for users who adopt new kernels only very slowly. The only report
> we have seen so far was a LTP test suite which doesn't really reflect
> any real life usecase.

Good to know, thank you for providing this information. I'm also
not aware of any users of the non-hierarchical mode.

> 
> Feel free to reuse the above in the changelog.
> 
> > However, it complicates the code and creates many edge cases
> > all over the memory controller code.
> > 
> > It's a good time to deprecate it completely.
> > 
> > Functionally this patch enabled is by default for all cgroups
> > and forbids switching it off. Nothing changes if cgroup v2 is used:
> > hierarchical mode was enforced from scratch.
> > 
> > To protect the ABI memory.use_hierarchy interface is preserved
> > with a limited functionality: reading always returns "1", writing
> > of "1" passes silently, writing of any other value fails with
> > -EINVAL and a warning to dmesg (on the first occasion).
> 
> Yes, that makes sense.
>  
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> I do not see any problems with the patch or any left overs behind
> (except for the documentation which you handle in the follow up
> patches).
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks and let's see whether some last minute usecase show up.

Thank you!

Roman

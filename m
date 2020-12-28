Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9A2E6C65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgL1Wzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2222 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729303AbgL1ThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:37:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSJXrrK008268;
        Mon, 28 Dec 2020 11:36:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=8Yqy29y4pRt+40m2mcltpme/27Xbz99gjuiM7XkpCEg=;
 b=j8dXbMjc+N6R+R3XqgNdD2LePnI5eUwsop9mBMaM9z75xv+MU9Xppy+YrvQykKgIHhku
 bKEWb1eU4uWT8kjf88Mgz4XSamaqrcKxjWTgF7IPC7SCh8xGnd1jdUDBj15lyobKPdGk
 86qW9p2Kag8xblXVhPaO9Mh4I4pSsNyaroo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ppc8vru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Dec 2020 11:36:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 11:36:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUbWHUXNv7O+skQIshk9eIlBpdD6hZo799Dbf4osS5mC7AvIHQQKUKLCipND4RaF0V9LT3duiKsKjIKCL4qJq3xT7a6aCtZ/ZMwtxBTL13agVgrFAjydhkYALdIAHaEhduqaAWUl8c5Rbnt6KM+ZQEWlzp9r4pxzQtRVxf06dyzuki9nUmbVCsM1kxkA1DTba+QM4Aw3xaZqDRRhkqJJidxpGlUgScMH81hyv84mU+f+YHJyMlrUUsjb1Z18x0iaIksyt3KldOEX3ENqOkn7d1dDWlTy/zNk0ze5PMhP7woQxG/r3sbnG6AeT2aizLEqxQwSJ5KCvroo9Jn7Z0OsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yqy29y4pRt+40m2mcltpme/27Xbz99gjuiM7XkpCEg=;
 b=jdpcq83T4gLtxQLgp/OfzGMxILo+P1+aN2oTjRMU0goEnxWZ5gZ2YirzfknQr37rj8v6EpDh18NyXR2csTqUUCNWi/oErWfj2BtxkqDQzZmEHuPy5ZVqgCRW61esGfTTJ9QR/ArPLU7GKT6fA0mMx4d7wVU0joaeAxh43k4ecNrTU+R8B4+C+RRp9LGl7+6n0y23tCA83/7TmCYvyEaTd8gknzumCcVFDEslvTRtSTQpd5m/mkZW0ABZdMozrYMvxu/LbELr+6HFEE/8vNjIzCk79pDgawE3XxBIMDVPAgqqI0l+UQureZDry6JhWhbLyYXhVB2W5v8Ajxk1T+y9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yqy29y4pRt+40m2mcltpme/27Xbz99gjuiM7XkpCEg=;
 b=WxJPwnrNnogHoUsZ2sIf+lSCsemTZ3omG9DN279Mi1WXjJiRDjpF3utWu7sbV+RXRYIPk6b0X1bDo3mhboiE+iPqkf91B6BaoXqro90/aq+IVAGjnaudU0xlK/t8fZh2l3U4bFapqB6PUErAUv0Q/tE9jI3B9vUj6vbRvM5POW4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2437.namprd15.prod.outlook.com (2603:10b6:a02:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Mon, 28 Dec
 2020 19:36:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66%5]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 19:36:23 +0000
Date:   Mon, 28 Dec 2020 11:36:19 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-ID: <20201228193619.GA317390@carbon.dhcp.thefacebook.com>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201220064848.GA392325@kernel.org>
 <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
 <20201222200606.fe4444f1f0ba008ee9fda091@linux-foundation.org>
 <20201223163537.GA4011967@carbon.DHCP.thefacebook.com>
 <20201223221039.GH392325@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223221039.GH392325@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:c141]
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c141) by MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Mon, 28 Dec 2020 19:36:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 570c2f34-b883-4a80-e589-08d8ab67dc51
X-MS-TrafficTypeDiagnostic: BYAPR15MB2437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB243724824AB33E4ADF06CB97BED90@BYAPR15MB2437.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcBY8f7SbVXQh0iMVdq3gM0QMJ7vGmKtCHmFiT2l480b5cDZpzDvcMo+rra0bphLiDmJcyfZvnvkTArUgEO6+MWjOpM8dsR8nQa4dVjeRf7r3Xc9yNlshWlWcaUmGYsZ3/EufTWSPtdRJXjdOeAig2Vp/Xb0E62pR5dGjpQSTUJSLFC6qRIQoN/8oXlXThQfP7WBLnW0IBTxIsxMYxDPr/fM4YEmRofVBsTcdwWilIE7JZ+nxvA+8SvKOyj3g9grMCNWwG75wDp8ZFwo4kLWuv80x02YBgcEZCOHckJKc0w2h+wYgIuVtkwPmXHeJeRNt/GxqXacEXu1Dw4tMDax/Ui+hLbtJ+DzUJeNpeO6ElWT8SLe2gJnsewthcr+cIMMjPVTlWvWfJ3xGJLzV1uqNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39860400002)(136003)(33656002)(66476007)(66556008)(2906002)(9686003)(7696005)(52116002)(8676002)(6506007)(1076003)(6666004)(8936002)(55016002)(86362001)(83380400001)(5660300002)(186003)(66946007)(478600001)(6916009)(316002)(54906003)(16526019)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akRUUnR2a2NyR3k5TXNKbCthYnE0bG9OYU9tZWtML2lNNVgrVXN5bHhXbDRl?=
 =?utf-8?B?ZXdORlJNNXpBWE54SmJ4bW9hNmdXWjhXUU85Z0ZmcTduOTYvTHAvcU1iSGRR?=
 =?utf-8?B?czhuYmh6VHRCSUhwQjJ2TWFlc0MweG1mOThVdHQ2M3lPUXo3K3hxWlFBVVdI?=
 =?utf-8?B?TnhUSDJ4Q05udkh0VkNMMDNjdHlaTUtLNkZobW45M0czbndsL1FWMmFGZVNQ?=
 =?utf-8?B?bGxOcDN2d29wd1V4QStyWVkxNklXY1VzM3VOMlJxdVNRbVhtemRXalFWaDdV?=
 =?utf-8?B?aERKUW55U1ZjN3hjQmh2VjN0NjdkT0ZHekJMUEwyVkVSWWU0Qlk0T2NkRzJW?=
 =?utf-8?B?Z0JYODRwYzQvaHZUekV0b0F2ZldDN3NxYjJScU10QlNaK0ZGMGU0azgyK1U2?=
 =?utf-8?B?NFBzUjZPcjN0aGFBRnB3dTZTWW1OLzFIdEJHL1FCaTAyTUJoLzA0Q0grR3Rv?=
 =?utf-8?B?NEc5a1pEbSszRlppdDd3TkNkNHRzbkFpcE5JRkZrM2V5L1VHcFg5cXdtNTZk?=
 =?utf-8?B?eityV2hpSG5Md0xvNWNoZ3NidUM5NlVqekJnUEVCTkZTUFJvbi9RQ1dtQmJM?=
 =?utf-8?B?MjZzaWdCYXF3VGdNVGQ0WjcvV3lpeWF1TU0yQ1dpcHZXeDNNUVBUMnFhMGlm?=
 =?utf-8?B?dzNKQ0MxcDF2cnc2S0k2VzZsQ1k1Wmh5QXliZ3l1OC9TUUFTS3hJcU12T0xS?=
 =?utf-8?B?SWlDcUtKZ09Tdzh5UkQvYTA1TnNpMktHZ1lqNGhra3pBWVY5Wm5udHUwQTJH?=
 =?utf-8?B?bVNOK0ZyK1MxTGY1bWF6RDYwK2VnNG91NlI5a1UzZWVtL3NNZGRzd0FmMjll?=
 =?utf-8?B?b0tzZnFHQVJHL3RsU2RhSnV6VkxtMzBMbkNkMTl5aDNmMVkyY2EyMVRvZmEv?=
 =?utf-8?B?eVcyeXB3VjhvdFU4QTRNcjJNRWNmZ283eVZXZ2R4MDNIYWpxNytkNmJTRXpu?=
 =?utf-8?B?Y0JlY0lLUjNralNIcG5kbXA1YzN0bDFlS3BVRnhnWHo4WWZCdzlkQlM0NGlO?=
 =?utf-8?B?YkR2QVp2SEJSbjVITmk5c21nNVFFOFF3MGdUSmJra05NeGdoLzBUS3dTWDh5?=
 =?utf-8?B?Y2lNdzVTZ2krSllmUEwyLzIyQytUamxqcGswY3hvZThOV3N3UXYyVkhFRE5Q?=
 =?utf-8?B?UUFqZWltaEp5ZE15MUw1dXRlcVR1blNMN0NNNnhTOFhWcTBzK2pILzVxOHBT?=
 =?utf-8?B?L3J0YzBHdTE5MUNYeEpDVEVZSnhIOGN0ek1TenE4UWJuMW5EZ2ozaVVrTWNk?=
 =?utf-8?B?dWh5a20xMUlCblFOdXpmWWZJWGV0MkxQTlRkbng5aDQva0xtRHcyMSswV1NR?=
 =?utf-8?B?dm9uM0J0L1k4WVRqSlY0KzBwVHZXeW5EV3dMVDFYU0RhNXdDSFhWdTZ5QStO?=
 =?utf-8?B?S2lUc2ZZT1N6YlE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 19:36:23.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 570c2f34-b883-4a80-e589-08d8ab67dc51
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itFl7I1ARcKYS4/cLU/RJaJ6jN0KSu7Q23+KIxKr66ClUOgUGkQ4A43WDNouDgSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_18:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012280119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 12:10:39AM +0200, Mike Rapoport wrote:
> On Wed, Dec 23, 2020 at 08:35:37AM -0800, Roman Gushchin wrote:
> > On Tue, Dec 22, 2020 at 08:06:06PM -0800, Andrew Morton wrote:
> > > On Mon, 21 Dec 2020 09:05:51 -0800 Roman Gushchin <guro@fb.com> wrote:
> > > 
> > > > Subject: [PATCH v3 1/2] mm: cma: allocate cma areas bottom-up
> > > 
> > > i386 allmodconfig:
> > > 
> > > In file included from ./include/vdso/const.h:5,
> > >                  from ./include/linux/const.h:4,
> > >                  from ./include/linux/bits.h:5,
> > >                  from ./include/linux/bitops.h:6,
> > >                  from ./include/linux/kernel.h:11,
> > >                  from ./include/asm-generic/bug.h:20,
> > >                  from ./arch/x86/include/asm/bug.h:93,
> > >                  from ./include/linux/bug.h:5,
> > >                  from ./include/linux/mmdebug.h:5,
> > >                  from ./include/linux/mm.h:9,
> > >                  from ./include/linux/memblock.h:13,
> > >                  from mm/cma.c:24:
> > > mm/cma.c: In function ‘cma_declare_contiguous_nid’:
> > > ./include/uapi/linux/const.h:20:19: warning: conversion from ‘long long unsigned int’ to ‘phys_addr_t’ {aka ‘unsigned int’} changes value from ‘4294967296’ to ‘0’ [-Woverflow]
> > >  #define __AC(X,Y) (X##Y)
> > >                    ^~~~~~
> > > ./include/uapi/linux/const.h:21:18: note: in expansion of macro ‘__AC’
> > >  #define _AC(X,Y) __AC(X,Y)
> > >                   ^~~~
> > > ./include/linux/sizes.h:46:18: note: in expansion of macro ‘_AC’
> > >  #define SZ_4G    _AC(0x100000000, ULL)
> > >                   ^~~
> > > mm/cma.c:349:53: note: in expansion of macro ‘SZ_4G’
> > >     addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
> > >                                                      ^~~~~
> > > 
> > 
> > I thought that (!memblock_bottom_up() && memblock_end >= SZ_4G + size)
> > can't be true on a 32-bit platform, so the whole if clause can be compiled out.
> > Maybe it's because memblock_end can be equal to SZ_4G and if the size == 0...
> > 
> > I have no better idea than wrapping everything into
> > #if BITS_PER_LONG > 32
> > #endif.
> 
> 32-bit systems can have more than 32 bit in the physical address.
> I think a better option would be to use CONFIG_PHYS_ADDR_T_64BIT

I agree. An updated fixup below.

Andrew, can you, please, replace the previous fixup with this one?

Thanks!

--

diff --git a/mm/cma.c b/mm/cma.c
index 4fe74c9d83b0..0ba69cd16aeb 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -344,12 +344,14 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
                 * Avoid using first 4GB to not interfere with constrained zones
                 * like DMA/DMA32.
                 */
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
                if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
                        memblock_set_bottom_up(true);
                        addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
                                                        limit, nid, true);
                        memblock_set_bottom_up(false);
                }
+#endif
 
                if (!addr) {
                        addr = memblock_alloc_range_nid(size, alignment, base,

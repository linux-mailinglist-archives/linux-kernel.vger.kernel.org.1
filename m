Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA72AE230
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgKJVwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:52:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbgKJVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:52:13 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AALbVT2006976;
        Tue, 10 Nov 2020 13:52:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9UDM8WzQumN6Dx0Cxb1Pag0BdjHV3DI4+RVFdQ24SQE=;
 b=YDY/TrA/DospD+59r+b80p40oJXx9LNcAtAZZ81bckBoGuhyfCIxBtTIblVMc6xsDV7W
 S2LGzySPPPOTvmjfsL3QREBw1a3x1Dftl5dmaI5UbLS6L/f+fwA4yIg0iGNTKhemoOI/
 mu5jmLFxp5Su8BexdCQ062UIOfr6Fhn08zw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34nr4q0d1h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Nov 2020 13:52:02 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 13:51:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfTTwHje7KMq1k/4LbuYdogxyEQ2TfxqxSaI7wsoxpmWYmhYUnRN3stgr1JsjHfdgGfbuTFlpssWR8Ztn+HwwFOfaTkfA+cKLZXa44JVbCGjAEuPj2AoE4zCiQ3r8B9I2vFgr3L5kpWgoi30XqwTO5L09pH5wY8A1PVHULnYf5IduUoExX9QwrTp4Zq2w1imescB/WWIaqSreo34sb5GrUN/FhvoMaaIa/8AJs3wxel+JUEl6yOoIjn/lSSLdx6vNmcJ8jaV5OiaOMNv10jgNFBMupYBqDv3DNKW8bAUMYOPSDCdV5G2gvnvHwa8oxWb1ThN2n8AeR/yCpCu5O9Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UDM8WzQumN6Dx0Cxb1Pag0BdjHV3DI4+RVFdQ24SQE=;
 b=H7d3mO4VBV1IIsuBcXoOEvsv9iSNGM5J60ZkCYpW53Ikaf501o6OuTqCnEHKNTmhgbUM2dQWgkhVYrgOc1UL4PWSkLyhAjkq0B+nU+Vug8EGaAdiDpztyN5f/4eTI610tvhBkzBDG+cnonK4vVyfPJAggna3os0eifPEup1nmcy4pIhPTGcatf8cnYyG2phUT/iU3UslckkBOeOnL8Ru6I1FijXbSf6+OW5818rjdpQLl1GaxY4EGHFoLx5up/6jh4ubFs2VZNVeBclWfeD5PxQusggaq090cCCgMVQnmjxlVCsUTlp8SbAvFaIHb2jx2j/gP9b4KK46TmKQspHCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UDM8WzQumN6Dx0Cxb1Pag0BdjHV3DI4+RVFdQ24SQE=;
 b=Ozc7xOIIJQY5uiGx4/PgjB4Q/J+KIR4lsrYbymXbEoRiJXu+BXw6ak2r3PbLjEN1dYbsYQRuYNjMF8yE88w4Cp3kSv1HqzA9VD42VXIdKXGtWgHCSHfdEMo+U70N4o+/BWCc51sfmwKJXpCmsMF/1HkTywCGOlLxgE985sewwVA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Tue, 10 Nov
 2020 21:51:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 21:51:56 +0000
Date:   Tue, 10 Nov 2020 13:51:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201110215152.GA2713540@carbon.dhcp.thefacebook.com>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
 <20201110125008.003fb018e74c40109fd6723f@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110125008.003fb018e74c40109fd6723f@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:2408]
X-ClientProxiedBy: MWHPR14CA0043.namprd14.prod.outlook.com
 (2603:10b6:300:12b::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2408) by MWHPR14CA0043.namprd14.prod.outlook.com (2603:10b6:300:12b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Tue, 10 Nov 2020 21:51:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38408657-00da-44f6-2cf4-08d885c2d7fb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27598994D2E788B1ACC3E237BEE90@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x73oMEsBfKS46K2E+7KnY61Bfs8KzhBoXQKbnKX2ZJg3fVdmCmyJxxuSYmMXqszQN9s9iS3IG0W2g4dI1u8Q+WL61ZDDId2XukQWIgVUhXEaYHRswufdT3X7urMYxkKB9st+UZhC5wT8vIoRIUqjkKtbGketNxjvjoqLcliUJpK5z5Pzw4bSL4Vaz/iEqGVw2EjsV0GX9ry4HVoODdDg9Gj7qogPWvs/RAnV4J5RDd4jG2UsNaJj5bohLqWecAJUR/3FpoBnj72De0wi4tS6La8YOc/SK+wb3l8V8O1G6JRdDIe4/OFvCbhJ08+ZKFi8mrjnSakMn0RpjrMvapE01g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(66946007)(33656002)(55016002)(5660300002)(66556008)(8676002)(6506007)(186003)(1076003)(9686003)(66476007)(8936002)(478600001)(2906002)(16526019)(6916009)(83380400001)(4326008)(7696005)(52116002)(86362001)(54906003)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dIykvm6CifOY1hvHNawPbiU26TABRWxmVIUNsldGP8ehifHFtHgN90V+rICHrKr1BoxtvpwgbG/df71GxKHCG7eXSE6XUJAeRxdvLjA+XinKHoC0lX2Hc3dSIeVbKB0WFxuV1/brsbRAvxzIXHiYWXjDmO6k9u48t4ZSodPnyru3FubUYkhHOlNH5m/XXJVyZXty6bBoqyOtL8o/BVU0cQNTcWsVwvm+NAaQjRV5jAebRhNmuuzH7NF2UDI5+tnmJMJbK5/dM2X0f+L2kRDXxxngHVNs6hHM/qLRu9fMEairWmXCmHp1l+qziEw/kftcBiMy9V4WyvrQh2O9vPWc6WPb6Wm/RhaM0kb0Fd5vAYsoO1gDFz2+nLuJkRbeM3eQfK27etNZ637a33pJ962FR/f6MSAPFEQZZ1+wENravLUTaffnGSvi5BEw0HuNMio5Kp0krBU6DbODre5zdEsA5ZnKCLYIsf5hb2VEEE2/DvS//FyPo0doaWTwYwW1bNW5yXGrxIE5gf2z80NMGWcoyxL0GYD6Clwqcada8exIw4ryBAcUMxIgwrMaHU6DFKblN7Hxj6wDyfa/i7KoWEkDehtzXh6l0MVsFDPGtOaIjO9Twq2bD3o/evmAS52GPzicwMycWLE5FCMTFxBImFzyhP4syM6uX92/ajOSpzdfLCc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38408657-00da-44f6-2cf4-08d885c2d7fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 21:51:56.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOy1+KItDbKqiBM4Qmiccb/ooGoeUz1hWC0/wZYqXp8Ys8Z+TXcLSKKQru9Vm7l9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_08:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=956 spamscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 12:50:08PM -0800, Andrew Morton wrote:
> On Tue, 10 Nov 2020 11:57:53 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > In general it's unknown in advance if a slab page will contain
> > accounted objects or not. In order to avoid memory waste, an
> > obj_cgroup vector is allocated dynamically when a need to account
> > of a new object arises. Such approach is memory efficient, but
> > requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> > because an allocation can race with a different allocation on another
> > cpu.
> > 
> > But in some common cases it's known for sure that a slab page will
> > contain accounted objects: if the page belongs to a slab cache with a
> > SLAB_ACCOUNT flag set. It includes such popular objects like
> > vm_area_struct, anon_vma, task_struct, etc.
> > 
> > In such cases we can pre-allocate the objcgs vector and simple assign
> > it to the page without any atomic operations, because at this early
> > stage the page is not visible to anyone else.
> 
> Was there any measurable performance change from this?

A very simplistic benchmark (allocating 10000000 64-bytes objects in a row)
shows ~15% win. In the real life it seems that most workloads are not very
sensitive to the speed of (accounted) slab allocations.

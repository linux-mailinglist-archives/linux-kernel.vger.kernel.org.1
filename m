Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37E2F23F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 01:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbhALA2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:28:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1568 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729982AbhALA23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:28:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C033bl030228;
        Mon, 11 Jan 2021 16:27:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0Ofv14OtAjqet3AqPhpbTc7WaiL2rqL1JGW/RV85og4=;
 b=b8I5jEacWAPsNBXDj1JB46JXHb4+XfVvPPMS9YvJXm5aAyDkm4BRRFqIjGTcWuTSYwtX
 LWRBD5Ig98y4VZM6hYk9eMl5/EVYa0nBzG7W4X0q8TgXkVLy8JiU8Oq0374l8FDp34bb
 6gvj4FI+EiMX/CFvI/vwf67xKaoBCHinGa0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35yw877wd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 16:27:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 16:27:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKNshTqJjTffdctA5XbAIjcuoAFLrUibf8pZkMuWHORJNF0NBFPpMc1HbTewdtPdvm5dTBYT+ZF0JhD1s0GtHmwlnJ+lwCoY3IefEcXtSWafsBhNtmg3iDMIeUXHe516GNxOdvOnAXwGNrKN1UJWBNA3zrdY6Vl8Y3WynXcxgER051ijuBg8HYlR7NuEVi7ztykPD/Rhua9iA/231p6H9EVIxb0UNMZ8TL/NlGsPrk+3HW2H8QGKK5sZ+sl0jtfe5PNiCHKLjtyF5JNdZpc+JEEj/x2+e0owlFvLOSVBdVGy7lNmB0LhXlY3JZtlEJOrIs53ftEPmwKK8QnNchUlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ofv14OtAjqet3AqPhpbTc7WaiL2rqL1JGW/RV85og4=;
 b=h1dye0Mjw6K6iQvHvaTtuGny1ermbId4stvRk5UNffa1lF/Y6bxNi8eglI8abiIwIx1mAJLU48Us7fiB/crMAvghGhvKAcAuR4uUZkxLEIyyLp3I/f6Sayw3jQa25Kybo+iD0SSn9Zrx7S3bUymxECVIDEww/GWFvoWSPYycqh0CHnwY+YJaXVGPGkK332mZqqVzYdKbbFcgyE7+IVsBonAqDL1vq9Ye+ZEBn8vRzuxLnmER8Jw8+a+EVf5LrrMd6eK3ZfaH1/WWA0C0YExeTuZ1IbgT5NmyF15ZOSu4aMmJx/G3xSGHjtEGCtYEPeZthxci77YKfgBLdgBAqIB05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ofv14OtAjqet3AqPhpbTc7WaiL2rqL1JGW/RV85og4=;
 b=EQ1nC1RlNSgVrRx1X9nSRsuxiMGUlIFl3vZOiSRg3/Dpbcd/w86zYMSc2UWUhuwGbvGcZDWU1Hu8YCCjdn4GN0C5p3R2Va/N8gcqd6qrADQybZ8OXRQJEAQ6mC6hhX/nKPpxItneCY0NFhpuF2rdFM4SHmp7K2JJqQDl7v8NHR8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 00:27:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 00:27:24 +0000
Date:   Mon, 11 Jan 2021 16:27:20 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Jann Horn <jannh@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: SLUB: percpu partial object count is highly inaccurate, causing
 some memory wastage and maybe also worse tail latencies?
Message-ID: <20210112002720.GA35320@carbon.dhcp.thefacebook.com>
References: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:392f]
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:392f) by SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Tue, 12 Jan 2021 00:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b6ad49-bb02-4fdf-d922-08d8b690d549
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32850051EAB9309CE8250E4DBEAA0@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xStU8hpwGwkOFzgczTiH+dKm/9TvFlPVnEFsX4kH/j/iNfeeDUFF8avfuAYC0Ig9F4ApIIblq42liA7ATMs0FUgkHXW23Y2ENdSheIWNWFhBRQD2UNPU+wZhrUkJ5OcTCOqMg/OQ11yqm0OUT6uvj/y6iY5YoxRG90n0+VR5ztykElyBmlMx+ZWnmbyoc13UCUWO+fTDnOrMzQxmp5aoffV4d4/UqiVGOytSdWEv5VDWc1HJXh8HnqjrTv//xlP8u4U7YqDJU3F/qRLwVinv6FaExkwfRskkc2d4zqfbwGuOlagjTxMA1Blfx91WCv+aDSU+QRmTqC0AGvWq38NhJ20kuNHSFmXMPIEz3Cd36bEdMCkiU4CjbdEIiECXVsOwvZG4Ll6R8ddYYsubbrvFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(8676002)(4744005)(16526019)(52116002)(4326008)(7696005)(55016002)(86362001)(5660300002)(33656002)(6506007)(316002)(6916009)(66556008)(66476007)(2906002)(66946007)(8936002)(54906003)(7416002)(9686003)(1076003)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0oBec9Su2IZej3TLrw0Vei67f36cyvzcbQ+RLd+f6nojVXvSnrC5cma3jorN?=
 =?us-ascii?Q?CN6Ba+0ZO7dzw1Zd1ixDjc7ZZmmVO4fp0r0DNdM0bXqFGuwQG2nV54KXpE4e?=
 =?us-ascii?Q?LI4PON4jJWAIJahgmGiQvG1ofIYnAIrf2coDdLQ75nhprAkNbQjCJVCNrVhT?=
 =?us-ascii?Q?GbTAJu/6Ka7F/BAMjHPh5wzkq/2tsz2lAN/AqcF7/jOMQO8fC/9vs598mAdH?=
 =?us-ascii?Q?eOCn6vTrjc+b7nrikRmlcacr5/YKypth0zsnC5UWJqroVeORdzzfr96CieyT?=
 =?us-ascii?Q?PwR54ZYb2vxxkCDeXKfth726DeG0i3VCN6+r2Vlfr93D8DQXXMHhDs+HOQWl?=
 =?us-ascii?Q?N/cYwzeRjP4N6tBm1PUn3Ptk6ESId1cKG6CI6GIzXXYb28nB3Uezn8QYDdDg?=
 =?us-ascii?Q?Y0QhfeDzwXA6mriE0E14YqOdfl8AOjfaicZfgu5Yy1zVF3SmbbjN5g7llm6Q?=
 =?us-ascii?Q?WIx2Qu41xvs5fc0IeH/y3Iey9D1rCgwTi6SAwD6wmZc0DgwK6YMfTA5UPWcF?=
 =?us-ascii?Q?xOe+6yuBhde/xqFm1S9Cw4zk5PLj281SSZNOdSUu2KTbs+1bMWtDAp8Utg2U?=
 =?us-ascii?Q?6XHyYdnVEWbLZQC55lG6HVswFo59agyOEvgEB6phuW2rz4ukT3EpxE4c7ZQo?=
 =?us-ascii?Q?6NLjpNaw/qfqSSeGqvPQmSo2AhDtbBGHtzl+bDFgOvZpCWV3/KXL4RliWDYW?=
 =?us-ascii?Q?j3MTDIdzWI7L86lGIyqxwFR8LUveJ8avV6JNA5+rORzDs97Qu0vkUbGAyOwM?=
 =?us-ascii?Q?2EhK/HN4wkA4jdV2nCC3yDRc9UFArL19SYLKh1ugP6JICk19YVn11wkNm0V0?=
 =?us-ascii?Q?iBb0VtOC0aD7N/OHvGDSYBms/Ir03a+2gJMP0wZoFgW6SCNKt8f9hgrzpliF?=
 =?us-ascii?Q?c9qy93SAmwE8N2wp0jl33UKTSJuA9UudtIoNKyjXTRPM74fCEr/QAWU/i7aO?=
 =?us-ascii?Q?m6+zW+i6t8eEb877MGyr/ONgiga+dQ1FM0kGOsdQRlfCww14XoBw90JD4n5X?=
 =?us-ascii?Q?T+2nMzf765XRlN0CqZceLrh1nw=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 00:27:24.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b6ad49-bb02-4fdf-d922-08d8b690d549
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYwns9bNniZIGrcJoE5erxSWtzC0bDZSilcIljF1wjiuR0IiyHrKD7cqXWdauRE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_34:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:12:47AM +0100, Jann Horn wrote:
> [This is not something I intend to work on myself. But since I
> stumbled over this issue, I figured I should at least document/report
> it, in case anyone is willing to pick it up.]

Hi, Jann!

Thank you very much for this report!

It should be less of a problem since 5.9, but still on a machine with
many CPUs a non-trivial amount of memory is wasted.

I'll definitely take a look.

Thanks!

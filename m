Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A832F5929
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhANDTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:19:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbhANDTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:19:41 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10E39gA2022251;
        Wed, 13 Jan 2021 19:18:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7gW8sHo9ncQxxpilLploBsDkIvh5B9uSJJYYoDiRYb0=;
 b=B/a1Nxnn4AWYF7Ekd7kgA7Th5ozntH5WFaDJUqGeMst6v1rCShxL6cOWMI7jOn/d4fL5
 Dm4+IcDasSlkOmDVfHGBQWwuOeKrcnLpAH6+yZfEtJeuQKP9757VhM0WDzb/EAm/x/Ja
 AQMiZMobn2zcuNJGWESXivVq7nlenEGQjkc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fpe8twh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 19:18:49 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 19:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXdxzLj5/TLsQ6bnVLm9vS3+DTK/pyM0kkKXeA2XFDlkOf5k1LvO8Cn4itqWHmWStU6KeQB5PMZt8MbB10IckKalY3fDa46WkNhDyvubypOSqY5pKYwHZ9djNsCITgy+UZS1d692jSq/slOa1VDOk4Fg+hPIkNTtxqs6bsMOj6lzPloZ+Vf1lGmVFy6IY3VrY9YjyPU1zR1DgnAsFEWjHUgF5sCL6+OfTmG/ZG6zY2Cq1CC3wFOf2vF4LmB79xD+zf2lwUY/DYJcweFl6cZLqCYr1fI8TJElZEdE1jAHVSXfrqbjL4Yh2Ubg9gdj+yhdv75K/I/aAuD3NnefWVtp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gW8sHo9ncQxxpilLploBsDkIvh5B9uSJJYYoDiRYb0=;
 b=M/fMD5P1aX0UR69MAArCvq/NOBrc/Ffm0Y1fV0pUA7gGXBUHKEzg4MFtuU0FOBA5/r4YzGR735VR487zgXKzKVBDky8sNEzIETKtvbREAhY1+q2Iz8mizGQxWN9sNOusGXVeb6r4dl9RDGqh3z78FL2JfdhPrwe82h274CpC4rKSXy8Lkbp2pb0FuTXXKeRwHryvJqleEKld16Ov3vblwQCbcZ/itO0xR6h2rLuLHKH3bJwzBnMbO4w+O22xVdjlUeiygw+yPFfog4oEpQW4H/ZIDYOfpDVfUBACm1DTINV2VRebmTVA5NR2m223eXpxW7mwSWIPUjYR1HOclZqxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gW8sHo9ncQxxpilLploBsDkIvh5B9uSJJYYoDiRYb0=;
 b=CNESBHG9MWLL+ZyNpt6cmXQEYaDHPsRX8IputRvE6HvDcdV5gZlDNsizjuXabJWAAvPIfcyO6UQ2GVo2vMD3b6n4h7i0ZA2+eoQv4j55Pdl0XOKuDoWC2bZfzkgn+7hdQoAuwu5GmWV/x9W3SOESRsoaFqCQj8Tdt+DgZZyYm0A=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 14 Jan
 2021 03:18:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 03:18:45 +0000
Date:   Wed, 13 Jan 2021 19:18:39 -0800
From:   Roman Gushchin <guro@fb.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@intel.com>
Subject: Re: [mm]  10befea91b:  hackbench.throughput -62.4% regression
Message-ID: <20210114031839.GA415540@carbon.dhcp.thefacebook.com>
References: <20210114025151.GA22932@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114025151.GA22932@xsang-OptiPlex-9020>
X-Originating-IP: [2620:10d:c090:400::5:31a8]
X-ClientProxiedBy: MWHPR10CA0065.namprd10.prod.outlook.com
 (2603:10b6:300:2c::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:31a8) by MWHPR10CA0065.namprd10.prod.outlook.com (2603:10b6:300:2c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 03:18:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6315c3-8bd7-4d5f-f30e-08d8b83b1a00
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27126C29A9E86793E5D983EBBEA80@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BD4w4kIyfDBlPg/0CyVXfM/OYzYfRI+MG9Ejpx/TGWB6WVF50eDP08UikqGdg5tZ2zm7ssBqJvt2MdYlGLY/SpLiZ0dBMwoQFTAU9tWzMrvjI6xv98idbXRhLK7dibcjL14ONekP7UfcfPtBlnDoXtZAAIXE8agT2I+cHc6c0ltL2FjItlXINWO7Z5gIr9LB/Tq8xB4KSV2sSWjvrf/Ik2B3E1ai59ntWSrPmVcjkUCxD3GbBA3d8Ep2Vn4xXjOUvYX7M1AUa/BLAt8XOJn+XkiJ+ZakuNDxywqRc8bDLZvcLe5jFeG9oZkV3Fv+mSZhBO1+B5mI/QVXpDJ+gUB8Q+pWvNWTIR5m9mKfGp6Qv2kNuyA9s3OlmFOiwIKj3kmrDd96H8hcLYk7wmOiBdIwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(396003)(366004)(376002)(8936002)(83380400001)(6666004)(186003)(1076003)(316002)(66556008)(54906003)(86362001)(4326008)(33656002)(7416002)(16526019)(9686003)(55016002)(66946007)(52116002)(66476007)(2906002)(6506007)(478600001)(8676002)(7696005)(6916009)(5660300002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YYlf3q5N7hQ+N5bLa2Pys7BbLj0F3W/HwxpxR1T/QHpYsEqLrR88FtgCmNYI?=
 =?us-ascii?Q?extOxr1ybhgyoLWQUha2adBEic5VmVcsLn839bMkZj07EonGnoLw5f075hJk?=
 =?us-ascii?Q?UcIzRbC2tM0PIIgBl/0h1k1LRbOT77VxXcvvbWDtrbUsrMUJOlGl9eOh6evJ?=
 =?us-ascii?Q?rCnp+lISNf2iLE0cSyanqsohW2WAm7TPxe8pduGPQtL7SNoKV3pCuCZO2aeb?=
 =?us-ascii?Q?iTZOqjBFd3s6yyjY1tHACDkKjRTapCmhTuqZXUIHWYXZtfchhaeYKdkw+jpC?=
 =?us-ascii?Q?nw+UzJhEdBt3in8hfZpXzbVj3dXU1zQ7HFK8Bgb9zeLKPr1bK6TmkArgvfc/?=
 =?us-ascii?Q?JA8wKYTH8tjhl40WaKp1L+TJzX7tqkOwRzPJtImtpBg0REZBjpP/kxvXUZlw?=
 =?us-ascii?Q?0Zj7ZLinv1LKjo/FTAhOcpPj+/4HAmh47qkDHZ0SL4Z3SYDUYvfyWoMp08fl?=
 =?us-ascii?Q?doKhO1wVKrevIb1oauGGYQZbclbnyM8OUcHTmy2rHPMjZhX3QjS3BobXc5tm?=
 =?us-ascii?Q?HEsKhKdlJu1PJkLOumz0ADodaHS02XvY3NXFZ2ZIXjl6nMpyGniozndJ3bm5?=
 =?us-ascii?Q?LBzriUD4lhPlGfW6RjeRx/ttuTDrr3Y2KHkmHBvMdVvws2moo3IcjfUriZLU?=
 =?us-ascii?Q?0nsKHkmlPJcromDrU4oH4A+ncaSTQTVo6Oz3iaSTI4NMb1sy5kpCra52B+ki?=
 =?us-ascii?Q?PA0RpmE9v9de1fNsff3SW5b6ShDwqO/kl6U6J5e5nq2ePuydoc2ZuLrC8s2c?=
 =?us-ascii?Q?wj7sIGzqSZ7QCGtCca2jZe064frzP9MWoK+j7HzZXVEwD6TPDVp+lQQXiq5u?=
 =?us-ascii?Q?5961zCq5XRb2RzNthvKI6XJd4IpieZf6UJk99MtcGl4siM7oNi0uBN2pBYDX?=
 =?us-ascii?Q?HEboCSsgYCtGYZnPU3cQ6eRXbpmWwBsvGcD7OBG6aJHU/8qQnDKK4Kqf9TiK?=
 =?us-ascii?Q?MQrDQ1/xIgBNPZ3qlcuapNq5WrWwHCBOnUT86oSOr0l3UcgyKafPqpL+xtlL?=
 =?us-ascii?Q?GLe5LBkk0afbxeSHaYuG3+QFYA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 03:18:45.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6315c3-8bd7-4d5f-f30e-08d8b83b1a00
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67IWflLIPT4P9QWnZ+g83w0Jx3T4KaLv3jv/rm/p5J4LeOvdFr0JgwyCN17R1KwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_01:2021-01-13,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 suspectscore=0
 mlxlogscore=706 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:51:51AM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -62.4% regression of hackbench.throughput due to commit:

Hi!

Commit "mm: memcg/slab: optimize objcg stock draining" (currently only in the mm tree,
so no stable hash) should improve the hackbench regression.

Thanks!

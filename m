Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2B2F1D42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbhAKR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:58:40 -0500
Received: from mail-co1nam11on2118.outbound.protection.outlook.com ([40.107.220.118]:17793
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389605AbhAKR6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:58:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8VmkfvLVK0AvrKepUb9S9HwNKO4JYxi8rI4XWB+MHRQL5hp5rkWPJot/X/K8oJ/g3OuZqjFU9g8Dy+s6QSbLo7FmZnXG4LLqJBmVLxZLa8hXypmT8m/CfhJQcWDAGuXUirS/GkukOrap9VSis22aZT9AuZle1GiRsSRBcpz8qgN8czYM7oELvkcvhgTnOINt+d3Dq2Hum1c2R+27Q/5gKeQ1R0zvINa5nj25/m1KmUq7XqjM33W+v0nbY7t2qVaHjn6GZozTl5dHgbC8weYRbKS45IOjCWfTNF5DHVQEX3cC4XiugzXeip4s17fjNoHHRBLMSb/TK8mgCi0NuXNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DFWhi6NjMlp2VwnrXMy3GY0lh+fJJC3cKWBZqk95eQ=;
 b=Hv21k8IPlwFVdiSS76lThvbOXVLLCfbaYNdy4RENLcdg+ngP6DeyLXiH+k9/5+8InylhUn+mipLkdeK3XAJa/BKWVlFDtt2TTJfxJpnM1k7YeyeQDeso1ZPqI1E8QFtlgTRkoyZ1j8HAP9SgItjBO2a/3mRjVOkr7MZ6iPBzplHThrKvvPVkX5SXyxIezRG0V9f7tNTRlw9RjyXwVf/RSaiu1DjvlvOkRSyJpsyfjMsftZjPc6qLV80bfTVjtX184AmF6SrmPUI/QnFuu1fqmYqU3pLSvwL5NRQ7oI2wXKlaZjdzCNWI3Pfv1PC2H0kuYbj7Cephb4dpCE+SaQgHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DFWhi6NjMlp2VwnrXMy3GY0lh+fJJC3cKWBZqk95eQ=;
 b=MacHB++zDhW/zIscaTvaAI0zE03LeNCRGUABVSHfmwuxkznK8OA9QlYgdL48PnrX2Q5rOpyC5CCJ4WtjHoQSeoX9/cr4/orE9W3eBZPYTH5cwJSok+6ghaaAveO6u4YvZ4X7/+BKsCjSlWhX/fuoqjtvlHykyu9mLrQd5QQRwX8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4293.prod.exchangelabs.com (2603:10b6:a03:12::18) by
 BYAPR01MB3878.prod.exchangelabs.com (2603:10b6:a02:90::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Mon, 11 Jan 2021 17:57:44 +0000
Received: from BYAPR01MB4293.prod.exchangelabs.com
 ([fe80::1854:ce25:a13:e381]) by BYAPR01MB4293.prod.exchangelabs.com
 ([fe80::1854:ce25:a13:e381%2]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 17:57:44 +0000
Date:   Mon, 11 Jan 2021 09:57:41 -0800
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210111105636.GA7071@willie-the-truck>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR22CA0069.namprd22.prod.outlook.com
 (2603:10b6:903:ae::31) To BYAPR01MB4293.prod.exchangelabs.com
 (2603:10b6:a03:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR22CA0069.namprd22.prod.outlook.com (2603:10b6:903:ae::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 17:57:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f596b5d7-1974-4a63-20bd-08d8b65a65af
X-MS-TrafficTypeDiagnostic: BYAPR01MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB38788A29C6EE4C7338C4033B9DAB0@BYAPR01MB3878.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++WywoVZlDAwMkNOX2fxC6IeGQzAoF+AiRpz2/Yuu/IvnL8wyW2ELg7a4BOH5bYchNPHesngq2GogW27oY2j4cO7iiJ0taHFDxz4FKFUg1UkgN+BihYtA4+cpSSaTr7OPxxdTOA1xoKwOwoTp2/FngR49QisfOQWjNTHuj4zM9F3YdqPCfG2ydcQKoEHpizeJXLKw5C4fYfAzUmDDu8DM9WuXRBzPvt+AwxK1CV6cL3MIkLzHEFr6E5C3CIoma9NWVrkYDuLZDP8T1U5/tBc307WipwtW54y8zUlh/oWIXLMqxrJ+vFBeMlauKxsPMiGqSjdZo/UWUbXKYTVR7VQgIjZBuPvJIceDudHegsZMJYANfzLszg8a6IHRYxlit4b+n/TPP9Fq1MMADUAV0hiqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4293.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39840400004)(136003)(396003)(346002)(66946007)(66476007)(26005)(8676002)(186003)(66556008)(16526019)(4326008)(478600001)(1076003)(4744005)(83380400001)(956004)(6496006)(6916009)(86362001)(2906002)(316002)(52116002)(5660300002)(8936002)(9686003)(107886003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bmrTT66BbUgxkhVVWRIO2A4bJEW4WjqCxzm1DtQIoIEEz7kBYMVcwhDpRyZl?=
 =?us-ascii?Q?9R3/A0XwaGmHgkO0kY0nx9QTxwXb79MMNw1IW8kBr8zfNRs1OXm2I6Bon7t/?=
 =?us-ascii?Q?IU7jTagJQBfJ90RNTE0QLOVFRkgZPgP0of8wG2Yae1ulM0u/7nd5bszkIwq+?=
 =?us-ascii?Q?ggHWGUtHkMt5S51q4fpusL9MjMQj5li2YnxYLOIuibV+Oe5PzHAFknjGDMVs?=
 =?us-ascii?Q?OsfQnX7cYT5xZbdAS2XDuCZ6a1L0r8I6VlKffbxVBuY8oIh/YXA+UT0JGQ/6?=
 =?us-ascii?Q?ilBeBkYZg8tNJK0lUC8Rk4pUwSo4VOCKv8JdJMh+icGihOUA8Q9/wvwFAlW3?=
 =?us-ascii?Q?XXswuCVZAMFpbNYizPtSrOw432ddpP4QZlHei9xCaFhUHZEIjrZaoc9y3H6M?=
 =?us-ascii?Q?avpHpoT7sjOPqP3MDUo97piphpybKnXZEIw1OMzhu7FHhQpMvRZ95S8GlwJj?=
 =?us-ascii?Q?kBZ+NGwktNtGTUhzo/wGJ8CCII12ax5fBqpuR3N89eQMhTiCN3k6B+BJwUCD?=
 =?us-ascii?Q?aJOnjFZdK/xdBjCCdmVUGsoCBE0T5aOd2PkqZBFtSsNbBAzNnaoc7jHLzv5T?=
 =?us-ascii?Q?bLq6G4KRzkODamOvHvCZ1eRmnED9uTVgr6+T9XQLryL5QWzyKeY8XPWItNc1?=
 =?us-ascii?Q?zPklF3D9aQQ2QMm7AnhFIpBWXsWR8tccnjhiLIJGW8fI0ZBlKo/CoPy+mZ9M?=
 =?us-ascii?Q?u2JSKJtiYyMIaZNIUbMD4inPux61dnCEa92av8uNnfR00wkt8ikX8H+SnZI4?=
 =?us-ascii?Q?KPRbx2mMf3ZkgUmRQyFsDOFG4twun55ZWr1x3O+KjhlB5sy1gho1yzk4FQGe?=
 =?us-ascii?Q?s1oLIBw6pExPcMxMMGE9NTR7GmH2Z+xjN4prZZ8pvZ3+9MbKOXkDo20kXc2p?=
 =?us-ascii?Q?knIhqwiV5V2SHSpXoffyRttoTy4ztpkT90bEry0q9djDLlQQu6Pp5h9a8hNW?=
 =?us-ascii?Q?NnH2fFgw5HFO4bCP49BuK5gAFJIxo44X3cweBGP5X1Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4293.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 17:57:44.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: f596b5d7-1974-4a63-20bd-08d8b65a65af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkRDvWOk4VyNa6ksA69CvjD4Dr13R1xytJUCQF3J+YAXJibfI/IvKK0i+QiQYP/Gwlo0UA11qIXAQeNpTGuKuJCYUpdvh04RqtM3SerJ2GTx4DwnZY6rVUug8rH9RSSs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
>On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>
>> Increase the default value of NR_CPUS to 512 from 256. This will
>> enable the defconfig kernel to support platforms that have upto
>> 512 cores.
>
>Do we already support such a platform, and what is it? I'm fine with bumping
>the number, it's just nice to be able to say specifically _why_ we're dong
>it.

I'm not aware of any publicly available systems that run into the 256
core limitation. At Ampere we have internal systems that would benefit
from this change as they support more than 256 cores.

Thanks,
Vanshi

>
>Thanks,
>
>Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBB2D1AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgLGUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:40:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12205 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:40:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce930c0003>; Mon, 07 Dec 2020 12:39:40 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:39:40 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1WysXiZa+/k3mfeII9pn1TguS7HPwxT1lXn6EaVBriET69GrZubo18L0OIZE2bJJ3pTDo8ed6y7BrDbowMoU7CQxa6rwCqEttorTRmR04vQ/rZKOlaX4auXqkCyG2qTjvqPAYsy3rrRgFsw3gj1i/EfitT5iyla7+9h0njqZ7u6boVOYGRT714WMLN+y2nC+w5xwuFM3sCxQpbWO4zFXPSk2S8RFj0QaLgLNR5Eps4JoK+cQuGy4jCwxxv/KWzjSJZ6KTJ36VyP4FTg2KzXIRfAAcr8V+jJMu6uPm2eZZuBrTm4ktSQrjr9nHQDquY2yPZ+mzd1BE5StB+mIZzCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x43gJJk2IG3c0yCWNgMXjRYyR6jyn1sl3LYfZgfmK1Q=;
 b=P+7KFAV1jZVQ6ng50FDT1XHPTArsgXVgMc0erLVrZocAYHjClmZ894HnHNgt24/sNLQBvS987Ud2PjOMkhc4/B3ESmpEpq7wA/cwtEotLgk5uN/Hqs1s8TvyLbUi2msgN9vOBpAiZ8NsQjGEjv/vYNG2dYAwdzdlX4dnHBjxQ0I6QmlxA8G/KNJqx1Wm7ieGmcfJZZWdx6MCJxzXJ3c51KA7ke9XPZ/pSExDEO/LQpfQV+fBoVVyVDCDqPQbsbsS4675Z31nXDW6ltThN444yB+uY3IEjg4eRu3XspKXN7Zscs9sO5PpvBfkIGRACP4jR2N/reQ3wKYg80OGimvqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:39:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:39:38 +0000
Date:   Mon, 7 Dec 2020 16:39:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>
Subject: Re: [PATCH -tip v1 2/3] seqlock: Prefix internal seqcount_t-only
 macros with a "do_"
Message-ID: <20201207203937.GE552508@nvidia.com>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
 <20201206162143.14387-3-a.darwish@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201206162143.14387-3-a.darwish@linutronix.de>
X-ClientProxiedBy: BL1PR13CA0467.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0467.namprd13.prod.outlook.com (2603:10b6:208:2c4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 20:39:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmNIH-007fE8-G5; Mon, 07 Dec 2020 16:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607373580; bh=x43gJJk2IG3c0yCWNgMXjRYyR6jyn1sl3LYfZgfmK1Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=AkiChL6sREKpWbOg+xMxG9grLwrFNvlvVF8NJfbjhWH3goaemfakT8mPxxbJlmKrA
         q5Kv9unWUtQTfrc30noYZbWH+JxlV4Z4NDvWHqbmwQzrJc7Yzis2tubDelc2zVmp/+
         d1Iic3yGn3jXaUv7ffcyY2Q+2utqdpje8Y34mKi/gkFFIRACJk5VfwAw2vfstRM9Nq
         6AzMw1ybDhqGFgIXqKoHI8XqVdvpvU1LYy2o58ZGBRzsBlHslcW+DfFOyYwTMGgTEP
         UcdN90yRpH+UxOLgfKOMLpMPNF6SLmN0DKUyayUbBeNxrjX8/eqs11eC0HM9l4ud+1
         n0fDeE73YzSaQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 05:21:42PM +0100, Ahmed S. Darwish wrote:
> When the seqcount_LOCKNAME_t group of data types were introduced, two
> classes of seqlock.h sequence counter macros were added:
> 
>   - An external public API which can either take a plain seqcount_t or
>     any of the seqcount_LOCKNAME_t variants.
> 
>   - An internal API which takes only a plain seqcount_t.
> 
> To distinguish between the two groups, the "*_seqcount_t_*" pattern was
> used for the latter. This confused a number of mm/ call-site developers,
> and Linus also commented that it was not a standard practice for marking
> seqlock.h internal APIs.
> 
> Distinguish the latter group of macros by prefixing a "do_".
> 
> Link: https://lkml.kernel.org/r/CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com
> Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>  include/linux/seqlock.h | 66 ++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

It is clearer, thank you

Jason

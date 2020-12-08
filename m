Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4041F2D2E96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgLHPre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:47:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5340 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgLHPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:47:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcf9fee0001>; Tue, 08 Dec 2020 07:46:54 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec
 2020 15:46:53 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Dec 2020 15:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma1ZbKQfWW/uXrKeIrzKsxL9TbAMFck/w3GTFiFSmVfy20ZVqQV5rVKicEMxwlXV2+Nk59ofd6oDlCLfLK5FLfzAF9ladQqhmlSbshxNYH26hZHOPT90TBKVEWXaX2/6s7YRAUyLx2JQ0psxCsfM6jDCcalHk5w2JnabuCIuFvowA9qMVmeOOxFXK/Vgdo+2A5OGwo6gHZpRd2LTKHsDuPLYHKIeJUDHKOcz9kn22LkbKuSx2rBhbryf416I0JuZKw0icmjQ4rGJGuN0HSff1/RdzZrZVlrDnYX4CUYu5nWHCC8GvDujaN0zqqM2nzTNycJr9j6cFV/83MXIjAwTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB0E+4KI/ryyAooQ9G7OLFeq1gC6efMUMVPhm6bzZwY=;
 b=IMBKcH6cKwe3Rfh4GhEnVQg2VSx5YM5qBaEHtQm+IE/jjDbZ7GJ1gtZT6zGbmbVMG22jzrjx2gnMNdnWTPJBNTojvMLEQo3xkEzcqlEHraD9kvCt336fFEXtmVN3sHcLdOgVt2oGJgPFtYgKDPjrqFX5M0UJVQyivlVJZITiaT6qUyOR7ctb0HBosNdiEOQm7zsCCbciYmqh5GdIp+3Ofq78IkZjaqcc47sV7/q1jfPlKyF/leK6HrELSS62Plsf2DP0Mn0pok9FaxKC1GVwsHzrruumlqZuJW+NbNx7EHMK8NL5Suqct3ucNcH0Tv0eg5duTNru+FYQF9gae84VAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Tue, 8 Dec
 2020 15:46:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 15:46:52 +0000
Date:   Tue, 8 Dec 2020 11:46:51 -0400
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
Subject: Re: [PATCH -tip v1 3/3] seqlock: kernel-doc: Specify when preemption
 is automatically altered
Message-ID: <20201208154651.GN552508@nvidia.com>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
 <20201206162143.14387-4-a.darwish@linutronix.de>
 <20201207204316.GF552508@nvidia.com> <X8+OS/K0+9ibIEGz@lx-t490>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <X8+OS/K0+9ibIEGz@lx-t490>
X-ClientProxiedBy: MN2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:208:a8::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR12CA0018.namprd12.prod.outlook.com (2603:10b6:208:a8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 15:46:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmfCV-007wQJ-3Z; Tue, 08 Dec 2020 11:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607442414; bh=kB0E+4KI/ryyAooQ9G7OLFeq1gC6efMUMVPhm6bzZwY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=C0DZmHS39Ekkdw3HN0WbyxsTt47hiFUezl98OfKBnS5VOvLmPjzD2tbhUEuVVCHX6
         1jMAwBuegpiS13fM12PLxxTpVimewj1sk6q45EiTP/+lT86Co8Lt98aalEuIJfBPTA
         Dxwh8eYVWq7aJJM7pJ2sMY4Sgg7FyPdtJUT1wlv/EkkjDwNga7yzz1BZx0WwzTeZxL
         YjAtiJt/sMbRZPdYHF2DrKVEypV2JoVSp/E8rKkMPHU3G5pqrbrB8e2Gul4DO4Uucx
         2WBErXsdCYTalNyfv7bPcNevoC4VBA9CafjwpTbMpZozd11sefFkjHTh0QJWoJAGnW
         iNTtBDQmFpM9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:31:39PM +0100, Ahmed S. Darwish wrote:
> Hi Jason,
> 
> On Mon, Dec 07, 2020 at 04:43:16PM -0400, Jason Gunthorpe wrote:
> ...
> >
> > The thing that was confusing is if it was appropriate to use a
> > seqcount in case where write side preemption was not disabled - which
> > is safe only if the read side doesn't spin.
> >
> 
> No, that's not correct.

Well, that is where I started from.. seqcount in normal pre-emption
disabled cases was well understood, I needed a no-pre-emption disable
case.

> For developers who're advanced enough to know the difference, they don't
> need the kernel-doc anyway. And that's why I've kindly asked to add the
> following to your mm/ patch (which you did, thanks):

That is probably over stating things quite a lot. If there are valid
locking patterns then I think we should document them, otherwise
people simply do something crazy and get it wrong.

It was not entirely easy to figure out why preemption disable is
necessary here, though in hindsight it is obvious..

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5528365D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJENN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:13:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8563 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgJENN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:13:57 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b17230009>; Mon, 05 Oct 2020 05:52:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 12:52:19 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 12:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmrmUsweSAW8gcuAO0J+mpgbG21Cxo424386h8BnLy5ApOnTGVpyFvyJj02OFtYgAS46MVV0HyFl0CHrai2b1ple38kZgLifJrtjAX6vvMWM5DwH0EuJgPprCmvvUPow0jcawMBDp7mQgMoqpFRzULm2Q+H/Q0IQLta6DzhZKJRi3Z4Pd1GRFxLyf67s+QqOoVVYSD39BjCv+sQz+C+vYCv8h6XkMXJMCDJ0C0Djeo7I2PuXKeEH5xXn26LE66huouNrfLtZrp8rF3BVDi8WgL301hBVdRU9robf4rbcO0LI77nocxxIZSkKQaLPRYJOGwyJAbxthl77UwXHvm8F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFpAt8G4kj4BWnNGLXnm/qbINihrY4F8VSzhDRBz/6A=;
 b=P+JHj/uJ1A97f5t2pXIc8Ap9fmj9vVwSlSALX+kw/cBCzkb7MNFamf+2LLkXElWvHKu2MuFr5V3/96yFYzylmN5K/iHrG/XFJZUscgHLQemaMplZ3Kb2vb3uMShww2XN8FqYNkoEQQ3k9aunYjsrpVmTqL57rx08pBwtkyLD/IP0xDo/BpGBj82Dl1eek0Mf1vX3r4JLrXXqrWvWKi8NdbFS4C3/N025dzwbUEIzCm+sUHvrJsQOqe+Hf+VRNhjceM9LNIyCCG+MTS0AbyWGSCwzaj4whSK+E/rIAig5on0HpnShhXYFzes/wCBuV1m7zziKqpPCYMWmKXfwRAm6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 12:52:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 12:52:18 +0000
Date:   Mon, 5 Oct 2020 09:52:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
CC:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Richard Weinberger" <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        <linux-um@lists.infradead.org>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
Message-ID: <20201005125216.GV816047@nvidia.com>
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
 <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
 <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
 <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
X-ClientProxiedBy: MN2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:208:234::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Mon, 5 Oct 2020 12:52:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPPyS-007cWz-3n; Mon, 05 Oct 2020 09:52:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601902371; bh=yFpAt8G4kj4BWnNGLXnm/qbINihrY4F8VSzhDRBz/6A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=i8J+K6GhYXSmZ+B3n3u7T6kWRWAkweQeQ9/IZEUAQgZAvlrBuO6fTi01KWWMNYqXN
         qUaqUqTiIlk9l5cw4YFuwQjGlqm1oLI0T7I/bjbLGlEnKSMrz9+3iqbsj5GhXowNIQ
         pDNjpLkMY2kkisn2AjadS2GyuPQrVSBkMQApD7M63jZDVVLOM/o2C4/uai/cdn9EDa
         V15IqCW652gLr4m2t9BBpbkdavfFdiiXprRenWgh+uvj++oXmXAzHUsVFOJUjEMcax
         csYGpeZxNuu6Avwk8WjFduxqikz3HiVBbMzS0KGR4bwkuKlVqX86wnRFyXU3EJPLWd
         c2HTpOv3dn0AA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 03:30:43AM +0200, Jann Horn wrote:
> But another place where lockdep asserts should be added is find_vma();
> there are currently several architectures that sometimes improperly
> call that with no lock held:

Yes, I've seen several cases of this mis-use in drivers too

Jason

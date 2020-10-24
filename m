Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689962979D3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755277AbgJXAFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:05:04 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:60072 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755266AbgJXAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:05:04 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f936fae0000>; Sat, 24 Oct 2020 08:05:02 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 00:05:02 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 24 Oct 2020 00:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYsFPGIk0yFfbJz0Y08nGIL/RvUvkb4XUU4WlV6IxJ5aEj8NI29hbt8n0Hc7IENfjwfCH3rk83mtn1k7gGSOZGOFWZljIdrxD5CspmWEKEKi8PAvFbx3d6F+DWHQzqCYLHpGnjJs/O+pTZmm79u93kjD7u2DlmAXOhCY8/swieleJWJNGCk6D5Y/I9iaEzKrQiOB8/pPh745t0spBejNlrUWdxYHEFt4k120WlzdGxK+u+h565sIB7zE1/Gq+5ZcRTvGC2WZPNCyA2sqUDfwgrW4f4Yopd2VA9BqVvnzD0mY5UQp5HQYYP66t4UaS2gQftWbZG+6Pz0CBGHdRi54lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KguUudpUfwVQkloHAjPio8f/9ooAzoaLiOucwSdlW5w=;
 b=Dbg2lkURV9NSKjhY0LI3ZpP0/tuTlhac+wajvDZcjo3fEX7zdCAVioS/7zjVR7s2uk0yr3HNJpA7DMhKzLHM+aQUInawY+8cXyE6V7V9howVElUo/mRD9fynFmYnX1Bdfi0Zbjk6n03vK+YvB0szb3QMXOSZlKShESwFWtDJZLAkOx9nko7IUkFhSxe6n7bbBCIuG7JWZUCi+Tl081vfRLApY8OhoND0cKg7doD2dVkQkMQEN5vnAay764xSd2BxOwiwKr3a3J8CFD3pHVZFmz4ck/mvuyDmTeAi9NB9e/LwO7eYBDjEuJgYc0FM9YGxmPXfO/eNhqABYGcLYLklYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Sat, 24 Oct
 2020 00:05:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Sat, 24 Oct 2020
 00:04:59 +0000
Date:   Fri, 23 Oct 2020 21:04:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in git
Message-ID: <20201024000458.GA1669055@nvidia.com>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
 <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com>
 <fce55e74e4331c6e19c4030a4e02fb35ca5ee4f7.camel@perches.com>
 <CAMuHMdUp5U0nnp9LfWgY0VnkRppMVXZU9NSpWqcMKYM_zRXRuA@mail.gmail.com>
 <3d9ef962b7007308a538e42375adf09d058ee8ab.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d9ef962b7007308a538e42375adf09d058ee8ab.camel@perches.com>
X-ClientProxiedBy: MN2PR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:208:19b::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0053.namprd19.prod.outlook.com (2603:10b6:208:19b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Sat, 24 Oct 2020 00:04:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kW73K-0070NK-He; Fri, 23 Oct 2020 21:04:58 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603497902; bh=KguUudpUfwVQkloHAjPio8f/9ooAzoaLiOucwSdlW5w=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=F4kCfl0t3Ps0lb0b9myCKKozVCFzk5q6IPehOw9smUAVOs0QSyvXK39qlsP77ZMf6
         3UIsuY5zDTT+1bvPYzinxIawYVCB3/a6NiyvO5fqEIpXZJivks66ZXs6dFYdkkzOns
         CX6J7qZUrshsZ1jLfs1sDTcHC/p+EYJFgj1TM3gKLHFr72TFSbRCwzVDm3CBCqC5nM
         UIiWUXTm45gnD+4fZlO/wyEYkOssAsEVcB+H3CmQ/194L4fJVZ3Hm8lb57x6do1YE0
         hLFYuItMSdGHP6nAEVVcCyiNin7quy5tZPlhE8MuGeNRA4OM1+JSCLkl2tyMXhjj80
         5b55e/ZeeZLfQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 11:26:59AM -0700, Joe Perches wrote:

> I'll post it again as a reply to this email with a
> with a sign-off and a better commit description and
> Linus/Andrew can decide if it's better to revert
> f5f613259f3f or apply it separately.

Gentle reminder on this, it is the last weekday of the merge window
and checkpatch is still failing on Linus's latest (b76f733c).. 

   Global symbol "$gitroot" requires explicit package name (did you forget to declare "my $gitroot"?) at scripts/checkpatch.pl line 980.

Thanks,
Jason

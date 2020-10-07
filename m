Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F9285ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJGMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:12:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:47489 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJGMMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:12:42 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7db0b80000>; Wed, 07 Oct 2020 20:12:40 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 12:12:38 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 7 Oct 2020 12:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keLZp6yeZPSxJ7U4dy1VqtUuUatHuHkga5asx+wMHWrOCnxDJ6UWH25F8bXRsaYHGjsktsuV88/Y1sPCR+RBhs/Geakgvqz3umVc//laiPzKSoaY3bWr2CEeThPsjLVOTn0S0DxL4pzQDCQXAPIoYXAUQx0QuVW/UbAQ/z9Tb9jYBsZ7YtbH3dBvlbDWw9sfgwvXI9/SkVJVwPVErbYe5KhIISxnwZoTqFB42E1lyNvlAY6r+X/T8Ijh4gA+QuAA4ayw1D8LWt26stLwlds3HXJCtkitO6WR3OlLkc+phQ4QK0i4pcP84/Rwt+Wf1wmBlmMelotq9+7RR8Z74K8i1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwDiLpOOo59gH4WA7MgEREfWHJUEeAWKFjtX0Y5zZ6Y=;
 b=mRWdBvtoEaZ/z66EXEkqjMpxRRRMe95p1gqujjg/X4bMWPa6njGEpmIrFw3dgkV6H5ImY65IDMFoaXppJJSbESixMfBoZ8djZTDXhgEJc6L0nIzRmG5NPoGk9yx7bU+WK4OEH3C2JsIm6Zv1x51oT7Yb5+wRwVxCo8jRkto+Y/p3M6y7lEUJB+GchrX0WBFFNul8BPiTuspE7dYKYU6xRHsxNVEgvyJZ8boMs+LpCwqMQUShKVlv5JoTtjx5f/+CLVP0ndbCLgb3AP7lG2pYFVw/hPMpNwvV/mKuCNodnE+FmxW0psfc5Vka4eIujOuikoCt60vl5Wb/fk0K1GhK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 12:12:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 12:12:36 +0000
Date:   Wed, 7 Oct 2020 09:12:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        <linux-um@lists.infradead.org>,
        "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/2] exec: Broadly lock nascent mm until
 setup_arg_pages()
Message-ID: <20201007121234.GS4734@nvidia.com>
References: <20201006225450.751742-1-jannh@google.com>
 <20201006225450.751742-3-jannh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201006225450.751742-3-jannh@google.com>
X-ClientProxiedBy: BL0PR02CA0091.namprd02.prod.outlook.com
 (2603:10b6:208:51::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0091.namprd02.prod.outlook.com (2603:10b6:208:51::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:12:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQ8J8-000t0N-I5; Wed, 07 Oct 2020 09:12:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602072760; bh=pwDiLpOOo59gH4WA7MgEREfWHJUEeAWKFjtX0Y5zZ6Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=bob9TmHWqtRuwB38MceU4wsiJyhaezYcw58sG/gpnO67eDTKadAIK2t8PRAF42XnG
         GB4n+2InfP2V3W0Jfhn8vEYEl7x3IJz+XEM4KtUv7zFKDnyQThiL/JyI2rj31vaPnF
         kh+t6RJaBMEX+pQpDgnKBXQFsfOrPXGFVuZaH/1WwJ88ciYXcbrF2v0OfCfstlCoNP
         rtfhNNt1Q0N7wShj5+DSNfrppGDxmN0Ju+bJKCBIZ8t8VLaHHqjDQ9rzRxy3IX4KNm
         zO6WpTa00U1oYkz8lzSNlSgE73UspzSL8ZHNBKdXHjeuQID5j2MWXIDbGmC//gEApQ
         XRSWjnIPvKhBA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:54:50AM +0200, Jann Horn wrote:
> @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	me->mm->task_size = TASK_SIZE;
>  	mutex_unlock(&me->signal->exec_update_mutex);
>  	mutex_unlock(&me->signal->cred_guard_mutex);
> +
> +#ifndef CONFIG_MMU
> +	/*
> +	 * On MMU, setup_arg_pages() wants to access bprm->vma after this point,
> +	 * so we can't drop the mmap lock yet.
> +	 * On !MMU, we have neither setup_arg_pages() nor bprm->vma, so we
> +	 * should drop the lock here.
> +	 */
> +	mmap_write_unlock(bprm->mm);
> +	mmput(bprm->mm);
> +	bprm->mm = NULL;
> +#endif
>  }

It looks like this could this be a

  if (!IS_ENABLED(CONFIG_MMU))

This all seems nice, more locking points were removed than added at
least

Jason

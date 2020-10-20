Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86F32942C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438027AbgJTTPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 15:15:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:63255 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437999AbgJTTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:15:47 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8f37600001>; Wed, 21 Oct 2020 03:15:44 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 19:15:44 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 19:15:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLk47c7LirqXN8gWhw1M524x8fRr6Ziv7ybaTR5TXIF7U8nfQu5mc+xSauiPFHhBV85q9uxjyLeOelsNvQQ2HYmRlHIdQZVCUxB6mcNMSJzPV1xnpE73r3syJbGcpRDi3r481RBg6sgmzYJJX11S/AYWn0AjQ08eNLsEVejGCfSpafUFrQrvzZeuAAV0jZbbOB2U92AJjfuVzB/Meo0WOv8QjL51xh7zAYlFBFROsgV/G86nMIZGmOUDmJG2DyQsJWZXigrVoAo3vNMxjDRygCwavet6ROgQT+2Wf+JjumTsmk14vH7Dx8gkAC9MPoly6lpHp8sp8oWdCSlmokzDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XrSliCG5twkvtPWgvbBPq+Pd5LMQX7D0QJyPZ2GljE=;
 b=PDK7Z11bDTfBCEarqYWXeiq2dNmRw2Jh9laypRvqzAWaH/MlpGYXIe5fgfE6VP0/CmCNAjYFEIlq3T7bNdXFkBtoJP7XTInsDZTFCQ9r0p5lh6ISIZtAbKlO65UQ4PrZUOIx10oo15TmPHWMfWy0jZG12lPu7hGZ5kWLTtUWGzRcMx3empirIi2pvEXVwzZr/aLjiN6Tphd0Zi/0mQ+OCaV8odvm0ieUHzf3IWfby8yJQttPBf6GLkDvDPWdlkJKb+3fWARwtD5dVKmfMSrV1JW4TlNH2emYmAi7FIB6SKrGmPTiJw41KJcCjC4DBww8uTGHWh5vDtvBwvIgwF5QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 19:15:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 19:15:42 +0000
Date:   Tue, 20 Oct 2020 16:15:40 -0300
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
        "John Hubbard" <jhubbard@nvidia.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH resend v3 2/2] exec: Broadly lock nascent mm until
 setup_arg_pages()
Message-ID: <20201020191540.GM6219@nvidia.com>
References: <20201016225713.1971256-1-jannh@google.com>
 <20201016225713.1971256-3-jannh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016225713.1971256-3-jannh@google.com>
X-ClientProxiedBy: MN2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:208:23c::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:208:23c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 19:15:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUx6i-0033Qn-R6; Tue, 20 Oct 2020 16:15:40 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603221344; bh=8XrSliCG5twkvtPWgvbBPq+Pd5LMQX7D0QJyPZ2GljE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=XBVk3fkHDF1qXwO9U3nvWhPHvhlyo7HxsYCMBm7iCQjSAo3YpSip0QXRDpHvXTOn2
         guY2dmsTSXhjndQCyp1Cheh0jW11fp0wK4N+fjoLNXpbxzcaP4clplknhn3vV56nRZ
         hsg1CaMBSMuElovaTrUFZ+aPvry+fIxz6WILD6OX+HrrbKWITAFUbIRZ8JDPhBLqHH
         1vitkc9XFvzlvGplhSH5CRXvRpoYTWO4Kv9vpq2YhswWg4Vi3X6MgH5XdQmE79xtq7
         RJwRXkcnr2ncCfFkpLoez9+YwlLHxiJv+IFpKy1/27+ZosYFhfujM4LqdmD/oeG8ft
         8sMq8VJaPepOg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:57:13AM +0200, Jann Horn wrote:
> @@ -374,17 +366,12 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	task_unlock(current->group_leader);
>  
>  	err = __bprm_mm_init(bprm);
> -	if (err)
> -		goto err;
> -
> -	return 0;
> -
> -err:
> -	if (mm) {
> -		bprm->mm = NULL;
> -		mmdrop(mm);
> -	}
> +	if (!err)
> +		return 0;
>  
> +	bprm->mm = NULL;
> +	mmap_write_unlock(mm);
> +	mmdrop(mm);
>  	return err;

nit, but prefer 'success-oriented-flow' eg invert the 'if (!err)' and
put the error unwind in the {}

> @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	me->mm->task_size = TASK_SIZE;
>  	mutex_unlock(&me->signal->exec_update_mutex);
>  	mutex_unlock(&me->signal->cred_guard_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_MMU)) {
> +		/*
> +		 * On MMU, setup_arg_pages() wants to access bprm->vma after
> +		 * this point, so we can't drop the mmap lock yet.
> +		 * On !MMU, we have neither setup_arg_pages() nor bprm->vma,
> +		 * so we should drop the lock here.
> +		 */
> +		mmap_write_unlock(bprm->mm);
> +		mmput(bprm->mm);
> +		bprm->mm = NULL;
> +	}

The only thing I dislike about this is how tricky the lock lifetime
is, it all looks correct, but expecting the setup_arg_pages() or
setup_new_exec() to unlock (depending!) is quite tricky.

It feels like it would be clearer to have an explicit function to do
this, like 'release_brp_mm()' indicating that current->mm is now the
only way to get the mm and it must be locked.

Or, more practically, the load_binary functionc can now call
vm_mmap().

Anyhow, it took a bit to study all the parts but I think it looks
right as is.

Jason

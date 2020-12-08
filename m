Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E42D2159
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLHDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgLHDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607397266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mthuFi5TW9YsKTeZpnIHZUZ93ckX2z2UHw2lFllgY/0=;
        b=TIhed8bOwJ6uzgkc9VAfoWSw2dRqsE4hTczOhgR5Mh8YBqEy+sBfIq0VmUKG6BkTgfLQB+
        CKAnjheT5Gabqi/zkOaRIIADindLNHQYWpPrM1zxcm/QsGPsbXEKptMVCRl/zwL33HvUsJ
        H/YKhSrSjOPDnzohrzqwQT1W/hbzrBo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-WvlGpe9xNWiKvMT0yM9qVg-1; Mon, 07 Dec 2020 22:14:24 -0500
X-MC-Unique: WvlGpe9xNWiKvMT0yM9qVg-1
Received: by mail-pl1-f197.google.com with SMTP id e11so5980882pld.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 19:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mthuFi5TW9YsKTeZpnIHZUZ93ckX2z2UHw2lFllgY/0=;
        b=SVWIE7BSqfmvegPJYwOSSHHKXyqXx/3Qc6+MdGQsJVmmKu1NzB3xYjxZTbz6KuAxr5
         0PV5jwNQ0PTpyU9POnYbdAZWNmzBW8h1yp6KnwhiafjbvP7XRzabVov2zvpBMI0NZckD
         LnMaBDTjkZaWqOfRdwUNkxaqHpqUKbC5D6zC+ilSZiKFcuWTAK3QJU4yb2YeTQta2glV
         302MxtUIw+ORXn1D4RRcpvIi0aBiG6+agQ/vpsw//NnCeZxIfYgV+38NapykZkx+ugeb
         E8z4S0PNfE37TOR1Jl11VaUwlJBqPBTea+ZOcLeP2UcBATIzNAgdSlnQ2IRfxhUB8DvM
         rCwA==
X-Gm-Message-State: AOAM5329l7PfoDdMcl87V6tS9CBfucojIixPJto/fBAPTfNw+MJpOQXy
        yY3EBmV29bdHUFM/cQTbxG+83b7VGyWF30zjjxUPehWGsxX/XRTGk1blW0pnsYEL0FoBQ6yepK2
        056qJB9CTF9RLBRH0bu9Xy33M
X-Received: by 2002:a63:1346:: with SMTP id 6mr21055465pgt.330.1607397263334;
        Mon, 07 Dec 2020 19:14:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL9m0kS6AeCJmmwicuLitmZb+KGqh/Eyv/pgMonwN3yI3VDUnAIQSSKutvLGtoYviZJC0HeQ==
X-Received: by 2002:a63:1346:: with SMTP id 6mr21055447pgt.330.1607397263111;
        Mon, 07 Dec 2020 19:14:23 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c6sm13738832pgl.38.2020.12.07.19.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 19:14:22 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:14:12 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208031412.GA3006985@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207012346.2713857-1-hsiangkao@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Dec 07, 2020 at 09:23:44AM +0800, Gao Xiang wrote:
> Previously, we played around with magical page->mapping for short-lived
> temporary pages since we need to identify different types of pages in
> the same pcluster but both invalidated and short-lived temporary pages
> can have page->mapping == NULL. It was considered as safe because that
> temporary pages are all non-LRU / non-movable pages.
> 
> This patch tends to use specific page->private to identify short-lived
> pages instead so it won't rely on page->mapping anymore. Details are
> described in "compress.h" as well.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> tested with ro_fsstress for a whole night.
> 
> The old "[PATCH 4/4] erofs: complete a missing case for inplace I/O" is
> temporarily dropped since ro_fsstress failed with such modification,
> will look into later.
> 

Do you have some extra bandwidth to review these commits?
plus a commit from Vladimir Zapolskiy:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/commit/?id=c8390cfaa07cb9e9ccaa946a1919b69dfb34bad1

The merge window will be open the next week. I have to prepare
the submission from now.

Thanks,
Gao Xiang


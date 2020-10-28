Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B329E0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgJ2BgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729724AbgJ1WDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/ijsR6wL+A44Ymsd37c8yCOb9K4D0s+LLkBgVrjUk=;
        b=ANs8mntHQp2+JP+RmwHHM1tT+CRoON7IlCBcLckdb0yc0U1jYmBXUgwCwqn1ARSlh4kHXT
        kU+M6GBM6tU82geuV1avZhDFdf/3dSQmSVmEPWS4L1wm56E+JqQlusAp/WXaDznCtb5/zk
        BIvabZbuMNlJNAomM4FnePF3pXElJCU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-1ugKgKmUP12ao3WPIg5uWw-1; Wed, 28 Oct 2020 10:02:40 -0400
X-MC-Unique: 1ugKgKmUP12ao3WPIg5uWw-1
Received: by mail-oi1-f198.google.com with SMTP id n62so2262617oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 07:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pA/ijsR6wL+A44Ymsd37c8yCOb9K4D0s+LLkBgVrjUk=;
        b=gY1SUZdAohM17lX9D/AC2BUAEanok7V5vtOdpMG7d4tXSVwN34Usv7oRtwn1g5ofPr
         vaD1PAXTl+6DPkZgVx1pK6GklHn/RD8A2aMtr3BpadmhYBQ1JomnmclRaFTXLk5hEPIW
         kiSafs2dFMRLrvYIPkvx+NVCut9ayX2Vz9Jln22uXXLqqAf4k8I1AfwqnTadTnSbWd93
         vDGxnSBqlpZEkgHXPIg3Hj7wzHJPQF6pF3MwBHuHXvMqmeDT+W5L6Ye2XVjfizN9HHrM
         QdLL4hVmJm6EtelEIyUovLbORDCp5RTAljg5YU5HMQeNm1prb4srOlr9JUVaZpnjWkjK
         n6Cg==
X-Gm-Message-State: AOAM531nlYLjWL2HwgpwTNT58yfdsJX1XU0cPioiJ520r8yLDWz+1R2H
        EW2eTVbIBQE4+fHVH6cbI6RMuJFLbUfAFeOOJBXLj0QBlettPy3pwmma/h7TqMzf9NElcl1wG2v
        lQm03siMJElAxMasOo0YlL6JA
X-Received: by 2002:aca:bc89:: with SMTP id m131mr5038503oif.48.1603893758574;
        Wed, 28 Oct 2020 07:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK8HVad9mubt69p9XV0Zovu/5ZN2GiKzorEFq6aLJFRbquF2hpuRfMn0Pgaxfxph4ok5FPqw==
X-Received: by 2002:aca:bc89:: with SMTP id m131mr5038471oif.48.1603893758162;
        Wed, 28 Oct 2020 07:02:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b125sm2656559oii.19.2020.10.28.07.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:02:37 -0700 (PDT)
Subject: Re: [PATCH] agp: amd64: remove unneeded initialization
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
References: <20201028133106.5420-1-lukas.bulwahn@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <37c4192a-2757-574c-85e1-1df05c6a7a31@redhat.com>
Date:   Wed, 28 Oct 2020 07:02:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201028133106.5420-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/20 6:31 AM, Lukas Bulwahn wrote:
> make clang-analyzer on x86_64 defconfig caught my attention with:
>
>   drivers/char/agp/amd64-agp.c:336:2: warning: \
>   Value stored to 'i' is never read [clang-analyzer-deadcode.DeadStores]
>           i = 0;
>           ^
>
> Remove this unneeded initialization to make clang-analyzer happy.
>
> Commit a32073bffc65 ("x86_64: Clean and enhance up K8 northbridge access
> code") refactored cache_nbs() and introduced this unneeded dead-store
> initialization.
>
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting binary is identical before and after this change.
>
> No functional change. No change in binary code.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master and next-20201028
>
> David, please pick this minor non-urgent clean-up patch.
>
>  drivers/char/agp/amd64-agp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index b40edae32817..0413b3136541 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
>  	if (!amd_nb_has_feature(AMD_NB_GART))
>  		return -ENODEV;
>  
> -	i = 0;
>  	for (i = 0; i < amd_nb_num(); i++) {
>  		struct pci_dev *dev = node_to_amd_nb(i)->misc;
>  		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {

Looks ok to me.

Reviewed-by: Tom Rix <trix@redhat.com>


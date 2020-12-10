Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88D72D6166
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbgLJQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392351AbgLJQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:13:16 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2AAC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:12:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l9so6033048wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zUKjdCr35kTtWg9pE3u73paElIIDHX8nqIkj6s1ib6s=;
        b=hrMth0SEQRxie/k9/Vd7afehjyxbhsINzLj3zAnJA9Yc81plSsX6q1YfAyDsHvD8Cs
         NhXOc1znnPbG3vyEKM9DACHYZ5NFqG9IRNduTMAMmU+NSnCAFrqSyFlul4FWnPlN+V2I
         xXoo9Rk9qDlkvKVMd9QCC2rDMzMv7lhhfCTYJckuWL/jfgBUWm7byY5YYFauJjdhobmM
         ZzTSn051klLcV4J6Q6Uh5PMzfZeFk1hLNSNbsP+wnhYDED0htSljIwO0Zj8wFkzlTzQs
         +GObVaXpGhdCoMMkgmsXpeE1vBErVdcDEDV897ys+aI1sNw5+s/MI7VAHS7pcqsHcUuk
         yiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUKjdCr35kTtWg9pE3u73paElIIDHX8nqIkj6s1ib6s=;
        b=GSjpv+swwoyu7cNL2VGnruHeCvKM4ZrPJ5o4+RnBIrfasV5pHoiC0OnUjEdOBOfE6E
         T6RmK/WbVfMXW+oFr7ak9I2tm+yZQ6JLZvuzK8oCK3RgdaT3M4gIrScFRYlnUP/8glBm
         tInTruBlWmyIaEy3p7rTaU9h4xQ3nEhhDsgidRbPiBdLFqL+Mxu1JYFs/rta48AFfKhW
         8Q2U/FXdPX9jRYQ26rVih5RydIWuX108C7AH2KjA2ckW9p8sQMhy/jeS1EStle+D6z9N
         AZFf8Rdxcdp662nEZQArCbiP+73MC9wDdZM1ATs5P+eLLHbjybLDJTShS0BNCHdeVELS
         XmTg==
X-Gm-Message-State: AOAM531Vc5TExX4CWLCdgCimkGBcKhpHpvbGltmqenISWTR5vjfjntXn
        vGM5J3GrlNrd+1ACKYyn5zC6GA==
X-Google-Smtp-Source: ABdhPJwVb74KOfvcGXHiHkge7ndt4jKhFNLiuM54Sm+I1XLwgYWzbSyRk5VT20QHXOA0AEE70A78Hw==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr5226281wrm.21.1607616754939;
        Thu, 10 Dec 2020 08:12:34 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id n14sm9955554wrx.79.2020.12.10.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:12:34 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:10:29 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v2 02/12] mm: memcontrol: convert NR_ANON_THPS
 account to pages
Message-ID: <20201210161029.GI264602@cmpxchg.org>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:14:41PM +0800, Muchun Song wrote:
> @@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
>  		 * disabled.
>  		 */
>  		if (compound)
> -			__inc_lruvec_page_state(page, NR_ANON_THPS);
> +			__mod_lruvec_page_state(page, NR_ANON_THPS,
> +						HPAGE_PMD_NR);
>  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);

What I mistakenly wrote about the previous patch applies to this and
the following patches, though:

/proc/vmstat currently prints number of anon, file and shmem THPs; you
are changing it to print number of 4k pages in those THPs.

That's an ABI change we cannot really do.

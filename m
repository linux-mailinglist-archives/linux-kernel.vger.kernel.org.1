Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941A32ADE06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgKJSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgKJSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:16:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D29C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pKCQZvoOQvWJRr3uzI2/rpjCuOUN8d8NnWJ8MSJwkRQ=; b=ipGMqHHT+Uh0XxKxUPFmvFKydJ
        dMurDpcXKK5sQ2/Kql2V4k2Osotc5yw2+jhhptLKc8IM6uVGToetKBKz5EgkjKfrtYk4Ga1yyGz5k
        H6B4TO7qAC4KL/3BDzhj9GYRytENrSmJ8eb6ThZP82QFvASFzUgGkpLADZsH9g/rhw8UThhWuUblc
        6HdOuGwSctoZheyJbn0UDl6le+M/JTi/OLZ27iLf+KTEL2EZXAlY19AEbq9tlOmDMatiE0MNx9Sqg
        h4OgllRyJrqxS4wkayL/q+JaAkQrmv5R+1q81aARrPjo9YD6XAbxgi5N0UEVMjqtscS9xLc5A1ZcY
        wuXuDAAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYC4-0001JN-3d; Tue, 10 Nov 2020 18:16:36 +0000
Date:   Tue, 10 Nov 2020 18:16:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/5] mm: migrate: skip shared exec THP for NUMA
 balancing
Message-ID: <20201110181636.GJ17076@casper.infradead.org>
References: <20201110181250.264394-1-shy828301@gmail.com>
 <20201110181250.264394-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110181250.264394-4-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:12:48AM -0800, Yang Shi wrote:
> @@ -2142,6 +2151,10 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>  	int page_lru = page_is_file_lru(page);
>  	unsigned long start = address & HPAGE_PMD_MASK;
>  
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +	    is_shared_exec_page(vma, page))
> +		goto out;

Why include the IS_ENABLED() check?  Once the ~50 patches I have pending
go in, shared executable THPs can exist without this option.  And can't
we have executables on tmpfs today without this option too?

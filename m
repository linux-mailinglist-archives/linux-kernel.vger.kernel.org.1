Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8B2DAF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgLOOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgLOOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:51:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2764C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SP8YFINVPRnhThewKPK7I5XpcEcBBVki7EiNwPcf1fc=; b=luZF/e7osMddljt2htKndpuFEp
        l/jNb5iedS8YIq6K3EVwCXOEZyJ/ruzqR3vxmGZopX9mZHSrUl8m9J/BZAmkY3wnVROGmxMczLHuY
        h1Syot32XN2M9f2645NlPoTRjdkAUV2+hnsQnWnHIwvbX4+UV/cyP6Ur8JVazHrbUfjbDu8dqay+a
        vsbnsQ84Gt4GAwOCgAapaBFeTAvwrebf1SPjFcupXyzwQNQ8mAyxaNkR14XuNMf0YBanrkDFogrRl
        D/jZEcC8vx3ZADUMsdhaHRQYJS0muf5gOP90mQPa1C3rnsM+L5lV4NxcM+qMWShFv4tWzMExXlyUG
        FmRpalcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpBey-0004lg-Mx; Tue, 15 Dec 2020 14:50:41 +0000
Date:   Tue, 15 Dec 2020 14:50:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@google.com>
Subject: Re: [PATCH] mm/mmap: Don't unlock VMAs in remap_file_pages()
Message-ID: <20201215145040.GT2443@casper.infradead.org>
References: <20201215141300.1436976-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215141300.1436976-1-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:13:00AM -0500, Liam R. Howlett wrote:
> @@ -3025,25 +3025,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  
>  	flags &= MAP_NONBLOCK;
>  	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED) {
> -		struct vm_area_struct *tmp;
> -		flags |= MAP_LOCKED;

I think you need to keep ^^^ that line because the vma needs to stay
mlocked.


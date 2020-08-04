Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4873723B33F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 05:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgHDDZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 23:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgHDDZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:25:17 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889392068F;
        Tue,  4 Aug 2020 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596511517;
        bh=OkGwV19lvozFPP7dvqytHQBH60u/k0mvdZOQB1UkLE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y/Ch27bn+/Ew9z341puf5vUzKvpE8kaoo2Ovhp5JSZ6/z9CIlRnJhpgV+6TDqBF5X
         wWxgClB9pQHnM1gHsE+2UEk8OF0MTn8/CkP6Dv2I4+D9LdOocSScHMXUF1lUWmHluT
         PUH6/jfafCch42+cqqBRgWgnlR4aJm/ng1E9Scpg=
Date:   Mon, 3 Aug 2020 20:25:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, mempolicy: Check parameters first in
 kernel_get_mempolicy
Message-Id: <20200803202516.5d6c1c770137cb35a288f514@linux-foundation.org>
In-Reply-To: <20200801090825.5597-1-haowenchao22@gmail.com>
References: <20200801090825.5597-1-haowenchao22@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Aug 2020 17:08:26 +0800 Wenchao Hao <haowenchao22@gmail.com> wrote:

> Previous implement called untagged_addr before error check, while
> if the error check failed and return EINVAL, the untagged_addr is
> just useless work.
>
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1632,11 +1632,11 @@ static int kernel_get_mempolicy(int __user *policy,
>  	int uninitialized_var(pval);
>  	nodemask_t nodes;
>  
> -	addr = untagged_addr(addr);
> -
>  	if (nmask != NULL && maxnode < nr_node_ids)
>  		return -EINVAL;
>  
> +	addr = untagged_addr(addr);
> +
>  	err = do_get_mempolicy(&pval, &nodes, addr, flags);
>  
>  	if (err)

Well, the compiler will surely avoid that useless work.  But the code
is better this way.


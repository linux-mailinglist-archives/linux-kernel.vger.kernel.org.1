Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FA1F100E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgFGVuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 17:50:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD86C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=qzT28bPo7SQhdysImYQOC48d1IlfGj87pYL9CAPSWNY=; b=Bj1vX63EPMrQNNxtjYWoAOMdr3
        NTqPsBih+gp1SihTA7w2c0CKK/3KP++t8oy5HOwSFpmTWfmv8um0t+PnVAyw6/1xN+a/NwqzkIeQM
        hYYXuR+IZaBWAvl3W3qfsUqT28EPOCJJw8CgiUYPbI1G8b7I1YjXVM6wM0schCuVoYIBAA6JcHHOK
        P/gtz0Bjva0l3qlaW1cf5yDwkYHGUF6Y53ezD8m+HhvTs6ZYF2gAYOCBhtDTotvPlIlqhPhI/mdoZ
        RbGYPiO61L09Pd7CqNgUBcVeW9sDaf60B+98vhCtLU/6NwMtWS6PTz+RcSwTnBL9HyV7AG1Z+Gla+
        jIVAaKnQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ji3BG-0007K3-Jc; Sun, 07 Jun 2020 21:50:14 +0000
Subject: Re: [PATCH] fs: ocfs2: fix spelling mistake
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20200607212115.99278-1-iamkeyur96@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <037d3c9a-2abe-1e4e-eb91-a14f2e84e629@infradead.org>
Date:   Sun, 7 Jun 2020 14:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607212115.99278-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/20 2:21 PM, Keyur Patel wrote:
> ./ocfs2/mmap.c:65: bebongs ==> belongs
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> ---
>  fs/ocfs2/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
> index 3a44e461828a..39a77e903fdf 100644
> --- a/fs/ocfs2/mmap.c
> +++ b/fs/ocfs2/mmap.c
> @@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
>  	last_index = (size - 1) >> PAGE_SHIFT;
>  
>  	/*
> -	 * There are cases that lead to the page no longer bebongs to the
> +	 * There are cases that lead to the page no longer belongs to the

I would say                                      no longer belonging to the

>  	 * mapping.
>  	 * 1) pagecache truncates locally due to memory pressure.
>  	 * 2) pagecache truncates when another is taking EX lock against 
> 

Please fix your To: line:

(no To-header on input) <>

-- 
~Randy


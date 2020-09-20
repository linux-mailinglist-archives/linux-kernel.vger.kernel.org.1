Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC82C271738
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgITStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgITStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:49:41 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C861C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:49:41 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 185so14307704oie.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T2hFKmZJlvTIbWOQCGeuk8z5hREoSVHVU52LKW8EOhQ=;
        b=GkypHfeNG9sKolaGeFYnd5pUpQ3Plcwj9YLNYxDMMhNy1MjZwta9buiSbQNhKR0w8b
         uoORmY+tDwnyCm2sJ12M2j+0EYUXshSt7oTdb8KFaAZI6clzshS5X8Zss8AoYZzjojNY
         a2pzJvwvg0blfztQHd+Bmb66j6PfiFV1eCHR3+uHFHizT+T2zxiqA+8oOcAX16QWql8k
         MiLLYh4C59S/Y5v7wq450yIBfvoSkkZhyvI6NQeuPXxgsIoLV+66+oRHfUYJJAdldT2d
         0TWN+62SeSuE5PHsdQLXpi7qrvYN63SqvgYVZiri9JJRRPl/+g3p2cPIV9gcq2ejTbsl
         aJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T2hFKmZJlvTIbWOQCGeuk8z5hREoSVHVU52LKW8EOhQ=;
        b=Dj/tgiZeAElCBpb+W1XjjBr6ZhfAiXtSintXun0tWr+DbUqqDQsRrs0aX5Gc03Xce7
         FHlC7K+RVg2A52pbhXtUgclmg6oV1PTGmZUrbQKrY+wDm5/R9t8aH98dG5mPmPw3RD7o
         lYfGWpX8rKgFtizaIwTNm09DEKthIWavCx1zHxNWWYv4AjK5eeDF2U61AGsV6xUOFnNN
         Xu56UD6tWWrkrzoA177BVbEffD+U/Cobsz1bFPSBi0u1jauPglIAavPbopOgFnVlHKoI
         Aae0A1kPV+3ajYDVEHfLizHytnTTS3oQHvFI+F/qh6GhJnbFNKcqdwHg8Mauf9GVXyuN
         Xq/A==
X-Gm-Message-State: AOAM533Z/xo4Sb2WggUy6CBOA0mRLsDtm21EgCaoMzqrauUec6JqfTvg
        Nqbg1ooqCzfpdULvn2WPhiSrwg==
X-Google-Smtp-Source: ABdhPJzdc9OCQsXRMp9Q5pIlzC47ECQfzDrkMTtjd82DubPRsr1YkLFqfY4C7mAaHoBKdIklPTe+Ag==
X-Received: by 2002:a05:6808:14f:: with SMTP id h15mr14768940oie.119.1600627779649;
        Sun, 20 Sep 2020 11:49:39 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z8sm6418184oic.11.2020.09.20.11.49.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2020 11:49:38 -0700 (PDT)
Date:   Sun, 20 Sep 2020 11:49:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem.c: Fix the missing unaccount on the failed
 path
In-Reply-To: <20200920163005.97079-1-tianjia.zhang@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009201141510.4318@eggly.anvils>
References: <20200920163005.97079-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020, Tianjia Zhang wrote:

> In function __shmem_file_setup(), shmem_unacct_size() is forgotten
> on the failed path, so add it.
> 
> Fixes: 93dec2da7b234 ("... and switch shmem_file_setup() to alloc_file_pseudo()")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  mm/shmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8e2b35ba93ad..591410dc3541 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4200,8 +4200,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
>  	if (!IS_ERR(res))
>  		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
>  				&shmem_file_operations);
> -	if (IS_ERR(res))
> +	if (IS_ERR(res)) {
>  		iput(inode);
> +		shmem_unacct_size(flags, size);
> +	}
>  	return res;
>  }
>  
> -- 
> 2.19.1.3.ge56e4f7

Looks mistaken to me.

Is this something you noticed by source inspection,
or something you have observed in practice?

I haven't tried exercising this path while injecting errors into
alloc_file_pseudo(); but what I'd expect to happen is that the
iput(inode), which you see already on that error path, will get
to evict the inode, which will entail calling shmem_evict_inode(),
which does that shmem_unacct_size() itself.

Hugh

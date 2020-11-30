Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5B2C7C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgK3CBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3CBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:01:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 18:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8GybmOCAZYuty3gAEYZbzVSJThvnLUYl5QYg5RvCPZM=; b=sJgWK6ylje+cVAPIHbpK5CmIsc
        8RW5pIlZn/7wImvfD/9bBsYe+Adzio7e0qXdubGtYWnWKnDn+ZJn4OoaX6NwUkTAO1o+fuyT6PW/B
        33zgIiV9YvnugHam9RQ5RKRStZXF8hPZ5AMb18NbSzoT9NGj+Oj9d+B7UucDQWlLlxA6+tkEYvcXF
        dcKZgNvfORmglyJ2SAlAmBlo+kdOPpXeb7ByOFZzMfHgcvJ6oBcyMvKeOsp/yGOQhorWTmMMJqqSP
        HALvU+RZGZXnm5Z2UqgtgXjcTmIogtl/hSCG3AzTWTU/llSC4/XYY33+xE+YxxAjgnBEdo+jEnzi7
        1i6QeHSw==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjYV0-0003uu-HJ; Mon, 30 Nov 2020 02:01:06 +0000
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, linux-kernel@vger.kernel.org
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
Date:   Sun, 29 Nov 2020 18:00:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/20 5:44 PM, Sergey Senozhatsky wrote:
> Some functions that are declared when CONFIG_POSIX_ACL is defined
> are not declared when CONFIG_POSIX_ACL is not defined. Add the
> missing ones:
>   set_posix_acl(), posix_acl_update_mode(), get_cached_acl(),
>   get_cached_acl_rcu(), set_cached_acl(), forget_cached_acl().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Hi,

I can't find CONFIG_POSIX_ACL in the kernel source tree.
Should it be CONFIG_FS_POSIX_ACL ?

How did you test this?

> ---
>  include/linux/posix_acl.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 90797f1b421d..f6d206359da5 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -117,6 +117,39 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>  static inline void forget_all_cached_acls(struct inode *inode)
>  {
>  }
> +
> +static inline int set_posix_acl(struct inode *inode, int type,
> +				struct posix_acl *acl)
> +{
> +	return 0;
> +}
> +
> +static inline int posix_acl_update_mode(struct inode *, umode_t *,
> +					struct posix_acl **)
> +{
> +	return 0;
> +}
> +
> +static inline struct posix_acl *get_cached_acl(struct inode *inode,
> +					       int type)
> +{
> +	return NULL;
> +}
> +
> +static inline struct posix_acl *get_cached_acl_rcu(struct inode *inode,
> +						   int type)
> +{
> +	return NULL;
> +}
> +
> +static inline void set_cached_acl(struct inode *inode, int type,
> +				  struct posix_acl *acl)
> +{
> +}
> +
> +static inline void forget_cached_acl(struct inode *inode, int type)
> +{
> +}
>  #endif /* CONFIG_FS_POSIX_ACL */
>  
>  struct posix_acl *get_acl(struct inode *inode, int type);
> 

thanks.
-- 
~Randy


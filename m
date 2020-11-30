Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0122C7D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 05:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgK3EBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 23:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3EBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 23:01:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240BC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 20:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=aL/qNKNfLYP4iY6u6Fr4U/r1RP0PxMwZ6lPsT0uWIGw=; b=xd1d7KlTV2MzUW43A0tpQDFfNz
        apd6eWzQtuyUOHxtUdsYnHIKMp5wJLaY6XG6I4mhCdnFYYZ1f3zH9GE0YucJC6SIF5OIvP7pUA5/n
        li5ZtC1LcmjbBvVdx9S8pmUnc68Y03C8Nyj2NHxBp0iKewwcGbmDTtmlda3Xu8Rqif1u1JnmahZIv
        wTUKwCdv2uibSWjjH4supaDJ4YNAoerQKlfAJlFGSXR6wBxS6htPAayogp/QUGTWLSvMODr2W+h34
        k9NXjIjaY+Qv6pddrfjsPxFXFsK+HMjHudY2dM+K3H8ZhnQu9TXU15/ockMy1YFu9O/wiHL0T2Eoc
        EeuDaRTg==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjaMr-0004SX-Ed; Mon, 30 Nov 2020 04:00:49 +0000
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
 <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
 <X8RkVIxou1D1YfEb@jagdpanzerIV.localdomain>
 <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c96f60f4-f525-2957-6a8a-ae9e3288b04a@infradead.org>
Date:   Sun, 29 Nov 2020 20:00:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8RpFo+5m1i4L5Gn@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/20 7:37 PM, Sergey Senozhatsky wrote:
> A quick question, shouldn't there be dummy definitions for
> the EXPORT_SYMBOL-s? So that external modules can be modprobed
> and used.
> 
> Some of posix_acl exported symbols have dummy definitions,
> others don't.
> 
> E.g. posix_acl_create() is exported symbol and it's defined for
> both FS_POSIX_ACL and !FS_POSIX_ACL. While exported set_posix_acl()
> is defined only for FS_POSIX_ACL config.

Hi,

Currently CONFIG_FS_POSIX_ACL differences seem to be handled in
each source file as needed:

fs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
fs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
fs/namei.c:#ifdef CONFIG_FS_POSIX_ACL
fs/overlayfs/dir.c:     if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !acl)
fs/overlayfs/inode.c:   if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
fs/overlayfs/inode.c:#ifdef CONFIG_FS_POSIX_ACL
fs/overlayfs/super.c:#ifdef CONFIG_FS_POSIX_ACL
fs/xattr.c:#ifdef CONFIG_FS_POSIX_ACL
include/linux/evm.h:#ifdef CONFIG_FS_POSIX_ACL
include/linux/fs.h:#ifdef CONFIG_FS_POSIX_ACL
include/linux/posix_acl.h:#ifdef CONFIG_FS_POSIX_ACL
include/linux/posix_acl.h:#endif /* CONFIG_FS_POSIX_ACL */
include/linux/posix_acl_xattr.h:#ifdef CONFIG_FS_POSIX_ACL

However, I have no objection to your patch.

I am adding Andreas & Al for their viewpoints.


> ---
> 
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 90797f1b421d..8a6c77a69761 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -59,19 +59,19 @@ posix_acl_release(struct posix_acl *acl)
>  
>  /* posix_acl.c */
>  
> +extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
> +
> +extern struct posix_acl *get_posix_acl(struct inode *, int);
> +
> +#ifdef CONFIG_FS_POSIX_ACL
>  extern void posix_acl_init(struct posix_acl *, int);
>  extern struct posix_acl *posix_acl_alloc(int, gfp_t);
> -extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
> -extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
> -extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
>  extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
> +extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
>  extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
>  extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
> -
> -extern struct posix_acl *get_posix_acl(struct inode *, int);
>  extern int set_posix_acl(struct inode *, int, struct posix_acl *);
> -
> -#ifdef CONFIG_FS_POSIX_ACL
> +extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
>  extern int posix_acl_chmod(struct inode *, umode_t);
>  extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
>  		struct posix_acl **);
> @@ -91,18 +91,61 @@ static inline void cache_no_acl(struct inode *inode)
>  	inode->i_acl = NULL;
>  	inode->i_default_acl = NULL;
>  }
> +
> +struct posix_acl *get_acl(struct inode *inode, int type);
>  #else
> +static inline void posix_acl_init(struct posix_acl *, int)
> +{
> +}
> +
> +static inline struct posix_acl *posix_acl_alloc(int, gfp_t)
> +{
> +	return NULL;
> +}
> +
> +static inline int posix_acl_valid(struct user_namespace *,
> +				  const struct posix_acl *)
> +{
> +	return 0;
> +}
> +
> +static inline int posix_acl_equiv_mode(const struct posix_acl *, umode_t *)
> +{
> +	return 0;
> +}
> +
> +static inline struct posix_acl *posix_acl_from_mode(umode_t, gfp_t)
> +{
> +	return NULL;
> +}
> +
>  static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
>  {
>  	return 0;
>  }
>  
> +static inline int set_posix_acl(struct inode *, int, struct posix_acl *)
> +{
> +	return 0;
> +}
> +
>  #define simple_set_acl		NULL
>  
>  static inline int simple_acl_create(struct inode *dir, struct inode *inode)
>  {
>  	return 0;
>  }
> +
> +static inline int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *)
> +{
> +	return 0;
> +}
> +
> +static inline int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t)
> +{
> +	return 0;
> +}
> +
>  static inline void cache_no_acl(struct inode *inode)
>  {
>  }
> @@ -117,8 +160,38 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>  static inline void forget_all_cached_acls(struct inode *inode)
>  {
>  }
> +
> +static inline struct posix_acl *get_cached_acl(struct inode *inode, int type)
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
> +
> +static inline struct posix_acl *get_acl(struct inode *inode, int type)
> +{
> +	return NULL;
> +}
> +
> +static inline int posix_acl_update_mode(struct inode *, umode_t *,
> +					struct posix_acl **)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_FS_POSIX_ACL */
>  
> -struct posix_acl *get_acl(struct inode *inode, int type);
>  
>  #endif  /* __LINUX_POSIX_ACL_H */
> 


-- 
~Randy


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF120342B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFVKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 06:00:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgFVKAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:00:16 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 29053AA4E1028E86C6D6;
        Mon, 22 Jun 2020 11:00:14 +0100 (IST)
Received: from localhost (10.52.127.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 22 Jun
 2020 11:00:13 +0100
Date:   Mon, 22 Jun 2020 10:59:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        Seth Jennings <sjenning@redhat.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-crypto@vger.kernel.org>, <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: [PATCH 1/3] crypto: permit users to specify numa node of acomp
 hardware
Message-ID: <20200622105923.0000710b@Huawei.com>
In-Reply-To: <20200622024901.12632-2-song.bao.hua@hisilicon.com>
References: <20200622024901.12632-1-song.bao.hua@hisilicon.com>
        <20200622024901.12632-2-song.bao.hua@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.176]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 14:48:59 +1200
Barry Song <song.bao.hua@hisilicon.com> wrote:

> For a Linux server with NUMA, there are possibly multiple (de)compressors
> which are either local or remote to some NUMA node. Some drivers will
> automatically use the (de)compressor near the CPU calling acomp_alloc().
> However, it is not necessarily correct because users who send acomp_req
> could be from different NUMA node with the CPU which allocates acomp.
> 
> Just like kernel has kmalloc() and kmalloc_node(), here crypto can have
> same support.
> 
> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Hi Barry,

Seems sensible to me.  A few trivial comments inline.

Thanks,

Jonathan

> ---
>  crypto/acompress.c         |  8 ++++++++
>  crypto/api.c               | 22 ++++++++++++++--------
>  crypto/internal.h          | 23 +++++++++++++++++++----
>  include/crypto/acompress.h |  7 +++++++
>  include/linux/crypto.h     |  3 ++-
>  5 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/crypto/acompress.c b/crypto/acompress.c
> index 84a76723e851..c32c72048a1c 100644
> --- a/crypto/acompress.c
> +++ b/crypto/acompress.c
> @@ -109,6 +109,14 @@ struct crypto_acomp *crypto_alloc_acomp(const char *alg_name, u32 type,
>  }
>  EXPORT_SYMBOL_GPL(crypto_alloc_acomp);
>  
> +struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
> +					u32 mask, int node)
> +{
> +	return crypto_alloc_tfm_node(alg_name, &crypto_acomp_type, type, mask,
> +				node);
> +}
> +EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
> +
>  struct acomp_req *acomp_request_alloc(struct crypto_acomp *acomp)
>  {
>  	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
> diff --git a/crypto/api.c b/crypto/api.c
> index edcf690800d4..4ecf712286af 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -433,8 +433,9 @@ struct crypto_tfm *crypto_alloc_base(const char *alg_name, u32 type, u32 mask)
>  }
>  EXPORT_SYMBOL_GPL(crypto_alloc_base);
>  
> -void *crypto_create_tfm(struct crypto_alg *alg,
> -			const struct crypto_type *frontend)
> +void *crypto_create_tfm_node(struct crypto_alg *alg,
> +			const struct crypto_type *frontend,
> +			int node)
>  {
>  	char *mem;
>  	struct crypto_tfm *tfm = NULL;
> @@ -451,6 +452,7 @@ void *crypto_create_tfm(struct crypto_alg *alg,
>  
>  	tfm = (struct crypto_tfm *)(mem + tfmsize);
>  	tfm->__crt_alg = alg;
> +	tfm->node = node;
>  
>  	err = frontend->init_tfm(tfm);
>  	if (err)
> @@ -472,7 +474,7 @@ void *crypto_create_tfm(struct crypto_alg *alg,
>  out:
>  	return mem;
>  }
> -EXPORT_SYMBOL_GPL(crypto_create_tfm);
> +EXPORT_SYMBOL_GPL(crypto_create_tfm_node);
>  
>  struct crypto_alg *crypto_find_alg(const char *alg_name,
>  				   const struct crypto_type *frontend,
> @@ -490,11 +492,13 @@ struct crypto_alg *crypto_find_alg(const char *alg_name,
>  EXPORT_SYMBOL_GPL(crypto_find_alg);
>  
>  /*
> - *	crypto_alloc_tfm - Locate algorithm and allocate transform
> + *	crypto_alloc_tfm_node - Locate algorithm and allocate transform
>   *	@alg_name: Name of algorithm
>   *	@frontend: Frontend algorithm type
>   *	@type: Type of algorithm
>   *	@mask: Mask for type comparison
> + *	@node: NUMA node in which users desire to put requests, if node is
> + *		NUMA_NO_NODE, it means users have no special requirement.
>   *
>   *	crypto_alloc_tfm() will first attempt to locate an already loaded
>   *	algorithm.  If that fails and the kernel supports dynamically loadable
> @@ -509,8 +513,10 @@ EXPORT_SYMBOL_GPL(crypto_find_alg);
>   *
>   *	In case of error the return value is an error pointer.
>   */
> -void *crypto_alloc_tfm(const char *alg_name,
> -		       const struct crypto_type *frontend, u32 type, u32 mask)
> +
> +void *crypto_alloc_tfm_node(const char *alg_name,
> +		       const struct crypto_type *frontend, u32 type, u32 mask,
> +		       int node)
>  {
>  	void *tfm;
>  	int err;
> @@ -524,7 +530,7 @@ void *crypto_alloc_tfm(const char *alg_name,
>  			goto err;
>  		}
>  
> -		tfm = crypto_create_tfm(alg, frontend);
> +		tfm = crypto_create_tfm_node(alg, frontend, node);
>  		if (!IS_ERR(tfm))
>  			return tfm;
>  
> @@ -542,7 +548,7 @@ void *crypto_alloc_tfm(const char *alg_name,
>  
>  	return ERR_PTR(err);
>  }
> -EXPORT_SYMBOL_GPL(crypto_alloc_tfm);
> +EXPORT_SYMBOL_GPL(crypto_alloc_tfm_node);
>  
>  /*
>   *	crypto_destroy_tfm - Free crypto transform
> diff --git a/crypto/internal.h b/crypto/internal.h
> index ff06a3bd1ca1..1b92a5a61852 100644
> --- a/crypto/internal.h
> +++ b/crypto/internal.h
> @@ -68,13 +68,28 @@ void crypto_remove_final(struct list_head *list);
>  void crypto_shoot_alg(struct crypto_alg *alg);
>  struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
>  				      u32 mask);
> -void *crypto_create_tfm(struct crypto_alg *alg,
> -			const struct crypto_type *frontend);
> +void *crypto_create_tfm_node(struct crypto_alg *alg,
> +			const struct crypto_type *frontend, int node);
> +
> +static inline void *crypto_create_tfm(struct crypto_alg *alg,
> +			const struct crypto_type *frontend)
> +{
> +	return crypto_create_tfm_node(alg, frontend, NUMA_NO_NODE);
> +}
> +
>  struct crypto_alg *crypto_find_alg(const char *alg_name,
>  				   const struct crypto_type *frontend,
>  				   u32 type, u32 mask);
> -void *crypto_alloc_tfm(const char *alg_name,
> -		       const struct crypto_type *frontend, u32 type, u32 mask);
> +
> +void *crypto_alloc_tfm_node(const char *alg_name,
> +		       const struct crypto_type *frontend, u32 type, u32 mask,
> +		       int node);
> +
> +static inline void *crypto_alloc_tfm(const char *alg_name,
> +		       const struct crypto_type *frontend, u32 type, u32 mask)
> +{
> +	return crypto_alloc_tfm_node(alg_name, frontend, type, mask, NUMA_NO_NODE);
> +}
>  
>  int crypto_probing_notify(unsigned long val, void *v);
>  
> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index 2b4d2b06ccbd..b1a78687014a 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -106,6 +106,13 @@ struct acomp_alg {
>   */
>  struct crypto_acomp *crypto_alloc_acomp(const char *alg_name, u32 type,
>  					u32 mask);
> +/**
> + * crypto_alloc_acomp_node() -- allocate ACOMPRESS tfm handle with desired NUMA
> + *				node

Given slightly relaxed view on 80 chars now in place, I'd put that on one line.

Also kernel-doc needs to be complete so though it's tedious you should document
the other parameters.

> + * @node:	specifies the NUMA node the ZIP hardware belongs to
> + */
> +struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
> +					u32 mask, int node);
>  
>  static inline struct crypto_tfm *crypto_acomp_tfm(struct crypto_acomp *tfm)
>  {
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 763863dbc079..c1a47ce4c09e 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -593,8 +593,9 @@ int crypto_has_alg(const char *name, u32 type, u32 mask);
>   */
>  
>  struct crypto_tfm {
> -

Stray change. Shouldn't be in this patch.


>  	u32 crt_flags;
> +
> +	int node;
>  	
>  	void (*exit)(struct crypto_tfm *tfm);
>  	



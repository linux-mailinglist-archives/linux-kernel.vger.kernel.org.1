Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB122A98F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGWHWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:22:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34434 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgGWHWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:22:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyVYT-0005Jd-7g; Thu, 23 Jul 2020 17:22:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:22:13 +1000
Date:   Thu, 23 Jul 2020 17:22:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     gregkh@linuxfoundation.org, wangzhou1@hisilicon.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: hisilicon: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200723072213.GA4760@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090345.13396-1-miaoqinglang@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> drivers/crypto/hisilicon/qm.c | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index b594dc728..5f16d8ae7 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1046,17 +1046,7 @@ static int qm_regs_show(struct seq_file *s, void *unused)
>        return 0;
> }
> 
> -static int qm_regs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, qm_regs_show, inode->i_private);
> -}
> -
> -static const struct file_operations qm_regs_fops = {
> -       .owner = THIS_MODULE,
> -       .open = qm_regs_open,
> -       .read_iter = seq_read_iter,
> -       .release = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(qm_regs);

This doesn't apply against the cryptodev tree.  If this patch
depends on another one, you should post them together in a series.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

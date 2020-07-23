Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8922A997
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGWHY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 03:24:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34454 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGWHY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:24:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyVa4-0005MC-IU; Thu, 23 Jul 2020 17:23:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:23:52 +1000
Date:   Thu, 23 Jul 2020 17:23:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: zip: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200723072352.GA6019@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090354.13454-1-miaoqinglang@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> @@ -584,41 +584,9 @@ static int zip_print_regs(struct seq_file *s, void *unused)
>        return 0;
> }
> 
> -static int zip_stats_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, zip_show_stats, NULL);
> -}
> -
> -static const struct file_operations zip_stats_fops = {
> -       .owner = THIS_MODULE,
> -       .open  = zip_stats_open,
> -       .read_iter  = seq_read_iter,
> -       .release = single_release,
> -};

This patch doesn't apply either.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

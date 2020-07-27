Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24D22E61A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG0Gwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 02:52:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50994 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgG0Gws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:52:48 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jzwzu-0000b6-OZ; Mon, 27 Jul 2020 16:52:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 27 Jul 2020 16:52:30 +1000
Date:   Mon, 27 Jul 2020 16:52:30 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Huang Guobin <huangguobin4@huawei.com>
Cc:     haren@us.ibm.com, ddstreet@ieee.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: Verify array index is correct before using it
Message-ID: <20200727065230.GA25105@gondor.apana.org.au>
References: <20200727065910.1628-1-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727065910.1628-1-huangguobin4@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:59:10AM -0400, Huang Guobin wrote:
> This code reads from the array before verifying that "c" is a valid
> index. Move test array offset code before use to fix it.
> 
> Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")
> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
> ---
>  lib/842/842_compress.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Please post this to linux-crypto@vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

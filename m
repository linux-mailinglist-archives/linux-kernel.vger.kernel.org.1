Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50364201AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgFSTOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgFSTOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:14:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD6CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:14:46 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6AE4B23B;
        Fri, 19 Jun 2020 19:14:46 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:14:45 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: add entries for Alexander Lobakin
Message-ID: <20200619131445.00a9c83e@lwn.net>
In-Reply-To: <5YUtoWlS7NX1N6TxI4ddZ9V-Yx8Bn8wzrEVJqfkTuwEzZjAsJg157goV81xPAU76k84Nis2uBwdHWk4JmYHbvGmd_JcBTk-rZDVpFNPNolU=@pm.me>
References: <5YUtoWlS7NX1N6TxI4ddZ9V-Yx8Bn8wzrEVJqfkTuwEzZjAsJg157goV81xPAU76k84Nis2uBwdHWk4JmYHbvGmd_JcBTk-rZDVpFNPNolU=@pm.me>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 09:51:14 +0000
Alexander Lobakin <alobakin@pm.me> wrote:

> My D-Link and Yandex addresses don't exist anymore, map them to my
> private box.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index c69d9c734fb5..86eb59ad4c54 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -18,6 +18,8 @@ Aleksey Gorelov <aleksey_gorelov@phoenix.com>
>  Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
>  Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
>  Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
> +Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
> +Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>

Applied, thanks.

jon

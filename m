Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA82349E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgGaRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgGaRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:08:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:08:12 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 72B7A2B7;
        Fri, 31 Jul 2020 17:08:11 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:08:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: add entry for <alobakin@marvell.com>
Message-ID: <20200731110810.2ca27738@lwn.net>
In-Reply-To: <9xzFiqHAFGYuKfUycRaCQSIgsqmeL9E9SA3lSoqOMUPhFVaAgSgvukCUWO7iRbjtiUrFjK46fhu7dJ5TaCv1EjaNFm5yF_H3y5S1s_QALCA=@pm.me>
References: <9xzFiqHAFGYuKfUycRaCQSIgsqmeL9E9SA3lSoqOMUPhFVaAgSgvukCUWO7iRbjtiUrFjK46fhu7dJ5TaCv1EjaNFm5yF_H3y5S1s_QALCA=@pm.me>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 16:59:45 +0000
Alexander Lobakin <alobakin@pm.me> wrote:

> My Marvell account has been suspended, map the address to my private mail.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index e662fdac632b..a96f1b38fa58 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -19,6 +19,7 @@ Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.c
>  Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
>  Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
>  Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
> +Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
>  Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>

Applied, thanks.

jon

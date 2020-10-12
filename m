Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91328C149
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgJLTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgJLTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:14:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40336C0613D0;
        Mon, 12 Oct 2020 12:14:23 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 00A9837C;
        Mon, 12 Oct 2020 19:14:21 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:14:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Naoki Hayama <naoki.hayama@lineo.co.jp>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/admin-guide: tainted-kernels: Fix typo
 occured
Message-ID: <20201012131420.0e621db1@lwn.net>
In-Reply-To: <20201012082441.5831-1-naoki.hayama@lineo.co.jp>
References: <20201012082441.5831-1-naoki.hayama@lineo.co.jp>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 17:24:41 +0900
Naoki Hayama <naoki.hayama@lineo.co.jp> wrote:

> Fix typo.
> s/occured/occurred/
> 
> Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index abf804719890..f718a2eaf1f6 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -130,7 +130,7 @@ More detailed explanation for tainting
>   5)  ``B`` If a page-release function has found a bad page reference or some
>       unexpected page flags. This indicates a hardware problem or a kernel bug;
>       there should be other information in the log indicating why this tainting
> -     occured.
> +     occurred.

Applied, thanks.

jon

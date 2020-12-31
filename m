Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4342E8271
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 23:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLaWsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 17:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgLaWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:48:35 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC79C061573;
        Thu, 31 Dec 2020 14:47:55 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B2CFC385;
        Thu, 31 Dec 2020 22:47:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B2CFC385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1609454874; bh=Qw6AjmhOctrbxoibWNzHDUYgQzBGIxuyIAXSMK7+onQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WTuABmi4mYZbZ5olNH6Pz3DRpuhPaXXVELwGlQ7NmeaETdA43aG4xAOJl8VwpDq2J
         FRZTfxO0ThKPrttGNJtvAYBoypTygNO+4obpDEf45nGDo8RMVkerz2PyJHHK5va1Rc
         SuQEJFWhK5C85aQ2pVvEMy8wG3pRIdQmda30T9vnTOtblpBHfoaD3/ZriZswn8BkTU
         pZjS7aW87a7uK8CetEblvolpXEYPZHBTX1JUs5W0OmYOcImF3pe/eYrlWr+ZWcqzFW
         xn1YvxtzOae66jXn8nb/7FdT4qnFsqtxjML5zFlb9UiXqZW8/o0poNmTUF3IVI6Ogg
         CNC08nV7bP8IA==
Date:   Thu, 31 Dec 2020 15:47:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     winndows@163.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: concepts.rst: Correct the threshold to low
 watermark
Message-ID: <20201231154753.09b64ec6@lwn.net>
In-Reply-To: <1609053319-3112-1-git-send-email-winndows@163.com>
References: <1609053319-3112-1-git-send-email-winndows@163.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020 15:15:19 +0800
winndows@163.com wrote:

> It should be "low watermark" where we wake up kswapd daemon.
> 
> Signed-off-by: Liao Pingfang <winndows@163.com>
> ---
>  Documentation/admin-guide/mm/concepts.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
> index fa0974f..b966fcf 100644
> --- a/Documentation/admin-guide/mm/concepts.rst
> +++ b/Documentation/admin-guide/mm/concepts.rst
> @@ -184,7 +184,7 @@ pages either asynchronously or synchronously, depending on the state
>  of the system. When the system is not loaded, most of the memory is free
>  and allocation requests will be satisfied immediately from the free
>  pages supply. As the load increases, the amount of the free pages goes
> -down and when it reaches a certain threshold (high watermark), an
> +down and when it reaches a certain threshold (low watermark), an

Applied, thanks.

jon

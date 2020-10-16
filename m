Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA7290B27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbgJPSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390885AbgJPSKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:10:38 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA96208E4;
        Fri, 16 Oct 2020 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602871837;
        bh=KMK4Fja3s5VhAcwScM26Q5THZAJjZpspQRsETK4F1a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8tIe8x8JSx1ut0ImT9f8lMzVdXxtDgRHbsdpHf2Xi2lRB+g4gOO898TgIHZn0ihR
         2o1fJif4yaAa8Bw5kUaZ7qfpBgD9KnWCrT2FjbTSsQeUAIu5cyOLZo0vj97KbUrF4t
         9fz/px8+obkrqZzK1CAoMzgizdALjv9QfYcwhrzI=
Date:   Fri, 16 Oct 2020 13:16:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Expand str*cpy() replacement notes
Message-ID: <20201016181619.GA17037@embeddedor>
References: <20201015231730.2138505-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015231730.2138505-1-keescook@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 04:17:31PM -0700, Kees Cook wrote:
> The notes on replacing the deprecated str*cpy() functions didn't call
> enough attention to the change in return type. Add these details and
> clean up the language a bit more.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

--
Gustavo

> ---
>  Documentation/process/deprecated.rst | 44 ++++++++++++++++------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index ff71d802b53d..9d83b8db8874 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -106,23 +106,29 @@ NUL or newline terminated.
>  
>  strcpy()
>  --------
> -strcpy() performs no bounds checking on the destination
> -buffer. This could result in linear overflows beyond the
> -end of the buffer, leading to all kinds of misbehaviors. While
> -`CONFIG_FORTIFY_SOURCE=y` and various compiler flags help reduce the
> -risk of using this function, there is no good reason to add new uses of
> -this function. The safe replacement is strscpy().
> +strcpy() performs no bounds checking on the destination buffer. This
> +could result in linear overflows beyond the end of the buffer, leading to
> +all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
> +compiler flags help reduce the risk of using this function, there is
> +no good reason to add new uses of this function. The safe replacement
> +is strscpy(), though care must be given to any cases where the return
> +value of strcpy() was used, since strscpy() does not return a pointer to
> +the destination, but rather a count of non-NUL bytes copied (or negative
> +errno when it truncates).
>  
>  strncpy() on NUL-terminated strings
>  -----------------------------------
> -Use of strncpy() does not guarantee that the destination buffer
> -will be NUL terminated. This can lead to various linear read overflows
> -and other misbehavior due to the missing termination. It also NUL-pads the
> -destination buffer if the source contents are shorter than the destination
> -buffer size, which may be a needless performance penalty for callers using
> -only NUL-terminated strings. The safe replacement is strscpy().
> -(Users of strscpy() still needing NUL-padding should instead
> -use strscpy_pad().)
> +Use of strncpy() does not guarantee that the destination buffer will
> +be NUL terminated. This can lead to various linear read overflows and
> +other misbehavior due to the missing termination. It also NUL-pads
> +the destination buffer if the source contents are shorter than the
> +destination buffer size, which may be a needless performance penalty
> +for callers using only NUL-terminated strings. The safe replacement is
> +strscpy(), though care must be given to any cases where the return value
> +of strncpy() was used, since strscpy() does not return a pointer to the
> +destination, but rather a count of non-NUL bytes copied (or negative
> +errno when it truncates). Any cases still needing NUL-padding should
> +instead use strscpy_pad().
>  
>  If a caller is using non-NUL-terminated strings, strncpy() can
>  still be used, but destinations should be marked with the `__nonstring
> @@ -131,10 +137,12 @@ attribute to avoid future compiler warnings.
>  
>  strlcpy()
>  ---------
> -strlcpy() reads the entire source buffer first, possibly exceeding
> -the given limit of bytes to copy. This is inefficient and can lead to
> -linear read overflows if a source string is not NUL-terminated. The
> -safe replacement is strscpy().
> +strlcpy() reads the entire source buffer first (since the return value
> +is meant to match that of strlen()). This read may exceed the destination
> +size limit. This is both inefficient and can lead to linear read overflows
> +if a source string is not NUL-terminated. The safe replacement is strscpy(),
> +though care must be given to any cases where the return value of strlcpy()
> +is used, since strscpy() will return negative errno values when it truncates.
>  
>  %p format specifier
>  -------------------
> -- 
> 2.25.1
> 

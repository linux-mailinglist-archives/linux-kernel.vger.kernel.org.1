Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1B27FC01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgJAIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbgJAIzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:55:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8575320B1F;
        Thu,  1 Oct 2020 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601542545;
        bh=Lmndb/S6MK+pcARG47+loeLrbW8fJTcFCcXY6A/D8MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PT5kCBVmlTTfqQjGqwWISToPHs5XIxehYOqt9yCdVdkg2vSTWZn9zrnbQkkeeoH/i
         hUg05924olZPl+P1ENWbTWFWDJYm1ad1HIwnTu9l0oU4dceQ5G5Kl7n0lKjxRzFFeT
         zg5Hga2Yyx5Fzo2o4mH8S4X7jJ6NJ1Arhuj1GxN0=
Date:   Thu, 1 Oct 2020 10:55:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>
Cc:     marvin24@gmx.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: nvec: Remove duplicate word in comment.
Message-ID: <20201001085546.GA1824150@kroah.com>
References: <CAF4OWHKYrcZzZp_YVf+mnGgjHUi7AKPA22s5q7vVfu371_8HTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF4OWHKYrcZzZp_YVf+mnGgjHUi7AKPA22s5q7vVfu371_8HTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:39:53PM -0400, Matthew Hanzelik wrote:
> Remove a duplicate word in a comment within nvec.c.
> 
> Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
> ---
> Changes in v2:
>  - Fix spelling mistake in commit.
> ---
>  drivers/staging/nvec/nvec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 360ec0407740..a80996b2f5ce 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -289,7 +289,7 @@ EXPORT_SYMBOL(nvec_write_async);
>   * interrupt handlers.
>   *
>   * Returns: 0 on success, a negative error code on failure.
> - * The response message is returned in @msg. Shall be freed with
> + * The response message is returned in @msg. Shall be freed
>   * with nvec_msg_free() once no longer used.
>   *
>   */

Someone else sent this patch right before you did, sorry:
	https://lore.kernel.org/r/20200927172855.9813-1-ryanpkosta@gmail.com

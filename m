Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE122FC04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgG0WUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 18:20:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:57936 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:20:43 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 95CF62E7;
        Mon, 27 Jul 2020 22:20:42 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:20:41 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: correct flag name
Message-ID: <20200727162041.2a154e0a@lwn.net>
In-Reply-To: <1595789020-12941-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595789020-12941-1-git-send-email-Julia.Lawall@inria.fr>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 20:43:40 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> There is no flag REMAP_CAN_SHORTEN.  Commit eca3654e3cc7 ("vfs: enable
> remap callers that can handle short operations") that introduces this
> text also introduces the flag REMAP_FILE_CAN_SHORTEN.  Change the name
> in the documentation accordingly.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  Documentation/filesystems/vfs.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index da4b735..d08357d 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1116,7 +1116,7 @@ otherwise noted.
>  	before any bytes were remapped.  The remap_flags parameter
>  	accepts REMAP_FILE_* flags.  If REMAP_FILE_DEDUP is set then the
>  	implementation must only remap if the requested file ranges have
> -	identical contents.  If REMAP_CAN_SHORTEN is set, the caller is
> +	identical contents.  If REMAP_FILE_CAN_SHORTEN is set, the caller is

Applied, thanks.

jon

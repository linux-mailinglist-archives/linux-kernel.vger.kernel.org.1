Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7C21DEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgGMRZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgGMRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:25:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F6C061755;
        Mon, 13 Jul 2020 10:25:48 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C6A0460C;
        Mon, 13 Jul 2020 17:25:47 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:25:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: AFS FILESYSTEM
Message-ID: <20200713112546.0c6a8d0c@lwn.net>
In-Reply-To: <20200708081403.13323-1-grandmaster@al2klimov.de>
References: <20200708081403.13323-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 10:14:03 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/filesystems/afs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/afs.rst b/Documentation/filesystems/afs.rst
> index cada9464d6bd..0abb155ac666 100644
> --- a/Documentation/filesystems/afs.rst
> +++ b/Documentation/filesystems/afs.rst
> @@ -190,7 +190,7 @@ Security
>  Secure operations are initiated by acquiring a key using the klog program.  A
>  very primitive klog program is available at:
>  
> -	http://people.redhat.com/~dhowells/rxrpc/klog.c
> +	https://people.redhat.com/~dhowells/rxrpc/klog.c

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2D21DA20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgGMPdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:33:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C8C061755;
        Mon, 13 Jul 2020 08:33:38 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0E1112E2;
        Mon, 13 Jul 2020 15:33:38 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:33:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: Replace HTTP links with HTTPS ones
Message-ID: <20200713093337.2f8f409a@lwn.net>
In-Reply-To: <20200713113705.33773-1-grandmaster@al2klimov.de>
References: <20200713113705.33773-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 13:37:05 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/filesystems/caching/cachefiles.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
> index 65d3db476765..e58bc1fd312a 100644
> --- a/Documentation/filesystems/caching/cachefiles.rst
> +++ b/Documentation/filesystems/caching/cachefiles.rst
> @@ -348,7 +348,7 @@ data cached therein; nor is it permitted to create new files in the cache.
>  
>  There are policy source files available in:
>  
> -	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.8.tar.bz2
> +	https://people.redhat.com/~dhowells/fscache/cachefilesd-0.8.tar.bz2
>  
>  and later versions.  In that tarball, see the files::

Applied, thanks.

jon

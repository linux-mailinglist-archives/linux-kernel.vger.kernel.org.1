Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745721DEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgGMR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:28:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:36092 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgGMR2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D48D2823;
        Mon, 13 Jul 2020 17:28:50 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:28:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: 9P FILE SYSTEM
Message-ID: <20200713112849.0190b29b@lwn.net>
In-Reply-To: <20200708145804.14887-1-grandmaster@al2klimov.de>
References: <20200708145804.14887-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 16:58:04 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/filesystems/9p.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 2995279ddc24..7b5964bc8865 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -18,7 +18,7 @@ and Maya Gokhale.  Additional development by Greg Watson
>  The best detailed explanation of the Linux implementation and applications of
>  the 9p client is available in the form of a USENIX paper:
>  
> -   http://www.usenix.org/events/usenix05/tech/freenix/hensbergen.html
> +   https://www.usenix.org/events/usenix05/tech/freenix/hensbergen.html
>  
Applied, thanks.

jon

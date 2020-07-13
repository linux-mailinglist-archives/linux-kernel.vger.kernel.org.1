Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2D21DEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgGMRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:24:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C563C061755;
        Mon, 13 Jul 2020 10:24:59 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1ED42E2;
        Mon, 13 Jul 2020 17:24:58 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:24:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     me@bobcopeland.com, linux-karma-devel@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: OMFS
Message-ID: <20200713112457.3db4212f@lwn.net>
In-Reply-To: <20200708062842.12214-1-grandmaster@al2klimov.de>
References: <20200708062842.12214-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 08:28:42 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/filesystems/omfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/omfs.rst b/Documentation/filesystems/omfs.rst
> index 4c8bb3074169..a104c25b7a2f 100644
> --- a/Documentation/filesystems/omfs.rst
> +++ b/Documentation/filesystems/omfs.rst
> @@ -24,7 +24,7 @@ More information is available at:
>  Various utilities, including mkomfs and omfsck, are included with
>  omfsprogs, available at:
>  
> -    http://bobcopeland.com/karma/
> +    https://bobcopeland.com/karma/

Applied, thanks.

jon

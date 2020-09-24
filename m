Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2F327772D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgIXQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:49:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C6C0613CE;
        Thu, 24 Sep 2020 09:49:13 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88965750;
        Thu, 24 Sep 2020 16:49:12 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:49:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/admin-guide: kernel-parameters:
 capitalize Korina
Message-ID: <20200924104909.52b8b86c@lwn.net>
In-Reply-To: <20200918054722.28713-1-rdunlap@infradead.org>
References: <20200918054722.28713-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 22:47:22 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix typo, capitalize Korina proper noun.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200917.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20200917/Documentation/admin-guide/kernel-parameters.txt
> @@ -2194,7 +2194,7 @@
>  	kgdbwait	[KGDB] Stop kernel execution and enter the
>  			kernel debugger at the earliest opportunity.
>  
> -	kmac=		[MIPS] korina ethernet MAC address.
> +	kmac=		[MIPS] Korina ethernet MAC address.

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008B2277722
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIXQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:47:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:59238 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:47:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D154577D;
        Thu, 24 Sep 2020 16:47:10 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:47:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/admin-guide: kernel-parameters: fix "io7"
 parameter description
Message-ID: <20200924104708.0a375a4c@lwn.net>
In-Reply-To: <20200918054751.6538-1-rdunlap@infradead.org>
References: <20200918054751.6538-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 22:47:51 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix punctuation and capitalization for the "io7" boot parameter.
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
> @@ -1973,7 +1973,7 @@
>  			1 - Bypass the IOMMU for DMA.
>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>  
> -	io7=		[HW] IO7 for Marvel based alpha systems
> +	io7=		[HW] IO7 for Marvel-based Alpha systems

Applied, thanks.

jon

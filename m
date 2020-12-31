Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD52E8266
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 23:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgLaWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 17:47:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:37188 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgLaWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:47:16 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E2F86385;
        Thu, 31 Dec 2020 22:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2F86385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1609454796; bh=A1nSfVgFkhDgktahJLlvUXThTg8NcK+xsGfWwRJha3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A9CC7EC8iTeypfc/eUzxB+znSRYepIIWMjHW3ES+GKZ9imp2yhxG4O6O06zCpAa4q
         vjnP0gP0bn4iSrRrLBCP9j8ONWPuj4FhviGhwcQeAxoU3giP9XTphWUNw7BTR/ESDc
         AYbGXCgRi5CSrVn21BFexdcfJcka6AwX1xV94/TtEDtgUe35AE18ZlpNxZQoFc3xWE
         9mw960KPewD873IShLNpqYvW/iIEZ5yKIy0ov5WpV9QGHrTSvNQ+XemxRoxAjB1e+z
         vABhhxEZo5goq1oiH53ggEfBFYURt/8n8AU+2VBEzsYI1Cl6mD+7V8t/MRcVWPbHha
         ke+1gf8SU2Szw==
Date:   Thu, 31 Dec 2020 15:46:34 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin: early_param()s are also listed in
 kernel-parameters
Message-ID: <20201231154634.0384d0d5@lwn.net>
In-Reply-To: <20201226174433.7885-1-rdunlap@infradead.org>
References: <20201226174433.7885-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Dec 2020 09:44:33 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Add info that "early_param()" kernel boot parameters are also listed
> in kernel-parameters.txt.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20201223.orig/Documentation/admin-guide/kernel-parameters.rst
> +++ linux-next-20201223/Documentation/admin-guide/kernel-parameters.rst
> @@ -3,8 +3,8 @@
>  The kernel's command-line parameters
>  ====================================
>  
> -The following is a consolidated list of the kernel parameters as
> -implemented by the __setup(), core_param() and module_param() macros
> +The following is a consolidated list of the kernel parameters as implemented
> +by the __setup(), early_param(), core_param() and module_param() macros

Applied, thanks.

jon

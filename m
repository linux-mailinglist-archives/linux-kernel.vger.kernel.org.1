Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98655253E05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 08:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgH0GoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 02:44:13 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:50502 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0GoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id C67BC2057A;
        Thu, 27 Aug 2020 08:44:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UZbeWDV983C0; Thu, 27 Aug 2020 08:44:10 +0200 (CEST)
Received: from cas-essen-01.secunet.de (201.40.53.10.in-addr.arpa [10.53.40.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 5E7BB201D5;
        Thu, 27 Aug 2020 08:44:10 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 08:44:10 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 27 Aug
 2020 08:44:09 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 9E66831803E0; Thu, 27 Aug 2020 08:44:09 +0200 (CEST)
Date:   Thu, 27 Aug 2020 08:44:09 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] padata: add a reviewer
Message-ID: <20200827064409.GA20687@gauss3.secunet.de>
References: <20200826145923.719126-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200826145923.719126-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:59:23AM -0400, Daniel Jordan wrote:
> I volunteer to review padata changes for the foreseeable future.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b186ade3597..1481d47cfd75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13024,6 +13024,7 @@ F:	lib/packing.c
>  
>  PADATA PARALLEL EXECUTION MECHANISM
>  M:	Steffen Klassert <steffen.klassert@secunet.com>
> +R:	Daniel Jordan <daniel.m.jordan@oracle.com>

Please also consider to add yourself as one of the maintainers.

Otherwise:

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

Thanks!

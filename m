Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D80201D39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgFSVkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 17:40:01 -0400
Received: from v6.sk ([167.172.42.174]:55398 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgFSVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:40:01 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id EC8AA61635;
        Fri, 19 Jun 2020 21:39:29 +0000 (UTC)
Date:   Fri, 19 Jun 2020 23:39:26 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fix incorrect directory reference
Message-ID: <20200619213926.GA1105134@furthur.local>
References: <20200618195527.162034-1-ralf.ramsauer@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618195527.162034-1-ralf.ramsauer@oth-regensburg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:55:27PM +0200, Ralf Ramsauer wrote:
> the below-mentioned commit moved headers to inlucde/linux/soc/mmp. MAINTAINERS
> was updated, but include/ was omitted.
> 
> Fixes: 32adcaa010 ("ARM: mmp: move cputype.h to include/linux/soc/")
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

Thanks for the patch. This duplicates a patch that Lukas has sent [1] out to be
applied via the trivial fix tree, but it never made it in.

[1] https://lore.kernel.org/lkml/20200506053431.7464-1-lukas.bulwahn@gmail.com/

I've followed up on the original one.

Lubo

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68f21d46614c..20d897b5be4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11492,7 +11492,7 @@ S:	Odd Fixes
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
>  F:	arch/arm/boot/dts/mmp*
>  F:	arch/arm/mach-mmp/
> -F:	linux/soc/mmp/
> +F:	include/linux/soc/mmp/
>  
>  MMP USB PHY DRIVERS
>  R:	Lubomir Rintel <lkundrak@v3.sk>
> -- 
> 2.27.0
> 

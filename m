Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BF2DFEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgLURAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:00:12 -0500
Received: from ms.lwn.net ([45.79.88.28]:47762 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgLURAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:00:05 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC7EF559;
        Mon, 21 Dec 2020 16:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DC7EF559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608569965; bh=JnmhB4Pw4MEk2ytPAwCi3tTGfBlhp+Wz+PJito8slck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=irHCFjaRIU5N/TIetdcFkeyZvPgS0EXIoYDM3DloMOEPHMyJJxujCFRD6j9H19C8x
         hLeOxWu4Gu+XVXkSlHSTaVbliJH/KY3qUyWLJBxVceHD1Rj9fiKBhfIkTIGdXyORBL
         NThKifKNUPqgO8ied78KTnBT27qO6omE6wnTleJHvN0RS5hdRVfWh9wH0gC1B5x1i2
         Mp7ha0LptCavPtpF4Ce21ofL36+X7n9bD7NolqQn6XYKwOuQm8G5SO6CYQAK23BFHp
         sgnOu//STp/OSYtmkOhXHlB4h3hlYDlOMUxNr0LGQFqgkwI3SWCd5k3wo9aBQgH6WW
         o8wHK4CYJ3kig==
Date:   Mon, 21 Dec 2020 09:59:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Fengfei Xi <xi.fengfei@h3c.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: admin-guide: Fix default value of max_map_count
 in sysctl/vm.rst
Message-ID: <20201221095923.67dacea4@lwn.net>
In-Reply-To: <20201210082134.36957-1-xi.fengfei@h3c.com>
References: <20201210082134.36957-1-xi.fengfei@h3c.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 16:21:34 +0800
Fengfei Xi <xi.fengfei@h3c.com> wrote:

> Since the default value of sysctl_max_map_count is defined as
> DEFAULT_MAX_MAP_COUNT from mm/util.c
> 
>     int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> 
> DEFAULT_MAX_MAP_COUNT is defined as 65530 (65535-5) in include/linux/mm.h
> 
>     #define MAPCOUNT_ELF_CORE_MARGIN        (5)
>     #define DEFAULT_MAX_MAP_COUNT   (USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
> 
> Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f455fa00c..834c3fc74 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -428,7 +428,7 @@ While most applications need less than a thousand maps, certain
>  programs, particularly malloc debuggers, may consume lots of them,
>  e.g., up to one or two maps per allocation.
>  
> -The default value is 65536.
> +The default value is 65530.

Applied, thanks.

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816912E2723
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgLXNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgLXNNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:13:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 717EA22287;
        Thu, 24 Dec 2020 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608815551;
        bh=wZSUMjWJQbOHjVbsHANA5eOCKDCLkNM7NT0tcxPNeHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJurApUPRZAJfoHeepGJ8D1MKD/isTWyL6APu2pGUAEuM34tRL1sCINaV+7Hddszw
         mXNe0nEDwEVd87xYhHdT7Kf1G/gv5BgLRKGsHXMK0t4D7iTg0QZZcBCOv4EaN/dskX
         z4MgvIhedhUvsdf0J4ax0injf4ljcCwNrNciGhI2kzDGHmVZldsl4BNI7Yiv3nZZQ3
         UjbMm/vQgY2KQ4BoNSXsmPVtx1EOqSQklOcgKjQYdcmwgUU2Upv9olq+R8f1Q0TOZB
         CQtZIaJlYsAXd3qttZDnyaQbL6VtexBcrvxBYHxf7WbqT/lvkzQvPmLMI8cNbc92uk
         d+gqn+dy/dMPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2834E411E9; Thu, 24 Dec 2020 10:12:45 -0300 (-03)
Date:   Thu, 24 Dec 2020 10:12:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: remove -Wnested-externs
Message-ID: <20201224131245.GD477817@kernel.org>
References: <1608812646-23489-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608812646-23489-1-git-send-email-tiantao6@hisilicon.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 24, 2020 at 08:24:06PM +0800, Tian Tao escreveu:
> since commit c93e4aeed1be
> ("Makefile.extrawarn: remove -Wnested-externs warning")
> has removed this check, so it's not needed here.

But the above commit is for the kernel, scripts/Makefile.extrawarn isn't
included in tools/perf/

This is the one used:

[acme@five perf]$ grep nested-externs tools/scripts/Makefile.include
EXTRA_WARNINGS += -Wnested-externs
[acme@five perf]$

But since you're looking at this, you could consider adding
tools/scripts/Makefile.extrawarn out of tools/scripts/Makefile.include,
etc, to better mimic what is in the kernel sources :-)

Thanks,

- Arnaldo
 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ce8516e..b9e8634 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -16,7 +16,7 @@ $(shell printf "" > $(OUTPUT).config-detected)
>  detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
>  detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  
> -CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> +CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
>  
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo

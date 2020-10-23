Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D4296A20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375650AbgJWHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:15:08 -0400
Received: from verein.lst.de ([213.95.11.211]:55002 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373936AbgJWHPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:15:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 41E1667373; Fri, 23 Oct 2020 09:15:04 +0200 (CEST)
Date:   Fri, 23 Oct 2020 09:15:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdi: fix -Wformat-security
Message-ID: <20201023071503.GA30563@lst.de>
References: <20201023065754.83084-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023065754.83084-1-nick.desaulniers@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:57:54PM -0700, Nick Desaulniers wrote:
> mm/backing-dev.c:810:57: warning: format string is not a string literal
> (potentially insecure) [-Wformat-security]
> dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);

The callers never pass format strings here.  That being said the fix is
probably ok anyway, modulo the obvious style issue.

> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 408d5051d05b..5755578d671d 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -807,7 +807,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  		return 0;
>  
>  	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
> -	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, "%s", bdi->dev_name);

Please don't introduce any over 80 char lines.

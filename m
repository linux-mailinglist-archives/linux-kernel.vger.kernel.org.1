Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB31B1995
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 00:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgDTWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 18:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgDTWdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:33:53 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C24F20782;
        Mon, 20 Apr 2020 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587422032;
        bh=ViONWUUyMBUwXsCi2iskcpvlAwUnt1s05iWjG3WH8Pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uDwWm7NxumBoTt+V8rV7xTtd1DxB+bFx9ihDXHb5kZqYopJHQgVgv8cAMvuSUqhnS
         FVS1nKe//wXkKusDiwWiaObhZli1SvY6fERQPqRdGARnYi7sLQbizUt/zhSKkNZEum
         Yo9Cjpi80RTrd2r5cBHttRMh9pz+VL7u6GiIRaAc=
Date:   Mon, 20 Apr 2020 15:33:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     glider@google.com
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        sunhaoyl@outlook.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-Id: <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
In-Reply-To: <20200419100848.63472-1-glider@google.com>
References: <20200419100848.63472-1-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:

> KMSAN reported uninitialized data being written to disk when dumping
> core. As a result, several kilobytes of kmalloc memory may be written to
> the core file and then read by a non-privileged user.
> 
> ...
>
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  		    (!regset->active || regset->active(t->task, regset) > 0)) {
>  			int ret;
>  			size_t size = regset_size(t->task, regset);
> -			void *data = kmalloc(size, GFP_KERNEL);
> +			void *data = kzalloc(size, GFP_KERNEL);
>  			if (unlikely(!data))
>  				return 0;
>  			ret = regset->get(t->task, regset,

This seems to be a quite easy way of exposing quite a large amount of
kernel memory contents, so I think I'll add a cc:stable to this patch?


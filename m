Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2E21DEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgGMR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:29:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:36102 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgGMR3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:29:53 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B1E8D2E2;
        Mon, 13 Jul 2020 17:29:53 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:29:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     oberpar@linux.ibm.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: GCOV BASED KERNEL
 PROFILING
Message-ID: <20200713112952.762df60f@lwn.net>
In-Reply-To: <20200708161839.15170-1-grandmaster@al2klimov.de>
References: <20200708161839.15170-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jul 2020 18:18:39 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/dev-tools/gcov.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
> index 7bd013596217..9e989baae154 100644
> --- a/Documentation/dev-tools/gcov.rst
> +++ b/Documentation/dev-tools/gcov.rst
> @@ -22,7 +22,7 @@ Possible uses:
>  * minimizing kernel configurations (do I need this option if the
>    associated code is never run?)
>  
> -.. _gcov: http://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> +.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
>  .. _lcov: http://ltp.sourceforge.net/coverage/lcov.php
>  
>  
> @@ -171,7 +171,7 @@ Note on compilers
>  GCC and LLVM gcov tools are not necessarily compatible. Use gcov_ to work with
>  GCC-generated .gcno and .gcda files, and use llvm-cov_ for Clang.
>  
> -.. _gcov: http://gcc.gnu.org/onlinedocs/gcc/Gcov.html
> +.. _gcov: https://gcc.gnu.org/onlinedocs/gcc/Gcov.html
>  .. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html

Applied, thanks.

jon

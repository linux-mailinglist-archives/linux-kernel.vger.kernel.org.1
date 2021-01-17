Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD12F958E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbhAQVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 16:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQVej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:34:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E666D2076E;
        Sun, 17 Jan 2021 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610919238;
        bh=9Gx50XkPXi9s3QSzulaxwMMlBv7fz3Wj8XqmohpdiHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIwxvCB3tzM1PSIQiu6YGu1ZzejGDoTUhf2pTLi0Nzssc2lwLFDCxI1hpf+o3mCac
         1LcbR6Itxf87QBfFbrHBSrOtlyvirq9Zlur3MfSEAizyKgrxJ2TFMcgQzVhbiAz//j
         OjCkXe5CP1Vgr/8dodaFw9J2q8PXSKMq2sLA0YQw=
Date:   Sun, 17 Jan 2021 13:33:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, opendmb@gmail.com,
        Barret Rhoden <brho@google.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] initramfs: Panic with memory information
Message-Id: <20210117133355.10fe86c628279161bb3435d4@linux-foundation.org>
In-Reply-To: <20210114231517.1854379-1-f.fainelli@gmail.com>
References: <20210114231517.1854379-1-f.fainelli@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 15:15:16 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:

> On systems with large amounts of reserved memory we may fail to
> successfully complete unpack_to_rootfs() and be left with:
> 
>  Kernel panic - not syncing: write error
> 
> this is not too helpful to understand what happened, so let's wrap the
> panic() calls with a surrounding show_mem() such that we have a chance
> of understanding the memory conditions leading to these allocation
> failures.

Seems sensible.

> @@ -45,6 +46,11 @@ static void __init error(char *x)
>  		message = x;
>  }
>  
> +#define panic_show_mem(...) {	\
> +	show_mem(0, NULL);	\
> +	panic(__VA_ARGS__);	\
> +}
> +

But can we replace nasty macro with pleasing C code?

--- a/init/initramfs.c~initramfs-panic-with-memory-information-fix
+++ a/init/initramfs.c
@@ -46,9 +46,14 @@ static void __init error(char *x)
 		message = x;
 }
 
-#define panic_show_mem(...) {	\
-	show_mem(0, NULL);	\
-	panic(__VA_ARGS__);	\
+static void panic_show_mem(const char *fmt, ...)
+{
+	va_list args;
+
+	show_mem(0, NULL);
+	va_start(args, fmt);
+	panic(fmt, args);
+	va_end(args);
 }
 
 /* link hash */
_


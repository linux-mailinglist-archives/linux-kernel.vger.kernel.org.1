Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C582B1468
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKMCqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgKMCqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:46:39 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431DF204EF;
        Fri, 13 Nov 2020 02:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605235598;
        bh=ctaQ3C6ggnwKYCfwEzYPswDn+1kfv0MOILMIiYSgbZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/1UCbozzNbr0RF+VQOf1xGEEgdfVNrcviaWlWEMw7QS3jTtVZ8PAqn7P4mFldPrN
         GWKMMKUXdIhBGveD+FCTXm1ghWd+1oUl97fxCUReNzOlSf3wrDlSBTNN3xluZj38xd
         7TFINNL3dsMPQlJjX5NobcDO0lK/mRqFfExFCW5Y=
Date:   Thu, 12 Nov 2020 18:46:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
Message-Id: <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
In-Reply-To: <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
        <20201112035023.974748-1-natechancellor@gmail.com>
        <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
        <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
        <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
        <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 02:38:18 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:

> At this point, since 'pci' enables BOOT_CF9_FORCE type and
> BOOT_CF9_SAFE is not user selectable, should I simply leave only
> 'pci'?
> This way, we'll have the same set of options for both sysfs and kernel cmdline.

Well, you're the reboot expert ;)

But my $0.02 is yes, let's keep the command-line and sysfs interfaces
in sync and cover it all in documentation.  It would of course be
problematic to change the existing reboot= interface.

I assume that means doing this?

- #define BOOT_CF9_FORCE_STR     "cf9_force"
+ #define BOOT_CF9_FORCE_STR     "pci"
- #define BOOT_CF9_SAFE_STR      "cf9_safe"

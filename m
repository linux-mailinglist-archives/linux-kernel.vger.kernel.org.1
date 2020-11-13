Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECF2B13C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMBS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgKMBS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:18:28 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6FD216C4;
        Fri, 13 Nov 2020 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605230308;
        bh=+BcndtHMLbCZgLLpKs6+e77sbXfPv6PvkofRyK7eY3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M8uOspxhCcy9VaAVIv3ZMu3YJDUTbgLhOzebBywhbY2TH/wJjmC1/jD39XaDs9KBe
         d1ArDgONxt9UrfRp1ali3MkGTlwo9txQ1uDWHklj5NRB9VBXja+H48nVd2V9PV+xjq
         Wxo5VhOcV6WSpUrwiDpJN+pWnfW6p5TFql6X8qvs=
Date:   Thu, 12 Nov 2020 17:18:26 -0800
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
Message-Id: <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
In-Reply-To: <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
        <20201112035023.974748-1-natechancellor@gmail.com>
        <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
        <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 01:20:29 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:

> While writing the script I found that in the documentation I left for
> 'type' the values from
> Documentation/admin-guide/kernel-parameters.txt, which is 'pci' for
> cf9_force reboot.
> While at it, should we update the doc with the values 'cf9_force' and
> 'cf9_safe', or rename to 'pci' and 'pci_safe' to be coherent with the
> kernel cmdline?

I looked at Documentation/admin-guide/kernel-parameters.txt's "reboot="
section and decided that I don't understand your above words :( Can you
please expand on all of this?  Simple akpm-compatible words ;)

> In any case, kernel-parameters.txt doesn't mention that reboot=q does
> the 'cf9_safe' reboot type, so it must be fixed anyway.

Thanks for noticing.

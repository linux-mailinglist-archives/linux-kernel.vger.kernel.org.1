Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11822CF804
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgLEAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgLEAfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:35:40 -0500
Date:   Fri, 4 Dec 2020 16:34:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607128500;
        bh=5MBLk0zEnrM8cZb9QfLi08ejcxL0qjNVh5Q0Cgf0U/0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=ArMxRUdQVR0pAb62C92p4l45bXjbYri26k4y22yxxsUNmYQpXUvSo09GkZesXFrKO
         1Z64Livwz2FOmtIEauvMlqbkpe7lMOo0pkirI6xFqtGJiF1+WAF0hUYnpZCQ0B/6FO
         CMv2O9cH99IXAmfC9Yfs8c9HM+E5f6pnQ+IyUAQw=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Barret Rhoden <brho@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] initramfs: fix clang build failure
Message-Id: <20201204163459.7e95c5a1b24cf5c84f779766@linux-foundation.org>
In-Reply-To: <20201204165742.3815221-1-arnd@kernel.org>
References: <20201204165742.3815221-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Dec 2020 17:57:33 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> There is only one function in init/initramfs.c that is in the .text
> section, and it is marked __weak. When building with clang-12 and
> the integrated assembler, this leads to a bug with recordmcount:
> 
> ./scripts/recordmcount  "init/initramfs.o"
> Cannot find symbol for section 2: .text.
> init/initramfs.o: failed

That looks like recordmcount is being silly?

> I'm not quite sure what exactly goes wrong, but I notice that this
> function is only ever called from an __init function, and normally
> inlined. Marking it __init as well is clearly correct and it
> leads to recordmcount no longer complaining.

That works, too.

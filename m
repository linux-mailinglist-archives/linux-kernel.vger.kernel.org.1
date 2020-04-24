Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2918E1B8299
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 01:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDXX6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 19:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXX6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:58:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A98F20748;
        Fri, 24 Apr 2020 23:58:35 +0000 (UTC)
Date:   Fri, 24 Apr 2020 19:58:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUGFIX PATCH 1/1] bootconfig: Fix to remove bootconfig data
 from initrd while boot
Message-ID: <20200424195833.1487a1a0@oasis.local.home>
In-Reply-To: <158774605193.7423.573803007569761807.stgit@devnote2>
References: <158774604073.7423.11492815214537711118.stgit@devnote2>
        <158774605193.7423.573803007569761807.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 01:34:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> If there is a bootconfig data in the tail of initrd/initramfs,
> initrd image sanity check caused an error while decompression
> stage as follows.
> 
> [    0.883882] Unpacking initramfs...
> [    2.696429] Initramfs unpacking failed: invalid magic at start of compressed archive
> 
> This error will be ignored if CONFIG_BLK_DEV_RAM=n,
> but CONFIG_BLK_DEV_RAM=y the kernel failed to mount rootfs
> and causes a panic.
> 
> To fix this issue, shrink down the initrd_end for removing
> tailing bootconfig data while boot the kernel.
> 
> Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  init/main.c |   62 +++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> 

A build with

 $ make allnoconfig

Produces this:

  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      vmlinux
ld: init/main.o: in function `start_kernel':
main.c:(.init.text+0x37f): undefined reference to `initrd_end'
ld: main.c:(.init.text+0x3a7): undefined reference to `initrd_start'
ld: main.c:(.init.text+0x3ae): undefined reference to `initrd_end'
make[1]: *** [/work/git/linux-trace.git/Makefile:1106: vmlinux] Error 1

-- Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CBF2DCD71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgLQIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgLQIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:12:57 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51533C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:12:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id w135so25034744ybg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skHxIoVLp+SMbkm5xPTdyHQT8ReVVH2SXONfbEQLh1M=;
        b=nkAk6meeSPTfVQoOzH9Vuel7uag9F+3v09xDADuWoDZ8tt5O1O7CEDXKgxZJfL/xjU
         NZbOXd8a7l37cmWJ/CL8ayHgLoa34/91MjagQyqIuqM5qxHkPIlcFX2rbXNIkklhmrxo
         eYgjAQxKtvUhD0lJq0rnDodlHWW9w0aaMBPptummXcfIMqJOkIPcWQqSPPi30t7WX/gO
         bk95oBIyqQhv/Gpr/43oxRlW38BM9StTXQY3K6SRkU+l9Y7jbOSL5lMFO2d8cQS27TYA
         Nlc5hCBpbrrSvLHSHnNJ2LGt27oxWCz5800FiYwDMBEBL0IiGx438wYhd68KY1GUo8C0
         +K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skHxIoVLp+SMbkm5xPTdyHQT8ReVVH2SXONfbEQLh1M=;
        b=HARHMwBoIXVtiMmiscPa7h+2T9q/jQTCAgkKOQfTWZ1iAIvEXxcouEqYxcUT4yIpb9
         QLJHkzboW5OqlH5qFYAKmf9q+wL1uuf2PkG1mXU3PyHJMHI2HqaANOFyIvUsa2kEXdLF
         PWh8xsIu5UWeDMcDkZs+san4e9xdeQU15OgqZwBoT5Q2W54Q+W/oYVuk1QTS+P0NEA8Z
         xxMUqMGpDE1nFFSM1AJQHpgFBRy3SR9ERaJLymMmRhfwoq7axpDa6JVYYAPWesyXwavg
         elzizMp6hzpl9jbv7DsTl9j8UXtoa/jNZB1LjfueFBteW2EoNWS+K1JuUUlUzrEtCaRT
         uzoA==
X-Gm-Message-State: AOAM531qbqIyvhvX9vck+kEb0h44jC7spGfSJt7VGbbent5DYvD2M3iC
        FMS2wpKGtA2JkqK4szSRShYRCfD9QTQalL3TlsI=
X-Google-Smtp-Source: ABdhPJytF59c5M9wxGDMR+P9AjaSilWM8G8AgZFxQMPipoy/6/l6e4jTlnY40fFVb5OZC0Rc2Dy0eSocthoMbFXdrbk=
X-Received: by 2002:a05:6902:210:: with SMTP id j16mr57375188ybs.122.1608192735719;
 Thu, 17 Dec 2020 00:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20201217074855.1948743-1-atish.patra@wdc.com>
In-Reply-To: <20201217074855.1948743-1-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 17 Dec 2020 16:12:04 +0800
Message-ID: <CAEUhbmV-AirwmVDN9xWi8eLwH53PFdoc+eU3sKzosA19Xd36Ag@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Thu, Dec 17, 2020 at 3:49 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> memblock_enforce_memory_limit accepts the maximum memory size not the last
> address. Fix the function invocation correctly.
>
> Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thank you for working on this.

Tested with QEMU 5.2.0 on 32-bit 'virt' and 'sifive_u', with
fw_jump.bin used as the -bios.
32-bit 'virt' boots, but 32-bit 'sifive_u' still does not boot, which
should be another issue because reverting the original 1bd14a66ee52 it
still does not help 'sifive_u'.

Tested-by: Bin Meng <bin.meng@windriver.com>

I believe the following tag should also be added and patch cc'ed to
stable-kernel:

Reported-by: Bin Meng <bin.meng@windriver.com>
Cc: <stable@vger.kernel.org> # 5.10

Regards,
Bin

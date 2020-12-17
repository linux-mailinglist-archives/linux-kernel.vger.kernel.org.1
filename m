Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5E2DCDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgLQIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgLQIo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:44:29 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2981C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:43:48 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id t9so25135082ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyvM0JTI1ydl5VSsasQuRjR8gmnzoIsqUBzYnVc9TT4=;
        b=DhBrBRowc9Z5HNcivJKgo5Rgre54UgzfTuKotHhpYXeHMfLn/rSA6EWV22SH84v1Au
         G8H2yxl6OMBVCvcSb1o6KoKt7WWxlqZBmsxvIVA0nrcPm20JiGHJzZXEPt9IwlF4z+mx
         Pb5kzGLNCjg2bLlDY2NTZcdtfAc61ZNxfiUXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyvM0JTI1ydl5VSsasQuRjR8gmnzoIsqUBzYnVc9TT4=;
        b=uWd/KHOoKLJe9QN9NccNz9Ko5sBTIQWQXhz/Z3QzAKiS2X7nmxTtK3pGeY9r+f337k
         ZJMjsE8lTuOz2/CA2irArKDUcqtR0+gLhpcDnUbfVUhgGUg9IYADkbl+vaUUvtIVEc6X
         erwZxRWQVz2yUMpfSgkOs1TxrPAuJF0hB89K2tMnWvQNj9xYLF+xziddcY9CNlAMTAd0
         AFxRTS5ZAW5Z3BhiTLs7i2hW0BoVu9q9bQ8ZzM02WMncmvcWD/QYqjO7U/wA33jp3iIp
         RffgapDU4ZToLkvRb/H9YJOjkEbMAckuXOJoR/vS52QCMB2pjKcdj5RkcZzVPef4+ZBj
         YXsA==
X-Gm-Message-State: AOAM531YfXSiIMCaP+LdJoRP4u3/qbiCFgz8uVbR/kW0FTz6ig5VPRYP
        oU6IsBBQi/l5Hl8KPtdiIbgg45cn0uJQv1EOG3OCGhEzHWWF
X-Google-Smtp-Source: ABdhPJy89vpEbfhvusOQEEUbjElFUDT8Yr3qx6v/ayUMzdxTaapyCNKahoiHA8EKbt1mYqkk6bBjHQk9hLVRf7+bJ2U=
X-Received: by 2002:a92:d84a:: with SMTP id h10mr47862427ilq.77.1608194628256;
 Thu, 17 Dec 2020 00:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20201217074855.1948743-1-atish.patra@wdc.com> <CAEUhbmV-AirwmVDN9xWi8eLwH53PFdoc+eU3sKzosA19Xd36Ag@mail.gmail.com>
In-Reply-To: <CAEUhbmV-AirwmVDN9xWi8eLwH53PFdoc+eU3sKzosA19Xd36Ag@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Dec 2020 00:43:37 -0800
Message-ID: <CAOnJCUJSKn-QNwKCcHXc+kYtuwFQE2qatnOtGfqTOG0_Jzt4og@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:12 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Atish,
>
> On Thu, Dec 17, 2020 at 3:49 PM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > memblock_enforce_memory_limit accepts the maximum memory size not the last
> > address. Fix the function invocation correctly.
> >
> > Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Thank you for working on this.
>
> Tested with QEMU 5.2.0 on 32-bit 'virt' and 'sifive_u', with
> fw_jump.bin used as the -bios.

fw_dynamic should also work unless you are using more than 1G of memory.
Linux kernel can only support 1G of memory for RV32. The current
Kconfig is bit misleading and
I will send a patch to update the description.

However, kernel should be able to ignore any memory beyond what it can
address and continue.
I will investigate more.

> 32-bit 'virt' boots, but 32-bit 'sifive_u' still does not boot, which
> should be another issue because reverting the original 1bd14a66ee52 it
> still does not help 'sifive_u'.
>

Are you using more than 1G of memory ? Let me know if the kernel boots
if you use 1G.

> Tested-by: Bin Meng <bin.meng@windriver.com>
>
> I believe the following tag should also be added and patch cc'ed to
> stable-kernel:
>
> Reported-by: Bin Meng <bin.meng@windriver.com>
> Cc: <stable@vger.kernel.org> # 5.10
>
> Regards,
> Bin
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish

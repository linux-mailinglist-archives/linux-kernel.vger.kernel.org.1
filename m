Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA026D576
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIQH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgIQH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:59:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63375C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:59:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so1001473wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9pR7FK+JGoERdb0Ak9FECdQMuRJrYsyh3lgs4kFEwQ=;
        b=MPL4ax1SFCVhCQXNZ+Ha0xfJQbr9rJo7lwNYbfSI5tHuUDUWkjIfUKBOpQG43D6n/n
         FTlO+xC+hXTt010btWXgWLdlxelIeZtC21jWFar+z+83KCo0mepJEWxf/ReYS/dQDx6Y
         KCWzPCJ7YK+kTZ5K2OoNmp/SD7rIC67kuetU9tQxsswe7RWhRRCGRhKKdf9YHNkb9P54
         yDrj9zZ7CVqqiG0kNJeb6FpmswiC1blbOcloYm1T/T//rJWS0ung+s9Fx2X5rzbRGL/n
         OJgFJjZZ51BK1Twn7baV28XqiiiGS8GoNJqsRSnm/GpxPYi+NLwEWRn7nGLC9M8+yjKd
         j7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9pR7FK+JGoERdb0Ak9FECdQMuRJrYsyh3lgs4kFEwQ=;
        b=HHG87xwaX54Uu6NV+F0zXSTC7olAr8IuPiT2EYc/gLugor/8gl2xjVqAjOPJWCCYvf
         nZEzw7NlkU55aUdBwEhXnXVN1OAbNP/eZAorqD5fgxF28RJhW5GsDDaKjXdwLzihwC2z
         n3aLTxmF0CRk+0wERurj3jnveorenHUauqxrx06zUL3lUeDqz9CJZx8TkHZU7gXLxk2I
         df8y0laLYaXX7YKK96AKVGViAERH+6/iKi5Ofd3REdbSin293bUXDZRBHTF4abZKENA7
         k2fkaJ/0+A+K7y7KqQ6YcT9FtacZDJ2cQm7aNWcRqX7ntMbBqFSMx29Zg9AJh7YOSz7g
         bUVg==
X-Gm-Message-State: AOAM533KCTBuSwkwxIUeut8o97Dw6byXfUI5fhRH7Q/AcP0dzeF/aVGN
        rpkkW6qtIrIAtrGqi/fl3Il9b0Qy3K2hL3v30jnxUQ==
X-Google-Smtp-Source: ABdhPJy64KlmX4N12OxqX23EP5E04YYy4MNUIXKmL/3zu7BPBVj4Ub21t3SB9b5bJIyYHJCiiwGiKVIn/Ld42eCnLog=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr8505787wmh.152.1600329563988;
 Thu, 17 Sep 2020 00:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
In-Reply-To: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 17 Sep 2020 13:29:12 +0530
Message-ID: <CAAhSdy1kn5K3aH3-LP9zy2R-Xq0ha9RqjBnBd8y9xZkCEn0rsg@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix pfn_to_virt err in do_page_fault().
To:     liush <liush@allwinnertech.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        walken@google.com, daniel.m.jordan@oracle.com, vbabka@suse.cz,
        Mike Rapoport <rppt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:56 PM liush <liush@allwinnertech.com> wrote:
>
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
>
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 716d64e..9b4e088 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -212,7 +212,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>                  * of a task switch.
>                  */
>                 index = pgd_index(addr);
> -               pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +               pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP) & SATP_PPN) + index;
>                 pgd_k = init_mm.pgd + index;
>
>                 if (!pgd_present(*pgd_k))
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A892C984B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgLAHmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgLAHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:42:13 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:41:33 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id o8so684104ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4x+7bX+90aM2/6MhSIys1rmKK1XZrhcw7vhfqYqSRM=;
        b=VE/EnvMu20AqpeZwugCON8r/nG8CseB0YevYYyK2hwvh4vyAJ5CutGWvZYbFciFE8S
         pjymne5+KN8QCYyBsnkJEZXkZOu8h9cAbclBVagZzSbTbOD6ZsCWNVJ7c4e/dQocdq7r
         fbQl54KC0etlFpK1mO4fLxE01eWt9Fzhg8yj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4x+7bX+90aM2/6MhSIys1rmKK1XZrhcw7vhfqYqSRM=;
        b=lYvE8o1kjnOqvuJeWvFSwKes241TyCpxgZuYTZKt8vzuRrCmLSYJ76lFz+ngTFzaFs
         0DE1g4xNRZgngcvrARWIgJAQ3FRxiSKSyGw26c0R0SxndTPmKpunVwzJaahCWrRRjS3O
         IuhU+St7e9lj95UrAsAOQ+8/0Zl666aYCmZtcNHkpBjzFJKf6Wwlfja40knUi4g5GHAu
         q8G+7Ix/FIgT44zBb6KYwK6l1TmvAwp47G34qwOI12n2HMS+Yfu/P6DqciA4mG40Exj+
         rZ20jqfM/h+vkneOWgveZ0fJP6cYz+Bn3s7v9ODdnSUNt9cQi+zA3V8OqbrnNUBE/owc
         82Sg==
X-Gm-Message-State: AOAM531Ne4Nw9s5g7PBJ6Xi1KwD11f/nQ621GlfsJBDAI1q2dZd3wHyE
        AfBuN/h6vBIBWL5RpwfmOkusdbPQwgxSh6BUjkIk
X-Google-Smtp-Source: ABdhPJxcEuJGRXd6NBzZxS5ew9eeBlD64P/FotTqpfaXlYxTjifB7TUfPwPafBleYMiQxj3q2+vDSTZfS8frTuxEZHA=
X-Received: by 2002:a5d:8617:: with SMTP id f23mr1420643iol.174.1606808492370;
 Mon, 30 Nov 2020 23:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20201125051752.295572-1-anup.patel@wdc.com>
In-Reply-To: <20201125051752.295572-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 30 Nov 2020 23:41:25 -0800
Message-ID: <CAOnJCUK-sffDYnLxQ2ERNHCaQELxK0Nu7haBAEtYFS5qSpe2GQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Use SBI SRST extension when available
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 9:18 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The SBI SRST extension provides a standard way to poweroff and
> reboot the system irrespective to whether Linux RISC-V S-mode
> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>
> The SBI SRST extension is available in latest SBI v0.3-draft
> specification at: https://github.com/riscv/riscv-sbi-doc.
>
> This patch extends Linux RISC-V SBI implementation to detect
> and use SBI SRST extension.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v2:
>  - Rebased on Linux-5.10-rc5
>  - Updated patch as-per SBI SRST extension available in the latest
>    SBI v0.3-draft specification
> Changes since v1:
>  - Updated patch as-per latest SBI SRST extension draft spec where
>    we have only one SBI call with "reset_type" parameter
> ---
>  arch/riscv/include/asm/sbi.h | 16 ++++++++++++++++
>  arch/riscv/kernel/sbi.c      | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 653edb25d495..5b2d6d614c20 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
>         SBI_EXT_HSM = 0x48534D,
> +       SBI_EXT_SRST = 0x53525354,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
>         SBI_HSM_HART_STATUS_STOP_PENDING,
>  };
>
> +enum sbi_ext_srst_fid {
> +       SBI_EXT_SRST_RESET = 0,
> +};
> +
> +enum sbi_srst_reset_type {
> +       SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
> +};
> +
> +enum sbi_srst_reset_reason {
> +       SBI_SRST_RESET_REASON_NONE = 0,
> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 226ccce0f9e0..33b834ecd195 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#include <linux/reboot.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>  }
>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>
> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
> +{
> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
> +                 0, 0, 0, 0);
> +       pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
> +               __func__, type, reason);

sbi_system_reset may return the failure reason as well. I think we can
print that in the warning message if present.

> +}
> +
> +static int sbi_srst_reboot(struct notifier_block *this,
> +                          unsigned long mode, void *cmd)
> +{
> +       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +                      SBI_SRST_RESET_REASON_NONE);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sbi_srst_reboot_nb;
> +
> +static void sbi_srst_power_off(void)
> +{
> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> +                      SBI_SRST_RESET_REASON_NONE);
> +}
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>   * @extid: The extension ID to be probed.
> @@ -593,6 +620,13 @@ int __init sbi_init(void)
>                 } else {
>                         __sbi_rfence    = __sbi_rfence_v01;
>                 }
> +               if (sbi_probe_extension(SBI_EXT_SRST) > 0) {
> +                       pr_info("SBI v0.2 SRST extension detected\n");
> +                       pm_power_off = sbi_srst_power_off;
> +                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> +                       sbi_srst_reboot_nb.priority = 192;
> +                       register_restart_handler(&sbi_srst_reboot_nb);
> +               }
>         } else {
>                 __sbi_set_timer = __sbi_set_timer_v01;
>                 __sbi_send_ipi  = __sbi_send_ipi_v01;
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Apart from that, it looks good to me.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish

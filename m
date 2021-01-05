Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8053E2EA6C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbhAEIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbhAEIzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:55:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A0A22525
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609836904;
        bh=c+iWKsnwjk317ZoBhpEI8SgnI0WlpfD9+a5eG0+2x10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ml+mYsnbuQjhIWIQ9EhslyAj5T4Q6HvPMUVTDnIpkm2uUzgnAaMb7fCYDwj8o0p7l
         +vW+ky2DMDr8NolOvMTSC/7mcwRzrZASDhts42/98i/l7FG61gAoJuIYJ/1Ut1gkCj
         wajBzz76DRwJYUJTewfu2I2skULtvSsnSnVIrq8m1ziVhMOos+DJcOzHRa11selix4
         Md8dwvyNb+bGm1cauxJr2oo6Wy5AyM2bR1S1h7sQYOQ9UlvwGg3mCYrNOSTNKCS0X6
         8A10QOjY+7nDfH4byraxgMNqKotfT+aqvAoTNhpcgsniU3bVqtyuk7XqRzNChShgV0
         Znymk8II1mHmg==
Received: by mail-ot1-f47.google.com with SMTP id j20so28639801otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:55:04 -0800 (PST)
X-Gm-Message-State: AOAM532bpS0J/52AuLeuR21f+pysXENmciH8ZEDbosL1WboFW1lQ/36N
        I2T06cs6cpC+qW9SsvU7E/tEd4WvIOA5XeW5m5I=
X-Google-Smtp-Source: ABdhPJyjZQ1DGRpJCt6W/sXV+9t1ybiAHF2vYbbOmksv8u3WrgmDunWmoapKGixhJ0qtAKfkgxSvMOyyYHVK9AFIC/k=
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr55016652oto.90.1609836903651;
 Tue, 05 Jan 2021 00:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20210105085346.995-1-linfeng23@huawei.com>
In-Reply-To: <20210105085346.995-1-linfeng23@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 Jan 2021 09:54:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
Message-ID: <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
Subject: Re: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
To:     Lin Feng <linfeng23@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        weidong.huang@huawei.com, hogan.wang@huawei.com,
        wangxinxin.wang@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Arvind)

On Tue, 5 Jan 2021 at 09:54, Lin Feng <linfeng23@huawei.com> wrote:
>
> On efi64 x86_64 system, the EFI_CONVENTIONAL_MEMORY regions will not
> be mapped when making EFI runtime calls. So kexec-tools can not get
> these from /sys/firmware/efi/runtime-map. Then compressed boot os
> can not get suitable regions in process_efi_entries and print debug
> message as follow:
>         Physical KASLR disabled: no suitable memory region!
> To enable physical kaslr with kexec, call process_e820_entries when
> no suitable regions in efi memmaps.
>
> Signed-off-by: Lin Feng <linfeng23@huawei.com>
>
> ---
>
> I find a regular of Kernel code and data placement with kexec. It
> seems unsafe. The reason is showed above.
>
> I'm not familiar with efi firmware. I wonder if there are some risks
> to get regions according to e820 when there is no suitable region
> in efi memmaps.
> ---
>  arch/x86/boot/compressed/kaslr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b92fffbe761f..dbd7244b71aa 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -685,6 +685,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  {
>         struct efi_info *e = &boot_params->efi_info;
>         bool efi_mirror_found = false;
> +       bool efi_mem_region_found = false;
>         struct mem_vector region;
>         efi_memory_desc_t *md;
>         unsigned long pmap;
> @@ -742,12 +743,13 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>                         continue;
>
> +               efi_mem_region_found = false;
>                 region.start = md->phys_addr;
>                 region.size = md->num_pages << EFI_PAGE_SHIFT;
>                 if (process_mem_region(&region, minimum, image_size))
>                         break;
>         }
> -       return true;
> +       return efi_mem_region_found;
>  }
>  #else
>  static inline bool
> --
> 2.23.0
>

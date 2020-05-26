Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190C81B08A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDTMBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDTMBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:01:19 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB9921473
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587384078;
        bh=LE0hh02HGEfNqHWFJ0oLjv2Ppm84+xP/7ZLrcujrTG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y13i5g47xbUNGJNi5vTVFyDihSOt16suza+URvR5daM1z5eHSMAj9R1xnPAD1zyjt
         TPtd/jzEVgkfEGKGqnJre94CCl/6aPZNrJaVkvPIogBqXE2SlslhP8VsaZPV5Cuj+Q
         1BZ406gj3boWp9JBYXDWjqU9KM9Sr1UB/rriubC4=
Received: by mail-io1-f53.google.com with SMTP id u11so10623125iow.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:01:18 -0700 (PDT)
X-Gm-Message-State: AGi0Pua+wpigL7uFWqDOxHQQ6lob8jMIRQXGoet3WHCkslOmuQwUhjmM
        4w8zcke8GwAkWCQ/hZuKm5MnX/wAo+etYfVzR3s=
X-Google-Smtp-Source: APiQypLo7VI0Gx3PbINM1K4iGJJh8+XZEBEP5FIy1rH93FIKcOA36tIEnlm+cprLdjkY4/CAHs7D4dW8Nypqz+QTXq8=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr8391396iom.171.1587384077983;
 Mon, 20 Apr 2020 05:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210452.27436-1-kristen@linux.intel.com> <20200415210452.27436-10-kristen@linux.intel.com>
In-Reply-To: <20200415210452.27436-10-kristen@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 20 Apr 2020 14:01:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
Message-ID: <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] module: Reorder functions
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Jessica Yu <jeyu@kernel.org>, arjan@linux.intel.com,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 23:07, Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> If a module has functions split out into separate text sections
> (i.e. compiled with the -ffunction-sections flag), reorder the
> functions to provide some code diversification to modules.
>

Is that the only prerequisite? I.e., is it sufficient for another
architecture to add -ffunction-sections to the module CFLAGS to get
this functionality? (assuming it defines CONFIG_FG_KASLR=y)

> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/module.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 646f1e2330d2..e432ec5f6df4 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -53,6 +53,8 @@
>  #include <linux/bsearch.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
> +#include <linux/random.h>
> +#include <asm/setup.h>
>  #include <uapi/linux/module.h>
>  #include "module-internal.h"
>
> @@ -2370,6 +2372,83 @@ static long get_offset(struct module *mod, unsigned int *size,
>         return ret;
>  }
>
> +/*
> + * shuffle_text_list()
> + * Use a Fisher Yates algorithm to shuffle a list of text sections.
> + */
> +static void shuffle_text_list(Elf_Shdr **list, int size)
> +{
> +       int i;
> +       unsigned int j;
> +       Elf_Shdr *temp;
> +
> +       for (i = size - 1; i > 0; i--) {
> +               /*
> +                * pick a random index from 0 to i
> +                */
> +               get_random_bytes(&j, sizeof(j));
> +               j = j % (i + 1);
> +
> +               temp = list[i];
> +               list[i] = list[j];
> +               list[j] = temp;
> +       }
> +}
> +
> +/*
> + * randomize_text()
> + * Look through the core section looking for executable code sections.
> + * Store sections in an array and then shuffle the sections
> + * to reorder the functions.
> + */
> +static void randomize_text(struct module *mod, struct load_info *info)
> +{
> +       int i;
> +       int num_text_sections = 0;
> +       Elf_Shdr **text_list;
> +       int size = 0;
> +       int max_sections = info->hdr->e_shnum;
> +       unsigned int sec = find_sec(info, ".text");
> +
> +       if (sec == 0)
> +               return;
> +
> +       text_list = kmalloc_array(max_sections, sizeof(*text_list), GFP_KERNEL);
> +       if (text_list == NULL)
> +               return;
> +
> +       for (i = 0; i < max_sections; i++) {
> +               Elf_Shdr *shdr = &info->sechdrs[i];
> +               const char *sname = info->secstrings + shdr->sh_name;
> +
> +               if (!(shdr->sh_flags & SHF_ALLOC) ||
> +                   !(shdr->sh_flags & SHF_EXECINSTR) ||
> +                   strstarts(sname, ".init"))
> +                       continue;
> +
> +               text_list[num_text_sections] = shdr;
> +               num_text_sections++;
> +       }
> +
> +       shuffle_text_list(text_list, num_text_sections);
> +
> +       for (i = 0; i < num_text_sections; i++) {
> +               Elf_Shdr *shdr = text_list[i];
> +
> +               /*
> +                * get_offset has a section index for it's last
> +                * argument, that is only used by arch_mod_section_prepend(),
> +                * which is only defined by parisc. Since this this type
> +                * of randomization isn't supported on parisc, we can
> +                * safely pass in zero as the last argument, as it is
> +                * ignored.
> +                */
> +               shdr->sh_entsize = get_offset(mod, &size, shdr, 0);
> +       }
> +
> +       kfree(text_list);
> +}
> +
>  /* Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
>     might -- code, read-only data, read-write data, small data.  Tally
>     sizes, and place the offsets into sh_entsize fields: high bit means it
> @@ -2460,6 +2539,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
>                         break;
>                 }
>         }
> +
> +       if (IS_ENABLED(CONFIG_FG_KASLR) && kaslr_enabled())

kaslr_enabled() only exists [as a function] on x86


> +               randomize_text(mod, info);
>  }
>
>  static void set_license(struct module *mod, const char *license)
> --
> 2.20.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7084026772A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 04:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgILCK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgILCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:10:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 19:10:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so9404521qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 19:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZiqJJzRszA8sfylho0I06IV4lu0RleMsXL29ujwW9Qc=;
        b=NhZ6t58sndgHcFesG2epVOV01yvEmPYqN8GFSC1/TpoKeXCsxndzzKNQu4jsKA7Hr5
         Xs08pBMsNdgRG7Uxzv7m955oW+OslAMzQdzIxBpA1XQqDnmtNNvOZCr20BhdNoTLIqKC
         0hgWV1DU7XaVbjufHui2ymxoInHFlP/KqFfxpm7PbX3+ggGYgu2NWc9qYpVilJ+BRx0X
         R281BW7nSbkNpxCqdK8JqGdSbRy3Cw7vNNdmncqaY2snh4mMTj0UW0aJU2yjANsq3pGr
         RZaer54KiY1/8xVWPpQhSJ0ITjyrabRFxulj4dY6jEGXofmmYetEPA64FEdstcPVClP2
         lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZiqJJzRszA8sfylho0I06IV4lu0RleMsXL29ujwW9Qc=;
        b=e3L4LGYpZCWJrQWkvZOT4NpUN4V/eg89O5qZPIJ4ghv1V32QMUB3XFkAGqj4a722vv
         lq1ORnZNWTeItTw9JniwWNelWYr7lmgtz5boP8WJfawzsRKJtgWbEc7CxP1YPXwzltHx
         cYL+iPvBixibXFNPt+uhaMtuEIaHVo+caRHmdtnF2/aZR3f/lMq5xGlVgPjRQ/g9kSEI
         ramWFVQ1NdhO1A7foNBnPAec+81XVXlI0lfhNA7Fi2MaPvwMKVSkf6UUFwMSF9GtHP7H
         yJB8hUuMEa8VMpD8hADkueiydshYv3iFZt02W4IsJB5tbZK9lgklAj0HuF+0/PIIUceC
         SKFQ==
X-Gm-Message-State: AOAM531W6jNzHBw3AVl6UPPsO0HAXpnvueVhIg7pEheDJuZJKFNbc4iA
        VLdy1DiEBOk/drAwrLGD1dZzhKIORL4QwUeB6sBUSA==
X-Google-Smtp-Source: ABdhPJyQ9TcOcosXc8x+MEogEBhbztazXLTte+z2BLrqlvJOLe/OFX/EBEgJi/a6XOqalPPPB9DZD/3ae4mc6P8ir5k=
X-Received: by 2002:ac8:1667:: with SMTP id x36mr4647841qtk.51.1599876622754;
 Fri, 11 Sep 2020 19:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200912013441.9730-1-atish.patra@wdc.com> <20200912013441.9730-4-atish.patra@wdc.com>
In-Reply-To: <20200912013441.9730-4-atish.patra@wdc.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Sat, 12 Sep 2020 10:10:09 +0800
Message-ID: <CAHCEehJqV1aBQjWCB1b=r+aQmkMmQnx1ynYzHgCW92NNntZrfg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2 3/5] riscv: Separate memory init from paging init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>, linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=889:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Currently, we perform some memory init functions in paging init. But,
> that will be an issue for NUMA support where DT needs to be flattened
> before numa initialization and memblock_present can only be called
> after numa initialization.
>
> Move memory initialization related functions to a separate function.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 1 +
>  arch/riscv/kernel/setup.c        | 1 +
>  arch/riscv/mm/init.c             | 6 +++++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index eaea1f717010..515b42f98d34 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -466,6 +466,7 @@ static inline void __kernel_map_pages(struct page *pa=
ge, int numpages, int enabl
>  extern void *dtb_early_va;
>  void setup_bootmem(void);
>  void paging_init(void);
> +void misc_mem_init(void);
>
>  #define FIRST_USER_ADDRESS  0
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c6dd329312b..07fa6d13367e 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -78,6 +78,7 @@ void __init setup_arch(char **cmdline_p)
>  #else
>         unflatten_device_tree();
>  #endif
> +       misc_mem_init();
>
>  #ifdef CONFIG_SWIOTLB
>         swiotlb_init(1);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 188281fc2816..8f31a5428ce4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -568,8 +568,12 @@ static void __init resource_init(void)
>  void __init paging_init(void)
>  {
>         setup_vm_final();
> -       sparse_init();
>         setup_zero_page();
> +}
> +
> +void __init misc_mem_init(void)
> +{
> +       sparse_init();
>         zone_sizes_init();
>         resource_init();
>  }

Thank you, Atish.
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>

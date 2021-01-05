Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1713A2EB48B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAEVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbhAEVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:01:33 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB95C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:00:53 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b64so683043qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nIRlRpjfgwk2Cu6hKwK/UViv3+kUVAFFs7qkdFhQDgo=;
        b=c+33G1IJ8Ajj3EQ6ajiJVII/ETkyz2jOTsyEYAAKLgxg6otqsKvC2tlrWOEBYpItk+
         WNgQ7QPg056FMNQgh7JkYVHW5N8+AWbaUK9axA2qBuB8yKzNNFasjWlETNXG7gBaqker
         faVb1m+eeM1mlELpVJKZZaRsfhxfzm1K/3GM/nuK4nZQNUK6EzP7ZtOR5tQCYqBneHlE
         y/5g9xm5w6JqPef3dXYzf52cRa7Mnqxr5U1cTX9nfPsU3NSnW3C0C2ioGSpHro80Z61H
         GvxuQu7QkAed3o9Nws3pnm5ANYPT1skYph6jfrWi5O+wtq+ReM40htlkhNCiy+JCSt4g
         Mykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nIRlRpjfgwk2Cu6hKwK/UViv3+kUVAFFs7qkdFhQDgo=;
        b=USRblHHLbIMVBbVvxsp90L3aDr9EtAddmY1xzWEBot7HJdY302reL4RkT92FBeRXjx
         PSkOJejMeQnxEtyVqVGFn9lmbIeQfPuMwZPBNT/xwjQCnSWlWbUXy0UH+mwdVTp2PW0R
         JACcJlGlwFcFayievAxM6kHdFRYO4sqF/g17mH6WTZL54pLUdkowRMXvy9yUXuJjonf/
         ADLoKbZCVnkZwDhGlM/WTsY0kg9322TdnipkxFv3ZCKHgdmmvHVAjhJwQkwwzWJDfOqx
         C0PjMzy/RFbOD74QlK5CpjBNncFK/nK9kncyt95Nh37pJ9GDLPLaKgRNHVWYfej3sakY
         vN8g==
X-Gm-Message-State: AOAM530AlMyIWpH7uoItBtsuMV6DEcVXfVVq+wkvc5LdtHJ2BOMwb4fJ
        n4Btu3fDhcaV5aRVvFwQgIHFfrohhvbAIA==
X-Google-Smtp-Source: ABdhPJxl8gGQn7JIY5Ynfj23ZoCh9BGPez8VhZ7xqIM+o0qJkHYhafiWGnn1UxPML0aP+ICcswDFzA==
X-Received: by 2002:a37:ad0d:: with SMTP id f13mr1375956qkm.355.1609880452376;
        Tue, 05 Jan 2021 13:00:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z30sm182106qtc.15.2021.01.05.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:00:51 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 5 Jan 2021 16:00:49 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lin Feng <linfeng23@huawei.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        weidong.huang@huawei.com, hogan.wang@huawei.com,
        wangxinxin.wang@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86/kaslr: try process e820 entries if can not get
 suitable regions from efi
Message-ID: <X/TTgYA+C0LjFAo2@rani.riverdale.lan>
References: <20210105085346.995-1-linfeng23@huawei.com>
 <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHJ62ib6zeRuqEKoASP1244naWijw9s7Ofhc8_g2K7WNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:54:52AM +0100, Ard Biesheuvel wrote:
> (cc Arvind)
> 
> On Tue, 5 Jan 2021 at 09:54, Lin Feng <linfeng23@huawei.com> wrote:
> >
> > On efi64 x86_64 system, the EFI_CONVENTIONAL_MEMORY regions will not
> > be mapped when making EFI runtime calls. So kexec-tools can not get
> > these from /sys/firmware/efi/runtime-map. Then compressed boot os
> > can not get suitable regions in process_efi_entries and print debug
> > message as follow:
> >         Physical KASLR disabled: no suitable memory region!
> > To enable physical kaslr with kexec, call process_e820_entries when
> > no suitable regions in efi memmaps.
> >
> > Signed-off-by: Lin Feng <linfeng23@huawei.com>
> >
> > ---
> >
> > I find a regular of Kernel code and data placement with kexec. It
> > seems unsafe. The reason is showed above.
> >
> > I'm not familiar with efi firmware. I wonder if there are some risks
> > to get regions according to e820 when there is no suitable region
> > in efi memmaps.
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index b92fffbe761f..dbd7244b71aa 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -685,6 +685,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >  {
> >         struct efi_info *e = &boot_params->efi_info;
> >         bool efi_mirror_found = false;
> > +       bool efi_mem_region_found = false;
> >         struct mem_vector region;
> >         efi_memory_desc_t *md;
> >         unsigned long pmap;
> > @@ -742,12 +743,13 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >                     !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
> >                         continue;
> >
> > +               efi_mem_region_found = false;
					   ^^ this should be true, not false.

Other than that, I think this should be okay. The reason EFI memmap is
preferred over E820, according to commit

  0982adc74673 ("x86/boot/KASLR: Work around firmware bugs by excluding EFI_BOOT_SERVICES_* and EFI_LOADER_* from KASLR's choice")

was to avoid allocating inside EFI_BOOT_SERVICES/EFI_LOADER_DATA etc.
That's not a danger during kexec, and I believe runtime services regions
should be marked as reserved in the E820 map, right?

Also, something a little fishy-looking here is that the first loop to
see if there is any EFI_MEMORY_MORE_RELIABLE region does not apply any
of the checks on the memory region type/attributes. If there is a mirror
region but it isn't conventional memory, or if it was soft-reserved, we
shouldn't be setting efi_mirror_found.


> >                 region.start = md->phys_addr;
> >                 region.size = md->num_pages << EFI_PAGE_SHIFT;
> >                 if (process_mem_region(&region, minimum, image_size))
> >                         break;
> >         }
> > -       return true;
> > +       return efi_mem_region_found;
> >  }
> >  #else
> >  static inline bool
> > --
> > 2.23.0
> >

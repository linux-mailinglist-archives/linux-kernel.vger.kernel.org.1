Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58952E2F23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgLZVRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:17:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082DC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:16:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o17so15977866lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQiB/N6vURjg6dOpOwGpn1IZbShpuFXt1LxjdVRRQl0=;
        b=QrKZyWIlQNpwpRfYAap3JBcf1Rgjp9mla47l8nPjUk+LtWkutlhkno0HRaeI8l01ze
         7YIPTHmo7LEq6IcMWLNMdhZlYCfg4QQhLa63QwOUx0LM6Bq2XGpMey/60px88MgTnk+d
         uD/J9oj4ov7JCZjqnNkqKHZ6HLd20toudEO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQiB/N6vURjg6dOpOwGpn1IZbShpuFXt1LxjdVRRQl0=;
        b=Cg2Fr3oDw8TCRVmhdv/TCIWnPzdX/R3KP4t/pZmz6mK05pPscW97ZZjwNpj5Kwv3ui
         OHxQLYP3m+1TQQwlppbez0riso9zNohKd0hoHVPFolSysML8idO5vc3wUluTnRqeKyMg
         JHZjXXbovxryhzeHB15EWm18TnKYCoUaeEoWpZh6LTQVhjXo2pj6B+60sYHdfo+uTDxf
         DnoMDn0LWMqCEB8T36/vcv4ZDPHFKPBynA7aKBkRLKS9NVErb27jQijn/MKppvDqvh9A
         r9s0Dy8JF5ZSb45yISSPTW5v3GHFNo8927GKv7Ktnj57xvs/YS9eB8MyXg9MtsvnUCRl
         BLiA==
X-Gm-Message-State: AOAM532ud1zm7dxceY1aS12cxB4D0pmxlHTd1b0ala4o9ELKyms2rTR2
        WTt9haxRP0ZEdYgkiMEc0FW2R4X6QQ9+Ag==
X-Google-Smtp-Source: ABdhPJwPAHf4E/6Fo5DIZxkRRumu+Vds0wl60NgNq/gzP4h/RhUR4pis4UYYos42jtARTnIrsba6Gg==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr11397127ljo.402.1609017387348;
        Sat, 26 Dec 2020 13:16:27 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j21sm4694319lfe.83.2020.12.26.13.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 13:16:26 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id s26so15936163lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:16:25 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr17749625lji.48.1609017385687;
 Sat, 26 Dec 2020 13:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Dec 2020 13:16:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
Message-ID: <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 1:04 PM Hugh Dickins <hughd@google.com> wrote:
>
>
> Hold on. I guess this one will suffer from the same bug as the previous.
> I was about to report back, after satisfactory overnight testing of that
> version - provided that one big little bug is fixed:
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2919,7 +2919,7 @@ static bool filemap_map_pmd(struct vm_fa
>
>         if (pmd_none(*vmf->pmd) &&
>             PageTransHuge(page) &&
> -           do_set_pmd(vmf, page)) {
> +           do_set_pmd(vmf, page) == 0) {
>                 unlock_page(page);
>                 return true;
>         }

I missed that entirely, because when just reading the patch it looks
fine and I didn't look at what do_set_pmd() function returns outside
the patch.

And maybe it would be better to write it as

        if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
                vm_fault_t ret = do_set_pmd(vmf, page);
                if (!ret) {
                        ...

instead to make it a bit more explicit about how that return value is
a vm_fault_t there...

And see my other email about how I suspect there is still a leak in
that patch for the previous test-case.

            Linus

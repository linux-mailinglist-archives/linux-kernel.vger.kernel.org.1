Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4180F2DF180
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 21:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgLSUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 15:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgLSUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 15:09:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84981C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:08:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s26so14244726lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVODdPybrlcbXNP7lCnqd5UusuAf6ILXOIXCJqNGVzA=;
        b=Vi+1ed9OKjtopsq+1bVnAurIL+SBBBmWE1yCd+bEWojjNIE5+ScQRteZg58le8psS+
         OGMgdv+vJwa8mhGIBiS2tBURhTt+WaaxRTNSsg8GVUONtSKPyRqWQUC9+pmlV1GECXio
         vXXjflwYbXnkzPzO43btJGKJJDEDqSKDZTI04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVODdPybrlcbXNP7lCnqd5UusuAf6ILXOIXCJqNGVzA=;
        b=MOy3yfO5f2Z8qR6o77k1HjSGgxgFW9fDhXH7z42QtRjb1RCQ2AtwAHB7ta0IZkAqmx
         TSbGOzWjcK/QW+YrsV3pCRLgz6DRz3vS3iYbA1hjwNxfp4jOSHWLCQKa7biOIOG+i44m
         dmqgP0huoKrpyLcpttOs6wrSiEj/W6osqo5+FX5HyWT0h2e8tm3L/3wTnbdirSB2eWEY
         YrQ6HRXxmzxxVlOWv480yPiE78wh06iFFNyP2+IEsSO2bMr+EkrEiu5IyxA2wa4oFrsH
         QqydHSOYuQ0/axE/rYZhauFlS2oteEmi/XSNGShd3Ia32leTlPRUj8riMnhhsZMnfi1P
         aJkg==
X-Gm-Message-State: AOAM530c2J6bJmAgyq/ctDS4uxOTdpsTs6IQ1sRdKNmumc5cD5XdSTau
        5C6U70KkjtjtYk9WkmdixFHcMY1mWYX/8A==
X-Google-Smtp-Source: ABdhPJxhQw6CvbapnKN+KSCSMUMCj1zVXyje5bNDOOL6f9md5N4OEogIabgZ9k+FaqQBgVIO/eTMnw==
X-Received: by 2002:a2e:390b:: with SMTP id g11mr4152225lja.239.1608408519680;
        Sat, 19 Dec 2020 12:08:39 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y23sm1528834ljc.119.2020.12.19.12.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 12:08:38 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id l11so14369478lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 12:08:37 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr3561966lfl.41.1608408517290;
 Sat, 19 Dec 2020 12:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box>
In-Reply-To: <20201219124103.w6isern3ywc7xbur@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Dec 2020 12:08:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwf_JUS+0kQas8SWLs3bkpF55xCoWPOACFsdgwonuZ8g@mail.gmail.com>
Message-ID: <CAHk-=wgwf_JUS+0kQas8SWLs3bkpF55xCoWPOACFsdgwonuZ8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Sat, Dec 19, 2020 at 4:41 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Okay, but we only win the NULL check. xas_retry() and xa_is_value() has to
> be repeated in the beginning of the loop.

Yeah.

I wonder if it might make sense to have a "xas_next_entry_rcu()"
function that does something like

    while ((entry = xas_next_entry(&xas, end)) != NULL) {
            if (xas_retry(entry) || xa_is_value(entry))
                    continue;
            return entry;
    }
    return NULL;

but that's a question for Willy, and independent of this patch.

I like the patch, and I'll think about it a bit more, but I might
decide to just apply it to get this thing over with.

Otherwise it should probably go into -mm for more testing.

                Linus

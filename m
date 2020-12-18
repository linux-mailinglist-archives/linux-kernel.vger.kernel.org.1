Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE62DE95D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLRS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLRS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:57:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F508C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:57:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h205so8015207lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTkIwRPG9MysKSy4nLERH4DSVmgkNBJHlqN1//PDmMg=;
        b=dsF5q71ELOhRK7vGOEP6lscSDyihytaDJgLbWaXR+ZI6DYKPA+mGbTu53U5ZoRC/DL
         1+pKhVd1B9xa8VF/IukiJOfVgOnuGio7+tX2NCp8romWhqh1y5rH2y2WQZkVKJAPYmgl
         Lvat0PcrqQdD0PeMMR7ynUxZiG5BSUcGfefI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTkIwRPG9MysKSy4nLERH4DSVmgkNBJHlqN1//PDmMg=;
        b=A8UgK8TSl92XiMFKUFXH1YuNZQWXjK5Kk4+QiXxrADU9CtR3AX82tLGcXw+Z4sfuh+
         k39HsWO6w/rCHHj3znGa9JTDJQdS17aqKDv6GUmUpcIhnshNJ8BM+/qzpxYpO0Z5R5Lj
         hSZuYelx2JEGSF7LL1/zTyjKKO4FL28YhiMGj0MhxFPFdtUUbfx+M8qiKng/tCa1YzAq
         j5CVpT8E6uqXeRwpbighWLwLO5/N8wW42kBeje7cGMeTbmzs3UWHwHFH0cc4je4APGR5
         IN6R/YTAtRErg9V2PbXCcdg7LOUMgauiuGIdduJ+yoHwBcVYCwvQfMBZ6LekSvH85u2+
         qL6g==
X-Gm-Message-State: AOAM532bg1qsr9I6pl2iyRYJV7UtuwFvUcSBwZbr+IUF1GCTQDJ9Z+40
        loFmFwJVlrq5A/VlNC7c1NxSgmLhCb+VMA==
X-Google-Smtp-Source: ABdhPJwRY7y2mKS8fkcTfwciIX1wxR4IYi1T3XEpCA9rsbWJ05dyMJSkMpu8PtQfvFLwzwtfwEqQBQ==
X-Received: by 2002:a19:2d10:: with SMTP id k16mr1884264lfj.161.1608317834320;
        Fri, 18 Dec 2020 10:57:14 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m7sm1011385lfb.146.2020.12.18.10.57.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 10:57:12 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m25so7931459lfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:57:11 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr2332467lji.48.1608317831659;
 Fri, 18 Dec 2020 10:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com> <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
 <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com>
 <20201217105409.2gacwgg7rco2ft3m@box> <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box>
In-Reply-To: <20201218110400.yve45r3zsv7qgfa3@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 10:56:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
Message-ID: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
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

On Fri, Dec 18, 2020 at 3:04 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> This should do. See below.

Looks fine.

> > Then that second loop very naturally becomes a "do { } while ()" one.
>
> I don't see it. I haven't found a reasonable way to rework it do-while.

Now that you return early for the "HEAD == NULL" case, this loop:

        for (; head; head = xas_next_entry(&xas, end_pgoff)) {
                [...]
        }

very naturally becomes

        do {
                [...]
        } while ((head = xas_next_entry(&xas, end_pgoff)) != NULL);

because the initial test for 'head' being NULL is no longer needed,
and thus it's a lot more logical to just test it at the end of the
loop when we update it.

No?

Maybe I'm missing something silly.

           Linus

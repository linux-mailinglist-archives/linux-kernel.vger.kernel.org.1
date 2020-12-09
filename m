Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA92D4C70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgLIVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:05:24 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE9C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 13:04:43 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so5095620lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwSKHrmHmEJGWwO8q35qAr+m2UELcccwDz7jvO6KV+0=;
        b=IGmsBh+7AADorFbyaW+61TYjRjnM3bZ+NPiz+O5Dtl9xXc7x2VzpA6Qi+F5WOMjgq6
         uMLjKW4msweI0isgQir1zt5KsIkczApET555uk/vdNU6Y07CL9TzUCflnfZuK/y+iqje
         yIw7qBjbKEo3ew5HYtrYmvAXUyDO9SGwq8BK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwSKHrmHmEJGWwO8q35qAr+m2UELcccwDz7jvO6KV+0=;
        b=nXKHSG8Aza4nhU0pM8PEUeLeClcFXehuXR37cavWgWyKkq8vls0BNoTiy1QP39uvBD
         RtXOzeT20Q5Xt6nw0LKk2iU3XLEVbMGH1nhIIll7KN0ArgeKIi/ARa2iGWfPEGlVbUdn
         J2x4epcEiQMhInwPGZvlfka09zVSM8K32UD+0gC7zbk0UCM3nTVi1K64Hn2VHkV+V2DR
         Wwv0mXBUoY+9aXsaWsb69rO8TqYpHdxsZHc3GK3Qez6wa1tii43RooVzOU+owSvV1DIV
         nqkbKuFOoedJIG6Zo04//Hlqr9bokue2r4HdBVVRbrH5R7b6p5dV2RGUmwVS/2SJHOOn
         Vkzw==
X-Gm-Message-State: AOAM533oQKkVm5Rei77w/j480LINZKiFAV2mnpgetmXgbc+zBIekatxt
        uxwHN2l6O+mrE7p1fjAeeruVVri1cbFSRA==
X-Google-Smtp-Source: ABdhPJzUYRX9ZuksO2l2iCr6mfgoJOdwrKhohrcuXZFWFq/HnUo7CcQYcrb6joODg0pNdirNNNFoQQ==
X-Received: by 2002:ac2:43c1:: with SMTP id u1mr610299lfl.38.1607547882022;
        Wed, 09 Dec 2020 13:04:42 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id g15sm286097lfd.42.2020.12.09.13.04.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 13:04:39 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id t22so4155668ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 13:04:39 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr1768604ljc.411.1607547879048;
 Wed, 09 Dec 2020 13:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201209203203.GU7338@casper.infradead.org>
In-Reply-To: <20201209203203.GU7338@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 13:04:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCk9frb1Y+pkzh-vXGdvbs5=B=2NanG6yGLY35s99wBg@mail.gmail.com>
Message-ID: <CAHk-=wjCk9frb1Y+pkzh-vXGdvbs5=B=2NanG6yGLY35s99wBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> If a filesystem has put an Uptodate page into the page cache, the
> rest of the kernel can read it without telling the filesystem.

XFS does the same thing for xfs_file_read_iter() too.

Not that I disagree with you - when you mmap a file, once it's mapped
you see the data without any lock anyway. So it's all kinds of
pointless to serialize the page fault, because that's simply not
relevant. The lock will be gone by the time the user actually sees the
data.

But hey, the XFS people have their opinions.

              Linus

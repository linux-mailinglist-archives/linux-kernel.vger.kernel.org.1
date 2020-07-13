Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8ED219DED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGIKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 06:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGIKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:35:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE126C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:35:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so849217lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3U/7ZV9xpswgkJcBW8XUKStVETeILR3YImCVsvlVP7c=;
        b=gQfMi2T6XnBK1vnut1rjEGYSgc76BZNbsuiIfiqKHrRjHdivzSdz8+3sAmzMKXuYrc
         PCafJKU02DcJrANiZ788Fh91wxrsaK832wCZnlfkYIzXpbRkQ/DYKsn8F3CzJvsv7wq9
         8oQHR0Nj/KLma64boKj3jn7ervRG82PnUcJXeqLrmzsG6F5IDi2z1G/mrIDhrBkKeB30
         0NreVpostpd8OjSlU13dHLHxm8foPyGETcf/Jl5UzBC5UPI5eochoXYK2mE4SbNQErb/
         b95p5duIRuCO6t7F0kCo6DbCqEog9mGkO9Mp9eTbE8U8XHH8QuG73UvKgHnjzRyBLh3s
         jf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3U/7ZV9xpswgkJcBW8XUKStVETeILR3YImCVsvlVP7c=;
        b=gPJs/zJhwq/Tz5KVGDjMktszDtvnvqVR8J1U/k8GH0roV4fF+ULFNt2amn/cN2wsyJ
         PosqOTmsdERRbgjq0aaANpRontsLLwqJGRSuoiMArQ5rItIWnjiJkF+n+z0q7WHtTdPj
         FnYPeKtH60urALMiNQeA6pzbKZ8wezw9l+LH8qPArxYKfiAqtOFBvSGiYJt0PneFgM5Q
         tt3hR5yQDcdCBMKW41yck0gcqEI1BaHwXIhLAPhI5u11niwUUJfJsjLSFJpJNB5Kabv+
         9VOMe+jAXKUCx9/0E1mqguKQe740+72mSMHBw5ZK9v3/bqiXncKgqUgpBXFExVz1JGBn
         oodw==
X-Gm-Message-State: AOAM530tR8jAtlkcKhXJ69paO900jhCPTkYzyNUmjvIr/tCGnCeulbUt
        YFeJ71rN/XGZkiLayKSYqiOxNA==
X-Google-Smtp-Source: ABdhPJzgL8KuDBss2CZu23sJQ7h/8TM18HIroVn70bnt+dgvPmaIJNVKHgDZ9ljnBb2diH8RPw1k5Q==
X-Received: by 2002:a05:6512:203b:: with SMTP id s27mr22289235lfs.158.1594290899219;
        Thu, 09 Jul 2020 03:34:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m2sm656023ljc.58.2020.07.09.03.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:34:58 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C350610222B; Thu,  9 Jul 2020 13:34:59 +0300 (+03)
Date:   Thu, 9 Jul 2020 13:34:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200709103459.wenqhbp52vesr7e5@box>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
 <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
 <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:30:27AM +0200, Arnd Bergmann wrote:
> The most interesting version to require in the future would be
> gcc-7, which IIRC is the point at which we can just use -std=gnu99
> or -std=gnu11 instead of -std=gnu89 without running into the
> problem with compound literals[1].

It is gcc-5, not gcc-7. This commit: 

https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d303aeafa9b4

-- 
 Kirill A. Shutemov

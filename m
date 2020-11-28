Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B572C71B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbgK1VvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgK1Saj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:30:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD32C02B8FD
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:28:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so9961991ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGDndFrV+B41FUm0rBqaTWW6GcKei+83JgpSLF04Y7w=;
        b=bUXH/5+0xZCjoD49lFhvhBHOl2Oik0drcHRCVi0eywu8IrMLqHBAH+EL/nF40LJ+SS
         sLw++ze+tS2I8qxrFeyJ8ElqKutyBiSRKI2gu2HfwvI4jtY/s2OOFdZpiXszYg5vWlPK
         PXhA+vcYp0dxmUbrLzCRSF9vPKSzPuCMvp1Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGDndFrV+B41FUm0rBqaTWW6GcKei+83JgpSLF04Y7w=;
        b=m3xfW3yKR1HxAj6Az7M3WrH7zyhFsdNmNdGBDkTWrab/E3Af2d4x4pJxCbnULCz9YK
         ZRotRpGnEfI3tDoDgVuV/y4ex96aI+wf/m/3Uh9sYZZ4gc2CCZcRD6F290GqB79vunNF
         u7ZWUwTFZvCkpv7SdH/LOQZEE+gtlPNhiExnTwZd81bxlVK7aDIQEYcc+EwcL6+BHNT9
         wW0zmxCNEThz3vkmytuTCEizEw2WxptJMJ+A/cthuX6pWjlR8pIg5CtXLkFYSHGjVydt
         VBu3CIE21btU0hBPbV/KTWP7/1rm2MUvWzod8OOySNSgL9DWbZcc50vcZorX6h/gg0h5
         mLNw==
X-Gm-Message-State: AOAM5330qDlfJhQRrw95hYpVOlvhI/g4e/1cueiun+rYQ0hQv8zqVOva
        QpWDpsTwllvfwSJOadqSU09jMfo3ed5cAQ==
X-Google-Smtp-Source: ABdhPJza6mRec+nFcnmOhiMuD+GwgsLJYU/vU/D8Tz7DF2ukRW1NmnVy6H52WTnZy2Va+gUJhs82+Q==
X-Received: by 2002:a2e:9b90:: with SMTP id z16mr6188735lji.433.1606588131004;
        Sat, 28 Nov 2020 10:28:51 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o6sm147826ljc.25.2020.11.28.10.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 10:28:48 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id r24so11967325lfm.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 10:28:48 -0800 (PST)
X-Received: by 2002:ac2:4199:: with SMTP id z25mr5936619lfh.148.1606588128248;
 Sat, 28 Nov 2020 10:28:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
 <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
 <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
 <CAHk-=wjU4DCuwQ4pXshRbwDCUQB31ScaeuDo1tjoZ0_PjhLHzQ@mail.gmail.com> <CAK7LNAQtABssBH2LGThgv-F3_aSrz9Hd-ra9Yyu4-FFzY1nsUw@mail.gmail.com>
In-Reply-To: <CAK7LNAQtABssBH2LGThgv-F3_aSrz9Hd-ra9Yyu4-FFzY1nsUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Nov 2020 10:28:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whK0aQxs6Q5ijJmYF1n2ch8cVFSUzU5yUM_HOjig=+vnw@mail.gmail.com>
Message-ID: <CAHk-=whK0aQxs6Q5ijJmYF1n2ch8cVFSUzU5yUM_HOjig=+vnw@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000af75be05b52ef291"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000af75be05b52ef291
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 27, 2020 at 11:05 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As for the cc1plus cost, I got a similar result.
>
> Running scripts/gcc-plugin.sh directly
> took me 0.5 sec, which is a fourth
> of the allmodconfig run-time.
>
> Actually, I did not know this shell script
> was so expensive to run...

So it turns out that one reason it's so expensive to run is that it
does a *lot* more than it claims to do.

It says "we need a c++ compiler that supports the designated
initializer GNU extension", but then it actually includes a header
file from hell, rather than just test designated initializers.

This patch makes the cc1plus overhead go down a lot. That said, I'm
doubtful we really want gcc plugins at all, considering that the only
real users have all apparently migrated to clang builtin functionality
instead.

        Linus

--000000000000af75be05b52ef291
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ki212utg0>
X-Attachment-Id: f_ki212utg0

IHNjcmlwdHMvZ2NjLXBsdWdpbi5zaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2NjLXBsdWdpbi5zaCBi
L3NjcmlwdHMvZ2NjLXBsdWdpbi5zaAppbmRleCBiNzlmZDBiZWE4MzguLjU5ZGI4N2JmZjQ1NiAx
MDA3NTUKLS0tIGEvc2NyaXB0cy9nY2MtcGx1Z2luLnNoCisrKyBiL3NjcmlwdHMvZ2NjLXBsdWdp
bi5zaApAQCAtOCw4ICs4LDggQEAgc3JjdHJlZT0kKGRpcm5hbWUgIiQwIikKIGdjY3BsdWdpbnNf
ZGlyPSQoJCogLXByaW50LWZpbGUtbmFtZT1wbHVnaW4pCiAKICMgd2UgbmVlZCBhIGMrKyBjb21w
aWxlciB0aGF0IHN1cHBvcnRzIHRoZSBkZXNpZ25hdGVkIGluaXRpYWxpemVyIEdOVSBleHRlbnNp
b24KK3Rlc3QgLWUgIiRnY2NwbHVnaW5zX2Rpci9pbmNsdWRlL3BsdWdpbi12ZXJzaW9uLmgiICYm
CiAkSE9TVENDIC1jIC14IGMrKyAtc3RkPWdudSsrOTggLSAtZnN5bnRheC1vbmx5IC1JICRzcmN0
cmVlL2djYy1wbHVnaW5zIC1JICRnY2NwbHVnaW5zX2Rpci9pbmNsdWRlIDI+L2Rldi9udWxsIDw8
RU9GCi0jaW5jbHVkZSAiZ2NjLWNvbW1vbi5oIgogY2xhc3MgdGVzdCB7CiBwdWJsaWM6CiAJaW50
IHRlc3Q7Cg==
--000000000000af75be05b52ef291--

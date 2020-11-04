Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E02A6CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgKDSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:30:22 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F2C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:30:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 2so24001655ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fKMG6pv6YF1DPpeParNbpC+aNjojYtgbk7dV+Fzj8w=;
        b=ChEkzV7gse5pgsr+RZcpcU5fG0SW7Yr+3Lbq8JpI/aWGfHyh8r1ThH/4GIMPDiwpo3
         D2xOFAUbG655/QTLOHuqVgZHLsL10CT1BniKTpbbNtMtqBnl3nPo+KqxRe+0EJsyfXXW
         yK1L6B2rbPzAJluw0fo9uxI3OWu0hygfsuIew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fKMG6pv6YF1DPpeParNbpC+aNjojYtgbk7dV+Fzj8w=;
        b=qvOIaoosN9ik8qeJazgnM+DYI5qSKAfEvs3KInwFyWZ0MTaIXFpNWJKRGKb696peXZ
         LfPnBloBS0y9whh0Q/6EcJij9Nqt48STvYhcUI1lJu6UMWGrc84BlV6iIF9SPMa0R8hK
         8XT0GYeDsTtAeyt6RwujloTCaRs/mCxX0Hy0f+L/zmP9+mGIk4YiV5Q9rRbQ3/NlvNZK
         p16TrVKHkXFsuSCSFVjlSCay98OER4zMtyPVahOGmx6tzgeMFT6WHWyKifLtEDKof1a+
         Pol+xfJHDwcPTblROehfVnzXMCdLyhFlxDNjGQvf1Zyn2YD7a03V5D0xVOhozR0hYGV1
         9MsA==
X-Gm-Message-State: AOAM531HfuRdyNwwgSYgLFRHnwtqLTn+VwqtwE/Ln8el5sXHsphprNr8
        8TKCOJ8rhD2uwmylhKl4NW4yDGHnnCkaFg==
X-Google-Smtp-Source: ABdhPJz27JNJXEd7gmTDKWs7H4zgs9YG6mGKv+1DSKBlh2pBT1DAzhDf5vglMltSjZBdBW180DJ4nA==
X-Received: by 2002:a2e:89cb:: with SMTP id c11mr10703825ljk.248.1604514618694;
        Wed, 04 Nov 2020 10:30:18 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y125sm474246lfa.208.2020.11.04.10.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:30:16 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id o13so15724392ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:30:16 -0800 (PST)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr10293805lji.70.1604514616029;
 Wed, 04 Nov 2020 10:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20201102091428.GK31092@shao2-debian>
In-Reply-To: <20201102091428.GK31092@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Nov 2020 10:29:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
Message-ID: <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
Subject: Re: [mm/gup] a308c71bf1: stress-ng.vm-splice.ops_per_sec -95.6% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: multipart/mixed; boundary="000000000000bac91505b34c2b78"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bac91505b34c2b78
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 2, 2020 at 1:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -95.6% regression of stress-ng.vm-splice.ops_per_sec due to commit:
>
> commit: a308c71bf1e6e19cc2e4ced31853ee0fc7cb439a ("mm/gup: Remove enfornced COW mechanism")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Note that this is just the reverse of the previous 2000% improvement
reported by the test robot here:

    https://lore.kernel.org/lkml/20200611040453.GK12456@shao2-debian/

and the explanation seems to remain the same:

    https://lore.kernel.org/lkml/CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com/

IOW, this is testing a special case (zero page lookup) that the "force
COW" patches happened to turn into a regular case (COW creating a
regular page from the zero page).

The question is whether we should care about the zero page for gup_fast lookup.

If we do care, then the proper fix is likely simply to allow the zero
page in fast-gup, the same way we already do in slow-gup.

ENTIRELY UNTESTED PATCH ATTACHED.

Rong - mind testing this? I don't think the zero-page _should_ be
something that real loads care about, but hey, maybe people do want to
do things like splice zeroes very efficiently..

And note the "untested" part of the patch. It _looks_ fairly obvious,
but maybe I'm missing something.

            Linus

--000000000000bac91505b34c2b78
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kh3qhmzd0>
X-Attachment-Id: f_kh3qhmzd0

IG1tL2d1cC5jIHwgNyArKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMKaW5kZXggMTAy
ODc3ZWQ3N2E0Li44OTY2ZDNjODllNWQgMTAwNjQ0Ci0tLSBhL21tL2d1cC5jCisrKyBiL21tL2d1
cC5jCkBAIC0yMTgyLDggKzIxODIsMTEgQEAgc3RhdGljIGludCBndXBfcHRlX3JhbmdlKHBtZF90
IHBtZCwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKIAkJCQl1bmRvX2Rl
dl9wYWdlbWFwKG5yLCBucl9zdGFydCwgZmxhZ3MsIHBhZ2VzKTsKIAkJCQlnb3RvIHB0ZV91bm1h
cDsKIAkJCX0KLQkJfSBlbHNlIGlmIChwdGVfc3BlY2lhbChwdGUpKQotCQkJZ290byBwdGVfdW5t
YXA7CisJCX0gZWxzZSBpZiAocHRlX3NwZWNpYWwocHRlKSkgeworCQkJaWYgKCFpc196ZXJvX3Bm
bihwdGVfcGZuKHB0ZSkpKQorCQkJCWdvdG8gcHRlX3VubWFwOworCQkJLyogV2UnbGwgYWxsb3cg
dGhlIHplcm8gcGFnZSAtIGxpa2UgZm9sbG93X3BhZ2VfcHRlKCkgZG9lcyAqLworCQl9CiAKIAkJ
Vk1fQlVHX09OKCFwZm5fdmFsaWQocHRlX3BmbihwdGUpKSk7CiAJCXBhZ2UgPSBwdGVfcGFnZShw
dGUpOwo=
--000000000000bac91505b34c2b78--

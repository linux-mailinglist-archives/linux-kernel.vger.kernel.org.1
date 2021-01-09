Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5462EFCF6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbhAICFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAICFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:05:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0923DC061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 18:04:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so27481642lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X0k10gEU5RU+YALYiXkZo4igtQpWwlajig6tj8kuiQ=;
        b=fZb6v61atyzfrrDYtqgFHKlNTWj+llarfBgW2li3VAHFiI9v2whnfzp2rPIc5ME6Yc
         Il4xP9F756ShlIumSNYfUGhyiNgKXRDeenhBPiEROH7todZP8SZEJwYoIcuCW/Bi8yq0
         JCY1lGtZvB1umvqAU5nCSrnSEPKAUUN+TXGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X0k10gEU5RU+YALYiXkZo4igtQpWwlajig6tj8kuiQ=;
        b=QqyETM04rubwl6Su3hOoSlUFdhurTPYP0LUT9zXodazQFzTsqHozYGqb2A7HPCyXfG
         7pVSdRkBdMdSKJDU3Qcx8csF33Fbx6/fzNizbjsdOHPSnF4xkxMZKzh9ZVOSr0mr4sJs
         TSWfV4PLTq3UO72X2VWEscgIYR0F3ZNtOaHYUK9anlhnJjlv3w/ODRO1bC87CRmHUy8a
         dpBmiONRzSd7gkBLtXDteX+AdrThG8I2dBqxeMeRFyrfXxSX90C1CYAY/oJN1SL5dvxa
         d4qdSbPn/tBy/JjE+LijbrbApOzUjc0GP1n83AmFbv9WoYdkqI/M9ZCeTgo/IpaT0JMt
         1Wcg==
X-Gm-Message-State: AOAM5304ye6su/pJW5aTd1DgxlJoLbgCYOL6pO1Gi/vTBLs9jc6iI8lu
        LaTTdl96pj8bXYe7I0HNvDg4TnPp1ZTS9w==
X-Google-Smtp-Source: ABdhPJyqqiRAa1Ek5soS0rWZ/zdZP60usLhk4Cp3+NAyNCKH5iBgDfU/RIBZM5rstuK3Dyj0ZIgo0g==
X-Received: by 2002:a2e:3314:: with SMTP id d20mr2803667ljc.21.1610157879210;
        Fri, 08 Jan 2021 18:04:39 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l28sm1439927lfk.25.2021.01.08.18.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 18:04:37 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id o10so16548248lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:04:37 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr2429298lfi.377.1610157877097;
 Fri, 08 Jan 2021 18:04:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
 <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
 <alpine.LSU.2.11.2101041839440.3466@eggly.anvils> <CAHk-=wi36CBggdRfdggACvf2hG+djM9kKnorrwsByN6uDvPExA@mail.gmail.com>
 <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
In-Reply-To: <CAHk-=wh=5kDGukMs2sVZ8uHZJX4VL13oD5+xMAR4HvuY6QckLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 18:04:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgD9GK5CeHopYmRHoYS9cNuCmDMsc=+MbM_KgJ0KB+=ng@mail.gmail.com>
Message-ID: <CAHk-=wgD9GK5CeHopYmRHoYS9cNuCmDMsc=+MbM_KgJ0KB+=ng@mail.gmail.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="0000000000004c20ba05b86e1822"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004c20ba05b86e1822
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 5, 2021 at 11:53 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I took your "way to go" statement as an ack, and made it all be commit
> c2407cf7d22d ("mm: make wait_on_page_writeback() wait for multiple
> pending writebacks").

Oh, and Michael Larabel (of phoronix) reports that that one-liner does
something bad to a few PostgreSQL tests, on the order of 5-10%
regression on some machines (but apparently not others).

I suspect that's a sign of instability in the benchmark numbers, but
it probably also means that we have some silly condition where
multiple threads want to clean the same page.

I sent him a patch to try if it ends up being better to just not wake
things up early at all (instead of the "if" -> "while") conversion.
That trivial patch appended here in case anybody has comments.

Just the fact that that one-liner made a performance impact makes me
go "hmm", though. Michael didn't see the BUG_ON(), so it's presumably
some _other_ user of wait_on_page_writeback() than the
write_cache_pages() one that causes issues.

Anybody got any suspicions? Honestly, when working on the page wait
queues, I was working under the assumption that it's really just the
page lock that truly matters.

I'm thinking things like __filemap_fdatawait_range(), which doesn't
hold the page lock at all, so it's all kinds of non-serialized, and
could now be waiting for any number of IO's ro complete..

Oh well. This email doesn't really have a point, it's more of a
heads-up that that "wait to see one or multiple writebacks" thing
seems to matter more than I would have expected for some loads..

            Linus

--0000000000004c20ba05b86e1822
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kjp1dr5k0>
X-Attachment-Id: f_kjp1dr5k0

IG1tL2ZpbGVtYXAuYyAgICAgICAgfCA2ICsrKystLQogbW0vcGFnZS13cml0ZWJhY2suYyB8IDIg
Ky0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRleCA1YzlkNTY0MzE3YTUu
LjAzMWQxOWQwZjRiMiAxMDA2NDQKLS0tIGEvbW0vZmlsZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAu
YwpAQCAtMTA1MiwxNCArMTA1MiwxNiBAQCBzdGF0aWMgaW50IHdha2VfcGFnZV9mdW5jdGlvbih3
YWl0X3F1ZXVlX2VudHJ5X3QgKndhaXQsIHVuc2lnbmVkIG1vZGUsIGludCBzeW5jLAogCWlmICgh
d2FrZV9wYWdlX21hdGNoKHdhaXRfcGFnZSwga2V5KSkKIAkJcmV0dXJuIDA7CiAKKwkvKiBTdG9w
IHdhbGtpbmcgaWYgdGhlIGJpdCB3YXMgYWxyZWFkeSB0YWtlbiAqLworCWlmICh0ZXN0X2JpdChr
ZXktPmJpdF9uciwgJmtleS0+cGFnZS0+ZmxhZ3MpKQorCQlyZXR1cm4gLTE7CisKIAkvKgogCSAq
IElmIGl0J3MgYSBsb2NrIGhhbmRvZmYgd2FpdCwgd2UgZ2V0IHRoZSBiaXQgZm9yIGl0LCBhbmQK
IAkgKiBzdG9wIHdhbGtpbmcgKGFuZCBkbyBub3Qgd2FrZSBpdCB1cCkgaWYgd2UgY2FuJ3QuCiAJ
ICovCiAJZmxhZ3MgPSB3YWl0LT5mbGFnczsKIAlpZiAoZmxhZ3MgJiBXUV9GTEFHX0VYQ0xVU0lW
RSkgewotCQlpZiAodGVzdF9iaXQoa2V5LT5iaXRfbnIsICZrZXktPnBhZ2UtPmZsYWdzKSkKLQkJ
CXJldHVybiAtMTsKIAkJaWYgKGZsYWdzICYgV1FfRkxBR19DVVNUT00pIHsKIAkJCWlmICh0ZXN0
X2FuZF9zZXRfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5mbGFncykpCiAJCQkJcmV0dXJu
IC0xOwpkaWZmIC0tZ2l0IGEvbW0vcGFnZS13cml0ZWJhY2suYyBiL21tL3BhZ2Utd3JpdGViYWNr
LmMKaW5kZXggZWIzNGQyMDRkNGVlLi41ODYwNDI0NzJhYzkgMTAwNjQ0Ci0tLSBhL21tL3BhZ2Ut
d3JpdGViYWNrLmMKKysrIGIvbW0vcGFnZS13cml0ZWJhY2suYwpAQCAtMjgyNiw3ICsyODI2LDcg
QEAgRVhQT1JUX1NZTUJPTChfX3Rlc3Rfc2V0X3BhZ2Vfd3JpdGViYWNrKTsKICAqLwogdm9pZCB3
YWl0X29uX3BhZ2Vfd3JpdGViYWNrKHN0cnVjdCBwYWdlICpwYWdlKQogewotCXdoaWxlIChQYWdl
V3JpdGViYWNrKHBhZ2UpKSB7CisJaWYgKFBhZ2VXcml0ZWJhY2socGFnZSkpIHsKIAkJdHJhY2Vf
d2FpdF9vbl9wYWdlX3dyaXRlYmFjayhwYWdlLCBwYWdlX21hcHBpbmcocGFnZSkpOwogCQl3YWl0
X29uX3BhZ2VfYml0KHBhZ2UsIFBHX3dyaXRlYmFjayk7CiAJfQo=
--0000000000004c20ba05b86e1822--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA492E6A10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgL1Ssj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgL1Ssi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:48:38 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A4C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:47:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so25828587lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul9Q7F+zVW3PAg2S28tHJ0IR0KNP8kk2DEXpGYeIlWk=;
        b=KMz20JUoK22L486IVp7caAQRxpZ8S38J8Jj8SYjxbV/2agAn1XdkiISquPYQRJW1NZ
         BzhkpKZWGzoh12IDv+006ZR9bm3NnfFzCFwKPl2CY7Fp4pA9o8KEXdrfYpWns0a6uB5G
         3IE7VhWsbuQlLRJgfgKehWJwyFvcqT3jWXckU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul9Q7F+zVW3PAg2S28tHJ0IR0KNP8kk2DEXpGYeIlWk=;
        b=JC+ES7ZdYH+7xQ221ejRfmASA99mC4meh6wU4xHAMxZ0gcRw7AoRKjTylZO1fBogAb
         v4fzRn9iZhmZhviahPxgCV5vUbJJ7K9hFEXPQISlBw2+e9HtThdCpXAXbRbZrRuInHC2
         Gt4j6tu+KOG1/KHb7o8+sT1/unmrMSwtotKZD3FH0nW6xBGOQdjm9BwfGY7Mri0OqpxU
         GrVaOZo34fU73UkSh5eqdmbpknFz5lEa31R1/hO8Mtg7Q84LuRIn+VHhQtsNKueZX9EW
         VgJQQuMKYKBNDa7Cy3wxIDdt5HXb/Q4GjhYjOLjyv4jcDQG4SkN7jsvtTf3BBHAkW5kq
         k/Ow==
X-Gm-Message-State: AOAM532khV7slUA/iPQFwC2XzsaYJMJNNjbsqeWcwQu4G5223bvjI/ME
        h8nkn0ezsJzMlWwq1biUo4QzPOJO7LmC7A==
X-Google-Smtp-Source: ABdhPJyZ63HMe9z62x0RFSUtIJlJFdIBiaYbW7kwVeqLKjkhbYAp8HzfR6O2B+Rtwi1l7sCWWjkJJQ==
X-Received: by 2002:a19:4148:: with SMTP id o69mr18203076lfa.610.1609181276136;
        Mon, 28 Dec 2020 10:47:56 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c7sm5410475lfm.262.2020.12.28.10.47.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 10:47:54 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id x20so25819622lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:47:53 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr23613429ljj.220.1609181273408;
 Mon, 28 Dec 2020 10:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box> <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils> <20201228125352.phnj2x2ci3kwfld5@box>
In-Reply-To: <20201228125352.phnj2x2ci3kwfld5@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 10:47:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
Message-ID: <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
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
Content-Type: multipart/mixed; boundary="0000000000002e6e5605b78ab6d7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002e6e5605b78ab6d7
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 28, 2020 at 4:53 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> So far I only found one more pin leak and always-true check. I don't see
> how can it lead to crash or corruption. Keep looking.

Well, I noticed that the nommu.c version of filemap_map_pages() needs
fixing, but that's obviously not the case Hugh sees.

No,m I think the problem is the

        pte_unmap_unlock(vmf->pte, vmf->ptl);

at the end of filemap_map_pages().

Why?

Because we've been updating vmf->pte as we go along:

                vmf->pte += xas.xa_index - last_pgoff;

and I think that by the time we get to that "pte_unmap_unlock()",
vmf->pte potentially points to past the edge of the page directory.

I think that is the bug that Hugh sees - simply because we get
entirely confused about the page table locking. And it would match the
latest change, which was all about moving that unlock from the caller
to filemap_map_pages(), and now it's missing the pte fixup..

I personally think it's wrong to update vmf->pte at all. We should
just have a local 'ptep' pointer that we update as we walk along. But
that requires another change to the calling convention, namely to
"do_set_pte()".

Also, considering how complicated this patch is getting, I think it
might be good to try to split it up a bit.

In particular, I think the calling convention change for
"filemap_map_pages()" could be done first and independently. And then
as a second step, move the VM_FAULT_NOPAGE and "pte_unmap_lock()" from
the callers to filemap_map_pages().

And then only as the final step, do that nice re-organization with
first_map_page/next_map_page() and moving the locking from
alloc_set_pte() into filemap_map_pages()..

How does that sound?

Anyway, Hugh, if it's about overshooting the pte pointer, maybe this
absolutely horrendous and disgusting patch fixes it without the above
kinds of more extensive cleanups. Worth testing, perhaps, even if it's
too ugly for words?

               Linus

--0000000000002e6e5605b78ab6d7
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kj8wyykk0>
X-Attachment-Id: f_kj8wyykk0

IG1tL2ZpbGVtYXAuYyB8IDE0ICsrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRl
eCA0MmQ3YTU4ZTNhMTQuLjc0Mzg0ZjlmMTc3NiAxMDA2NDQKLS0tIGEvbW0vZmlsZW1hcC5jCisr
KyBiL21tL2ZpbGVtYXAuYwpAQCAtMzAyMiw2ICszMDIyLDggQEAgdm1fZmF1bHRfdCBmaWxlbWFw
X21hcF9wYWdlcyhzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLAog
CXN0cnVjdCBwYWdlICpoZWFkLCAqcGFnZTsKIAl1bnNpZ25lZCBpbnQgbW1hcF9taXNzID0gUkVB
RF9PTkNFKGZpbGUtPmZfcmEubW1hcF9taXNzKTsKIAl2bV9mYXVsdF90IHJldCA9IDA7CisJcHRl
X3QgKm9yaWdfcHRlOworCXVuc2lnbmVkIGxvbmcgb3JpZ19hZGRyZXNzOwogCiAJcmN1X3JlYWRf
bG9jaygpOwogCWhlYWQgPSBmaXJzdF9tYXBfcGFnZSh2bWYsICZ4YXMsIGVuZF9wZ29mZik7CkBA
IC0zMDM3LDYgKzMwMzksMTQgQEAgdm1fZmF1bHRfdCBmaWxlbWFwX21hcF9wYWdlcyhzdHJ1Y3Qg
dm1fZmF1bHQgKnZtZiwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLAogCiAJdm1mLT5wdGUgPSBwdGVf
b2Zmc2V0X21hcF9sb2NrKHZtYS0+dm1fbW0sIHZtZi0+cG1kLAogCQkJCSAgICAgICB2bWYtPmFk
ZHJlc3MsICZ2bWYtPnB0bCk7CisKKwkvKgorCSAqIERpc2d1c3RpbmcgLSB3ZSBzaG91bGQgbm90
IHVwZGF0ZSB2bWYtPnB0ZSBhbmQgLT5hZGRyZXNzLAorCSAqIGJ1dCBkb19zZXRfcHRlKCkgbmVl
ZHMgaXQKKwkgKi8KKwlvcmlnX3B0ZSA9IHZtZi0+cHRlOworCW9yaWdfYWRkcmVzcyA9IHZtZi0+
YWRkcmVzczsKKwogCWRvIHsKIAkJcGFnZSA9IGZpbmRfc3VicGFnZShoZWFkLCB4YXMueGFfaW5k
ZXgpOwogCQlpZiAoUGFnZUhXUG9pc29uKHBhZ2UpKQpAQCAtMzA2Niw2ICszMDc2LDEwIEBAIHZt
X2ZhdWx0X3QgZmlsZW1hcF9tYXBfcGFnZXMoc3RydWN0IHZtX2ZhdWx0ICp2bWYsIHVuc2lnbmVk
IGxvbmcgYWRkcmVzcywKIAkJdW5sb2NrX3BhZ2UoaGVhZCk7CiAJCXB1dF9wYWdlKGhlYWQpOwog
CX0gd2hpbGUgKChoZWFkID0gbmV4dF9tYXBfcGFnZSh2bWYsICZ4YXMsIGVuZF9wZ29mZikpICE9
IE5VTEwpOworCisJLyogSGFja2V0eSBoYWNrIC0gcmVzZXQgdGhlIHZtZiBzdGF0ZSBiYWNrICov
CisJdm1mLT5wdGUgPSBvcmlnX3B0ZTsKKwl2bWYtPmFkZHJlc3MgPSBvcmlnX2FkZHJlc3M7CiAJ
cHRlX3VubWFwX3VubG9jayh2bWYtPnB0ZSwgdm1mLT5wdGwpOwogCXJjdV9yZWFkX3VubG9jaygp
OwogCVdSSVRFX09OQ0UoZmlsZS0+Zl9yYS5tbWFwX21pc3MsIG1tYXBfbWlzcyk7Cg==
--0000000000002e6e5605b78ab6d7--

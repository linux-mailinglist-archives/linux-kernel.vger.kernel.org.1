Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4B275E85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIWRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgIWRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:22:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05585C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:22:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so716148ejf.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lk74hRwBOjXHi2fDp7TcFPuA3uKeiSvp+FT3AfpwVzQ=;
        b=bvyqVhNUE2X8gzUG+6FM/3oxDUOxRrzvU8MuQ6kjYex/v1VvTGCzA8kYXcdpKiCRbo
         w8Cp+VjdMQ96dBtToeQdiBbFwgOVwFFn1suwEyWBk41Rpwo37BUD8hue0jP72VBGscC+
         CXtiUAS0QDu23/lULwa5VxXDSIewalROgE3sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lk74hRwBOjXHi2fDp7TcFPuA3uKeiSvp+FT3AfpwVzQ=;
        b=eZDxsJlkhsfIjzVzOLDsetop5NYrxjqkInTcejuzBnFiENKPTMCRwIM+Ze3MNL648S
         SslWK5/V60jBFcBxeHFdAp3pQ0+lBFkrq4Rf5ye2KsNoLfWzB9lF5BkbY21i6oVbC5Wr
         FWMM0Div/rz6lvDLEhxX0qzddKFtQArZ6JYuPAcyvQu+30YbxQYUijTSDt1+aJ+/cnfZ
         FSJ2ifqhcB5j2lI+9lJdsySS9juCtrGmKB/dSxoEteQIBkvesCwQk+JVU+KqX8J3A46x
         c/19uVs+xCLCbiQ3jXrDFfl93TbiOHGImHlBpthYpPxzyKnPx4UeXvNbnPUHfAG4mara
         dKew==
X-Gm-Message-State: AOAM530I4/H+te5Sa4ygBOPGa1OzBxzoI6lcHmRKqNUTnjqYeWNTvgiy
        RNlCTBzXlmfw90YrmrHJSkBkUDScp9FGNA==
X-Google-Smtp-Source: ABdhPJwnSPow4VN+H2BxUrE1fxJmtkaQhgdmGhQwaCZoGmsg51V0DTj9Tma89XYSprCPc8SvBC/TEQ==
X-Received: by 2002:a17:906:4c4c:: with SMTP id d12mr634371ejw.491.1600881766215;
        Wed, 23 Sep 2020 10:22:46 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id b25sm466485ejc.75.2020.09.23.10.22.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 10:22:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id b12so536512edz.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:22:45 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr292377lfg.603.1600881423494;
 Wed, 23 Sep 2020 10:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921211744.24758-4-peterx@redhat.com>
In-Reply-To: <20200921211744.24758-4-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Sep 2020 10:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3G+OqehMdybQ++ikPMgd9BcydKJqkd6gRNuVz9TJG+w@mail.gmail.com>
Message-ID: <CAHk-=wh3G+OqehMdybQ++ikPMgd9BcydKJqkd6gRNuVz9TJG+w@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: multipart/mixed; boundary="000000000000938f2505affe4062"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000938f2505affe4062
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 21, 2020 at 2:18 PM Peter Xu <peterx@redhat.com> wrote:
>
> There's one special path for copy_one_pte() with swap entries, in which
> add_swap_count_continuation(GFP_ATOMIC) might fail.  In that case we'll return
> the swp_entry_t so that the caller will release the locks and redo the same
> thing with GFP_KERNEL.
>
> It's confusing when copy_one_pte() must return a swp_entry_t (even if all the
> ptes are non-swap entries).  More importantly, we face other requirement to
> extend this "we need to do something else, but without the locks held" case.
>
> Rework the return value into something easier to understand, as defined in enum
> copy_mm_ret.  We'll pass the swp_entry_t back using the newly introduced union
> copy_mm_data parameter.

Ok, I'm reading this series, and I do hate this.

And I think it's unnecessary.

There's a very simple way to avoid this all: split out the
"!pte_present(pte)" case from the function entirely.

That actually makes the code much more legible: that non-present case
is very different, and it's also unlikely() and causes deeper
indentation etc.

Because it's unlikely, it probably also shouldn't be inline.

That unlikely case is also why when then have that special
"out_set_pte" label, which should just go away and be copied into the
(now uninlined) function.

Once that re-organization has been done, the second step is to then
just move the "pte_present()" check into the caller, and suddenly all
the ugly return value games will go entirely away.

I'm attaching the two patches that do this here, but I do want to note
how that first patch is much more legible with "--ignore-all-space",
and then you really see that the diff is a _pure_ code movement thing.
Otherwise it looks like it's doing a big change.

Comments?

NOTE! The intent here is that now we can easily add new argument (a
pre-allocated page or NULL) and a return value to
"copy_present_page()": it can return "I needed a temporary page but
you hadn't allocated one yet" or "I used up the temporary page you
gave me" or "all good, keep the temporary page around for the future".

But these two patches are very intentionally meant to be just "this
clearly changes NO semantics at all".

                   Linus

--000000000000938f2505affe4062
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-split-out-the-non-present-case-from-copy_one_pte.patch"
Content-Disposition: attachment; 
	filename="0001-mm-split-out-the-non-present-case-from-copy_one_pte.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kffng9fx0>
X-Attachment-Id: f_kffng9fx0

RnJvbSBkZjNhNTdkMWY2MDcyZDA3OTc4YmFmYTdkYmQ5OTA0Y2RmOGYzZTEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFdlZCwgMjMgU2VwIDIwMjAgMDk6NTY6NTkgLTA3MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gbW06IHNwbGl0IG91dCB0aGUgbm9uLXByZXNlbnQgY2FzZSBmcm9tIGNvcHlf
b25lX3B0ZSgpCgpUaGlzIGlzIGEgcHVyZWx5IG1lY2hhbmljYWwgc3BsaXQgb2YgdGhlIGNvcHlf
b25lX3B0ZSgpIGZ1bmN0aW9uLiAgSXQncwpub3QgaW1tZWRpYXRlbHkgb2J2aW91cyB3aGVuIGxv
b2tpbmcgYXQgdGhlIGRpZmYgYmVjYXVzZSBvZiB0aGUKaW5kZW50YXRpb24gY2hhbmdlLCBidXQg
dGhlIHdheSB0byBzZWUgd2hhdCBpcyBnb2luZyBvbiBpbiB0aGlzIGNvbW1pdAppcyB0byB1c2Ug
dGhlICItdyIgZmxhZyB0byBub3Qgc2hvdyBwdXJlIHdoaXRlc3BhY2UgY2hhbmdlcywgYW5kIHlv
dSBzZWUKaG93IHRoZSBmaXJzdCBwYXJ0IG9mIGNvcHlfb25lX3B0ZSgpIGlzIHNpbXBseSBsaWZ0
ZWQgb3V0IGludG8gYQpzZXBhcmF0ZSBmdW5jdGlvbi4KCkFuZCBzaW5jZSB0aGUgbm9uLXByZXNl
bnQgY2FzZSBpcyBtYXJrZWQgdW5saWtlbHksIGRvbid0IG1ha2UgdGhlIG5ldwpmdW5jdGlvbiBi
ZSBpbmxpbmVkLiAgTm90IHRoYXQgZ2NjIHJlYWxseSBzZWVtcyB0byBjYXJlLCBzaW5jZSBpdCBs
b29rcwpsaWtlIGl0IHdpbGwgaW5saW5lIGl0IGFueXdheSBkdWUgdG8gdGhlIHdob2xlICJzaW5n
bGUgY2FsbHNpdGUgZm9yCnN0YXRpYyBmdW5jdGlvbiIgbG9naWMuICBJbiBmYWN0LCBjb2RlIGdl
bmVyYXRpb24gd2l0aCB0aGUgZnVuY3Rpb24Kc3BsaXQgaXMgYWxtb3N0IGlkZW50aWNhbCB0byBi
ZWZvcmUuICBCdXQgbm90IG1hcmtpbmcgaXQgaW5saW5lIGlzIHRoZQpyaWdodCB0aGluZyB0byBk
by4KClRoaXMgaXMgcHVyZSBwcmVwLXdvcmsgYW5kIGNsZWFudXAgZm9yIHN1YnNlcXVlbnQgY2hh
bmdlcy4KClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4KLS0tCiBtbS9tZW1vcnkuYyB8IDE1MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgODIgaW5zZXJ0
aW9ucygrKSwgNzAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9t
ZW1vcnkuYwppbmRleCA0NjlhZjM3M2FlNzYuLjMxYTNhYjdkOWFhMyAxMDA2NDQKLS0tIGEvbW0v
bWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTY5NSw2ICs2OTUsODQgQEAgc3RydWN0IHBh
Z2UgKnZtX25vcm1hbF9wYWdlX3BtZChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWdu
ZWQgbG9uZyBhZGRyLAogICogY292ZXJlZCBieSB0aGlzIHZtYS4KICAqLwogCitzdGF0aWMgdW5z
aWduZWQgbG9uZworY29weV9ub25wcmVzZW50X3B0ZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0s
IHN0cnVjdCBtbV9zdHJ1Y3QgKnNyY19tbSwKKwkJcHRlX3QgKmRzdF9wdGUsIHB0ZV90ICpzcmNf
cHRlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKKwkJdW5zaWduZWQgbG9uZyBhZGRyLCBp
bnQgKnJzcykKK3sKKwl1bnNpZ25lZCBsb25nIHZtX2ZsYWdzID0gdm1hLT52bV9mbGFnczsKKwlw
dGVfdCBwdGUgPSAqc3JjX3B0ZTsKKwlzdHJ1Y3QgcGFnZSAqcGFnZTsKKwlzd3BfZW50cnlfdCBl
bnRyeSA9IHB0ZV90b19zd3BfZW50cnkocHRlKTsKKworCWlmIChsaWtlbHkoIW5vbl9zd2FwX2Vu
dHJ5KGVudHJ5KSkpIHsKKwkJaWYgKHN3YXBfZHVwbGljYXRlKGVudHJ5KSA8IDApCisJCQlyZXR1
cm4gZW50cnkudmFsOworCisJCS8qIG1ha2Ugc3VyZSBkc3RfbW0gaXMgb24gc3dhcG9mZidzIG1t
bGlzdC4gKi8KKwkJaWYgKHVubGlrZWx5KGxpc3RfZW1wdHkoJmRzdF9tbS0+bW1saXN0KSkpIHsK
KwkJCXNwaW5fbG9jaygmbW1saXN0X2xvY2spOworCQkJaWYgKGxpc3RfZW1wdHkoJmRzdF9tbS0+
bW1saXN0KSkKKwkJCQlsaXN0X2FkZCgmZHN0X21tLT5tbWxpc3QsCisJCQkJCQkmc3JjX21tLT5t
bWxpc3QpOworCQkJc3Bpbl91bmxvY2soJm1tbGlzdF9sb2NrKTsKKwkJfQorCQlyc3NbTU1fU1dB
UEVOVFNdKys7CisJfSBlbHNlIGlmIChpc19taWdyYXRpb25fZW50cnkoZW50cnkpKSB7CisJCXBh
Z2UgPSBtaWdyYXRpb25fZW50cnlfdG9fcGFnZShlbnRyeSk7CisKKwkJcnNzW21tX2NvdW50ZXIo
cGFnZSldKys7CisKKwkJaWYgKGlzX3dyaXRlX21pZ3JhdGlvbl9lbnRyeShlbnRyeSkgJiYKKwkJ
CQlpc19jb3dfbWFwcGluZyh2bV9mbGFncykpIHsKKwkJCS8qCisJCQkgKiBDT1cgbWFwcGluZ3Mg
cmVxdWlyZSBwYWdlcyBpbiBib3RoCisJCQkgKiBwYXJlbnQgYW5kIGNoaWxkIHRvIGJlIHNldCB0
byByZWFkLgorCQkJICovCisJCQltYWtlX21pZ3JhdGlvbl9lbnRyeV9yZWFkKCZlbnRyeSk7CisJ
CQlwdGUgPSBzd3BfZW50cnlfdG9fcHRlKGVudHJ5KTsKKwkJCWlmIChwdGVfc3dwX3NvZnRfZGly
dHkoKnNyY19wdGUpKQorCQkJCXB0ZSA9IHB0ZV9zd3BfbWtzb2Z0X2RpcnR5KHB0ZSk7CisJCQlp
ZiAocHRlX3N3cF91ZmZkX3dwKCpzcmNfcHRlKSkKKwkJCQlwdGUgPSBwdGVfc3dwX21rdWZmZF93
cChwdGUpOworCQkJc2V0X3B0ZV9hdChzcmNfbW0sIGFkZHIsIHNyY19wdGUsIHB0ZSk7CisJCX0K
Kwl9IGVsc2UgaWYgKGlzX2RldmljZV9wcml2YXRlX2VudHJ5KGVudHJ5KSkgeworCQlwYWdlID0g
ZGV2aWNlX3ByaXZhdGVfZW50cnlfdG9fcGFnZShlbnRyeSk7CisKKwkJLyoKKwkJICogVXBkYXRl
IHJzcyBjb3VudCBldmVuIGZvciB1bmFkZHJlc3NhYmxlIHBhZ2VzLCBhcworCQkgKiB0aGV5IHNo
b3VsZCB0cmVhdGVkIGp1c3QgbGlrZSBub3JtYWwgcGFnZXMgaW4gdGhpcworCQkgKiByZXNwZWN0
LgorCQkgKgorCQkgKiBXZSB3aWxsIGxpa2VseSB3YW50IHRvIGhhdmUgc29tZSBuZXcgcnNzIGNv
dW50ZXJzCisJCSAqIGZvciB1bmFkZHJlc3NhYmxlIHBhZ2VzLCBhdCBzb21lIHBvaW50LiBCdXQg
Zm9yIG5vdworCQkgKiBrZWVwIHRoaW5ncyBhcyB0aGV5IGFyZS4KKwkJICovCisJCWdldF9wYWdl
KHBhZ2UpOworCQlyc3NbbW1fY291bnRlcihwYWdlKV0rKzsKKwkJcGFnZV9kdXBfcm1hcChwYWdl
LCBmYWxzZSk7CisKKwkJLyoKKwkJICogV2UgZG8gbm90IHByZXNlcnZlIHNvZnQtZGlydHkgaW5m
b3JtYXRpb24sIGJlY2F1c2Ugc28KKwkJICogZmFyLCBjaGVja3BvaW50L3Jlc3RvcmUgaXMgdGhl
IG9ubHkgZmVhdHVyZSB0aGF0CisJCSAqIHJlcXVpcmVzIHRoYXQuIEFuZCBjaGVja3BvaW50L3Jl
c3RvcmUgZG9lcyBub3Qgd29yaworCQkgKiB3aGVuIGEgZGV2aWNlIGRyaXZlciBpcyBpbnZvbHZl
ZCAoeW91IGNhbm5vdCBlYXNpbHkKKwkJICogc2F2ZSBhbmQgcmVzdG9yZSBkZXZpY2UgZHJpdmVy
IHN0YXRlKS4KKwkJICovCisJCWlmIChpc193cml0ZV9kZXZpY2VfcHJpdmF0ZV9lbnRyeShlbnRy
eSkgJiYKKwkJICAgIGlzX2Nvd19tYXBwaW5nKHZtX2ZsYWdzKSkgeworCQkJbWFrZV9kZXZpY2Vf
cHJpdmF0ZV9lbnRyeV9yZWFkKCZlbnRyeSk7CisJCQlwdGUgPSBzd3BfZW50cnlfdG9fcHRlKGVu
dHJ5KTsKKwkJCWlmIChwdGVfc3dwX3VmZmRfd3AoKnNyY19wdGUpKQorCQkJCXB0ZSA9IHB0ZV9z
d3BfbWt1ZmZkX3dwKHB0ZSk7CisJCQlzZXRfcHRlX2F0KHNyY19tbSwgYWRkciwgc3JjX3B0ZSwg
cHRlKTsKKwkJfQorCX0KKwlzZXRfcHRlX2F0KGRzdF9tbSwgYWRkciwgZHN0X3B0ZSwgcHRlKTsK
KwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nCiBjb3B5X29uZV9w
dGUoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJ
CXB0ZV90ICpkc3RfcHRlLCBwdGVfdCAqc3JjX3B0ZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsCkBAIC03MDUsNzUgKzc4MywxMCBAQCBjb3B5X29uZV9wdGUoc3RydWN0IG1tX3N0cnVjdCAq
ZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJc3RydWN0IHBhZ2UgKnBhZ2U7CiAK
IAkvKiBwdGUgY29udGFpbnMgcG9zaXRpb24gaW4gc3dhcCBvciBmaWxlLCBzbyBjb3B5LiAqLwot
CWlmICh1bmxpa2VseSghcHRlX3ByZXNlbnQocHRlKSkpIHsKLQkJc3dwX2VudHJ5X3QgZW50cnkg
PSBwdGVfdG9fc3dwX2VudHJ5KHB0ZSk7Ci0KLQkJaWYgKGxpa2VseSghbm9uX3N3YXBfZW50cnko
ZW50cnkpKSkgewotCQkJaWYgKHN3YXBfZHVwbGljYXRlKGVudHJ5KSA8IDApCi0JCQkJcmV0dXJu
IGVudHJ5LnZhbDsKLQotCQkJLyogbWFrZSBzdXJlIGRzdF9tbSBpcyBvbiBzd2Fwb2ZmJ3MgbW1s
aXN0LiAqLwotCQkJaWYgKHVubGlrZWx5KGxpc3RfZW1wdHkoJmRzdF9tbS0+bW1saXN0KSkpIHsK
LQkJCQlzcGluX2xvY2soJm1tbGlzdF9sb2NrKTsKLQkJCQlpZiAobGlzdF9lbXB0eSgmZHN0X21t
LT5tbWxpc3QpKQotCQkJCQlsaXN0X2FkZCgmZHN0X21tLT5tbWxpc3QsCi0JCQkJCQkJJnNyY19t
bS0+bW1saXN0KTsKLQkJCQlzcGluX3VubG9jaygmbW1saXN0X2xvY2spOwotCQkJfQotCQkJcnNz
W01NX1NXQVBFTlRTXSsrOwotCQl9IGVsc2UgaWYgKGlzX21pZ3JhdGlvbl9lbnRyeShlbnRyeSkp
IHsKLQkJCXBhZ2UgPSBtaWdyYXRpb25fZW50cnlfdG9fcGFnZShlbnRyeSk7Ci0KLQkJCXJzc1tt
bV9jb3VudGVyKHBhZ2UpXSsrOwotCi0JCQlpZiAoaXNfd3JpdGVfbWlncmF0aW9uX2VudHJ5KGVu
dHJ5KSAmJgotCQkJCQlpc19jb3dfbWFwcGluZyh2bV9mbGFncykpIHsKLQkJCQkvKgotCQkJCSAq
IENPVyBtYXBwaW5ncyByZXF1aXJlIHBhZ2VzIGluIGJvdGgKLQkJCQkgKiBwYXJlbnQgYW5kIGNo
aWxkIHRvIGJlIHNldCB0byByZWFkLgotCQkJCSAqLwotCQkJCW1ha2VfbWlncmF0aW9uX2VudHJ5
X3JlYWQoJmVudHJ5KTsKLQkJCQlwdGUgPSBzd3BfZW50cnlfdG9fcHRlKGVudHJ5KTsKLQkJCQlp
ZiAocHRlX3N3cF9zb2Z0X2RpcnR5KCpzcmNfcHRlKSkKLQkJCQkJcHRlID0gcHRlX3N3cF9ta3Nv
ZnRfZGlydHkocHRlKTsKLQkJCQlpZiAocHRlX3N3cF91ZmZkX3dwKCpzcmNfcHRlKSkKLQkJCQkJ
cHRlID0gcHRlX3N3cF9ta3VmZmRfd3AocHRlKTsKLQkJCQlzZXRfcHRlX2F0KHNyY19tbSwgYWRk
ciwgc3JjX3B0ZSwgcHRlKTsKLQkJCX0KLQkJfSBlbHNlIGlmIChpc19kZXZpY2VfcHJpdmF0ZV9l
bnRyeShlbnRyeSkpIHsKLQkJCXBhZ2UgPSBkZXZpY2VfcHJpdmF0ZV9lbnRyeV90b19wYWdlKGVu
dHJ5KTsKLQotCQkJLyoKLQkJCSAqIFVwZGF0ZSByc3MgY291bnQgZXZlbiBmb3IgdW5hZGRyZXNz
YWJsZSBwYWdlcywgYXMKLQkJCSAqIHRoZXkgc2hvdWxkIHRyZWF0ZWQganVzdCBsaWtlIG5vcm1h
bCBwYWdlcyBpbiB0aGlzCi0JCQkgKiByZXNwZWN0LgotCQkJICoKLQkJCSAqIFdlIHdpbGwgbGlr
ZWx5IHdhbnQgdG8gaGF2ZSBzb21lIG5ldyByc3MgY291bnRlcnMKLQkJCSAqIGZvciB1bmFkZHJl
c3NhYmxlIHBhZ2VzLCBhdCBzb21lIHBvaW50LiBCdXQgZm9yIG5vdwotCQkJICoga2VlcCB0aGlu
Z3MgYXMgdGhleSBhcmUuCi0JCQkgKi8KLQkJCWdldF9wYWdlKHBhZ2UpOwotCQkJcnNzW21tX2Nv
dW50ZXIocGFnZSldKys7Ci0JCQlwYWdlX2R1cF9ybWFwKHBhZ2UsIGZhbHNlKTsKLQotCQkJLyoK
LQkJCSAqIFdlIGRvIG5vdCBwcmVzZXJ2ZSBzb2Z0LWRpcnR5IGluZm9ybWF0aW9uLCBiZWNhdXNl
IHNvCi0JCQkgKiBmYXIsIGNoZWNrcG9pbnQvcmVzdG9yZSBpcyB0aGUgb25seSBmZWF0dXJlIHRo
YXQKLQkJCSAqIHJlcXVpcmVzIHRoYXQuIEFuZCBjaGVja3BvaW50L3Jlc3RvcmUgZG9lcyBub3Qg
d29yawotCQkJICogd2hlbiBhIGRldmljZSBkcml2ZXIgaXMgaW52b2x2ZWQgKHlvdSBjYW5ub3Qg
ZWFzaWx5Ci0JCQkgKiBzYXZlIGFuZCByZXN0b3JlIGRldmljZSBkcml2ZXIgc3RhdGUpLgotCQkJ
ICovCi0JCQlpZiAoaXNfd3JpdGVfZGV2aWNlX3ByaXZhdGVfZW50cnkoZW50cnkpICYmCi0JCQkg
ICAgaXNfY293X21hcHBpbmcodm1fZmxhZ3MpKSB7Ci0JCQkJbWFrZV9kZXZpY2VfcHJpdmF0ZV9l
bnRyeV9yZWFkKCZlbnRyeSk7Ci0JCQkJcHRlID0gc3dwX2VudHJ5X3RvX3B0ZShlbnRyeSk7Ci0J
CQkJaWYgKHB0ZV9zd3BfdWZmZF93cCgqc3JjX3B0ZSkpCi0JCQkJCXB0ZSA9IHB0ZV9zd3BfbWt1
ZmZkX3dwKHB0ZSk7Ci0JCQkJc2V0X3B0ZV9hdChzcmNfbW0sIGFkZHIsIHNyY19wdGUsIHB0ZSk7
Ci0JCQl9Ci0JCX0KLQkJZ290byBvdXRfc2V0X3B0ZTsKLQl9CisJaWYgKHVubGlrZWx5KCFwdGVf
cHJlc2VudChwdGUpKSkKKwkJcmV0dXJuIGNvcHlfbm9ucHJlc2VudF9wdGUoZHN0X21tLCBzcmNf
bW0sCisJCQkJCSAgIGRzdF9wdGUsIHNyY19wdGUsIHZtYSwKKwkJCQkJICAgYWRkciwgcnNzKTsK
IAogCS8qCiAJICogSWYgaXQncyBhIENPVyBtYXBwaW5nLCB3cml0ZSBwcm90ZWN0IGl0IGJvdGgK
QEAgLTgwNyw3ICs4MjAsNiBAQCBjb3B5X29uZV9wdGUoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21t
LCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJCXJzc1ttbV9jb3VudGVyKHBhZ2UpXSsrOwog
CX0KIAotb3V0X3NldF9wdGU6CiAJc2V0X3B0ZV9hdChkc3RfbW0sIGFkZHIsIGRzdF9wdGUsIHB0
ZSk7CiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjI4LjAuMjE4LmdjMTJlZjNkMzQ5Cgo=
--000000000000938f2505affe4062
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-mm-move-the-copy_one_pte-pte_present-check-into-the-.patch"
Content-Disposition: attachment; 
	filename="0002-mm-move-the-copy_one_pte-pte_present-check-into-the-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kffngcol1>
X-Attachment-Id: f_kffngcol1

RnJvbSA3OWExOTcxYzVmMTRlYTNhNmUyYjBjNGNhZjczYTE3NjBkYjdjYWI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFdlZCwgMjMgU2VwIDIwMjAgMTA6MDQ6MTYgLTA3MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gbW06IG1vdmUgdGhlIGNvcHlfb25lX3B0ZSgpIHB0ZV9wcmVzZW50IGNoZWNr
IGludG8gdGhlCiBjYWxsZXIKClRoaXMgY29tcGxldGVzIHRoZSBzcGxpdCBvZiB0aGUgbm9uLXBy
ZXNlbnQgYW5kIHByZXNlbnQgcHRlIGNhc2VzIGJ5Cm1vdmluZyB0aGUgY2hlY2sgZm9yIHRoZSBz
b3VyY2UgcHRlIGJlaW5nIHByZXNlbnQgaW50byB0aGUgc2luZ2xlCmNhbGxlciwgd2hpY2ggYWxz
byBtZWFucyB0aGF0IHdlIGNsZWFybHkgc2VwYXJhdGUgb3V0IHRoZSB2ZXJ5IGRpZmZlcmVudApy
ZXR1cm4gdmFsdWUgY2FzZSBmb3IgYSBub24tcHJlc2VudCBwdGUuCgpUaGUgcHJlc2VudCBwdGUg
Y2FzZSBjdXJyZW50bHkgYWx3YXlzIHN1Y2NlZWRzLgoKVGhpcyBpcyBhIHB1cmUgY29kZSByZS1v
cmdhbml6YXRpb24gd2l0aCBubyBzZW1hbnRpYyBjaGFuZ2U6IHRoZSBpbnRlbnQKaXMgdG8gbWFr
ZSBpdCBtdWNoIGVhc2llciB0byBhZGQgYSBuZXcgcmV0dXJuIGNhc2UgdG8gdGhlIHByZXNlbnQg
cHRlCmNhc2UgZm9yIHdoZW4gd2UgZG8gZWFybHkgQ09XIGF0IHBhZ2UgdGFibGUgY29weSB0aW1l
LgoKVGhpcyB3YXMgc3BsaXQgb3V0IGZyb20gdGhlIHByZXZpb3VzIGNvbW1pdCBzaW1wbHkgdG8g
bWFrZSBpdCBlYXN5IHRvCnZpc3VhbGx5IHNlZSB0aGF0IHRoZXJlIHdlcmUgbm8gc2VtYW50aWMg
Y2hhbmdlcyBmcm9tIHRoaXMgY29kZQpyZS1vcmdhbml6YXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBM
aW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogbW0vbWVt
b3J5LmMgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBi
L21tL21lbW9yeS5jCmluZGV4IDMxYTNhYjdkOWFhMy4uZTMxNWIxZjFlZjA4IDEwMDY0NAotLS0g
YS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtNzczLDggKzc3Myw4IEBAIGNvcHlf
bm9ucHJlc2VudF9wdGUoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0
ICpzcmNfbW0sCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZwot
Y29weV9vbmVfcHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAq
c3JjX21tLAorc3RhdGljIGlubGluZSB2b2lkCitjb3B5X3ByZXNlbnRfcHRlKHN0cnVjdCBtbV9z
dHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLAogCQlwdGVfdCAqZHN0X3B0
ZSwgcHRlX3QgKnNyY19wdGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCQl1bnNpZ25l
ZCBsb25nIGFkZHIsIGludCAqcnNzKQogewpAQCAtNzgyLDEyICs3ODIsNiBAQCBjb3B5X29uZV9w
dGUoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJ
cHRlX3QgcHRlID0gKnNyY19wdGU7CiAJc3RydWN0IHBhZ2UgKnBhZ2U7CiAKLQkvKiBwdGUgY29u
dGFpbnMgcG9zaXRpb24gaW4gc3dhcCBvciBmaWxlLCBzbyBjb3B5LiAqLwotCWlmICh1bmxpa2Vs
eSghcHRlX3ByZXNlbnQocHRlKSkpCi0JCXJldHVybiBjb3B5X25vbnByZXNlbnRfcHRlKGRzdF9t
bSwgc3JjX21tLAotCQkJCQkgICBkc3RfcHRlLCBzcmNfcHRlLCB2bWEsCi0JCQkJCSAgIGFkZHIs
IHJzcyk7Ci0KIAkvKgogCSAqIElmIGl0J3MgYSBDT1cgbWFwcGluZywgd3JpdGUgcHJvdGVjdCBp
dCBib3RoCiAJICogaW4gdGhlIHBhcmVudCBhbmQgdGhlIGNoaWxkCkBAIC04MjEsNyArODE1LDYg
QEAgY29weV9vbmVfcHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVj
dCAqc3JjX21tLAogCX0KIAogCXNldF9wdGVfYXQoZHN0X21tLCBhZGRyLCBkc3RfcHRlLCBwdGUp
OwotCXJldHVybiAwOwogfQogCiBzdGF0aWMgaW50IGNvcHlfcHRlX3JhbmdlKHN0cnVjdCBtbV9z
dHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLApAQCAtODYzLDEwICs4NTYs
MTcgQEAgc3RhdGljIGludCBjb3B5X3B0ZV9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0s
IHN0cnVjdCBtbV9zdHJ1Y3QgKnNyY19tbSwKIAkJCXByb2dyZXNzKys7CiAJCQljb250aW51ZTsK
IAkJfQotCQllbnRyeS52YWwgPSBjb3B5X29uZV9wdGUoZHN0X21tLCBzcmNfbW0sIGRzdF9wdGUs
IHNyY19wdGUsCisJCWlmICh1bmxpa2VseSghcHRlX3ByZXNlbnQoKnNyY19wdGUpKSkgeworCQkJ
ZW50cnkudmFsID0gY29weV9ub25wcmVzZW50X3B0ZShkc3RfbW0sIHNyY19tbSwKKwkJCQkJCQlk
c3RfcHRlLCBzcmNfcHRlLAogCQkJCQkJCXZtYSwgYWRkciwgcnNzKTsKLQkJaWYgKGVudHJ5LnZh
bCkKLQkJCWJyZWFrOworCQkJaWYgKGVudHJ5LnZhbCkKKwkJCQlicmVhazsKKwkJCXByb2dyZXNz
ICs9IDg7CisJCQljb250aW51ZTsKKwkJfQorCQljb3B5X3ByZXNlbnRfcHRlKGRzdF9tbSwgc3Jj
X21tLCBkc3RfcHRlLCBzcmNfcHRlLAorCQkJCSB2bWEsIGFkZHIsIHJzcyk7CiAJCXByb2dyZXNz
ICs9IDg7CiAJfSB3aGlsZSAoZHN0X3B0ZSsrLCBzcmNfcHRlKyssIGFkZHIgKz0gUEFHRV9TSVpF
LCBhZGRyICE9IGVuZCk7CiAKLS0gCjIuMjguMC4yMTguZ2MxMmVmM2QzNDkKCg==
--000000000000938f2505affe4062--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA20E27B5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1TuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgI1TuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:50:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BCC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:50:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d15so2705063lfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFe59ygllh1csDHLKc44rrpmdcLi64mRKne6cb8G5UI=;
        b=Z0cCPdE6eUpwNg59dDo5sroppxJdJjGWOa0DlXCxyc6xwoewubzGhHY+W2SnxgFXY6
         BQAGI/kDvFOe9f8N/05GMm2wT4fxaHSXxGDf/xGBj/Md6yNoJ1jSVfpzSSSvRwUto3Ff
         TcmrSRZ+nRW7MfF9KCZ4CrfxAXla/gqbDcT50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFe59ygllh1csDHLKc44rrpmdcLi64mRKne6cb8G5UI=;
        b=mUQZW4hn7crtz6XsILv2vdxe2UdtJNkJ9xh0RE0gPVq7/pO1smoSsAdyWNTzTvVyzg
         q9S/Xl/a4gxVbR4Vy2b6aKQkXqhU/dzms7dOfFCCLBwUIrsWrEqvMvY/oVVGXxWBz/t6
         yQuYkspgUp4wdxwBRsq5mQ0OhE4ziHfEgTJVxRXbkr/wcVeV0aKX2JLUCOlBGoHTdZl+
         BCY0TsB4kWsORgr9It8LHcbwWIOplTjHqm+jpINg1MYdgdKewnWCeWokW9S2PtsflAkI
         UNhDvcbfV8V9aHv53T6e3cq5EHOxs5w5fJ7YMfAAmkrvnbJT9XtTHCJ+nKCyQxomRD3f
         g6Qg==
X-Gm-Message-State: AOAM530THqU73yynzSaFBy8YyVr1Ex1jOVuwtj8CIcSPGapOJGyjqIvV
        98gnB7gLKzyuij55v41wVHVqW+6oG0RMCA==
X-Google-Smtp-Source: ABdhPJy1aFbcBmyHDBdaZ85ADfxd6x6kMTI/qXW0hL1S/k+W779sjAjazvLnKieEqA/BDEFWeutQng==
X-Received: by 2002:a19:c002:: with SMTP id q2mr957850lff.372.1601322621839;
        Mon, 28 Sep 2020 12:50:21 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z7sm2956127lfc.59.2020.09.28.12.50.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:50:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 77so2767619lfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:50:19 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr913345lfr.352.1601322619227;
 Mon, 28 Sep 2020 12:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca> <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1> <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca> <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 12:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
Message-ID: <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Content-Type: multipart/mixed; boundary="000000000000e3fbfb05b064f9df"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e3fbfb05b064f9df
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 28, 2020 at 12:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll do the pte wrprotect/restore removal. Anybody willing to do
> and test the sequence count approach?

So the wrprotect removal is trivial, with most of it being about the comments.

However, when I look at this, I am - once again - tempted to just add a

        if (__page_mapcount(page) > 1)
                return 1;

there too. Because we know it's a private mapping (shared mappings we
checked for with the "is_cow_mapping()" earlier), and the only case we
really care about is the one where the page is only mapped in the
current mm (because that's what a write pinning will have done, and as
mentioned, a read pinning doesn't do anything wrt fork() right now
anyway).

So if it's mapped in another mm, the COW clearly hasn't been broken by
a pin, and a read pinned page had already gone through a fork.

But the more I look at this code, the more I go "ok, I want somebody
to actually test this with the rdma case".

So I'll attach my suggested patch, but I won't actually commit it. I'd
really like to have this tested, possibly _together_ with the sequence
count addition..

               Linus

--000000000000e3fbfb05b064f9df
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfmy4mp90>
X-Attachment-Id: f_kfmy4mp90

IG1tL21lbW9yeS5jIHwgNDYgKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZmNmYzRjYTM2
ZWJhLi40YTdlODlkMzVlY2YgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9y
eS5jCkBAIC04MDYsOCArODA2LDYgQEAgY29weV9wcmVzZW50X3BhZ2Uoc3RydWN0IG1tX3N0cnVj
dCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJCXJldHVybiAxOwogCiAJLyoK
LQkgKiBUaGUgdHJpY2sgc3RhcnRzLgotCSAqCiAJICogV2hhdCB3ZSB3YW50IHRvIGRvIGlzIHRv
IGNoZWNrIHdoZXRoZXIgdGhpcyBwYWdlIG1heQogCSAqIGhhdmUgYmVlbiBwaW5uZWQgYnkgdGhl
IHBhcmVudCBwcm9jZXNzLiAgSWYgc28sCiAJICogaW5zdGVhZCBvZiB3cnByb3RlY3QgdGhlIHB0
ZSBvbiBib3RoIHNpZGVzLCB3ZSBjb3B5CkBAIC04MTUsNDYgKzgxMywyMiBAQCBjb3B5X3ByZXNl
bnRfcGFnZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHN0cnVjdCBtbV9zdHJ1Y3QgKnNyY19t
bSwKIAkgKiB0aGUgcGlubmVkIHBhZ2Ugd29uJ3QgYmUgcmFuZG9tbHkgcmVwbGFjZWQgaW4gdGhl
CiAJICogZnV0dXJlLgogCSAqCi0JICogVG8gYWNoaWV2ZSB0aGlzLCB3ZSBkbyB0aGUgZm9sbG93
aW5nOgotCSAqCi0JICogMS4gV3JpdGUtcHJvdGVjdCB0aGUgcHRlIGlmIGl0J3Mgd3JpdGFibGUu
ICBUaGlzIGlzCi0JICogICAgdG8gcHJvdGVjdCBjb25jdXJyZW50IHdyaXRlIGZhc3QtZ3VwIHdp
dGgKLQkgKiAgICBGT0xMX1BJTiwgc28gdGhhdCB3ZSdsbCBmYWlsIHRoZSBmYXN0LWd1cCB3aXRo
Ci0JICogICAgdGhlIHdyaXRlIGJpdCByZW1vdmVkLgotCSAqCi0JICogMi4gQ2hlY2sgcGFnZV9t
YXliZV9kbWFfcGlubmVkKCkgdG8gc2VlIHdoZXRoZXIgdGhpcwotCSAqICAgIHBhZ2UgbWF5IGhh
dmUgYmVlbiBwaW5uZWQuCisJICogVGhlIHBhZ2UgcGlubmluZyBjaGVja3MgYXJlIGp1c3QgImhh
cyB0aGlzIG1tIGV2ZXIKKwkgKiBzZWVuIHBpbm5pbmciLCBhbG9uZyB3aXRoIHRoZSAoaW5leGFj
dCkgY2hlY2sgb2YKKwkgKiB0aGUgcGFnZSBjb3VudC4gVGhhdCBtaWdodCBnaXZlIGZhbHNlIHBv
c2l0aXZlcyBmb3IKKwkgKiBmb3IgcGlubmluZywgYnV0IGl0IHdpbGwgd29yayBjb3JyZWN0bHku
CiAJICoKLQkgKiBUaGUgb3JkZXIgb2YgdGhlc2Ugc3RlcHMgaXMgaW1wb3J0YW50IHRvIHNlcmlh
bGl6ZQotCSAqIGFnYWluc3QgdGhlIGZhc3QtZ3VwIGNvZGUgKGd1cF9wdGVfcmFuZ2UoKSkgb24g
dGhlCi0JICogcHRlIGNoZWNrIGFuZCB0cnlfZ3JhYl9jb21wb3VuZF9oZWFkKCksIHNvIHRoYXQK
LQkgKiB3ZSdsbCBtYWtlIHN1cmUgZWl0aGVyIHdlJ2xsIGNhcHR1cmUgdGhhdCBmYXN0LWd1cAot
CSAqIHNvIHdlJ2xsIGNvcHkgdGhlIHBpbm5lZCBwYWdlIGhlcmUsIG9yIHdlJ2xsIGZhaWwKLQkg
KiB0aGF0IGZhc3QtZ3VwLgotCSAqCi0JICogTk9URSEgRXZlbiBpZiB3ZSBkb24ndCBlbmQgdXAg
Y29weWluZyB0aGUgcGFnZSwKLQkgKiB3ZSB3b24ndCB1bmRvIHRoaXMgd3Jwcm90ZWN0KCksIGJl
Y2F1c2UgdGhlIG5vcm1hbAotCSAqIHJlZmVyZW5jZSBjb3B5IHdpbGwgbmVlZCBpdCBhbnl3YXku
Ci0JICovCi0JaWYgKHB0ZV93cml0ZShwdGUpKQotCQlwdGVwX3NldF93cnByb3RlY3Qoc3JjX21t
LCBhZGRyLCBzcmNfcHRlKTsKLQotCS8qCi0JICogVGhlc2UgYXJlIHRoZSAibm9ybWFsbHkgd2Ug
Y2FuIGp1c3QgY29weSBieSByZWZlcmVuY2UiCi0JICogY2hlY2tzLgorCSAqIEFub3RoZXIgaGV1
cmlzdGljIGlzIHRvIGp1c3QgY2hlY2sgdGhlIG1hcGNvdW50IGZvcgorCSAqIHRoaXMgcGFnZS4g
SWYgaXQgaXMgbWFwcGVkIGVsc2V3aGVyZSwgaXQgYWxyZWFkeSBpcworCSAqIG5vdCBhbiBleGNs
dXNpdmVseSBwaW5uZWQgcGFnZSwgYW5kIGRvaW5nIGFub3RoZXIKKwkgKiAiY29weSBieSByZWZl
cmVuY2UiIGlzbid0IGdvaW5nIHRvIG1hdHRlci4KIAkgKi8KIAlpZiAobGlrZWx5KCFhdG9taWNf
cmVhZCgmc3JjX21tLT5oYXNfcGlubmVkKSkpCiAJCXJldHVybiAxOwogCWlmIChsaWtlbHkoIXBh
Z2VfbWF5YmVfZG1hX3Bpbm5lZChwYWdlKSkpCiAJCXJldHVybiAxOwotCi0JLyoKLQkgKiBVaGh1
aC4gSXQgbG9va3MgbGlrZSB0aGUgcGFnZSBtaWdodCBiZSBhIHBpbm5lZCBwYWdlLAotCSAqIGFu
ZCB3ZSBhY3R1YWxseSBuZWVkIHRvIGNvcHkgaXQuIE5vdyB3ZSBjYW4gc2V0IHRoZQotCSAqIHNv
dXJjZSBwdGUgYmFjayB0byBiZWluZyB3cml0YWJsZS4KLQkgKi8KLQlpZiAocHRlX3dyaXRlKHB0
ZSkpCi0JCXNldF9wdGVfYXQoc3JjX21tLCBhZGRyLCBzcmNfcHRlLCBwdGUpOworCWlmIChfX3Bh
Z2VfbWFwY291bnQocGFnZSkgPiAxKQorCQlyZXR1cm4gMTsKIAogCW5ld19wYWdlID0gKnByZWFs
bG9jOwogCWlmICghbmV3X3BhZ2UpCg==
--000000000000e3fbfb05b064f9df--

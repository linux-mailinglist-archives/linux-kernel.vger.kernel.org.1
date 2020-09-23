Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E827620B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:26:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708BC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:26:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so1378426lfj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLB4DRRXoa8ewsaibQOQoUjg6wFUOgvHUlS6KwrQW+Q=;
        b=LBRKpKsCN18FhUCT+ybewb3k/YEEHjRtd7HxGQxdBKW2iF5/B/ldqJlEJGGoY3Dvf0
         BnyxMahBOLtdrW1QsvXec8yhZHZZW3OZ0PhjkAvhJ25wity4VnTPnnHOkub/MCsM8CaF
         uApDqbydEW7dEB4jVZdAyxGzc9jX6WFZUurAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLB4DRRXoa8ewsaibQOQoUjg6wFUOgvHUlS6KwrQW+Q=;
        b=C3FO9bynftz9+WFFbUjaJRnOa8aT5zZRvTA1zegaxoHlUi0MG6d71ZIHuMqBDGAjWf
         J8P4VXIPRHiDvGbnhMnqlG5E733DV4GGThCzV8QISkstifTOUEEzcwm+zPf1Qwg9Yi7g
         E5Xqez4FoeVsLJlp6+CrOhceABFywQaRBNOAjRrscj67ZicObTT3IpLvApgDqhcSRS3h
         ber1EvhBdK7e+R6Da2D3WzxUC5JvdIMa/Gkwn57vslToRq14VqSA6a5hcA/imWW9Pd5+
         XLeUWs1emsWFBypiRQgRZq2VPaiqb0TCTkkezIw2HVFS1t6xU1+PaLMTgBmOc1+jdKWZ
         FaJQ==
X-Gm-Message-State: AOAM530+NLdQ3kYVjpeLWE2axW/yNgIHdIy6M0HipfnJfXti3yHjQjrz
        O86lIji6w3Rlu1AU6it53/8E3XwlNBxKFg==
X-Google-Smtp-Source: ABdhPJww4DiagZFlEhSRjdLOAsgNM8uMAslYBmRqXu9JGvW9UXZlHTSUj2dftPS4PaRUCePiWjQz/Q==
X-Received: by 2002:a19:589:: with SMTP id 131mr480879lff.229.1600892771818;
        Wed, 23 Sep 2020 13:26:11 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l9sm411137lfh.285.2020.09.23.13.26.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 13:26:09 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id r24so770148ljm.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:26:09 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr459528ljc.371.1600892769057;
 Wed, 23 Sep 2020 13:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com> <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1> <20200922165216.GF11679@redhat.com>
 <20200922183438.GL19098@xz-x1> <20200922184359.GI11679@redhat.com> <20200923010332.GP19098@xz-x1>
In-Reply-To: <20200923010332.GP19098@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Sep 2020 13:25:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBth_SpXYCmYLiZTRadAvncCDAmK_Kw1QNTg-HS23aKA@mail.gmail.com>
Message-ID: <CAHk-=whBth_SpXYCmYLiZTRadAvncCDAmK_Kw1QNTg-HS23aKA@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for ptes
To:     Peter Xu <peterx@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000d2fa5405b000e481"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d2fa5405b000e481
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 22, 2020 at 6:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> > If we rely on "copy_ret == COPY_MM_BREAK_COW" we can unify "again" and
> > "again_break_cow", we don't need to clear ->cow_new_page, this makes the
> > logic more understandable. To me at least ;)
>
> I see your point.  I'll definitely try it out.  I think I'll at least use what
> you preferred above since it's actually the same as before, logically.  Then
> I'll consider drop the again_break_cow, as long as I'm still as confident after
> I do the change on not leaking anything :).

So the two patches I sent out to re-organize copy_one_pte() were
literally meant to make all this mess go away.

IOW, the third patch would be something (COMPLETELY UNTESTED) like the attached.

I think the logic for the preallocation is fairly obvious, but it
might be better to allocate a batch of pages for all I know. That
said, I can't really make myself care about the performance of a
fork() after you've pinned pages in it, so..

                 Linus

--000000000000d2fa5405b000e481
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kffu7k9z0>
X-Attachment-Id: f_kffu7k9z0

IG1tL21lbW9yeS5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZTMxNWIxZjFlZjA4Li41MjRh
YTcxODM5NzEgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5jCkBAIC03
NzMsMTAgKzc3MywxNCBAQCBjb3B5X25vbnByZXNlbnRfcHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRz
dF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLAogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
aW5saW5lIHZvaWQKKy8qCisgKiBUaGlzIHJldHVybnMgMCBmb3Igc3VjY2VzcywgPjAgZm9yICJz
dWNjZXNzLCBhbmQgSSB1c2VkIHRoZSBwcmVhbGxvYyBwYWdlIiwKKyAqIGFuZCA8MCBmb3IgInlv
dSBuZWVkIHRvIHByZWFsbG9jYXRlIGEgcGFnZSBhbmQgcmV0cnkiLgorICovCitzdGF0aWMgaW5s
aW5lIGludAogY29weV9wcmVzZW50X3B0ZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHN0cnVj
dCBtbV9zdHJ1Y3QgKnNyY19tbSwKIAkJcHRlX3QgKmRzdF9wdGUsIHB0ZV90ICpzcmNfcHRlLCBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKLQkJdW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgKnJz
cykKKwkJdW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgKnJzcywgc3RydWN0IHBhZ2UgKnByZWFsbG9j
KQogewogCXVuc2lnbmVkIGxvbmcgdm1fZmxhZ3MgPSB2bWEtPnZtX2ZsYWdzOwogCXB0ZV90IHB0
ZSA9ICpzcmNfcHRlOwpAQCAtODE1LDYgKzgxOSw3IEBAIGNvcHlfcHJlc2VudF9wdGUoc3RydWN0
IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJfQogCiAJc2V0
X3B0ZV9hdChkc3RfbW0sIGFkZHIsIGRzdF9wdGUsIHB0ZSk7CisJcmV0dXJuIDA7CiB9CiAKIHN0
YXRpYyBpbnQgY29weV9wdGVfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3Qg
bW1fc3RydWN0ICpzcmNfbW0sCkBAIC04MjQsMTYgKzgyOSwxOSBAQCBzdGF0aWMgaW50IGNvcHlf
cHRlX3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3Jj
X21tLAogCXB0ZV90ICpvcmlnX3NyY19wdGUsICpvcmlnX2RzdF9wdGU7CiAJcHRlX3QgKnNyY19w
dGUsICpkc3RfcHRlOwogCXNwaW5sb2NrX3QgKnNyY19wdGwsICpkc3RfcHRsOwotCWludCBwcm9n
cmVzcyA9IDA7CisJaW50IHByb2dyZXNzLCB1c2VkX3BhZ2U7CiAJaW50IHJzc1tOUl9NTV9DT1VO
VEVSU107CiAJc3dwX2VudHJ5X3QgZW50cnkgPSAoc3dwX2VudHJ5X3QpezB9OworCXN0cnVjdCBw
YWdlICpwcmVhbGxvYyA9IE5VTEw7CiAKIGFnYWluOgorCXByb2dyZXNzID0gMDsKKwl1c2VkX3Bh
Z2UgPSAwOwogCWluaXRfcnNzX3ZlYyhyc3MpOwogCiAJZHN0X3B0ZSA9IHB0ZV9hbGxvY19tYXBf
bG9jayhkc3RfbW0sIGRzdF9wbWQsIGFkZHIsICZkc3RfcHRsKTsKIAlpZiAoIWRzdF9wdGUpCi0J
CXJldHVybiAtRU5PTUVNOworCQlnb3RvIG91dF9vZl9tZW1vcnk7CiAJc3JjX3B0ZSA9IHB0ZV9v
ZmZzZXRfbWFwKHNyY19wbWQsIGFkZHIpOwogCXNyY19wdGwgPSBwdGVfbG9ja3B0cihzcmNfbW0s
IHNyY19wbWQpOwogCXNwaW5fbG9ja19uZXN0ZWQoc3JjX3B0bCwgU0lOR0xFX0RFUFRIX05FU1RJ
TkcpOwpAQCAtODY1LDggKzg3MywxMiBAQCBzdGF0aWMgaW50IGNvcHlfcHRlX3JhbmdlKHN0cnVj
dCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLAogCQkJcHJvZ3Jl
c3MgKz0gODsKIAkJCWNvbnRpbnVlOwogCQl9Ci0JCWNvcHlfcHJlc2VudF9wdGUoZHN0X21tLCBz
cmNfbW0sIGRzdF9wdGUsIHNyY19wdGUsCi0JCQkJIHZtYSwgYWRkciwgcnNzKTsKKwkJLyogY29w
eV9wcmVzZW50X3BhZ2UoKSBtYXkgbmVlZCB0byBoYXZlIGEgcHJlLWFsbG9jYXRlZCB0ZW1wb3Jh
cnkgcGFnZSAqLworCQl1c2VkX3BhZ2UgPSBjb3B5X3ByZXNlbnRfcHRlKGRzdF9tbSwgc3JjX21t
LCBkc3RfcHRlLCBzcmNfcHRlLCB2bWEsIGFkZHIsIHJzcywgcHJlYWxsb2MpOworCQlpZiAodXNl
ZF9wYWdlIDwgMCkKKwkJCWJyZWFrOworCQlpZiAodXNlZF9wYWdlKQorCQkJcHJlYWxsb2MgPSBO
VUxMOwogCQlwcm9ncmVzcyArPSA4OwogCX0gd2hpbGUgKGRzdF9wdGUrKywgc3JjX3B0ZSsrLCBh
ZGRyICs9IFBBR0VfU0laRSwgYWRkciAhPSBlbmQpOwogCkBAIC04NzksMTIgKzg5MSwyNCBAQCBz
dGF0aWMgaW50IGNvcHlfcHRlX3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0
IG1tX3N0cnVjdCAqc3JjX21tLAogCiAJaWYgKGVudHJ5LnZhbCkgewogCQlpZiAoYWRkX3N3YXBf
Y291bnRfY29udGludWF0aW9uKGVudHJ5LCBHRlBfS0VSTkVMKSA8IDApCisJCQlnb3RvIG91dF9v
Zl9tZW1vcnk7CisJfQorCS8qIERpZCB3ZSBleGl0IGZyb20gdGhlIHB0ZSBsb2NrIGJlY2F1c2Ug
d2UgbmVlZGVkIGEgbmV3IHBhZ2U/ICovCisJaWYgKHVzZWRfcGFnZSA8IDApIHsKKwkJcHJlYWxs
b2MgPSBhbGxvY19wYWdlX3ZtYShHRlBfSElHSFVTRVJfTU9WQUJMRSwgdm1hLCBhZGRyKTsKKwkJ
aWYgKCFwcmVhbGxvYykKIAkJCXJldHVybiAtRU5PTUVNOwotCQlwcm9ncmVzcyA9IDA7CiAJfQog
CWlmIChhZGRyICE9IGVuZCkKIAkJZ290byBhZ2FpbjsKKwlpZiAocHJlYWxsb2MpCisJCWZyZWVf
dW5yZWZfcGFnZShwcmVhbGxvYyk7CiAJcmV0dXJuIDA7CisKK291dF9vZl9tZW1vcnk6CisJaWYg
KHByZWFsbG9jKQorCQlmcmVlX3VucmVmX3BhZ2UocHJlYWxsb2MpOworCXJldHVybiAtRU5PTUVN
OwogfQogCiBzdGF0aWMgaW5saW5lIGludCBjb3B5X3BtZF9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0
ICpkc3RfbW0sIHN0cnVjdCBtbV9zdHJ1Y3QgKnNyY19tbSwK
--000000000000d2fa5405b000e481--

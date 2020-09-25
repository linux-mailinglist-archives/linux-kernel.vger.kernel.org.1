Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41202792F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIYVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgIYVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:07:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A4CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:07:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so4331643lff.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcGzcytv6at245rIYmIAtT4sb1kjH/VqfMRQpRQuCl8=;
        b=hqh6gA8nay+2HSIJcqTqMAl79Jzfp9c0xWS0SiD5jX7bBHht0y7TEa15wcaCqGBPI5
         YBRb0a87PVkjGTPEf/LpxL59zd3SSEKCMIgDRv0yYaYC7slq4XCCIGAUBYGqPjVH8kPQ
         /m4GjUl9wS+/4csvZonEPiVWpOEx93JEDy5cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcGzcytv6at245rIYmIAtT4sb1kjH/VqfMRQpRQuCl8=;
        b=WPX9ii5mtRM5brwhJC5aEHu18ZGMa7LsVA5iVrIu+kjk3/qDN99jwHUKfHxT3KyUuQ
         5T1jlmarDFO7GaNFhdlGmO1BZ+lWrAhBeIq88v91fzigXAiCk6R4No9OCDnaEF6dy/jO
         bhoupJQJ4BXDvv4CleFIImR/jxNK0vVcyGNedTFT6kOcv6qo3JFG8qxNRRAhmitKa0cv
         MnOu1z0XWIGdhCoqyCeOQPxEN/CPrE/1QJMne4XbMb9a97A74r618T4XMYlmdcvu+g2L
         OBYePUP5ZOfaWtX4pYISSGLY3miiYbIH2GFYa7svbbpmPNvD8DAy+0Pwu0UsZ7uF+cFk
         t0wQ==
X-Gm-Message-State: AOAM531od4F4V3VMnZ1OT3mD8gpmdPlNnBMxRH84PUzbJwlV0C2wR2kS
        KlCRjXHgW7ShAvNZQp4M4X5GpH2p+koodw==
X-Google-Smtp-Source: ABdhPJxk7t9r4q8oANiBfuLwpzPGcwH/k01isuvmWgFeaZ1bWTAk8eilpbvBfxLiRRQFO4ppJTehNA==
X-Received: by 2002:ac2:5547:: with SMTP id l7mr206869lfk.153.1601068041873;
        Fri, 25 Sep 2020 14:07:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h11sm196556lfd.21.2020.09.25.14.07.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 14:07:16 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a15so3590993ljk.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:07:16 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr1832078ljp.314.1601068035912;
 Fri, 25 Sep 2020 14:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200922175415.GI19098@xz-x1> <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1> <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1> <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1> <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1> <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1> <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 14:06:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
Message-ID: <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: multipart/mixed; boundary="0000000000008af20a05b029b3f2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008af20a05b029b3f2
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 25, 2020 at 12:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And honestly, since this is all getting fairly late in the rc, and it
> took longer than I thought, I think we should do the GFP_ATOMIC
> approach for now - not great, but since it only triggers for this case
> that really should never happen anyway, I think it's probably the best
> thing for 5.9, and we can improve on things later.

I'm not super-happy with this patch, but I'm throwing it out anyway, in case

 (a) somebody can test it - I don't have any test cases

 (b) somebody can find issues and improve on it

but it's the simplest patch I can come up with for the small-page case.

I have *NOT* tested it. I have tried to think about it, and there are
more lines of comments than there are lines of code, but that only
means that if I didn't think about some case, it's neither in the
comments nor in the code.

I'm happy to take Peter's series too, this is more of an alternative
simplified version to keep the discussion going.

Hmm? What did I miss?

                     Linus

--0000000000008af20a05b029b3f2
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfiqk0yi0>
X-Attachment-Id: f_kfiqk0yi0

IG1tL21lbW9yeS5jIHwgMTI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEyMiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMK
aW5kZXggZjNlYjU1OTc1OTAyLi40OWNlZGRkOTFkYjQgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5j
CisrKyBiL21tL21lbW9yeS5jCkBAIC03NzMsNyArNzczLDExNSBAQCBjb3B5X25vbnByZXNlbnRf
cHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLAog
CXJldHVybiAwOwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQKKy8qCisgKiBDb3B5IGEgc2luZ2xl
IHNtYWxsIHBhZ2UgZm9yIGZvcmsoKS4KKyAqCisgKiBXZSBoYXZlIGFscmVhZHkgbWFya2VkIGl0
IHJlYWQtb25seSBpbiB0aGUgcGFyZW50IGlmCisgKiBpdCdzIGEgQ09XIHBhZ2UsIGFuZCB0aGUg
cHRlIHBhc3NlZCBpbiBoYXMgYWxzbyBiZWVuCisgKiBtYXJrZWQgcmVhZC1vbmx5LiBTbyB0aGUg
bm9ybWFsIHRoaW5nIHRvIGRvIGlzIHRvCisgKiBzaW1wbHkgaW5jcmVhZSB0aGUgcGFnZSBjb3Vu
dCBhbmQgdGhlIHBhZ2UgbWFwcGluZworICogY291bnQsIGFuZCB0aGUgcnNzLCBhbmQgdXNlIHRo
ZSBwdGUgYXMtaXMuIERvbmUuCisgKgorICogSG93ZXZlciwgdGhlcmUgaXMgb25lIHNpdHVhdGlv
biB3aGVyZSB3ZSBjYW4ndCBqdXN0CisgKiByZWx5IG9uIHRoZSBDT1cgYmVoYXZpb3IgLSBpZiB0
aGUgcGFnZSBoYXMgYmVlbiBwaW5uZWQKKyAqIGZvciBETUEgaW4gdGhlIHBhcmVudCwgd2UgY2Fu
J3QganVzdCBnaXZlIGEgcmVmZXJlbmNlCisgKiB0byBpdCB0byB0aGUgY2hpbGQsIGFuZCBzYXkg
Indob2V2ZXIgd3JpdGVzIHRvIGl0IHdpbGwKKyAqIGZvcmNlIGEgQ09XIi4gTm8sIHRoZSBwaW5u
ZWQgcGFnZSBuZWVkcyB0byByZW1haW4KKyAqIHdpdGggdGhlIHBhcmVudCwgYW5kIHdlIG5lZWQg
dG8gZ2l2ZSB0aGUgY2hpbGQgYSBjb3B5LgorICoKKyAqIE5PVEUhIFRoaXMgc2hvdWxkIG5ldmVy
IGhhcHBlbi4gR29vZCBwaW5uaW5nIHVzZXJzCisgKiB3aWxsIGVpdGhlciBub3QgZm9yaywgb3Ig
d2lsbCBtYXJrIHRoZSBhcmVhIHRoZXkgcGlubmVkCisgKiBhcyBNQURWX0RPTlRGT1JLIHNvIHRo
YXQgdGhpcyBzaXR1YXRpb24gbmV2ZXIgY29tZXMgdXAuCisgKiBCdXQgaWYgeW91IGRvbid0IGRv
IHRoYXQuLi4KKyAqCisgKiBOb3RlIHRoYXQgaWYgYSBzbWFsbCBwYWdlIGhhcyBiZWVuIHBpbm5l
ZCwgd2Uga25vdyB0aGUKKyAqIG1hcGNvdW50IGZvciB0aGF0IHBhZ2Ugc2hvdWxkIGJlIDEsIHNp
bmNlIHRoZSBwaW5uaW5nCisgKiB3aWxsIGhhdmUgZG9lbiB0aGUgQ09XIGF0IHRoYXQgcG9pbnQu
IFNvIHRvZ2V0aGVyIHdpdGgKKyAqIHRoZSBlbGV2YXRlZCByZWZjb3VudCwgd2UgaGF2ZSB2ZXJ5
IHNvbGlkIGhldXJpc3RpY3MKKyAqIGZvciAiaXMgdGhpcyBwYWdlIHNvbWV0aGluZyB3ZSBuZWVk
IHRvIHdvcnJ5IGFib3V0IgorICovCitzdGF0aWMgaW50IGNvcHlfbm9ybWFsX3BhZ2Uoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgYWRkciwKKwkJc3RydWN0IG1tX3N0
cnVjdCAqc3JjX21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sCisJCXB0ZV90ICpzcmNfcHRl
LCBwdGVfdCAqZHN0X3B0ZSwKKwkJc3RydWN0IHBhZ2UgKnNyY19wYWdlLCBpbnQgKnJzcykKK3sK
KwlzdHJ1Y3QgcGFnZSAqZHN0X3BhZ2U7CisKKwlpZiAobGlrZWx5KCFwYWdlX21heWJlX2RtYV9w
aW5uZWQoc3JjX3BhZ2UpKSkKKwkJZ290byByZXVzZV9wYWdlOworCisJaWYgKCFpc19jb3dfbWFw
cGluZyh2bWEtPnZtX2ZsYWdzKSkKKwkJZ290byByZXVzZV9wYWdlOworCisJaWYgKF9fcGFnZV9t
YXBjb3VudChzcmNfcGFnZSkgIT0gMSkKKwkJZ290byByZXVzZV9wYWdlOworCisJaWYgKCF2bWEt
PmFub25fdm1hIHx8ICFwdGVfZGlydHkoKnNyY19wdGUpKQorCQlnb3RvIHJldXNlX3BhZ2U7CisK
KwkvKgorCSAqIFdlIGhhdmUgbm93IGNoZWNrZWQgdGhhdCB0aGUgcGFnZSBjb3VudCBpbXBsaWVz
IHRoYXQKKwkgKiBpdCdzIHBpbm5lZCwgYW5kIHRoYXQgaXQncyBtYXBwZWQgb25seSBpbiB0aGlz
IHByb2Nlc3MsCisJICogYW5kIHRoYXQgaXQncyBkaXJ0eSBhbmQgd2UgaGF2ZSBhbiBhbm9udm1h
IChzbyBpdCdzCisJICogYW4gYWN0dWFsIHdyaXRlIHBpbiwgbm90IHNvbWUgcmVhZC1vbmx5IG9u
ZSkuCisJICoKKwkgKiBUaGF0IG1lYW5zIHdlIGhhdmUgdG8gdHJlYXQgaXMgc3BlY2lhbGx5LiBO
YXN0eS4KKwkgKi8KKworCS8qCisJICogTm90ZSB0aGUgd3JvbmcgJ3ZtYScgLSBzb3VyY2UgcmF0
aGVyIHRoYW4gZGVzdGluYXRpb24uCisJICogSXQncyBvbmx5IHVzZWQgZm9yIHBvbGljeSwgd2hp
Y2ggaXMgdGhlIHNhbWUuCisJICoKKwkgKiBUaGUgYmlnZ2VyIGlzc3VlIGlzIHRoYXQgd2UncmUg
aG9sZGluZyB0aGUgcHRsIGxvY2ssCisJICogc28gdGhpcyBuZWVkcyB0byBiZSBhIG5vbi1zbGVl
cGluZyBhbGxvY2F0aW9uLgorCSAqLworCWRzdF9wYWdlID0gYWxsb2NfcGFnZV92bWEoR0ZQX0FU
T01JQyB8IF9fR0ZQX0hJR0ggfCBfX0dGUF9OT1dBUk4sIHZtYSwgYWRkcik7CisJaWYgKCFkc3Rf
cGFnZSkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlpZiAobWVtX2Nncm91cF9jaGFyZ2UoZHN0X3Bh
Z2UsIGRzdF9tbSwgR0ZQX0FUT01JQykpIHsKKwkJcHV0X3BhZ2UoZHN0X3BhZ2UpOworCQlyZXR1
cm4gLUVOT01FTTsKKwl9CisJY2dyb3VwX3Rocm90dGxlX3N3YXByYXRlKGRzdF9wYWdlLCBHRlBf
QVRPTUlDKTsKKwlfX1NldFBhZ2VVcHRvZGF0ZShkc3RfcGFnZSk7CisKKwljb3B5X3VzZXJfaGln
aHBhZ2UoZHN0X3BhZ2UsIHNyY19wYWdlLCBhZGRyLCB2bWEpOworCSpkc3RfcHRlID0gbWtfcHRl
KGRzdF9wYWdlLCB2bWEtPnZtX3BhZ2VfcHJvdCk7CisKKwkvKgorCSAqIE5PVEUhIFRoaXMgdXNl
cyB0aGUgd3Jvbmcgdm1hIGFnYWluLCBidXQgdGhlIG9ubHkgdGhpbmcKKwkgKiB0aGF0IG1hdHRl
cnMgYXJlIHRoZSB2bWEgZmxhZ3MgYW5kIGFub25fdm1hLCB3aGljaCBhcmUKKwkgKiB0aGUgc2Ft
ZSBmb3Igc291cmNlIGFuZCBkZXN0aW5hdGlvbi4KKwkgKi8KKwlwYWdlX2FkZF9uZXdfYW5vbl9y
bWFwKGRzdF9wYWdlLCB2bWEsIGFkZHIsIGZhbHNlKTsKKwlscnVfY2FjaGVfYWRkX2luYWN0aXZl
X29yX3VuZXZpY3RhYmxlKGRzdF9wYWdlLCB2bWEpOworCXJzc1ttbV9jb3VudGVyKGRzdF9wYWdl
KV0rKzsKKworCS8qCisJICogRmluYWwgbm90ZTogbWFrZSB0aGUgc291cmNlIHdyaXRhYmxlIGFn
YWluLiBUaGUgZmFjdCB0aGF0CisJICogaXQgd2FzIHVud3JpdGFibGUgbWVhbnMgdGhhdCB3ZSBk
aWRuJ3QgcmFjZSB3aXRoIGFueSBuZXcKKwkgKiBQSU4gZXZlbnRzIHVzaW5nIGZhc3QtR1VQLCBh
bmQgd2UndmUgaGVsZCBvbiB0byB0aGUgcGFnZQorCSAqIHRhYmxlIGxvY2sgdGhlIHdob2xlIHRp
bWUgc28gaXQncyBzYWZlIHRvIGp1c3QgbWFrZSBpdAorCSAqIHdyaXRhYmxlIGFnYWluIGhlcmUu
CisJICoKKwkgKiBXZSBtaWdodCByYWNlIHdpdGggaGFyZHdhcmUgd2Fsa2VycywgYnV0IHRoZSBk
aXJ0eSBiaXQKKwkgKiB3YXMgYWxyZWFkeSBzZXQsIHNvIG5vIGZlYXIgb2YgbG9zaW5nIGEgcmFj
ZSB3aXRoIGEgaHcKKwkgKiB3YWxrZXIgdGhhdCBzZXRzIHRoYXQuCisJICovCisJaWYgKHZtYS0+
dm1fZmxhZ3MgJiBWTV9XUklURSkKKwkJKnNyY19wdGUgPSBwdGVfbWt3cml0ZSgqc3JjX3B0ZSk7
CisKKwlyZXR1cm4gMDsKKworcmV1c2VfcGFnZToKKwlnZXRfcGFnZShzcmNfcGFnZSk7CisJcGFn
ZV9kdXBfcm1hcChzcmNfcGFnZSwgZmFsc2UpOworCXJzc1ttbV9jb3VudGVyKHNyY19wYWdlKV0r
KzsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlubGluZSBpbnQKIGNvcHlfcHJlc2VudF9wdGUo
c3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJCXB0
ZV90ICpkc3RfcHRlLCBwdGVfdCAqc3JjX3B0ZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
CiAJCXVuc2lnbmVkIGxvbmcgYWRkciwgaW50ICpyc3MpCkBAIC04MDksMTIgKzkxNywxNSBAQCBj
b3B5X3ByZXNlbnRfcHRlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVj
dCAqc3JjX21tLAogCiAJcGFnZSA9IHZtX25vcm1hbF9wYWdlKHZtYSwgYWRkciwgcHRlKTsKIAlp
ZiAocGFnZSkgewotCQlnZXRfcGFnZShwYWdlKTsKLQkJcGFnZV9kdXBfcm1hcChwYWdlLCBmYWxz
ZSk7Ci0JCXJzc1ttbV9jb3VudGVyKHBhZ2UpXSsrOworCQlpbnQgZXJyb3I7CisKKwkJZXJyb3Ig
PSBjb3B5X25vcm1hbF9wYWdlKHZtYSwgYWRkciwgc3JjX21tLCBkc3RfbW0sIHNyY19wdGUsICZw
dGUsIHBhZ2UsIHJzcyk7CisJCWlmIChlcnJvcikKKwkJCXJldHVybiBlcnJvcjsKIAl9CiAKIAlz
ZXRfcHRlX2F0KGRzdF9tbSwgYWRkciwgZHN0X3B0ZSwgcHRlKTsKKwlyZXR1cm4gMDsKIH0KIAog
c3RhdGljIGludCBjb3B5X3B0ZV9yYW5nZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0sIHN0cnVj
dCBtbV9zdHJ1Y3QgKnNyY19tbSwKQEAgLTgyNCw3ICs5MzUsNyBAQCBzdGF0aWMgaW50IGNvcHlf
cHRlX3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3Jj
X21tLAogCXB0ZV90ICpvcmlnX3NyY19wdGUsICpvcmlnX2RzdF9wdGU7CiAJcHRlX3QgKnNyY19w
dGUsICpkc3RfcHRlOwogCXNwaW5sb2NrX3QgKnNyY19wdGwsICpkc3RfcHRsOwotCWludCBwcm9n
cmVzcyA9IDA7CisJaW50IHByb2dyZXNzID0gMCwgZXJyb3IgPSAwOwogCWludCByc3NbTlJfTU1f
Q09VTlRFUlNdOwogCXN3cF9lbnRyeV90IGVudHJ5ID0gKHN3cF9lbnRyeV90KXswfTsKIApAQCAt
ODY1LDggKzk3NiwxMCBAQCBzdGF0aWMgaW50IGNvcHlfcHRlX3JhbmdlKHN0cnVjdCBtbV9zdHJ1
Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVjdCAqc3JjX21tLAogCQkJcHJvZ3Jlc3MgKz0gODsK
IAkJCWNvbnRpbnVlOwogCQl9Ci0JCWNvcHlfcHJlc2VudF9wdGUoZHN0X21tLCBzcmNfbW0sIGRz
dF9wdGUsIHNyY19wdGUsCisJCWVycm9yID0gY29weV9wcmVzZW50X3B0ZShkc3RfbW0sIHNyY19t
bSwgZHN0X3B0ZSwgc3JjX3B0ZSwKIAkJCQkgdm1hLCBhZGRyLCByc3MpOworCQlpZiAoZXJyb3Ip
CisJCQlicmVhazsKIAkJcHJvZ3Jlc3MgKz0gODsKIAl9IHdoaWxlIChkc3RfcHRlKyssIHNyY19w
dGUrKywgYWRkciArPSBQQUdFX1NJWkUsIGFkZHIgIT0gZW5kKTsKIApAQCAtODc3LDYgKzk5MCw5
IEBAIHN0YXRpYyBpbnQgY29weV9wdGVfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqZHN0X21tLCBz
dHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJcHRlX3VubWFwX3VubG9jayhvcmlnX2RzdF9wdGUs
IGRzdF9wdGwpOwogCWNvbmRfcmVzY2hlZCgpOwogCisJaWYgKGVycm9yKQorCQlyZXR1cm4gZXJy
b3I7CisKIAlpZiAoZW50cnkudmFsKSB7CiAJCWlmIChhZGRfc3dhcF9jb3VudF9jb250aW51YXRp
b24oZW50cnksIEdGUF9LRVJORUwpIDwgMCkKIAkJCXJldHVybiAtRU5PTUVNOwo=
--0000000000008af20a05b029b3f2--

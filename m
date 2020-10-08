Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC6287A81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgJHRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgJHRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:03:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91622C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:03:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a23so5747556ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HnkrkgfxXwwWT8ss7RwMmEpIzbYLcseAwgIbkR5olg=;
        b=Pr37Vkqlz1xNBMlcKSqc44JuHcizUfj8LYo2/YkTOXcK5w5LPfBExAQSaa61+gHvUJ
         BpJypLE0KW7sRHD3xT20EEJ/kf/FbCkBbXoOQ3qTO+R9W6ETIIGPxtV9po7vSCNF0WHW
         XF2QZkukVaYQunpEagpECWZPy2+Saqhj4dV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HnkrkgfxXwwWT8ss7RwMmEpIzbYLcseAwgIbkR5olg=;
        b=VfXhKWF7TLMHN5mBjNV8liRGZ9j/Ht+FljGHCHLovWYWBxjY82BAaHX/cRTc9Sr8G7
         q+JGnTzhZyDY0GD2h68e92IBU4SoKGAidFYpQrkpXIsXjaZMclogsX73+XNXFX1CnNLn
         TrKU/1+POh5K8AjFKRFXRKpej2Sghl1shSJOqdW9z69YZ2EDoG++ayDBpZ/zxtPCPYaf
         rE0pp3u8At9QKDDXUuJYf/fAW0UXwol5/kZQlx1SZr1asVRCioUY8oY+sFk8j1PdK4ZH
         T4S8af8bgxO3fPVwuwsV8Q4Otd8+mYbkn+nuQeW446I9ACTi0KuP7Q709Xo0zfHUv72m
         pxEA==
X-Gm-Message-State: AOAM530Tk2eQhtuYiq0gWCfR+VI42GaUax49+57BhDKmypGGMff4pswQ
        QjBHF+mGalxNm6k2myl5AvFNYfS7ezv+rw==
X-Google-Smtp-Source: ABdhPJzL6wIz4bLjctp/+llDXJWAC3FxqS2W3Mp3mpENOI4GpkZy/VhqH7FQKvfTjQjedzD03znF8g==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr3405845lji.247.1602176581259;
        Thu, 08 Oct 2020 10:03:01 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u14sm1046660ljg.50.2020.10.08.10.02.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:03:00 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w11so7346580lfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:02:59 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr3302044lfg.603.1602176579161;
 Thu, 08 Oct 2020 10:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201008092627.399131-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20201008092627.399131-1-aneesh.kumar@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Oct 2020 10:02:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
Message-ID: <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Fetch the dirty bit before we reset the pte
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Content-Type: multipart/mixed; boundary="000000000000deeb1a05b12bcd0b"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000deeb1a05b12bcd0b
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2020 at 2:27 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> In copy_present_page, after we mark the pte non-writable, we should
> check for previous dirty bit updates and make sure we don't lose the dirty
> bit on reset.

No, we'll just remove that entirely.

Do you have a test-case that shows a problem? I have a patch that I
was going to delay until 5.10 because I didn't think it mattered in
practice..

The second part of this patch would be to add a sequence count
protection to fast-GUP pinning, so that GUP and fork() couldn't race,
but I haven't written that part.

Here's the first patch anyway. If you actually have a test-case where
this matters, I guess I need to apply it now..

                   Linus

--000000000000deeb1a05b12bcd0b
Content-Type: application/octet-stream; name=fork-cleanup
Content-Disposition: attachment; filename=fork-cleanup
Content-Transfer-Encoding: base64
Content-ID: <f_kg12k1ge0>
X-Attachment-Id: f_kg12k1ge0

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
--000000000000deeb1a05b12bcd0b--

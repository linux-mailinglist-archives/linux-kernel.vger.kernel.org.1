Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368C42F04AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAJBUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 20:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 20:20:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F4C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 17:20:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b26so32351247lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0DYh8R0owREjUF0rW5MfN/Je7rGC/Z6PzqB2A/sjLU=;
        b=XMHZ4hzJ1KNIJdjirbYY7rn4bf/WGrGFrNvC0Oc7tHmzgtnGZSAb9fcI7GCEG3NK7U
         ZpNccWHn+HG7I1P55LoqodGQk4Yyv0xPbnZIYecEcJJgaAbMVZrWg9/uQgSCNwQg+X87
         Qe0r8A6ELy7+wBwCuVGrMSbtiopg6PL3G+OkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0DYh8R0owREjUF0rW5MfN/Je7rGC/Z6PzqB2A/sjLU=;
        b=qpj1s4KG3aNIYjSaA1Ycry+FEo0Ih1IFksaeRH9qkKAgUCoMG3hK9WN7LArFV7ZM/J
         juTX57boF+96Va+tAsMkxmKOFchZaHWIcpcDlQ4KKs4mWRGhkysnSSYKIS+s67Sqq3BB
         7E9aLp407V8OBnXNVTtMTpw4oEpdtt0JamFt6hFev2wAnvFBpwXIhttNzdI2iBwkogiI
         98VfFoscfIzqtF4nVSgEmptSD+usK2JWdZzepZB5uLBhjlkRFS4aoQJ93hFxkE423/rL
         mxj2hNwqyxGQOJaihDkEIzywhS3sMI9GbAnb5H4AroXVKNRVjRdjOG8T2C60l376R74O
         HLYQ==
X-Gm-Message-State: AOAM531RZdXlflvOEApFZUuLyxZvaFemRumJlZA9OleScZRJ2yMW6Z8k
        47wAnkoDEWe59IHTVfHdGJCrOwUNlIzwVw==
X-Google-Smtp-Source: ABdhPJyM1A5JJjVQlZWffM2r+RHjICk81goMna/B9njUszvDK8jSGFt4W0e9AcQg6Iw1XU0Hy80IPw==
X-Received: by 2002:a2e:7102:: with SMTP id m2mr4743127ljc.245.1610241610373;
        Sat, 09 Jan 2021 17:20:10 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w6sm2804891lji.74.2021.01.09.17.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 17:20:08 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id h205so32365113lfd.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:20:07 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr4287325ljm.507.1610241607590;
 Sat, 09 Jan 2021 17:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
In-Reply-To: <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 17:19:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
Message-ID: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: multipart/mixed; boundary="00000000000006197605b88197b9"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000006197605b88197b9
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 9, 2021 at 4:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What part of "clear_refs is the _least_ important of the three cases"
> are you not willing to understand?

In fact, I couldn't even turn on that code with my normal config,
because it depends on CONFIG_CHECKPOINT_RESTORE that I didn't even
have enabled.

IOW, that code is some special-case stuff, and instead of messing up
the rest of the VM, it should be made to conform to all the normal VM
rules and requirements.

Here's two patches to basically start doing that.

The first one is the same one I already sent out earlier, fixing the
locking. And yes, it can be improved upon, but before improving on it,
let's _fix_ the code.

The second is a trivial "oh, look, I can see that the page is pinned,
soft-dirty cannot work so don't do it then". Again, it can be improved
upon, most particularly by doing the same (simple) tests for the
hugepage case too, which I didn't do.

Note: I have not a single actual user of this code that I can test
with, so this is all ENTIRELY untested.

IOW, I am in no way claiming that these patches are perfect and
correct, and the only way to do things.

But what I _am_ claiming is that this clear_refs code (and the UFFD
code) is of secondary importance, and instead of messing up the core
VM, we should fix these special cases to not do bad things.

It really is that simple.

And no, I didn't make the UFFDIO_WRITEPROTECT code take the mmap_sem
for writing. For whoever wants to look at that, it's
mwriteprotect_range() in mm/userfaultfd.c and the fix is literally to
turn the read-lock (and unlock) into a write-lock (and unlock).

           Linus

--00000000000006197605b88197b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-fix-clear_refs_write-locking.patch"
Content-Disposition: attachment; 
	filename="0001-mm-fix-clear_refs_write-locking.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kjqg91vp0>
X-Attachment-Id: f_kjqg91vp0

RnJvbSBkYWNiNWRlNjJiNjU0ZjFmNWRmMTE0N2UyNjNiNWI0ZTVmZTJhZjQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgOCBKYW4gMjAyMSAxMzoxMzo0MSAtMDgwMApTdWJqZWN0OiBb
UEFUQ0ggMS8yXSBtbTogZml4IGNsZWFyX3JlZnNfd3JpdGUgbG9ja2luZwoKVHVybmluZyBwYWdl
IHRhYmxlIGVudHJpZXMgcmVhZC1vbmx5IHJlcXVpcmVzIHRoZSBtbWFwX3NlbSBoZWxkIGZvcgp3
cml0aW5nLgoKU28gc3RvcCBkb2luZyB0aGUgb2RkIGdhbWVzIHdpdGggdHVybmluZyB0aGluZ3Mg
ZnJvbSByZWFkIGxvY2tzIHRvIHdyaXRlCmxvY2tzIGFuZCBiYWNrLiAgSnVzdCBnZXQgdGhlIHdy
aXRlIGxvY2suCgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgt
Zm91bmRhdGlvbi5vcmc+Ci0tLQogZnMvcHJvYy90YXNrX21tdS5jIHwgMzIgKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3Byb2MvdGFza19tbXUuYyBiL2ZzL3Byb2Mv
dGFza19tbXUuYwppbmRleCBlZTVhMjM1YjMwNTYuLmFiN2Q3MDBiMmNhYSAxMDA2NDQKLS0tIGEv
ZnMvcHJvYy90YXNrX21tdS5jCisrKyBiL2ZzL3Byb2MvdGFza19tbXUuYwpAQCAtMTIxNSw0MSAr
MTIxNSwyNiBAQCBzdGF0aWMgc3NpemVfdCBjbGVhcl9yZWZzX3dyaXRlKHN0cnVjdCBmaWxlICpm
aWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLAogCQkJLnR5cGUgPSB0eXBlLAogCQl9OwogCisJ
CWlmIChtbWFwX3dyaXRlX2xvY2tfa2lsbGFibGUobW0pKSB7CisJCQljb3VudCA9IC1FSU5UUjsK
KwkJCWdvdG8gb3V0X21tOworCQl9CiAJCWlmICh0eXBlID09IENMRUFSX1JFRlNfTU1fSElXQVRF
Ul9SU1MpIHsKLQkJCWlmIChtbWFwX3dyaXRlX2xvY2tfa2lsbGFibGUobW0pKSB7Ci0JCQkJY291
bnQgPSAtRUlOVFI7Ci0JCQkJZ290byBvdXRfbW07Ci0JCQl9Ci0KIAkJCS8qCiAJCQkgKiBXcml0
aW5nIDUgdG8gL3Byb2MvcGlkL2NsZWFyX3JlZnMgcmVzZXRzIHRoZSBwZWFrCiAJCQkgKiByZXNp
ZGVudCBzZXQgc2l6ZSB0byB0aGlzIG1tJ3MgY3VycmVudCByc3MgdmFsdWUuCiAJCQkgKi8KIAkJ
CXJlc2V0X21tX2hpd2F0ZXJfcnNzKG1tKTsKLQkJCW1tYXBfd3JpdGVfdW5sb2NrKG1tKTsKLQkJ
CWdvdG8gb3V0X21tOworCQkJZ290byBvdXRfdW5sb2NrOwogCQl9CiAKLQkJaWYgKG1tYXBfcmVh
ZF9sb2NrX2tpbGxhYmxlKG1tKSkgewotCQkJY291bnQgPSAtRUlOVFI7Ci0JCQlnb3RvIG91dF9t
bTsKLQkJfQogCQl0bGJfZ2F0aGVyX21tdSgmdGxiLCBtbSwgMCwgLTEpOwogCQlpZiAodHlwZSA9
PSBDTEVBUl9SRUZTX1NPRlRfRElSVFkpIHsKIAkJCWZvciAodm1hID0gbW0tPm1tYXA7IHZtYTsg
dm1hID0gdm1hLT52bV9uZXh0KSB7CiAJCQkJaWYgKCEodm1hLT52bV9mbGFncyAmIFZNX1NPRlRE
SVJUWSkpCiAJCQkJCWNvbnRpbnVlOwotCQkJCW1tYXBfcmVhZF91bmxvY2sobW0pOwotCQkJCWlm
IChtbWFwX3dyaXRlX2xvY2tfa2lsbGFibGUobW0pKSB7Ci0JCQkJCWNvdW50ID0gLUVJTlRSOwot
CQkJCQlnb3RvIG91dF9tbTsKLQkJCQl9Ci0JCQkJZm9yICh2bWEgPSBtbS0+bW1hcDsgdm1hOyB2
bWEgPSB2bWEtPnZtX25leHQpIHsKLQkJCQkJdm1hLT52bV9mbGFncyAmPSB+Vk1fU09GVERJUlRZ
OwotCQkJCQl2bWFfc2V0X3BhZ2VfcHJvdCh2bWEpOwotCQkJCX0KLQkJCQltbWFwX3dyaXRlX2Rv
d25ncmFkZShtbSk7Ci0JCQkJYnJlYWs7CisJCQkJdm1hLT52bV9mbGFncyAmPSB+Vk1fU09GVERJ
UlRZOworCQkJCXZtYV9zZXRfcGFnZV9wcm90KHZtYSk7CiAJCQl9CiAKIAkJCW1tdV9ub3RpZmll
cl9yYW5nZV9pbml0KCZyYW5nZSwgTU1VX05PVElGWV9TT0ZUX0RJUlRZLApAQCAtMTI2MSw3ICsx
MjQ2LDggQEAgc3RhdGljIHNzaXplX3QgY2xlYXJfcmVmc193cml0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJaWYgKHR5cGUgPT0gQ0xFQVJfUkVGU19TT0ZU
X0RJUlRZKQogCQkJbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kKCZyYW5nZSk7CiAJ
CXRsYl9maW5pc2hfbW11KCZ0bGIsIDAsIC0xKTsKLQkJbW1hcF9yZWFkX3VubG9jayhtbSk7Citv
dXRfdW5sb2NrOgorCQltbWFwX3dyaXRlX3VubG9jayhtbSk7CiBvdXRfbW06CiAJCW1tcHV0KG1t
KTsKIAl9Ci0tIAoyLjI5LjIuMTU3LmcxZDQ3NzkxYTM5Cgo=
--00000000000006197605b88197b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-mm-don-t-play-games-with-pinned-pages-in-clear_page_.patch"
Content-Disposition: attachment; 
	filename="0002-mm-don-t-play-games-with-pinned-pages-in-clear_page_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kjqg955v1>
X-Attachment-Id: f_kjqg955v1

RnJvbSBiNDA5NTBiNjQ3NTA5ZjcyMjJlMWY3MTc0ZDYxMDQ1ZDE1ZjU2ZjFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgOSBKYW4gMjAyMSAxNzowOToxMCAtMDgwMApTdWJqZWN0OiBb
UEFUQ0ggMi8yXSBtbTogZG9uJ3QgcGxheSBnYW1lcyB3aXRoIHBpbm5lZCBwYWdlcyBpbiBjbGVh
cl9wYWdlX3JlZnMKClR1cm5pZ24gYSBwaW5uZWQgcGFnZSByZWFkLW9ubHkgYnJlYWtzIHRoZSBw
aW5uaW5nIGFmdGVyIENPVy4gRG9uJ3QgZG8gaXQuCgpUaGUgd2hvbGUgInRyYWNrIHBhZ2Ugc29m
dCBkaXJ0eSIgc3RhdGUgZG9lc24ndCB3b3JrIHdpdGggcGlubmVkIHBhZ2VzCmFueXdheSwgc2lu
Y2UgdGhlIHBhZ2UgbWlnaHQgYmUgZGlydGllZCBieSB0aGUgcGlubmluZyBlbnRpdHkgd2l0aG91
dApldmVyIGJlaW5nIG5vdGljZWQgaW4gdGhlIHBhZ2UgdGFibGVzLgoKU2lnbmVkLW9mZi1ieTog
TGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGZzL3By
b2MvdGFza19tbXUuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9w
cm9jL3Rhc2tfbW11LmMKaW5kZXggYWI3ZDcwMGIyY2FhLi4wMzc3MDgxMDIxYjcgMTAwNjQ0Ci0t
LSBhL2ZzL3Byb2MvdGFza19tbXUuYworKysgYi9mcy9wcm9jL3Rhc2tfbW11LmMKQEAgLTEwMzUs
NiArMTAzNSwyNSBAQCBzdHJ1Y3QgY2xlYXJfcmVmc19wcml2YXRlIHsKIH07CiAKICNpZmRlZiBD
T05GSUdfTUVNX1NPRlRfRElSVFkKKworI2RlZmluZSBpc19jb3dfbWFwcGluZyhmbGFncykgKCgo
ZmxhZ3MpICYgKFZNX1NIQVJFRCB8IFZNX01BWVdSSVRFKSkgPT0gVk1fTUFZV1JJVEUpCisKK3N0
YXRpYyBpbmxpbmUgYm9vbCBwdGVfaXNfcGlubmVkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LCB1bnNpZ25lZCBsb25nIGFkZHIsIHB0ZV90IHB0ZSkKK3sKKwlzdHJ1Y3QgcGFnZSAqcGFnZTsK
KworCWlmICghaXNfY293X21hcHBpbmcodm1hLT52bV9mbGFncykpCisJCXJldHVybiBmYWxzZTsK
KwlpZiAobGlrZWx5KCFhdG9taWNfcmVhZCgmdm1hLT52bV9tbS0+aGFzX3Bpbm5lZCkpKQorCQly
ZXR1cm4gZmFsc2U7CisJcGFnZSA9IHZtX25vcm1hbF9wYWdlKHZtYSwgYWRkciwgcHRlKTsKKwlp
ZiAoIXBhZ2UpCisJCXJldHVybiBmYWxzZTsKKwlpZiAocGFnZV9tYXBjb3VudChwYWdlKSAhPSAx
KQorCQlyZXR1cm4gZmFsc2U7CisJcmV0dXJuIHBhZ2VfbWF5YmVfZG1hX3Bpbm5lZChwYWdlKTsK
K30KKwogc3RhdGljIGlubGluZSB2b2lkIGNsZWFyX3NvZnRfZGlydHkoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsCiAJCXVuc2lnbmVkIGxvbmcgYWRkciwgcHRlX3QgKnB0ZSkKIHsKQEAgLTEw
NDksNiArMTA2OCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjbGVhcl9zb2Z0X2RpcnR5KHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCWlmIChwdGVfcHJlc2VudChwdGVudCkpIHsKIAkJcHRl
X3Qgb2xkX3B0ZTsKIAorCQlpZiAocHRlX2lzX3Bpbm5lZCh2bWEsIGFkZHIsIHB0ZW50KSkKKwkJ
CXJldHVybjsKIAkJb2xkX3B0ZSA9IHB0ZXBfbW9kaWZ5X3Byb3Rfc3RhcnQodm1hLCBhZGRyLCBw
dGUpOwogCQlwdGVudCA9IHB0ZV93cnByb3RlY3Qob2xkX3B0ZSk7CiAJCXB0ZW50ID0gcHRlX2Ns
ZWFyX3NvZnRfZGlydHkocHRlbnQpOwotLSAKMi4yOS4yLjE1Ny5nMWQ0Nzc5MWEzOQoK
--00000000000006197605b88197b9--

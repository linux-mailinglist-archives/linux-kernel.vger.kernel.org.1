Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2A287B01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgJHRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbgJHRau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:30:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890BC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:30:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j22so1902553lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0r6hs94To3WnkkAO44dD5WsBrttflbyFzF64gAf7oOc=;
        b=e6YulghKmU2zbj8oKL6vbX/nL87I35BsKkEYWcuZH7T+d/AX9OaAN3D9jG63KOw2L4
         ADpXCUvcjyw+baQIDFxhMRcPcdnFPVKVLKoHXnWEEw3krz9/seeOnSrf8moXkwtHbnjh
         vldct/l7Bf3WG6cp0AqoGhKopct1dBy4/7QLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0r6hs94To3WnkkAO44dD5WsBrttflbyFzF64gAf7oOc=;
        b=Ks5bCmx4wHeLIXiehg9S8Zps2DLMdtWwSaxxg2rG1hbcw+lRhQZC/SOYvbej4ACpIU
         eTJCNEktoWBEZQZv8cAdvRhxui3Rk3CJjSRqz9OfA8a9yYalfeAf7vJ208QHUs7sGJK9
         ueOvtkCfueLQsR1Vnm+XRRAU6ROJtyGXdgoNFSH5X9X6vt9QbZPd+R/Igt8OQB6PO9Un
         Ci5nThcz+OSNUjGJEDlWBwTqNoUQAn6/YHyKK+gAQyGClYQ9JENF7apujBb0/D5xbHay
         cRzAW5mxzsDFRDDUdGR2PQuzHV2CTm+prGuQlen4SynFCKvESgXG+0NzM09JfH5vPgbP
         yKLw==
X-Gm-Message-State: AOAM531SSfVATYInwewXjmHLKmKTfy6auCs6vIkuIUg0sy9d3fuNdisR
        cDLaMtWtxQFl0rxRU7YiT5XF9gBLouAdxA==
X-Google-Smtp-Source: ABdhPJxo5mbs2u8BGqHM3GpAIWQB7NHqSqO+fYjegT5vr2LMdr+4rPN5LzUqZF4CXGN2OAT+TuSJ1g==
X-Received: by 2002:a05:6512:5c1:: with SMTP id o1mr1572874lfo.286.1602178248424;
        Thu, 08 Oct 2020 10:30:48 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n3sm970054lfq.274.2020.10.08.10.30.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:30:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c141so809271lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:30:46 -0700 (PDT)
X-Received: by 2002:a19:2d5:: with SMTP id 204mr1648128lfc.352.1602178246305;
 Thu, 08 Oct 2020 10:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201008092627.399131-1-aneesh.kumar@linux.ibm.com> <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
In-Reply-To: <CAHk-=whwY0WT046fqM-zdHu9vamUjgkvmd36gCd4qSaeYy98nA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Oct 2020 10:30:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whihCy1qxihM=vVDO0aPx0vFP3wTxizLwtbQSYCr1sZjw@mail.gmail.com>
Message-ID: <CAHk-=whihCy1qxihM=vVDO0aPx0vFP3wTxizLwtbQSYCr1sZjw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Fetch the dirty bit before we reset the pte
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>
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
Content-Type: multipart/mixed; boundary="0000000000003d1e2b05b12c3107"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003d1e2b05b12c3107
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2020 at 10:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's the first patch anyway. If you actually have a test-case where
> this matters, I guess I need to apply it now..

Actually, I removed the "__page_mapcount()" part of that patch, to
keep it minimal and _only_ do remove the wrprotect trick.

We can do the __page_mapcount() optimization and the mm sequence count
for 5.10 (although so far nobody has actually written the seqcount
patch - I think it would be a trivial few-liner, but I guess it won't
make 5.10 at this point).

So here's what I ended up with.

                      Linus

--0000000000003d1e2b05b12c3107
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-avoid-early-COW-write-protect-games-during-fork.patch"
Content-Disposition: attachment; 
	filename="0001-mm-avoid-early-COW-write-protect-games-during-fork.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kg13jquu0>
X-Attachment-Id: f_kg13jquu0

RnJvbSBmM2M2NGVkYTNlNTA5N2VjMzE5OGNiMjcxZjVmNTA0ZDY1ZDY3MTMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IE1vbiwgMjggU2VwIDIwMjAgMTI6NTA6MDMgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBtbTogYXZvaWQgZWFybHkgQ09XIHdyaXRlIHByb3RlY3QgZ2FtZXMgZHVyaW5nIGZv
cmsoKQoKSW4gY29tbWl0IDcwZTgwNmU0ZTY0NSAoIm1tOiBEbyBlYXJseSBjb3cgZm9yIHBpbm5l
ZCBwYWdlcyBkdXJpbmcgZm9yaygpCmZvciBwdGVzIikgd2Ugd3JpdGUtcHJvdGVjdGVkIHRoZSBQ
VEUgYmVmb3JlIGRvaW5nIHRoZSBwYWdlIHBpbm5pbmcKY2hlY2ssIGluIG9yZGVyIHRvIGF2b2lk
IGEgcmFjZSB3aXRoIGNvbmN1cnJlbnQgZmFzdC1HVVAgcGlubmluZyAod2hpY2gKZG9lc24ndCB0
YWtlIHRoZSBtbSBzZW1hcGhvcmUgb3IgdGhlIHBhZ2UgdGFibGUgbG9jaykuCgpUaGF0IHRyaWNr
IGRvZXNuJ3QgYWN0dWFsbHkgd29yayAtIGl0IGRvZXNuJ3QgaGFuZGxlIG1lbW9yeSBvcmRlcmlu
Zwpwcm9wZXJseSwgYW5kIGRvaW5nIHNvIHdvdWxkIGJlIHByb2hpYml0aXZlbHkgZXhwZW5zaXZl
LgoKSXQgYWxzbyBpc24ndCByZWFsbHkgbmVlZGVkLiAgV2hpbGUgd2UncmUgbW92aW5nIGluIHRo
ZSBkaXJlY3Rpb24gb2YKYWxsb3dpbmcgYW5kIHN1cHBvcnRpbmcgcGFnZSBwaW5uaW5nIHdpdGhv
dXQgbWFya2luZyB0aGUgcGlubmVkIGFyZWEKd2l0aCBNQURWX0RPTlRGT1JLLCB0aGUgZmFjdCBp
cyB0aGF0IHdlJ3ZlIG5ldmVyIHJlYWxseSBzdXBwb3J0ZWQgdGhpcwpraW5kIG9mIG9kZCAiY29u
Y3VycmVudCBmb3JrKCkgYW5kIHBhZ2UgcGlubmluZyIsIGFuZCBkb2luZyB0aGUKc2VyaWFsaXph
dGlvbiBvbiBhIHB0ZSBsZXZlbCBpcyBqdXN0IHdyb25nLgoKV2UgY2FuIGFkZCBzZXJpYWxpemF0
aW9uIHdpdGggYSBwZXItbW0gc2VxdWVuY2UgY291bnRlciwgc28gd2Uga25vdyBob3cKdG8gc29s
dmUgdGhhdCByYWNlIHByb3Blcmx5LCBidXQgd2UnbGwgZG8gdGhhdCBhdCBhIG1vcmUgYXBwcm9w
cmlhdGUKdGltZS4gIFJpZ2h0IG5vdyB0aGlzIGp1c3QgcmVtb3ZlcyB0aGUgd3JpdGUgcHJvdGVj
dCBnYW1lcy4KCkl0IGFsc28gdHVybnMgb3V0IHRoYXQgdGhlIHdyaXRlIHByb3RlY3QgZ2FtZXMg
YWN0dWFsbHkgYnJlYWsgb24gUG93ZXIsCmFzIHJlcG9ydGVkIGJ5IEFuZWVzaCBLdW1hcjoKCiAi
QXJjaGl0ZWN0dXJlIGxpa2UgcHBjNjQgZXhwZWN0cyBzZXRfcHRlX2F0IHRvIGJlIG5vdCB1c2Vk
IGZvciB1cGRhdGluZwogIGEgdmFsaWQgcHRlLiBUaGlzIGlzIGZ1cnRoZXIgZXhwbGFpbmVkIGlu
IGNvbW1pdCA1NmVlY2RiOTEyYjUgKCJtbToKICBVc2UgcHRlcC9wbWRwX3NldF9udW1hKCkgZm9y
IHVwZGF0aW5nIF9QQUdFX05VTUEgYml0IikiCgphbmQgdGhlIGNvZGUgdHJpZ2dlcmVkIGEgd2Fy
bmluZyB0aGVyZToKCiAgV0FSTklORzogQ1BVOiAwIFBJRDogMzA2MTMgYXQgYXJjaC9wb3dlcnBj
L21tL3BndGFibGUuYzoxODUgc2V0X3B0ZV9hdCsweDJhOC8weDNhMCBhcmNoL3Bvd2VycGMvbW0v
cGd0YWJsZS5jOjE4NQogIENhbGwgVHJhY2U6CiAgICBjb3B5X3ByZXNlbnRfcGFnZSBtbS9tZW1v
cnkuYzo4NTcgW2lubGluZV0KICAgIGNvcHlfcHJlc2VudF9wdGUgbW0vbWVtb3J5LmM6ODk5IFtp
bmxpbmVdCiAgICBjb3B5X3B0ZV9yYW5nZSBtbS9tZW1vcnkuYzoxMDE0IFtpbmxpbmVdCiAgICBj
b3B5X3BtZF9yYW5nZSBtbS9tZW1vcnkuYzoxMDkyIFtpbmxpbmVdCiAgICBjb3B5X3B1ZF9yYW5n
ZSBtbS9tZW1vcnkuYzoxMTI3IFtpbmxpbmVdCiAgICBjb3B5X3A0ZF9yYW5nZSBtbS9tZW1vcnku
YzoxMTUwIFtpbmxpbmVdCiAgICBjb3B5X3BhZ2VfcmFuZ2UrMHgxZjZjLzB4MmNjMCBtbS9tZW1v
cnkuYzoxMjEyCiAgICBkdXBfbW1hcCBrZXJuZWwvZm9yay5jOjU5MiBbaW5saW5lXQogICAgZHVw
X21tKzB4NzdjLzB4YWIwIGtlcm5lbC9mb3JrLmM6MTM1NQogICAgY29weV9tbSBrZXJuZWwvZm9y
ay5jOjE0MTEgW2lubGluZV0KICAgIGNvcHlfcHJvY2VzcysweDFmMDAvMHgyNzQwIGtlcm5lbC9m
b3JrLmM6MjA3MAogICAgX2RvX2ZvcmsrMHhjNC8weDEwYjAga2VybmVsL2ZvcmsuYzoyNDI5CgpM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBSGstPXdpV3IrZ08wUm80THZuSkJN
czkwT2llUE55ckUzRStwSnZjOVB6ZEJTaGRtd0BtYWlsLmdtYWlsLmNvbS8KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXhwcGMtZGV2LzIwMjAxMDA4MDkyNTQxLjM5ODA3OS0xLWFu
ZWVzaC5rdW1hckBsaW51eC5pYm0uY29tLwpSZXBvcnRlZC1ieTogQW5lZXNoIEt1bWFyIEsuViA8
YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+ClRlc3RlZC1ieTogTGVvbiBSb21hbm92c2t5IDxs
ZW9ucm9AbnZpZGlhLmNvbT4KQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4KQ2M6IEph
c29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPgpDYzogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBu
dmlkaWEuY29tPgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4K
Q2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+CkNjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNl
LmNvbT4KQ2M6IEtpcmlsbCBTaHV0ZW1vdiA8a2lyaWxsQHNodXRlbW92Lm5hbWU+CkNjOiBIdWdo
IERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBtbS9tZW1vcnkuYyB8IDQxICsr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9tZW1vcnku
YyBiL21tL21lbW9yeS5jCmluZGV4IGZjZmM0Y2EzNmViYS4uZWVhZTU5MGU1MjZhIDEwMDY0NAot
LS0gYS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtODA2LDggKzgwNiw2IEBAIGNv
cHlfcHJlc2VudF9wYWdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdF9tbSwgc3RydWN0IG1tX3N0cnVj
dCAqc3JjX21tLAogCQlyZXR1cm4gMTsKIAogCS8qCi0JICogVGhlIHRyaWNrIHN0YXJ0cy4KLQkg
KgogCSAqIFdoYXQgd2Ugd2FudCB0byBkbyBpcyB0byBjaGVjayB3aGV0aGVyIHRoaXMgcGFnZSBt
YXkKIAkgKiBoYXZlIGJlZW4gcGlubmVkIGJ5IHRoZSBwYXJlbnQgcHJvY2Vzcy4gIElmIHNvLAog
CSAqIGluc3RlYWQgb2Ygd3Jwcm90ZWN0IHRoZSBwdGUgb24gYm90aCBzaWRlcywgd2UgY29weQpA
QCAtODE1LDQ3ICs4MTMsMTYgQEAgY29weV9wcmVzZW50X3BhZ2Uoc3RydWN0IG1tX3N0cnVjdCAq
ZHN0X21tLCBzdHJ1Y3QgbW1fc3RydWN0ICpzcmNfbW0sCiAJICogdGhlIHBpbm5lZCBwYWdlIHdv
bid0IGJlIHJhbmRvbWx5IHJlcGxhY2VkIGluIHRoZQogCSAqIGZ1dHVyZS4KIAkgKgotCSAqIFRv
IGFjaGlldmUgdGhpcywgd2UgZG8gdGhlIGZvbGxvd2luZzoKLQkgKgotCSAqIDEuIFdyaXRlLXBy
b3RlY3QgdGhlIHB0ZSBpZiBpdCdzIHdyaXRhYmxlLiAgVGhpcyBpcwotCSAqICAgIHRvIHByb3Rl
Y3QgY29uY3VycmVudCB3cml0ZSBmYXN0LWd1cCB3aXRoCi0JICogICAgRk9MTF9QSU4sIHNvIHRo
YXQgd2UnbGwgZmFpbCB0aGUgZmFzdC1ndXAgd2l0aAotCSAqICAgIHRoZSB3cml0ZSBiaXQgcmVt
b3ZlZC4KLQkgKgotCSAqIDIuIENoZWNrIHBhZ2VfbWF5YmVfZG1hX3Bpbm5lZCgpIHRvIHNlZSB3
aGV0aGVyIHRoaXMKLQkgKiAgICBwYWdlIG1heSBoYXZlIGJlZW4gcGlubmVkLgotCSAqCi0JICog
VGhlIG9yZGVyIG9mIHRoZXNlIHN0ZXBzIGlzIGltcG9ydGFudCB0byBzZXJpYWxpemUKLQkgKiBh
Z2FpbnN0IHRoZSBmYXN0LWd1cCBjb2RlIChndXBfcHRlX3JhbmdlKCkpIG9uIHRoZQotCSAqIHB0
ZSBjaGVjayBhbmQgdHJ5X2dyYWJfY29tcG91bmRfaGVhZCgpLCBzbyB0aGF0Ci0JICogd2UnbGwg
bWFrZSBzdXJlIGVpdGhlciB3ZSdsbCBjYXB0dXJlIHRoYXQgZmFzdC1ndXAKLQkgKiBzbyB3ZSds
bCBjb3B5IHRoZSBwaW5uZWQgcGFnZSBoZXJlLCBvciB3ZSdsbCBmYWlsCi0JICogdGhhdCBmYXN0
LWd1cC4KLQkgKgotCSAqIE5PVEUhIEV2ZW4gaWYgd2UgZG9uJ3QgZW5kIHVwIGNvcHlpbmcgdGhl
IHBhZ2UsCi0JICogd2Ugd29uJ3QgdW5kbyB0aGlzIHdycHJvdGVjdCgpLCBiZWNhdXNlIHRoZSBu
b3JtYWwKLQkgKiByZWZlcmVuY2UgY29weSB3aWxsIG5lZWQgaXQgYW55d2F5LgotCSAqLwotCWlm
IChwdGVfd3JpdGUocHRlKSkKLQkJcHRlcF9zZXRfd3Jwcm90ZWN0KHNyY19tbSwgYWRkciwgc3Jj
X3B0ZSk7Ci0KLQkvKgotCSAqIFRoZXNlIGFyZSB0aGUgIm5vcm1hbGx5IHdlIGNhbiBqdXN0IGNv
cHkgYnkgcmVmZXJlbmNlIgotCSAqIGNoZWNrcy4KKwkgKiBUaGUgcGFnZSBwaW5uaW5nIGNoZWNr
cyBhcmUganVzdCAiaGFzIHRoaXMgbW0gZXZlcgorCSAqIHNlZW4gcGlubmluZyIsIGFsb25nIHdp
dGggdGhlIChpbmV4YWN0KSBjaGVjayBvZgorCSAqIHRoZSBwYWdlIGNvdW50LiBUaGF0IG1pZ2h0
IGdpdmUgZmFsc2UgcG9zaXRpdmVzIGZvcgorCSAqIGZvciBwaW5uaW5nLCBidXQgaXQgd2lsbCB3
b3JrIGNvcnJlY3RseS4KIAkgKi8KIAlpZiAobGlrZWx5KCFhdG9taWNfcmVhZCgmc3JjX21tLT5o
YXNfcGlubmVkKSkpCiAJCXJldHVybiAxOwogCWlmIChsaWtlbHkoIXBhZ2VfbWF5YmVfZG1hX3Bp
bm5lZChwYWdlKSkpCiAJCXJldHVybiAxOwogCi0JLyoKLQkgKiBVaGh1aC4gSXQgbG9va3MgbGlr
ZSB0aGUgcGFnZSBtaWdodCBiZSBhIHBpbm5lZCBwYWdlLAotCSAqIGFuZCB3ZSBhY3R1YWxseSBu
ZWVkIHRvIGNvcHkgaXQuIE5vdyB3ZSBjYW4gc2V0IHRoZQotCSAqIHNvdXJjZSBwdGUgYmFjayB0
byBiZWluZyB3cml0YWJsZS4KLQkgKi8KLQlpZiAocHRlX3dyaXRlKHB0ZSkpCi0JCXNldF9wdGVf
YXQoc3JjX21tLCBhZGRyLCBzcmNfcHRlLCBwdGUpOwotCiAJbmV3X3BhZ2UgPSAqcHJlYWxsb2M7
CiAJaWYgKCFuZXdfcGFnZSkKIAkJcmV0dXJuIC1FQUdBSU47Ci0tIAoyLjI4LjAuMjE4LmdjMTJl
ZjNkMzQ5Cgo=
--0000000000003d1e2b05b12c3107--

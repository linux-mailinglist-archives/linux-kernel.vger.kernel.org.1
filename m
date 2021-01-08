Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631342EEA74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbhAHAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:34:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FDC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:33:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id dk8so9581069edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s3uIzM7CTA6cmvZ+OTc9ndGPxNgOdh/GHBwFHUd4d0=;
        b=NtGQKCBiRPOwGZjhYMZBNKKfxScocvD0Cgjdpwrr3V9rBBbI9mHruMIWYOSIzFsDE2
         tvj8vUmTNk3Abio3nYepEGipIHPZlcouWvKuBYTDC5cMYhT3hAPO0AYYIAlmw/ipxsLs
         EyItQzyrvBm3z6/Bi85h8PHp/znaj79v1JLow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s3uIzM7CTA6cmvZ+OTc9ndGPxNgOdh/GHBwFHUd4d0=;
        b=ct/YTvt6S7gJcSGSWzyktiOTPBVzYUeRLsV/NiPW7Hj+Lv7+SaqLMTwFzRPMGnX0sG
         9i09nNUwbJQnF+xI5rWLE9i4oYnL/Bb26v3cxfwuYMP6pPmaOY9a70Vvsn2W2pl7+luC
         KdwF6SUenX0BD9AeZBe1oBdAZTVftTDiypXfgzmotRSw5RC2rk/SXwOp45k+Yi4gWt7k
         IGhfIRfMxv618n85sTGyi1uddT32XukZL/tY6GKhqZEGUWZPe2C4olfz8XzBgZjNxPFd
         K5XIalsJPHaA3wFAmygJejbVf1OpDCxJY+qIXe6lbcd9UpSYpzcvqw0SbBJSdz5VUwhz
         vB/g==
X-Gm-Message-State: AOAM5336AmKurqVJqnD3AOQcWhhl3+v1JX2xc0SDy1q5GaGDs2YR6HYZ
        FFAxT27EXs3ZmIFGHGGPFhW3UVVoHJDvPA==
X-Google-Smtp-Source: ABdhPJyIB+2h6YIrWv9w+vWMimKpLu8yGJYAHdTXuPEL3HCJEc8bcrMrrbQy1lUOAYN/oA/cXe057Q==
X-Received: by 2002:aa7:d2d3:: with SMTP id k19mr3408111edr.28.1610066033666;
        Thu, 07 Jan 2021 16:33:53 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k16sm2976206ejd.78.2021.01.07.16.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 16:33:53 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id r5so9439832eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:33:53 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr66695lfc.421.1610065570184;
 Thu, 07 Jan 2021 16:26:10 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com> <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com> <X/edsWgguQDgsOtx@redhat.com>
In-Reply-To: <X/edsWgguQDgsOtx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 16:25:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
Message-ID: <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: multipart/mixed; boundary="000000000000606e9605b8589a93"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000606e9605b8589a93
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 7, 2021 at 3:48 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> > The alternate fix remains "make sure we always flush the TLB before
> > releasing the page table lock, and make COW do the copy under the page
> > table lock". But I really would prefer to just have this code follow

> The copy under PT lock isn't enough.
>
> Flush TLB before releasing is enough of course.

Right. That's why I said "and". You need both, afaik.

But if we just do the mmap write lock, you need neither - then you
just need to flush before you release the write lock.

> Note also the patch in 2/2 patch that I sent:

Yes, yes, and that's what I'm objecting to.

All these stupid games with "flush_pending(" counts are complete garbage.

They all come from the fact that this code doesn't hold the right lock.

I don't understand you: in one breath you seem to say "yes, taking the
write lock is the right thing to do", and then in the next one you
point to this patch that adds all this garbage *because* it's not
holding the write lock.

All of those "tlb_flush_pending" things are wrong. They should not
exist. The code in clear_refs_write() should hold the mmap_sem for
writing, and do the TLB flush before it releases the mmap sem, and
then it *cannot* race with the page faults.

See what I'm saying? I refuse to apply your patch 2/2, because it all
seems entirely wrong.

What's doubly ludicrous about that is that the coide already _took_
the mmap_sem for writing, and spent extra cycles to downgrade it -
INCORRECTLY - to a read-lock. And as far as I can tell, it doesn't
even do anything expensive inside that (now downgraded) region, so the
downgrading was

 (a) buggy

 (b) slower than just keeping the lock the way it had

and (b) is because it had already done the expensive part (which was
to get the lock in the first place).

Just as an example, the whole "Rollback wrprotect_tlb_flush_pending"
is all because it got the lock - again wrongly - as a read-lock
initially, then it says "oh, I need to get a write lock", releases it,
re-takes it as a write lock, does a tiny amount of work, and then -
again incorrectly - downgrades it to a read-lock.

To make it even worse (if that is possible) it actually had YET
ANOTHER case - that CLEAR_REFS_MM_HIWATER_RSS - where it took the mmap
sem for writing, did its thing, and then released it.

So there's like *four* different locking mistakes in that single
function. And it's not even an important function to begin with.

It shgould just have done a single

        mmap_write_lock_killable(mm);
        ...
        mmap_write_unlock(mm);

around the whole thing, instead of _any_ of that crazy stuff.

That code is WRONG.

And your PATCH 2/2 makes that insane code EVEN WORSE. Why the heck is
that magic fs/proc/ interface allowed to get VM internals so wrong,
and make things so much worse?

Can you not see why I'm arguing with you?

Please. Why is the correct patch not the attached one (apart from the
obvious fact that I haven't tested it and maybe just screwed up
completely - but you get the idea)?

            Linus

--000000000000606e9605b8589a93
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kjnjflab0>
X-Attachment-Id: f_kjnjflab0

IGZzL3Byb2MvdGFza19tbXUuYyB8IDMyICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9mcy9wcm9jL3Rhc2tfbW11LmMgYi9mcy9wcm9jL3Rhc2tfbW11LmMKaW5kZXggZWU1
YTIzNWIzMDU2Li5hYjdkNzAwYjJjYWEgMTAwNjQ0Ci0tLSBhL2ZzL3Byb2MvdGFza19tbXUuYwor
KysgYi9mcy9wcm9jL3Rhc2tfbW11LmMKQEAgLTEyMTUsNDEgKzEyMTUsMjYgQEAgc3RhdGljIHNz
aXplX3QgY2xlYXJfcmVmc193cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3Vz
ZXIgKmJ1ZiwKIAkJCS50eXBlID0gdHlwZSwKIAkJfTsKIAorCQlpZiAobW1hcF93cml0ZV9sb2Nr
X2tpbGxhYmxlKG1tKSkgeworCQkJY291bnQgPSAtRUlOVFI7CisJCQlnb3RvIG91dF9tbTsKKwkJ
fQogCQlpZiAodHlwZSA9PSBDTEVBUl9SRUZTX01NX0hJV0FURVJfUlNTKSB7Ci0JCQlpZiAobW1h
cF93cml0ZV9sb2NrX2tpbGxhYmxlKG1tKSkgewotCQkJCWNvdW50ID0gLUVJTlRSOwotCQkJCWdv
dG8gb3V0X21tOwotCQkJfQotCiAJCQkvKgogCQkJICogV3JpdGluZyA1IHRvIC9wcm9jL3BpZC9j
bGVhcl9yZWZzIHJlc2V0cyB0aGUgcGVhawogCQkJICogcmVzaWRlbnQgc2V0IHNpemUgdG8gdGhp
cyBtbSdzIGN1cnJlbnQgcnNzIHZhbHVlLgogCQkJICovCiAJCQlyZXNldF9tbV9oaXdhdGVyX3Jz
cyhtbSk7Ci0JCQltbWFwX3dyaXRlX3VubG9jayhtbSk7Ci0JCQlnb3RvIG91dF9tbTsKKwkJCWdv
dG8gb3V0X3VubG9jazsKIAkJfQogCi0JCWlmIChtbWFwX3JlYWRfbG9ja19raWxsYWJsZShtbSkp
IHsKLQkJCWNvdW50ID0gLUVJTlRSOwotCQkJZ290byBvdXRfbW07Ci0JCX0KIAkJdGxiX2dhdGhl
cl9tbXUoJnRsYiwgbW0sIDAsIC0xKTsKIAkJaWYgKHR5cGUgPT0gQ0xFQVJfUkVGU19TT0ZUX0RJ
UlRZKSB7CiAJCQlmb3IgKHZtYSA9IG1tLT5tbWFwOyB2bWE7IHZtYSA9IHZtYS0+dm1fbmV4dCkg
ewogCQkJCWlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9TT0ZURElSVFkpKQogCQkJCQljb250aW51
ZTsKLQkJCQltbWFwX3JlYWRfdW5sb2NrKG1tKTsKLQkJCQlpZiAobW1hcF93cml0ZV9sb2NrX2tp
bGxhYmxlKG1tKSkgewotCQkJCQljb3VudCA9IC1FSU5UUjsKLQkJCQkJZ290byBvdXRfbW07Ci0J
CQkJfQotCQkJCWZvciAodm1hID0gbW0tPm1tYXA7IHZtYTsgdm1hID0gdm1hLT52bV9uZXh0KSB7
Ci0JCQkJCXZtYS0+dm1fZmxhZ3MgJj0gflZNX1NPRlRESVJUWTsKLQkJCQkJdm1hX3NldF9wYWdl
X3Byb3Qodm1hKTsKLQkJCQl9Ci0JCQkJbW1hcF93cml0ZV9kb3duZ3JhZGUobW0pOwotCQkJCWJy
ZWFrOworCQkJCXZtYS0+dm1fZmxhZ3MgJj0gflZNX1NPRlRESVJUWTsKKwkJCQl2bWFfc2V0X3Bh
Z2VfcHJvdCh2bWEpOwogCQkJfQogCiAJCQltbXVfbm90aWZpZXJfcmFuZ2VfaW5pdCgmcmFuZ2Us
IE1NVV9OT1RJRllfU09GVF9ESVJUWSwKQEAgLTEyNjEsNyArMTI0Niw4IEBAIHN0YXRpYyBzc2l6
ZV90IGNsZWFyX3JlZnNfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsCiAJCWlmICh0eXBlID09IENMRUFSX1JFRlNfU09GVF9ESVJUWSkKIAkJCW1tdV9ub3Rp
Zmllcl9pbnZhbGlkYXRlX3JhbmdlX2VuZCgmcmFuZ2UpOwogCQl0bGJfZmluaXNoX21tdSgmdGxi
LCAwLCAtMSk7Ci0JCW1tYXBfcmVhZF91bmxvY2sobW0pOworb3V0X3VubG9jazoKKwkJbW1hcF93
cml0ZV91bmxvY2sobW0pOwogb3V0X21tOgogCQltbXB1dChtbSk7CiAJfQo=
--000000000000606e9605b8589a93--

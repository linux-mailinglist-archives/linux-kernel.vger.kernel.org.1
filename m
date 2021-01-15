Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B82F8680
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbhAOUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbhAOUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:20:09 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B15C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:19:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q1so20541485ion.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=IrqnTD22eGyeV9KEEPPpb1M8jwdQm0lLlcbUlBKW3fA=;
        b=BGyVrrUhMukxKnyQCeKu7tCXOkjqiC6hypZhKznOEwe2KEjV9by4gUP8YeDkjfngzj
         ZO3n2hBwIAaMz/2KUYn6uShn2KIgarCEwg6TPyIL0ARM7zVYauubRHw2vTOBIGw8wvCg
         ucUCUV88rLe5iYx3y/Q/SKzTudbpWO/qlK0MVuAxRn5Y1oNzbV4uIClcOZZV6b4sMjAt
         hnd/wNkZYmQgL2Vf513ZlyU23h1/7S+axQlbDh89++W4JHLGL5KvJwQfH7Xkzd+0uyW/
         fyUCr8a+5TLdktmgJl0+7VWVSwgAZSdqDtrvgIwFq+95rzJGEQC6+nmdp9Ou4YNXrT3w
         k/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=IrqnTD22eGyeV9KEEPPpb1M8jwdQm0lLlcbUlBKW3fA=;
        b=DOsuvDsMJ0WjUlhO8o5+RITLO0k0i3pGbpYJy31jX26Hq4zIsLkoYXHVGBD/YZw4Pt
         Amv0Bq9X+0pw/GFDhemPltP84sA9+pRXDuxhlbdC0KfUCrhJkSXxnhqEdX24Tj34gh0V
         oXrkDR7RlMoc4Et9A+PuSfsG9bQEHw4GPWc2GWrlcGG8V63qZtlvUAvjK+TBS4MrmJoe
         0jdakC9iQVylA8uXYCae9foKY4NWXxHtkUS6iywzDHr56TUeEejhlDj+q0XwoZwdX9pG
         +CpaGo4UwyMzaK//BRnY99gUME/dxr2pDotn92wgCryvi7BWdW4sYGbgORoi5TbflA1P
         L6dA==
X-Gm-Message-State: AOAM5322aOaVX+2oB2G4sznCgkSCGKIfXjFB042+ftI+lA+PNd1uWbPg
        ex+5+OpiQGZ1pT11TX5aEu3REsZhQhXo8iEvILE=
X-Google-Smtp-Source: ABdhPJzFQJ3fa3Ig8eBYHwKSqQPMM66jotIe3Cg2W5Tz5LKsX+aQEZtXEJcSYTOCAoxVrXfESDMfzKETVTg7qF8LzP0=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr9842170iok.171.1610741968131;
 Fri, 15 Jan 2021 12:19:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CABCJKudgPc5FFAD5BKX2dK7BJYs_Dpa_JRFgKgGh8b2Xs6khUA@mail.gmail.com>
 <20210115195226.uiclol5lji3tuxgx@treble>
In-Reply-To: <20210115195226.uiclol5lji3tuxgx@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 21:19:16 +0100
Message-ID: <CA+icZUXPiE_ES4V7SbKs6Et9nJua5j4HhxFcBjgzvyttaxszDQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: multipart/mixed; boundary="000000000000d600f205b8f6162d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d600f205b8f6162d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 15, 2021 at 8:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jan 14, 2021 at 04:41:28PM -0800, Sami Tolvanen wrote:
> > Hi Josh,
> >
> > On Thu, Jan 14, 2021 at 11:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > Add support for proper vmlinux.o validation, which will be needed for
> > > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > > objtool anyway, for other reasons.)
> > >
> > > This isn't 100% done -- most notably, crypto still needs to be supported
> > > -- but I think this gets us most of the way there.
> > >
> > > This can also be found at
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> > >
> > > And for more testing it can be combined with Sami's x86 LTO patches:
> > >
> > >   https://github.com/samitolvanen/linux clang-lto
> >
> > Thank you for sending these! I applied this series on top of the
> > clang-lto tree and built allyesconfig with LTO_CLANG enabled and the
> > following crypto options disabled:
> >
> > CRYPTO_AES_NI_INTEL
> > CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
> > CRYPTO_SHA1_SSSE3
> > CRYPTO_SHA256_SSSE3
> > CRYPTO_SHA512_SSSE3
> > CRYPTO_CRC32C_INTEL
> >
> > I can confirm that all the warnings I previously saw are now fixed,
> > but I'm seeing a few new ones:
> >
> > vmlinux.o: warning: objtool: balance_leaf_when_delete()+0x17d4: stack
> > state mismatch: cfa1=7+192 cfa2=7+176
> > vmlinux.o: warning: objtool: internal_move_pointers_items()+0x9f7:
> > stack state mismatch: cfa1=7+160 cfa2=7+176
> > vmlinux.o: warning: objtool: strncpy_from_user()+0x181: call to
> > do_strncpy_from_user() with UACCESS enabled
> > vmlinux.o: warning: objtool: strnlen_user()+0x12b: call to
> > do_strnlen_user() with UACCESS enabled
> > vmlinux.o: warning: objtool: i915_gem_execbuffer2_ioctl()+0x390: call
> > to __ubsan_handle_negate_overflow() with UACCESS enabled
> > vmlinux.o: warning: objtool: .text.snd_trident_free_voice: unexpected
> > end of section
> >
> > I haven't had a chance to take a closer look yet, but some of these
> > are probably related to
> > https://github.com/ClangBuiltLinux/linux/issues/1192. However, I can
> > reproduce these also with ToT Clang, not just with Clang 11.
>
> Thanks, I'm able to reproduce these.  Will take a look.
>

AFAICS, that misses the v2 diff (see attachment) you sent me when
dealing with objtool-vmlinux and clang-cfi.
It does not cleanly apply with the combination of your objtool-vmlinux
Git and clang-cfi Git.


- Sedat -

--000000000000d600f205b8f6162d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="1-objtool-vmlinux-clang-cfi-jpoimboe-v2.diff"
Content-Disposition: attachment; 
	filename="1-objtool-vmlinux-clang-cfi-jpoimboe-v2.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kjyq65sk0>
X-Attachment-Id: f_kjyq65sk0

ZGlmZiAtLWdpdCBhL3Rvb2xzL29ianRvb2wvY2hlY2suYyBiL3Rvb2xzL29ianRvb2wvY2hlY2su
YwppbmRleCAzZDZjY2ExMjYxNzguLmM4YjJkMjZmNDk1NyAxMDA2NDQKLS0tIGEvdG9vbHMvb2Jq
dG9vbC9jaGVjay5jCisrKyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYwpAQCAtODM4LDM3ICs4Mzgs
NiBAQCBzdGF0aWMgaW50IGFkZF9pZ25vcmVfYWx0ZXJuYXRpdmVzKHN0cnVjdCBvYmp0b29sX2Zp
bGUgKmZpbGUpCiAJcmV0dXJuIDA7CiB9CiAKLS8qCi0gKiBDT05GSUdfQ0ZJX0NMQU5HOiBDaGVj
ayBpZiB0aGUgc2VjdGlvbiBpcyBhIENGSSBqdW1wIHRhYmxlIG9yIGEKLSAqIGNvbXBpbGVyLWdl
bmVyYXRlZCBDRkkgaGFuZGxlci4KLSAqLwotc3RhdGljIGJvb2wgaXNfY2ZpX3NlY3Rpb24oc3Ry
dWN0IHNlY3Rpb24gKnNlYykKLXsKLQlyZXR1cm4gKHNlYy0+bmFtZSAmJgotCQkoIXN0cm5jbXAo
c2VjLT5uYW1lLCAiLnRleHQuLkwuY2ZpLmp1bXB0YWJsZSIsIDIyKSB8fAotCQkgIXN0cmNtcChz
ZWMtPm5hbWUsICIudGV4dC5fX2NmaV9jaGVjayIpKSk7Ci19Ci0KLS8qCi0gKiBDT05GSUdfQ0ZJ
X0NMQU5HOiBJZ25vcmUgQ0ZJIGp1bXAgdGFibGVzLgotICovCi1zdGF0aWMgdm9pZCBhZGRfY2Zp
X2p1bXB0YWJsZXMoc3RydWN0IG9ianRvb2xfZmlsZSAqZmlsZSkKLXsKLQlzdHJ1Y3Qgc2VjdGlv
biAqc2VjOwotCXN0cnVjdCBzeW1ib2wgKmZ1bmM7Ci0Jc3RydWN0IGluc3RydWN0aW9uICppbnNu
OwotCi0JZm9yX2VhY2hfc2VjKGZpbGUsIHNlYykgewotCQlpZiAoIWlzX2NmaV9zZWN0aW9uKHNl
YykpCi0JCQljb250aW51ZTsKLQotCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGZ1bmMsICZzZWMtPnN5
bWJvbF9saXN0LCBsaXN0KSB7Ci0JCQlzeW1fZm9yX2VhY2hfaW5zbihmaWxlLCBmdW5jLCBpbnNu
KQotCQkJCWluc24tPmlnbm9yZSA9IHRydWU7Ci0JCX0KLQl9Ci19Ci0KIC8qCiAgKiBGaW5kIHRo
ZSBkZXN0aW5hdGlvbiBpbnN0cnVjdGlvbnMgZm9yIGFsbCBqdW1wcy4KICAqLwpAQCAtOTM5LDkg
KzkwOCw2IEBAIHN0YXRpYyBpbnQgYWRkX2p1bXBfZGVzdGluYXRpb25zKHN0cnVjdCBvYmp0b29s
X2ZpbGUgKmZpbGUpCiAJCQlpZiAoIXN0cmNtcChpbnNuLT5zZWMtPm5hbWUsICIuYWx0aW5zdHJf
cmVwbGFjZW1lbnQiKSkKIAkJCQljb250aW51ZTsKIAotCQkJaWYgKGlzX2NmaV9zZWN0aW9uKGlu
c24tPnNlYykpCi0JCQkJY29udGludWU7Ci0KIAkJCVdBUk5fRlVOQygiY2FuJ3QgZmluZCBqdW1w
IGRlc3QgaW5zdHJ1Y3Rpb24gYXQgJXMrMHglbHgiLAogCQkJCSAgaW5zbi0+c2VjLCBpbnNuLT5v
ZmZzZXQsIGRlc3Rfc2VjLT5uYW1lLAogCQkJCSAgZGVzdF9vZmYpOwpAQCAtMTA0OSw5ICsxMDE1
LDYgQEAgc3RhdGljIGludCBhZGRfY2FsbF9kZXN0aW5hdGlvbnMoc3RydWN0IG9ianRvb2xfZmls
ZSAqZmlsZSkKIAkJCWluc24tPmNhbGxfZGVzdCA9IGZpbmRfY2FsbF9kZXN0aW5hdGlvbihyZWxv
Yy0+c3ltLT5zZWMsCiAJCQkJCQkJCWRlc3Rfb2ZmKTsKIAkJCWlmICghaW5zbi0+Y2FsbF9kZXN0
KSB7Ci0JCQkJaWYgKGlzX2NmaV9zZWN0aW9uKHJlbG9jLT5zeW0tPnNlYykpCi0JCQkJCWNvbnRp
bnVlOwotCiAJCQkJV0FSTl9GVU5DKCJjYW4ndCBmaW5kIGNhbGwgZGVzdCBzeW1ib2wgYXQgJXMr
MHglbHgiLAogCQkJCQkgIGluc24tPnNlYywgaW5zbi0+b2Zmc2V0LAogCQkJCQkgIHJlbG9jLT5z
eW0tPnNlYy0+bmFtZSwKQEAgLTE3OTEsNyArMTc1NCw2IEBAIHN0YXRpYyBpbnQgZGVjb2RlX3Nl
Y3Rpb25zKHN0cnVjdCBvYmp0b29sX2ZpbGUgKmZpbGUpCiAKIAlhZGRfaWdub3JlcyhmaWxlKTsK
IAlhZGRfdWFjY2Vzc19zYWZlKGZpbGUpOwotCWFkZF9jZmlfanVtcHRhYmxlcyhmaWxlKTsKIAog
CXJldCA9IGFkZF9pZ25vcmVfYWx0ZXJuYXRpdmVzKGZpbGUpOwogCWlmIChyZXQpCkBAIC0yNjU0
LDggKzI2MTYsNyBAQCBzdGF0aWMgaW50IHZhbGlkYXRlX2JyYW5jaChzdHJ1Y3Qgb2JqdG9vbF9m
aWxlICpmaWxlLCBzdHJ1Y3Qgc3ltYm9sICpmdW5jLAogCQkJaWYgKGRlYWRfZW5kX2Z1bmN0aW9u
KGZpbGUsIGluc24tPmNhbGxfZGVzdCkpCiAJCQkJcmV0dXJuIDA7CiAKLQkJCWlmIChpbnNuLT50
eXBlID09IElOU05fQ0FMTCAmJiBpbnNuLT5jYWxsX2Rlc3QgJiYKLQkJCQkJaW5zbi0+Y2FsbF9k
ZXN0LT5zdGF0aWNfY2FsbF90cmFtcCkgeworCQkJaWYgKGluc24tPnR5cGUgPT0gSU5TTl9DQUxM
ICYmIGluc24tPmNhbGxfZGVzdC0+c3RhdGljX2NhbGxfdHJhbXApIHsKIAkJCQlsaXN0X2FkZF90
YWlsKCZpbnNuLT5zdGF0aWNfY2FsbF9ub2RlLAogCQkJCQkgICAgICAmZmlsZS0+c3RhdGljX2Nh
bGxfbGlzdCk7CiAJCQl9CmRpZmYgLS1naXQgYS90b29scy9vYmp0b29sL2VsZi5jIGIvdG9vbHMv
b2JqdG9vbC9lbGYuYwppbmRleCBjY2VlOGZjMzMxZjAuLmIzYjMwN2JmN2VjOSAxMDA2NDQKLS0t
IGEvdG9vbHMvb2JqdG9vbC9lbGYuYworKysgYi90b29scy9vYmp0b29sL2VsZi5jCkBAIC0zNTAs
NiArMzUwLDExIEBAIHN0YXRpYyBpbnQgcmVhZF9zZWN0aW9ucyhzdHJ1Y3QgZWxmICplbGYpCiAJ
CX0KIAkJc2VjLT5sZW4gPSBzZWMtPnNoLnNoX3NpemU7CiAKKwkJLyogRGV0ZWN0IC1mc2FuaXRp
emU9Y2ZpIHJlbGF0ZWQgc2VjdGlvbnMgKi8KKwkJaWYgKCFzdHJjbXAoc2VjLT5uYW1lLCAiLnRl
eHQuX19jZmlfY2hlY2siKSB8fAorCQkgICAgIXN0cm5jbXAoc2VjLT5uYW1lLCAiLnRleHQuLkwu
Y2ZpLmp1bXB0YWJsZSIsIDIyKSkKKwkJCXNlYy0+Y2ZpX2p0ID0gdHJ1ZTsKKwogCQlsaXN0X2Fk
ZF90YWlsKCZzZWMtPmxpc3QsICZlbGYtPnNlY3Rpb25zKTsKIAkJZWxmX2hhc2hfYWRkKGVsZi0+
c2VjdGlvbl9oYXNoLCAmc2VjLT5oYXNoLCBzZWMtPmlkeCk7CiAJCWVsZl9oYXNoX2FkZChlbGYt
PnNlY3Rpb25fbmFtZV9oYXNoLCAmc2VjLT5uYW1lX2hhc2gsIHN0cl9oYXNoKHNlYy0+bmFtZSkp
OwpAQCAtNjA2LDYgKzYxMSwzMyBAQCBzdGF0aWMgaW50IHJlYWRfcmVsb2NzKHN0cnVjdCBlbGYg
KmVsZikKIAkJCQlyZXR1cm4gLTE7CiAJCQl9CiAKKwkJCWlmIChyZWxvYy0+c3ltLT5zZWMtPmNm
aV9qdCkgeworCQkJCXN0cnVjdCBzeW1ib2wgKnN5bSA9IHJlbG9jLT5zeW07CisJCQkJY2hhciAq
c3VmZml4OworCQkJCWNoYXIgbmFtZVtNQVhfTkFNRV9MRU4gKyAxXTsKKwkJCQlzaXplX3QgbmFt
ZV9sZW47CisJCQkJc3RydWN0IHN5bWJvbCAqbmV3X3N5bTsKKworCQkJCWlmIChzeW0tPnR5cGUg
PT0gU1RUX1NFQ1RJT04pCisJCQkJCXN5bSA9IGZpbmRfZnVuY19ieV9vZmZzZXQoc3ltLT5zZWMs
CisJCQkJCQkJCSAgcmVsb2MtPmFkZGVuZCk7CisJCQkJaWYgKHN5bSkgeworCQkJCQlzdWZmaXgg
PSBzdHJzdHIoc3ltLT5uYW1lLCAiLmNmaV9qdCIpOworCQkJCQlpZiAoc3VmZml4KSB7CisJCQkJ
CQluYW1lX2xlbiA9IHN1ZmZpeCAtIHN5bS0+bmFtZTsKKwkJCQkJCXN0cm5jcHkobmFtZSwgc3lt
LT5uYW1lLCBuYW1lX2xlbik7CisJCQkJCQluYW1lW25hbWVfbGVuXSA9ICdcMCc7CisJCQkJCQlu
ZXdfc3ltID0gZmluZF9zeW1ib2xfYnlfbmFtZShlbGYsIG5hbWUpOworCQkJCQkJaWYgKCFuZXdf
c3ltKSB7CisJCQkJCQkJV0FSTigid3RmIik7CisJCQkJCQkJcmV0dXJuIC0xOworCQkJCQkJfQor
CisJCQkJCQlyZWxvYy0+c3ltID0gbmV3X3N5bTsKKwkJCQkJfQorCQkJCX0KKwkJCX0KKwogCQkJ
ZWxmX2FkZF9yZWxvYyhlbGYsIHJlbG9jKTsKIAkJCW5yX3JlbG9jKys7CiAJCX0KZGlmZiAtLWdp
dCBhL3Rvb2xzL29ianRvb2wvZWxmLmggYi90b29scy9vYmp0b29sL2VsZi5oCmluZGV4IGU2ODkw
Y2M3MGEyNS4uYmNjNTI0ZDczZjUxIDEwMDY0NAotLS0gYS90b29scy9vYmp0b29sL2VsZi5oCisr
KyBiL3Rvb2xzL29ianRvb2wvZWxmLmgKQEAgLTM5LDcgKzM5LDcgQEAgc3RydWN0IHNlY3Rpb24g
ewogCWNoYXIgKm5hbWU7CiAJaW50IGlkeDsKIAl1bnNpZ25lZCBpbnQgbGVuOwotCWJvb2wgY2hh
bmdlZCwgdGV4dCwgcm9kYXRhLCBub2luc3RyOworCWJvb2wgY2hhbmdlZCwgdGV4dCwgcm9kYXRh
LCBub2luc3RyLCBjZmlfanQ7CiB9OwogCiBzdHJ1Y3Qgc3ltYm9sIHsKLS0gCjIuMzAuMAoK
--000000000000d600f205b8f6162d--

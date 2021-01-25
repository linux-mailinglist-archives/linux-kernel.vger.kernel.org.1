Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1402D3039FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbhAZKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbhAYT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:28:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:27:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id f17so16730359ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIJBnzLR8xZZa5OMNks+idNijyo69a235Njhpd5w/og=;
        b=goPgelPBiJMObBaSHQwDfoIcznQetkFQJ78Ew3GV2Z1HVKeDf5rK/ub2lbJp0sRqV7
         N4sZ7KkZNBvW96gMcEKhByk9cxJdIUfuKVImNaiNi1Rdcuvca7m0EN0UqY7uYFPqvygZ
         B+ulJMSWB5+XexqSisDQBkGhKyQ7t+vHr+ADo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIJBnzLR8xZZa5OMNks+idNijyo69a235Njhpd5w/og=;
        b=EJAYOZHM+c8yyubjRQl0lDnHKEVTCUb1nHv8iysVfvxBJTJKLuS9ZM+8/ub98Gl/D+
         edXsGBzNbe+jScwnqD1p8oF7v9LdPOcta16r+FZ4JBxybNpT3zmLVcyNRWLFcK9Y1Ha3
         ggKTrRsu+tMU6U31BBNaMAlFWY23XMOW4kAFUTgLXCaUZSArvKSR5KgQ+SnO2o86ynb3
         Noj5F5KaDbQpsnCsMJD0cPX5GZ3pTMhMaEZ0PEVvnTgcxi3qmKajvm40fTKO+3d20Tqu
         zvpBxrYZBvpfh4Hqk4EBQzss5rkp/3IHaxslnwJXutfJfXVcZhblVYikkPasbzZ77RUi
         HHsA==
X-Gm-Message-State: AOAM533Tsp624yfjJN3a9qXjoeDzzjOcjEJHaPMiiGUPU2yp94Oo4OA6
        tGusP3ojaeWBcxyakuVGhnKzgRec9S6fQg==
X-Google-Smtp-Source: ABdhPJyHzr2sDcqk+iamNKYZnX1hUcjzKIpq4JxHkln4ix9DhODS/FIGN58NK5Rr/a3vowFBl7Jmxw==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr906324ljk.266.1611602854151;
        Mon, 25 Jan 2021 11:27:34 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m6sm363880lfr.245.2021.01.25.11.27.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:27:33 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t8so9407824ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:27:32 -0800 (PST)
X-Received: by 2002:a2e:8750:: with SMTP id q16mr902236ljj.465.1611602852618;
 Mon, 25 Jan 2021 11:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com>
In-Reply-To: <20210125190925.3655829-1-samitolvanen@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 11:27:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
Message-ID: <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008ccd0b05b9be87d5"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008ccd0b05b9be87d5
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 25, 2021 at 11:09 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Commit 9bb48c82aced ("tty: implement write_iter") converted the tty
> layer to use write_iter. Fix the redirected_tty_write declaration
> also in n_tty and change the comparisons to use write_iter instead of
> write.

Duh.

Obvious ACK from me.

The only thing I'd ask is that the declaration for
redirected_tty_write() be moved to a proper header file
(<linux/tty.h>.

Because the reason I didn't notice this was literally that n_tty.c did
its own private 'extern' declaration of that function. Which is
horribly wrong, exactly because it doesn't then ever notice when the
declaration is changed.

So I'd suggest doing the patch as attached - but please keep Sami's
credit, this is purely a "declare the function in the proper place"
fix.

            Linus

--0000000000008ccd0b05b9be87d5
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kkcyp69c0>
X-Attachment-Id: f_kkcyp69c0

IGRyaXZlcnMvdHR5L25fdHR5LmMgIHwgNyArKy0tLS0tCiBkcml2ZXJzL3R0eS90dHlfaW8uYyB8
IDIgLS0KIGluY2x1ZGUvbGludXgvdHR5LmggIHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9uX3R0
eS5jIGIvZHJpdmVycy90dHkvbl90dHkuYwppbmRleCAzMTlkNjhjOGE1ZGYuLjIxOWU4NTc1NjE3
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvbl90dHkuYworKysgYi9kcml2ZXJzL3R0eS9uX3R0
eS5jCkBAIC0yMDgxLDkgKzIwODEsNiBAQCBzdGF0aWMgaW50IGNhbm9uX2NvcHlfZnJvbV9yZWFk
X2J1ZihzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LAogCXJldHVybiAwOwogfQogCi1leHRlcm4gc3Np
emVfdCByZWRpcmVjdGVkX3R0eV93cml0ZShzdHJ1Y3QgZmlsZSAqLCBjb25zdCBjaGFyIF9fdXNl
ciAqLAotCQkJCQkJCXNpemVfdCwgbG9mZl90ICopOwotCiAvKioKICAqCWpvYl9jb250cm9sCQkt
CWNoZWNrIGpvYiBjb250cm9sCiAgKglAdHR5OiB0dHkKQEAgLTIxMDUsNyArMjEwMiw3IEBAIHN0
YXRpYyBpbnQgam9iX2NvbnRyb2woc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IGZpbGUg
KmZpbGUpCiAJLyogTk9URTogbm90IHlldCBkb25lIGFmdGVyIGV2ZXJ5IHNsZWVwIHBlbmRpbmcg
YSB0aG9yb3VnaAogCSAgIGNoZWNrIG9mIHRoZSBsb2dpYyBvZiB0aGlzIGNoYW5nZS4gLS0gamxj
ICovCiAJLyogZG9uJ3Qgc3RvcCBvbiAvZGV2L2NvbnNvbGUgKi8KLQlpZiAoZmlsZS0+Zl9vcC0+
d3JpdGUgPT0gcmVkaXJlY3RlZF90dHlfd3JpdGUpCisJaWYgKGZpbGUtPmZfb3AtPndyaXRlX2l0
ZXIgPT0gcmVkaXJlY3RlZF90dHlfd3JpdGUpCiAJCXJldHVybiAwOwogCiAJcmV0dXJuIF9fdHR5
X2NoZWNrX2NoYW5nZSh0dHksIFNJR1RUSU4pOwpAQCAtMjMwOSw3ICsyMzA2LDcgQEAgc3RhdGlj
IHNzaXplX3Qgbl90dHlfd3JpdGUoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IGZpbGUg
KmZpbGUsCiAJc3NpemVfdCByZXR2YWwgPSAwOwogCiAJLyogSm9iIGNvbnRyb2wgY2hlY2sgLS0g
bXVzdCBiZSBkb25lIGF0IHN0YXJ0IChQT1NJWC4xIDcuMS4xLjQpLiAqLwotCWlmIChMX1RPU1RP
UCh0dHkpICYmIGZpbGUtPmZfb3AtPndyaXRlICE9IHJlZGlyZWN0ZWRfdHR5X3dyaXRlKSB7CisJ
aWYgKExfVE9TVE9QKHR0eSkgJiYgZmlsZS0+Zl9vcC0+d3JpdGVfaXRlciAhPSByZWRpcmVjdGVk
X3R0eV93cml0ZSkgewogCQlyZXR2YWwgPSB0dHlfY2hlY2tfY2hhbmdlKHR0eSk7CiAJCWlmIChy
ZXR2YWwpCiAJCQlyZXR1cm4gcmV0dmFsOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvdHR5X2lv
LmMgYi9kcml2ZXJzL3R0eS90dHlfaW8uYwppbmRleCA0YTIwOGE5NWU5MjEuLjQ4ZGUyMDkxNmNh
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdHR5X2lvLmMKKysrIGIvZHJpdmVycy90dHkvdHR5
X2lvLmMKQEAgLTE0NCwxMCArMTQ0LDggQEAgREVGSU5FX01VVEVYKHR0eV9tdXRleCk7CiAKIHN0
YXRpYyBzc2l6ZV90IHR0eV9yZWFkKHN0cnVjdCBmaWxlICosIGNoYXIgX191c2VyICosIHNpemVf
dCwgbG9mZl90ICopOwogc3RhdGljIHNzaXplX3QgdHR5X3dyaXRlKHN0cnVjdCBraW9jYiAqLCBz
dHJ1Y3QgaW92X2l0ZXIgKik7Ci1zc2l6ZV90IHJlZGlyZWN0ZWRfdHR5X3dyaXRlKHN0cnVjdCBr
aW9jYiAqLCBzdHJ1Y3QgaW92X2l0ZXIgKik7CiBzdGF0aWMgX19wb2xsX3QgdHR5X3BvbGwoc3Ry
dWN0IGZpbGUgKiwgcG9sbF90YWJsZSAqKTsKIHN0YXRpYyBpbnQgdHR5X29wZW4oc3RydWN0IGlu
b2RlICosIHN0cnVjdCBmaWxlICopOwotbG9uZyB0dHlfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUs
IHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKTsKICNpZmRlZiBDT05GSUdfQ09N
UEFUCiBzdGF0aWMgbG9uZyB0dHlfY29tcGF0X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNp
Z25lZCBpbnQgY21kLAogCQkJCXVuc2lnbmVkIGxvbmcgYXJnKTsKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvdHR5LmggYi9pbmNsdWRlL2xpbnV4L3R0eS5oCmluZGV4IGM4NzNmNDc1ZjBhNy4u
Mzc4MDNmM2U2ZDQ5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3R0eS5oCisrKyBiL2luY2x1
ZGUvbGludXgvdHR5LmgKQEAgLTQyMSw2ICs0MjEsNyBAQCBleHRlcm4gdm9pZCB0dHlfa2Nsb3Nl
KHN0cnVjdCB0dHlfc3RydWN0ICp0dHkpOwogZXh0ZXJuIGludCB0dHlfZGV2X25hbWVfdG9fbnVt
YmVyKGNvbnN0IGNoYXIgKm5hbWUsIGRldl90ICpudW1iZXIpOwogZXh0ZXJuIGludCB0dHlfbGRp
c2NfbG9jayhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCB1bnNpZ25lZCBsb25nIHRpbWVvdXQpOwog
ZXh0ZXJuIHZvaWQgdHR5X2xkaXNjX3VubG9jayhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5KTsKK2V4
dGVybiBzc2l6ZV90IHJlZGlyZWN0ZWRfdHR5X3dyaXRlKHN0cnVjdCBraW9jYiAqLCBzdHJ1Y3Qg
aW92X2l0ZXIgKik7CiAjZWxzZQogc3RhdGljIGlubGluZSB2b2lkIHR0eV9rcmVmX3B1dChzdHJ1
Y3QgdHR5X3N0cnVjdCAqdHR5KQogeyB9Cg==
--0000000000008ccd0b05b9be87d5--

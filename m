Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C62E3219
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgL0RVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgL0RVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:21:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43650C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:21:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l11so19359637lfg.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pF2u3ZN5FurHISQaJ1JtNR9iaJ6KKzYmu9mpHtJpUI=;
        b=IVNN3iPccXLlG4jjYCeA2+vbs0ybfl7PDmvZMtdZjxbZZ69iKRVB0/bFH5MSvtpMpd
         KaGJ3DBM/jjWONeqZFVe2uXaVLl9vTbcSNpLkNItyoOfrKb4jzZeMv5G22D5RgSfDzTJ
         i55PFNV3p81XlgP6KuQXGK1Q1Ap25od0VdgU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pF2u3ZN5FurHISQaJ1JtNR9iaJ6KKzYmu9mpHtJpUI=;
        b=l3Wrm0LUlGfflcMJfpgyPiKRW7Tm9InO7/J3l8kG/6/GLDjrdm/McWcC3s4cSigNa4
         Q/gKqwp28T9PX03Va2KBsq3FoJ/lZhEHjUE2SBWUOZaeqYgQVP/bYnnzG3hCOTLDg12v
         gRjJD26yAlWvXW9hiFSDZio7l3z5onP1LOc71fNr9xFpAo/JfC5V02T6Hostc4hhs5vZ
         Ty3gXFUh83QqdnXzwN3+UBiucU5MfRKK4pQ1DboSt3b2t6NlJvS9bqMzzGVpYfbQXiXc
         8qzuiiQeNrTjcjchDzifg1skkNYf/XtQsEvjA54mE08j5qFuPwWdtmkh7ujhPuNyAGlO
         SvqA==
X-Gm-Message-State: AOAM530bvLfaJ4O57DLP+R79piTOoHDGzwVFHE85YzWR8CVIZdKwQvO2
        30f96rMxXpdoG1l26Uf0+zXS41lKJzG0aQ==
X-Google-Smtp-Source: ABdhPJzMsWsl7jj+S9uMnkTEWSGuigqkd9eorsq3k6qJWtcL3O4ta6GgJ8+nTd1kIFqBsAieB/0Cjw==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr21292203ljc.255.1609089666437;
        Sun, 27 Dec 2020 09:21:06 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m21sm5967644ljb.108.2020.12.27.09.21.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:21:04 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id y19so19161957lfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:21:04 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr19345113lji.251.1609089664219;
 Sun, 27 Dec 2020 09:21:04 -0800 (PST)
MIME-Version: 1.0
References: <16089960203931@kroah.com> <5ab86253-7703-e892-52b7-e6a8af579822@iki.fi>
In-Reply-To: <5ab86253-7703-e892-52b7-e6a8af579822@iki.fi>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 09:20:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtU5+7jPuPtDEpwhTuUUkA3CBN=V92Jg0Ag0=3LhfKqA@mail.gmail.com>
Message-ID: <CAHk-=wgtU5+7jPuPtDEpwhTuUUkA3CBN=V92Jg0Ag0=3LhfKqA@mail.gmail.com>
Subject: Re: LXC broken with 5.10-stable?, ok with 5.9-stable (Re: Linux 5.10.3)
To:     Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: multipart/mixed; boundary="000000000000d924a305b7756174"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d924a305b7756174
Content-Type: text/plain; charset="UTF-8"

On Sun, Dec 27, 2020 at 8:32 AM Jussi Kivilinna <jussi.kivilinna@iki.fi> wrote:
>
> Has this been fixed in 5.11-rc? Is there any patch that I could backport and test with 5.10?

Here's a patch to test. Entirely untested by me. I'm surprised at how
people use sendfile() on random files. Oh well..

          Linus

--000000000000d924a305b7756174
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kj7efh0f0>
X-Attachment-Id: f_kj7efh0f0

IGZzL3Byb2NfbmFtZXNwYWNlLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9wcm9jX25hbWVzcGFjZS5j
IGIvZnMvcHJvY19uYW1lc3BhY2UuYwppbmRleCBlNTlkNGJiM2E4OWUuLjAwMWU4YmQxMmU2NSAx
MDA2NDQKLS0tIGEvZnMvcHJvY19uYW1lc3BhY2UuYworKysgYi9mcy9wcm9jX25hbWVzcGFjZS5j
CkBAIC0zMjAsNyArMzIwLDcgQEAgc3RhdGljIGludCBtb3VudHN0YXRzX29wZW4oc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAKIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgcHJvY19tb3VudHNfb3BlcmF0aW9ucyA9IHsKIAkub3BlbgkJPSBtb3VudHNfb3BlbiwK
LQkucmVhZAkJPSBzZXFfcmVhZCwKKwkucmVhZF9pdGVyCT0gc2VxX3JlYWRfaXRlciwKIAkubGxz
ZWVrCQk9IHNlcV9sc2VlaywKIAkucmVsZWFzZQk9IG1vdW50c19yZWxlYXNlLAogCS5wb2xsCQk9
IG1vdW50c19wb2xsLApAQCAtMzI4LDcgKzMyOCw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgcHJvY19tb3VudHNfb3BlcmF0aW9ucyA9IHsKIAogY29uc3Qgc3RydWN0IGZpbGVfb3Bl
cmF0aW9ucyBwcm9jX21vdW50aW5mb19vcGVyYXRpb25zID0gewogCS5vcGVuCQk9IG1vdW50aW5m
b19vcGVuLAotCS5yZWFkCQk9IHNlcV9yZWFkLAorCS5yZWFkX2l0ZXIJPSBzZXFfcmVhZF9pdGVy
LAogCS5sbHNlZWsJCT0gc2VxX2xzZWVrLAogCS5yZWxlYXNlCT0gbW91bnRzX3JlbGVhc2UsCiAJ
LnBvbGwJCT0gbW91bnRzX3BvbGwsCkBAIC0zMzYsNyArMzM2LDcgQEAgY29uc3Qgc3RydWN0IGZp
bGVfb3BlcmF0aW9ucyBwcm9jX21vdW50aW5mb19vcGVyYXRpb25zID0gewogCiBjb25zdCBzdHJ1
Y3QgZmlsZV9vcGVyYXRpb25zIHByb2NfbW91bnRzdGF0c19vcGVyYXRpb25zID0gewogCS5vcGVu
CQk9IG1vdW50c3RhdHNfb3BlbiwKLQkucmVhZAkJPSBzZXFfcmVhZCwKKwkucmVhZF9pdGVyCT0g
c2VxX3JlYWRfaXRlciwKIAkubGxzZWVrCQk9IHNlcV9sc2VlaywKIAkucmVsZWFzZQk9IG1vdW50
c19yZWxlYXNlLAogfTsK
--000000000000d924a305b7756174--

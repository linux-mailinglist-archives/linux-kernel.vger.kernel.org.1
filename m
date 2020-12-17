Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717C32DD631
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgLQR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgLQR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:28:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42239C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:27:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o13so36248424lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+zfopRBCyd0EM7c39fRThm+xZRm+g4e92QxECE4u90=;
        b=OuqEWCLp+GHwdvhN8CVO3yDJMh92rWEWB1rb3d36nKZDVrtLrf+tB6YxDddGRoawkN
         3KQXwU1VJkQRubIOStO5WrJcrBf7VnzldUHkEUC8IypUZ63qS+fMrMEJ5VezyP3jL34j
         06qU5i7BXJXTDQS6anfoNAIuL66ZCwxBd3XZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+zfopRBCyd0EM7c39fRThm+xZRm+g4e92QxECE4u90=;
        b=pLD866Kzh1tcJ3yJAQTSqWG1YUNtH+zq12zjdAwigRk83Nok6Jk3NP8ch/6GeYaecr
         YvSOfpS7ZFnXQ9/vFJEIEr2cdWPWBMV6HRsds2kPKiacWmhqUmlqguv3KXX5d/tCAwnO
         53lk4x5AK9fZadaONGkKN19OGLN1VQcHClJ7tqiEpM24NwnBk2UHUq9L8ET1oYoHDndm
         ixycmEXN7kqn3Bs4Y4hT6Bv0/4Om8q1H4Uulbs8wYDfH4ziamCpAlNbTy3eL2Z97SZO0
         QQRneiVIAH7PshP04H7E4j9fkxKF9Pvgxk3TzAYgA2443mERV2FSbNwZa799yjFtRqMk
         3m8A==
X-Gm-Message-State: AOAM531ARkiLMmyT74nKN30sZhUYamaENoPOQbZiV+xqjOIg/Qntup9X
        pFGUUg0lcN5DS9SkEVHRfQFRHMMxrV7gCw==
X-Google-Smtp-Source: ABdhPJxczI+RaLoCxnth8au+P9QJhfvLtDUYaE8VTvSOapfrnwMc/M/7MgtImGxjWFFaCeTFzBRzZQ==
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr131672ljk.317.1608226063319;
        Thu, 17 Dec 2020 09:27:43 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a11sm649617lfl.22.2020.12.17.09.27.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 09:27:41 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id m25so59392986lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 09:27:41 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr15859185lfc.253.1608226061358;
 Thu, 17 Dec 2020 09:27:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble> <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
 <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
 <20201216200158.akf356yrw44o2rlb@treble> <20201217104556.GT3040@hirez.programming.kicks-ass.net>
 <20201217162524.fkxiemn7aezpv7d5@treble>
In-Reply-To: <20201217162524.fkxiemn7aezpv7d5@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 09:27:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
Message-ID: <CAHk-=wiJ7xt913Lf6rfeq4CyffhXwHLVZ2ZABcKHmV8cf0FArg@mail.gmail.com>
Subject: Re: New objtool warning..
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001b4b6d05b6ac4fce"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001b4b6d05b6ac4fce
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 17, 2020 at 8:25 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Oh yeah, I forgot about that.  That would be another option if my patch
> doesn't work out.

Well, one option is to just say "ok, we know gcc generates horrible
code that falls through to another function in a situation that we
claim is unreachable, so let's not claim it is unreachable".

IOW, the problem here is that the compiler fundamentally isn't smart
enough to see that something is unreachable, and the "unreachable()"
annotation we did didn't actually really cause any code that makes it
so. So we basically have code that _if_ we ever change it, it will
simply be wrong, and we'll never see any warnings about it but it will
fall through to nonsensical code.

So maybe the option here is simply "objtool was right before, the
unreachable() is fragile and wrong".

We can easily write that case statement in a way that actually makes
the compiler generate better code and avoids the issue by just making
case 0x00 also be the default case.

So I think I'll just apply this patch instead.

            Linus

--0000000000001b4b6d05b6ac4fce
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kit49ga60>
X-Attachment-Id: f_kit49ga60

IGRyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZWRpZC5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9lZGlkLmMKaW5kZXggNzRmNWEzMTk3
MjE0Li5lOTVjY2U4ZTczNmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jCkBAIC0zMTAyLDYgKzMxMDIsOCBAQCBz
dGF0aWMgaW50IGRybV9jdnRfbW9kZXMoc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwK
IAogCQloZWlnaHQgPSAoY3Z0LT5jb2RlWzBdICsgKChjdnQtPmNvZGVbMV0gJiAweGYwKSA8PCA0
KSArIDEpICogMjsKIAkJc3dpdGNoIChjdnQtPmNvZGVbMV0gJiAweDBjKSB7CisJCS8qIGRlZmF1
bHQgLSBiZWNhdXNlIGNvbXBpbGVyIGRvZXNuJ3Qgc2VlIHRoYXQgd2UndmUgZW51bWVyYXRlZCBh
bGwgY2FzZXMgKi8KKwkJZGVmYXVsdDoKIAkJY2FzZSAweDAwOgogCQkJd2lkdGggPSBoZWlnaHQg
KiA0IC8gMzsKIAkJCWJyZWFrOwpAQCAtMzExNCw4ICszMTE2LDYgQEAgc3RhdGljIGludCBkcm1f
Y3Z0X21vZGVzKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsCiAJCWNhc2UgMHgwYzoK
IAkJCXdpZHRoID0gaGVpZ2h0ICogMTUgLyA5OwogCQkJYnJlYWs7Ci0JCWRlZmF1bHQ6Ci0JCQl1
bnJlYWNoYWJsZSgpOwogCQl9CiAKIAkJZm9yIChqID0gMTsgaiA8IDU7IGorKykgewo=
--0000000000001b4b6d05b6ac4fce--

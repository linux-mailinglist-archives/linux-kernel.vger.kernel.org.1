Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C762ED5E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbhAGRo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbhAGRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:44:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE7DC0612FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:44:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x20so16435911lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/dnl8hzKP5RYsuLZ1L8Ai6F/gkDggofRzaB7P8q9uM=;
        b=g+5XCehK95aPRpOysTCCCJ6U0ZhSmPHp4h2WDl2CRbIBavbHR19IUTG89Z0cgalOYe
         u9Ekk3rbxn/KadUiiaoKPHuUxNSdZDzs1Y8RoMSZjleUdscrmAT7/JwlfgNqzlIaMENi
         9cTjBGTxwmHsoG0pBWmBhp5a3Mh4huf4qO4qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/dnl8hzKP5RYsuLZ1L8Ai6F/gkDggofRzaB7P8q9uM=;
        b=ZRAj/8rwk/j2K1RLc3D1aRxXXEerVk4Kjh8CCRJaMVYkfNOuGHgIEF/smDBDDWvg52
         neV/us9m/n1lABuI1BxIZhZhyHy529b/NjV1w9HyqxMtmAi+o9lhF8t0SPskZ15MnAW/
         9I4T0hrsJuPFe2pOM572SK4q+HJDGeY3yYCAhWYNZSqcbVwpucDYQulcAyqkcyJPBkD2
         2SGMxeoqXzC2qTDVqozWbACJ2rsucGZEqBdhKRZk26us4hjzRkon259jLiCvugENRUgN
         S7zIVD/U6OYEiwSJIdTREzGlmR49gkmxVmBnGT7IuUAVohmsThDBX2t5tIl46p+0oTLR
         PQ8Q==
X-Gm-Message-State: AOAM5328kEQgQyywh7E3aQdd27D9Vm9RlLOg/e52jSobJ3qqNu+kPS9N
        C4sLiBLTMkHRLD+pfUVzRv4lBhIwJwsouA==
X-Google-Smtp-Source: ABdhPJx+hUi6IGvIzZIRZAFzJlHKgvuxCe75ba0+S4Qo883gTIuQsSIj7h4oIsSq7m2He+qkKC8KvA==
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr4586368lff.497.1610041452702;
        Thu, 07 Jan 2021 09:44:12 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f19sm1407157ljm.7.2021.01.07.09.44.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:44:10 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id x20so16435540lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:44:10 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr4379912lji.251.1610041450018;
 Thu, 07 Jan 2021 09:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
In-Reply-To: <20210107134723.GA28532@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 09:43:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
Message-ID: <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: multipart/mixed; boundary="000000000000b48ca005b852fccb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b48ca005b852fccb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 7, 2021 at 5:32 AM kernel test robot <oliver.sang@intel.com> wr=
ote:
>
> FYI, we noticed a -5.8% regression of will-it-scale.per_thread_ops due to=
 commit:

Ok, that's noticeable.

And:

> commit: d55564cfc222326e944893eff0c4118353e349ec ("x86: Make __put_user()=
 generate an out-of-line call")

Yeah, that wasn't supposed to cause any performance regressions. No
core code should use __put_user() so much.

But:

> | testcase: change | will-it-scale: will-it-scale.per_process_ops -7.3% r=
egression             |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.3=
0GHz with 192G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                        |
> |                  | mode=3Dprocess                                      =
                        |
> |                  | nr_task=3D100%                                      =
                        |
> |                  | test=3Dpoll2                                        =
                        |
> |                  | ucode=3D0x16                                        =
                        |

Ok, it's poll(), and it's definitely the __put_user() there:

>       0.00            +1.8        1.77 =C4=85  3%  perf-profile.children.=
cycles-pp.__put_user_nocheck_2
>       0.00            +1.6        1.64 =C4=85  3%  perf-profile.self.cycl=
es-pp.__put_user_nocheck_2

And in fact, it's that final "write back the 16-bit revents field" at the e=
nd.

Which must have sucked before too, because it used to do a "stac/clac"
for every word - but now it does it out of line.

The fix is to convert that loop to use "unsafe_put_user()" with the
necessary accoutrements around it, and that should speed things up
quite nicely. The (double) loop itself is actually just 14
instructions, it's ridiculous how bad the code used to be, and how
much better it is with the nice unsafe_put_user(). The whole double
loop ends up being just

        lea    0x68(%rsp),%rsi
        mov    %rcx,%rax
  1:    mov    0x8(%rsi),%ecx
        lea    0xc(%rsi),%rdx
        test   %ecx,%ecx
        je     3f
        lea    (%rax,%rcx,8),%rdi
  2:    movzwl 0x6(%rdx),%ecx
        mov    %cx,0x6(%rax)
        add    $0x8,%rax
        add    $0x8,%rdx
        cmp    %rdi,%rax
        jne    2b
  3:    mov    (%rsi),%rsi
        test   %rsi,%rsi
        jne    1b

with the attached patch.

Before, it would do the whole CLAC/STAC dance inside that loop for
every entry (and with that commit d55564cfc22 it would be a function
call, of course).

Can you verify that this fixes the regression (and in fact I'd expect
it to improve that test-case)?

NOTE! The patch is entirely untested. I verified that the code
generation now looks sane, and it all looks ObviouslyCorrect(tm) to
me, but mistakes happen and maybe I missed some detail..

               Linus

--000000000000b48ca005b852fccb
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kjn50eyv0>
X-Attachment-Id: f_kjn50eyv0

IGZzL3NlbGVjdC5jIHwgMTQgKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NlbGVjdC5jIGIvZnMv
c2VsZWN0LmMKaW5kZXggZWJmZWJkZmU1YzY5Li4zN2FhYTgzMTdmM2EgMTAwNjQ0Ci0tLSBhL2Zz
L3NlbGVjdC5jCisrKyBiL2ZzL3NlbGVjdC5jCkBAIC0xMDExLDE0ICsxMDExLDE3IEBAIHN0YXRp
YyBpbnQgZG9fc3lzX3BvbGwoc3RydWN0IHBvbGxmZCBfX3VzZXIgKnVmZHMsIHVuc2lnbmVkIGlu
dCBuZmRzLAogCWZkY291bnQgPSBkb19wb2xsKGhlYWQsICZ0YWJsZSwgZW5kX3RpbWUpOwogCXBv
bGxfZnJlZXdhaXQoJnRhYmxlKTsKIAorCWlmICghdXNlcl93cml0ZV9hY2Nlc3NfYmVnaW4odWZk
cywgbmZkcyAqIHNpemVvZigqdWZkcykpKQorCQlnb3RvIG91dF9mZHM7CisKIAlmb3IgKHdhbGsg
PSBoZWFkOyB3YWxrOyB3YWxrID0gd2Fsay0+bmV4dCkgewogCQlzdHJ1Y3QgcG9sbGZkICpmZHMg
PSB3YWxrLT5lbnRyaWVzOwogCQlpbnQgajsKIAotCQlmb3IgKGogPSAwOyBqIDwgd2Fsay0+bGVu
OyBqKyssIHVmZHMrKykKLQkJCWlmIChfX3B1dF91c2VyKGZkc1tqXS5yZXZlbnRzLCAmdWZkcy0+
cmV2ZW50cykpCi0JCQkJZ290byBvdXRfZmRzOworCQlmb3IgKGogPSB3YWxrLT5sZW47IGo7IGZk
cysrLCB1ZmRzKyssIGotLSkKKwkJCXVuc2FmZV9wdXRfdXNlcihmZHMtPnJldmVudHMsICZ1ZmRz
LT5yZXZlbnRzLCBFZmF1bHQpOwogICAJfQorCXVzZXJfd3JpdGVfYWNjZXNzX2VuZCgpOwogCiAJ
ZXJyID0gZmRjb3VudDsKIG91dF9mZHM6CkBAIC0xMDMwLDYgKzEwMzMsMTEgQEAgc3RhdGljIGlu
dCBkb19zeXNfcG9sbChzdHJ1Y3QgcG9sbGZkIF9fdXNlciAqdWZkcywgdW5zaWduZWQgaW50IG5m
ZHMsCiAJfQogCiAJcmV0dXJuIGVycjsKKworRWZhdWx0OgorCXVzZXJfd3JpdGVfYWNjZXNzX2Vu
ZCgpOworCWVyciA9IC1FRkFVTFQ7CisJZ290byBvdXRfZmRzOwogfQogCiBzdGF0aWMgbG9uZyBk
b19yZXN0YXJ0X3BvbGwoc3RydWN0IHJlc3RhcnRfYmxvY2sgKnJlc3RhcnRfYmxvY2spCg==
--000000000000b48ca005b852fccb--

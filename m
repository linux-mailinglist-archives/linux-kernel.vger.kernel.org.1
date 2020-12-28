Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544ED2E6C04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgL1Wzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgL1TqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:46:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED52C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:45:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so26292482lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzCpwNkLm1sQWHhi/xhAqqK3At+nOC8e8syaAj1ubyE=;
        b=XzZh99tfUAhyhNjhzwm0zHeDGd+rsFEdioQtM39Fqxv1vm5gkSff3yw0jmp85Ezise
         W5CX/U4DN7D2cROuaiJL2aPBZt5nEtZSREsHRYzrH3MO9rzMl6PTOTDmicPl0mSjnUnY
         z11HX/cnwPzHOMC3ja03uoEDz6BQenlytsc5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzCpwNkLm1sQWHhi/xhAqqK3At+nOC8e8syaAj1ubyE=;
        b=YJqpc/5xPg8b/AsRmAmykekRlWljRgrqQaI5t13UnI9ciz1QW+CGoaBTH28Oekrhg2
         6yRvHJ0ZMPi0KTJBGJB03c2rt0wbSMYg0MHz8xvpaqXMhnOtumq6qdFQgIECczfloOpK
         JuwpqmG39RN/CB9jYm5p/z2oLPxCzoi7YQzYMgADJR+elhGz/ellcr4iZFm/ECKVCArX
         yLz0p6n47ECH6GJSVtstL74facfPA8FldbGJp8EVWwPD6F5W4j89N695pj98OS1FtSMk
         snuSxI04FQ8dHREBUzKhrv5vBGm2wzNTp70KkmlgfRq2+PbLGDIMY9SM9d5/9jwXVOd+
         S1gw==
X-Gm-Message-State: AOAM530ZXZ1ujS3s2kVut6ZhxtMsS1rhCR8OFSRHcQyVTOVmWBtTG/a/
        JZsE0Bkik4mY01zdUicM+NCMrdLP8EnZ4A==
X-Google-Smtp-Source: ABdhPJyU9FuJEhXh6sFN+TAIwWnVqqyUsWam7XHVwTmlapQD2diB8vJ/Ip/Bx2R/EnLoSOVKzUEK2w==
X-Received: by 2002:ac2:5cca:: with SMTP id f10mr18228152lfq.566.1609184728582;
        Mon, 28 Dec 2020 11:45:28 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v2sm5421157lfa.149.2020.12.28.11.45.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 11:45:27 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 23so26155288lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:45:27 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr20476212lfc.253.1609184726977;
 Mon, 28 Dec 2020 11:45:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
 <CA+icZUXfVF49iBYTvz-g9f=Fo04jkgLhHiYRxoon9NjZtWzGQg@mail.gmail.com>
In-Reply-To: <CA+icZUXfVF49iBYTvz-g9f=Fo04jkgLhHiYRxoon9NjZtWzGQg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 11:45:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+V1dkij1vTH+pk7LgwQ4snBH1Y+6Ts6jgSXRGDuFKdg@mail.gmail.com>
Message-ID: <CAHk-=wj+V1dkij1vTH+pk7LgwQ4snBH1Y+6Ts6jgSXRGDuFKdg@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 7:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I also tested with LLVM toolchain v11.0.1-rc2 together with passing
> LLVM=1 and LLVM_IAS=1 to my make line.
>
> I had one ERROR:
>
> error: too few operands for instruction in arch/x86/kvm/svm/sev.c

Looks like Paolo already picked up the fix, so this should be fixed
when I get the next kvm pull request.

That said, you might want to make sure the  LLVM people know about this too.

The whole "implicit arguments" is a common thing in x86, where lots of
instructions don't need to spell them out explicitly, because of fixed
register allocation (example: divide/multiply instructions only work
with ax/dx as a target etc).

             Linus

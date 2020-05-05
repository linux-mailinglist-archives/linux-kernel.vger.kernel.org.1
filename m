Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5A1C6492
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgEEXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 19:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728853AbgEEXhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:37:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D81C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:37:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so1516534plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV8k3SS2CHeSg6+79pVabsils9K32cepGXeLdcOAQJE=;
        b=Ua2Y5pt+OErrGRBo/BnuHn8XmNGatlMJtl73UVMhbLZg9dIgLiG9H8VPBxyed0B7Xj
         pKmDsX4Rt83fv/4OVyyvTJV9HeDQ4+kLkvr+rptl0op7KRmSeH7EEnl4TthCdLWJj7yy
         JkOXNNPblnEzyNfdhD5kzDOuSmwuup3xkl1ednTKQG2+sWMKdTRE+ozniU56+75e2UpW
         VgN4pKmjV+T/eqdZgP6qye1nvK3c+p+Ai+HpeHNTSIBuDmyBksU9kAkOSB84wBrhhvZi
         ucE3e39d1LJMsPkYyXacggBre/HMsfXKi7/unaDw6t18STqzlf/Ja24RhpdClm7LSL79
         cmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV8k3SS2CHeSg6+79pVabsils9K32cepGXeLdcOAQJE=;
        b=LBgazbgiCK1tjDU2GUu+Rh6d9yrwnYsz0ksKYsssqgajSneNYSoiJ9J5hu0eVNKG9D
         GYjSc1ytD0bfCXTEnSz9LjG9Ojq6gWpQVxMCzFzzTQXvJQiYkavnGgKeFTGe6QrTYfSc
         GQ1qCpmw4sVVSG5S624PM1bRe3/UZgyPdo5qs6txG14BeTP60AyThG4J5ffLUmVU9BBc
         sGzEc00KHO+8xfy39uRy3sltu3xTbsr2xDhWViAXNE14nPQLrqRxzqZE3Lf/8rG8ncho
         vmWsxxqvcLa210gjEJQ01Jm9mToswcbPY2cfABkM+MtQ4n7O1fpvnVWANPNAVB+H0gm1
         QmtQ==
X-Gm-Message-State: AGi0PuZ0ZwcslwVc7swxwydhYg256nDod+xbCeWXm6Bep2VNhCuxHgB4
        3k3N7Oh6lWKfqdR84jcp2AHOn6TqwkJKHTBGPhDOMQ==
X-Google-Smtp-Source: APiQypLovBrf/kLoL/BVlwKUEVNCB111jD4tkdcRD9SkmNC5GRRsdT6HJAVxN1k0TY4QYYbCy47f8CCYIzjl3ZA/+OM=
X-Received: by 2002:a17:90a:6488:: with SMTP id h8mr5982493pjj.51.1588721819875;
 Tue, 05 May 2020 16:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9oMcfY4nwkknwN9c4rB-O7xD4GCAOFPoZCbdnq=034=Vw@mail.gmail.com>
 <20200505215503.691205-1-Jason@zx2c4.com> <CAKwvOdk32cDowvrqRPKDRpf2ZiXh=jVnBTmhM-NWD=Ownq9v3w@mail.gmail.com>
 <20200505222540.GA230458@ubuntu-s3-xlarge-x86> <CAHmME9qs0iavoBqd_z_7Xibyz7oxY+FRt+sHyy+sBa1wQc66ww@mail.gmail.com>
 <202005051617.F9B32B5526@keescook> <CAHmME9q3zFe4e1xnpptJ27zywGqngZK2K7LCVzDSoG__ht=fNA@mail.gmail.com>
In-Reply-To: <CAHmME9q3zFe4e1xnpptJ27zywGqngZK2K7LCVzDSoG__ht=fNA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 May 2020 16:36:49 -0700
Message-ID: <CAKwvOdkrS-P_AS1azSCP-DVq_h8Dhb8YiLTfH=9zzEJQphZTcA@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: disable FORTIFY_SOURCE on clang-10
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        George Burgess <gbiv@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, May 5, 2020 at 5:19 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > (Though as was mentioned, it's likely that FORTIFY_SOURCE isn't working
> > _at all_ under Clang, so I may still send a patch to depend on !clang
> > just to avoid surprises until it's fixed, but I haven't had time to
> > chase down a solution yet.)

Not good.  If it's completely broken, turn it off, and we'll prioritize fixing.

> That might be the most coherent thing to do, at least so that people
> don't get some false sense of mitigation.

Do we have a better test for "this is working as intended" or not
other than excessive stack usage, since that doesn't repro for
clang-9?
-- 
Thanks,
~Nick Desaulniers

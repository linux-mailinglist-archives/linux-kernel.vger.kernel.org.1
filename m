Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8162B28FBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbgJPABo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbgJPABn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 20:01:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:01:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dg9so458680edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/1IntEkdWKImHNOT+qrBdO4BgCV+2jRbRdBJi8ptLs=;
        b=egXQczmuoyRvh6M/he1kd7PQ4dgg2oOgmQXK19ba+2lhe626jeXg8WMf0DaPeWUlVC
         bUhHRXqbb1VNrT4Xb2gNjmbxJBPbt43FrX+vt8ZKUWg3wiBoChwuc1jzxh4bevC9sR/8
         Re5O8J7oGzKbfCI5ZLYWjILsESNlNbH27JNVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/1IntEkdWKImHNOT+qrBdO4BgCV+2jRbRdBJi8ptLs=;
        b=iWv+JXbtFWaVJoA1oByWxKKg2/3w78wUK48hX0tc/AIN+/JGvxoTUvOo/Y7J38IqvZ
         nsq4r5PtAGRGFzJ2r4OlQ8el6dV1XdYskdJiSrHwRyuChyeYtmqqJAP4AQYxnCQPTtfR
         qGtXGyONYkhTEcdSO2QrNfTNKux6Ov9zrKV4Qd4B6WKqvIt6dlFsibTkDTm/w30NIa0M
         ZExLUpj9ucntZPULNUFsjT6Fi8yIAJGXSn0bUD+mChLhN/b5mfc4UDChMN3vScilqRjn
         b2ZjIMtAJB5wrQcR7VHUetiuWjMQLXyZW43E/hk5xHXbI4pAhrhGeRWK7Nc44DFoAJ+/
         FE0g==
X-Gm-Message-State: AOAM5317QmggUUluAhhl6CFobaKo6aiW8NmGGK2ADnCl20W0xObIf5OW
        ctNj0efnr6ZndsBa/407Doc5USafAjzKR27gdb/Ejg==
X-Google-Smtp-Source: ABdhPJwfQrrcT6QUMBHBgIm/m4g7SUq0+p4qrE08K2xMTDwSO9lwXA2IPSiEEa8yuchfyZh3lCSWC1CNlrA5c14ypsc=
X-Received: by 2002:a05:6402:602:: with SMTP id n2mr969028edv.327.1602806499816;
 Thu, 15 Oct 2020 17:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
In-Reply-To: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 15 Oct 2020 17:01:29 -0700
Message-ID: <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 4:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> These were rebased since the merge window started, for no apparent reason.
>
> Were they in linux-next?

Yeah, they are changes that were originally targeting the v5.9 merge
window (and thus were in -next during July/August) but I didn't get
the chance to send a pull request for them. Since I didn't touch my
-next branch since then they are also in 'next-20201013' and
'next-20201015'.

I just rebased to v5.9 to make sure the 1-line changes that touch
kernel/capability.c, kernel/groups.c and kernel/sys.c still applied
cleanly without conflicts. Should I have rebased onto one of the -rc's
for v5.9 instead?

>
> And if so, why was I sent some different version?
>
>              Linus

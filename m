Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A92B396F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgKOVQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 16:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgKOVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:16:54 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9CC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 13:16:52 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so22299945lfq.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljg0Lh1Ep5cFex2wVS52wkjBHeB32pDeyPYh2JaQMI8=;
        b=ITD8sPq+pOyS9VcfPREEpaUZQyYZUwIzYfJkA76QGgbfFv1muUfH5FQKxhjJA1Gb2W
         4hv0kwwxwDETclJwR5cJ1ofnybf8BQFlFcHUyp/MWrGZMULL47MYTAgR1HNMDiJb0QCz
         T11UUM3DqT44EM7cT0uE+CkZP06CkJYJ5BLNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljg0Lh1Ep5cFex2wVS52wkjBHeB32pDeyPYh2JaQMI8=;
        b=HVChyHgOfMOXN5RY7KTl6jw8uhoNTTc6f7R8Yej9Lc4IxDvX4gMXFxK7bObtUDPA+k
         S9zF3ocH27H/kML28JX2w2jn2GuI7JJgQD6Ry4in8vMi6mMayKmRB/NQuDmQANPt0jsL
         U9dqlTyV8HB4sRdV3+RF2W41C3qkX5+pNUmPTLzDz0270PDPg5c23chlNXdtcyQfF8QI
         hYITaeyoAtAjIWxe8cXDnJ8zMIT/CXcW9mCHWCDqF1LNPKHl/T/0/hYizgNLqEvqDWZC
         +CWCHFK9YOIStQe4uHGbRa1j8I2xWRCWZnIKgjdaIcV6pVz88407lBKbBUcld5sYMPGJ
         iooA==
X-Gm-Message-State: AOAM531KoQ+bg/hN6BYMBpQydnCBopWJK9bV3YORkxQLZN7j0i0NnoPq
        nt2sQk8Iki2YWpRIL5Myg6ycFW6JC/1tJQ==
X-Google-Smtp-Source: ABdhPJwrLlHuTUsEnjB7xN70BL5HATdzBe80im0zCl729kGc05EOWV49Fb/9xm7lrr5c2zj2tcKTJA==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr4802363lfo.431.1605475011145;
        Sun, 15 Nov 2020 13:16:51 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m62sm2473324lfd.233.2020.11.15.13.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 13:16:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id y16so17841039ljh.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 13:16:49 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr4683644lji.314.1605475009199;
 Sun, 15 Nov 2020 13:16:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
In-Reply-To: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 13:16:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whs3Wqg=TCgnX0QC9nz+3Y-FybKNcnuY8JLdW6EC-LkXQ@mail.gmail.com>
Message-ID: <CAHk-=whs3Wqg=TCgnX0QC9nz+3Y-FybKNcnuY8JLdW6EC-LkXQ@mail.gmail.com>
Subject: Re: [git pull] drm nouveau urgent fixes for 5.10-rc4
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <skeggsb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 12:41 PM Dave Airlie <airlied@gmail.com> wrote:
>
> As mentioned I did have a fixes pull from Ben from after I'd sent you
> out stuff, it contains the fix for the regression reported in the rc1
> thread along with two others.

Thanks, pulled,

             Linus

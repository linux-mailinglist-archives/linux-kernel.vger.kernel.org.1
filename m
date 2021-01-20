Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A472FCC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbhATIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbhATISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:18:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70666C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:17:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so1741647pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=cvUgzRNbehdStkMCTn3MSqVO0aKi1AC/+Yc6mZDN7Xw=;
        b=SkC5SX8yRZwW8vFj0W7KgR0eqbgmGj9lGBqt6gNA0L5LteGqLynZaXyJjI1VepMJv2
         +4RYHQq4uSMq/CZ5tD0Ugwzi6EHF3BVzaAJkOu28iLlpmLMawReCA5NggfC9wVnOPszS
         LxA0fX6/378JdAAnjvvyo1tZ0Pb0uqw/3fdxHE4n3RpTS+yt9slP/q9j/WS5hBH0Iw6v
         tXrBmpbfaq73wbhfOuB1wGnC90oOsOczV4et/8MVlol8CrIYPCo44huKHxwS4QjtZ5Nh
         2upK4uGxmAVkHYghJ9tRAkLAdyBfsG51yZYM/BRz9JRmVF0oHHjT2lSxwMl6IIjgoxyt
         cNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=cvUgzRNbehdStkMCTn3MSqVO0aKi1AC/+Yc6mZDN7Xw=;
        b=Y2QNGfFPnSzTGj1UxBIf1q8htCyAgpYq6sULQ7B7lEdbI7sgrGsIyW8xPRDebw4Jfo
         ja44EmyBRpZBNNdbgjHlMFAyA/u6kSxgIXEFFCNYMk6iiG+UK8FTHqAdq17RKnHn8Kdg
         XqOKXldefXfKOm107byO27Q3/rGuhZPbZLJXuEd3xj2/HyFqhna25dpJ8yFe1QEd0XXB
         RseBlAMArFFFYVMcY1CiIhYLi54nJy6hWweBDrka3M0VQNLOACvjjbVDKSJtEGpxICPa
         QWQZT+pigEnZH6xtJQSNdIJAQ9lwUUi6PWXb9WcMZQfklQlTo9bQugK0CzQe8eHE+6Rp
         IAMg==
X-Gm-Message-State: AOAM532TmLt5UO9mg+8P5RQB/gnhs3WnTauDR2QPstPhT58RFOcLEEg+
        Ydjf4USEbXXd9TCzt2Hg6B0=
X-Google-Smtp-Source: ABdhPJwW0xn7d7mcxb8yKbhUM0kC6Wzf6WJPctxCKOXhirdTAWLUhErvIrh2hmHdx0z6GyLZKbMePw==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr4416428pjg.109.1611130629031;
        Wed, 20 Jan 2021 00:17:09 -0800 (PST)
Received: from localhost ([116.12.58.169])
        by smtp.gmail.com with ESMTPSA id b206sm1358200pfb.73.2021.01.20.00.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 00:17:08 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jiri Slaby" <jirislaby@kernel.org>
Subject: Re: Splicing to/from a tty
From:   "Oliver Giles" <ohw.giles@gmail.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Robert Karszniewicz" <r.karszniewicz@phytec.de>
Date:   Wed, 20 Jan 2021 21:15:29 +1300
Message-Id: <C8NU3VCWCLXH.3CAMP4PFB70Q9@oguc>
In-Reply-To: <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 20, 2021 at 5:44 PM NZDT, Linus Torvalds wrote:
>
> But in the meantime, here's two more patches to try on top of the
> previous four. They shouldn't matter, other than making the non-icanon
> throughput a lot better. But the more coverage they get, the happier
> I'll be.
>

I tried these out too, my use case is still working well.

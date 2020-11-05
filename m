Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2E2A73D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgKEAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKEAda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:33:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76345C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:33:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x13so74928pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW/sv9yrZBL+KFBJhrCknWBwcN5pLx4pYyvBQgpEhFo=;
        b=XFCODDM0hRu5r4xs9VzpGAw5JCdxymkEQpKRuokkBNR61wWkQsj5pWb93v5Xe7rHNy
         3ByHrk2pHL1RZJ/7Xsb0aLBHnpRQHM4Va9dnDcjquddy+RV4Yb+cOnlbV1aPQPbtwO7r
         51cD9h+54oXTEQHuFIuWJfWFbrXCBtBq3k8xCe0AfG8D+TRtMA35Cy8Vt0U+c0yH9I0k
         c9ihPo698l+KGWDJmPocVaJmFOvTXOXY4vYMRWbCPhSGQe2X27mytZFq0gaN+0GahIKt
         eDra94NJvUCeWOm2CP3BXpzV+AVLK5t5MIfoVJv8cP7jnx7av9MITEkhsCo9x7WmBQKy
         v3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW/sv9yrZBL+KFBJhrCknWBwcN5pLx4pYyvBQgpEhFo=;
        b=ANTrPYs/3NjItk+U34JTO2AI3B8waYEmwy2yU6QCZ7SirJMttq5PpaVDlWPAaPMLMG
         CyGzzrJ7FAzPNT5lpFWd7ctxkV7+Z5+AYKf5FAXj5ujQwKy6SPfftBA2/SLRyzPpj3sh
         1V8/4FrfuRI+8TIpG6/vkYnffv3R+B2F3lm6R6QBmOpOurtcRvVHHmOWwB/VOmOvLChd
         Ev+lOg9YSJVxBx0wjgpCOub0uszq+0WClRMPLpgSU/AMG6TbKPI+2yhUTE0Uq6ZuDh/6
         5EOJdo7gvowlYP7VqoSUOCTttIAUqNKV1zWd/hKvOneKx9br9YI7rRQN1hxwaws7XBIU
         2aLA==
X-Gm-Message-State: AOAM532qeBdj0JD1YlSqdTifmePtGgLdSA7dsPYqPMTPG/DwmnPxC5bO
        bVjxQKW/HDd90w4CRx5Hib7TZvaA/IlhE6dX0UMoOw==
X-Google-Smtp-Source: ABdhPJwsZDpsljgbmig5J01HoNeUav4/uq0k+hNcgl/HyQhkw/gXgfk8kIu2U6AVMF+CcvCX6t6a1kcYQZhOLFlrNtc=
X-Received: by 2002:aa7:9a04:0:b029:163:fe2a:9e04 with SMTP id
 w4-20020aa79a040000b0290163fe2a9e04mr574390pfj.30.1604536408833; Wed, 04 Nov
 2020 16:33:28 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com> <CANiq72n0FFfH6Uag5yai=tSzzOgVSLpzu5gyUr40d6Gb8GzZpA@mail.gmail.com>
In-Reply-To: <CANiq72n0FFfH6Uag5yai=tSzzOgVSLpzu5gyUr40d6Gb8GzZpA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Nov 2020 16:33:17 -0800
Message-ID: <CAKwvOd=eHpmKy4mQKpGA2qAZr4Ue_K+Y-1HNe07dxar7dHy0gQ@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 7:40 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> distro etc.). One of the reasons for that was to help adoption, as
> well as because clang-format gives a hard error on encountering an
> unknown option :-(

Yeah, that's annoying. Why don't you send me a patch that downgrades
it from hard error to polite warning (in case someone made a typo),
and I'll review it?
-- 
Thanks,
~Nick Desaulniers

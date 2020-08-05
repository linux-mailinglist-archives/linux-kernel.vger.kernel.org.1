Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E823C581
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHEGAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 02:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHEGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:00:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:00:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s16so31043200ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4amqNobMnQskrRNh+ZQN5FQ7A/kozEUHT++fPm020d8=;
        b=E0lc3CXjKOyhFJ8W5SEzXm17LIcj0Xxh/4gZmYN6Fezg6JlIZ9gTkiO10Hu6Y8A5Fl
         jlT/crgqUtTel97HkTyRgKllCCY+pt6rFE4bdSoDo+TFnWyGyu/i+DiKDUsLgpECvr52
         sZfUtg5J0QJEbFGMKhvT9jbLdvhnmouDo5bdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4amqNobMnQskrRNh+ZQN5FQ7A/kozEUHT++fPm020d8=;
        b=jCfpGnkkgA0xUHb+m3GXlmMxc/jS7IG308INZ1v5B4EeHEIkdce6JaLy1YJsO8Dw8S
         WYtKJS+aCIaaRDXRD130nJKee/Omi6/iBJgGlVaJsiK5f3KzVr9lXm1APySEHfBppKm1
         JAZTJ0ZoAVe9hy0xKqiyt4LwEseuA1Uc3ny/hXc+YzkZTSt43ulADP0Wy4CPAXC4MLjZ
         nS+lyvNrGvZ0h9nAc7THVKmQUhhwZfQqdU+MgfZBSsmugltzW+rjbbuFKjHIjJlD/o4q
         OBp3PL1PCPh3nnoOFyz5OWgsoIJ3LD3+2E7bjryykzUEKoz/8JXVyWXjOlDjcZi6Ll8c
         9sPQ==
X-Gm-Message-State: AOAM531tjjCxyS0/YBDLV5biPCysmg8saF9KWGMj1GyDwuoWhqyMKQcU
        Qj3Yf7XC0sgNbnEQlZYvQtGYu8ATfsU=
X-Google-Smtp-Source: ABdhPJwtcyNNCv3xibO55VvWkxIh7NSGC8SFg6Ygeix5/BzA0SFTHRfxT2rC/L0yKjQ0ir0I+ihFHQ==
X-Received: by 2002:a2e:98d5:: with SMTP id s21mr571906ljj.59.1596607251275;
        Tue, 04 Aug 2020 23:00:51 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id c4sm419797ljk.70.2020.08.04.23.00.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 23:00:49 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id x9so46306479ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 23:00:49 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr593746ljc.371.1596607249414;
 Tue, 04 Aug 2020 23:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
In-Reply-To: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 23:00:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
Message-ID: <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 2:56 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the following Kselftest update for Linux 5.9-rc1.

Shortlog? diffstat? And the actual git address to pull from?

I see the attached diff, and I'm sure I could guess what branch you
want me to pull from, but please do a proper pull request.

            Linus

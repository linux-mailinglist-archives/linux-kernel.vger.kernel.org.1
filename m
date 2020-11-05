Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD42A8A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgKEWyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgKEWyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:54:25 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:54:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v19so3317502lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZcLJAUQ94UoO1154NHEjNS5p409tRzMt1dLh1JV8X0=;
        b=g5aQsBMYMupRE3CUnCwnVcNQ6fopoEZDKGl2fL4RZHPQ0NiTDmLcz224jWhnD4PnLz
         9LdopQdSYOZJ8wG9IcOlNwySbEHbVjsPLC/lqoQF5hCaJe1TCyhnmSTCPEnwsbZc9QdU
         fSo9cNln3rr7DdycgxPDA3OcYzUKUaZ5fb9XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZcLJAUQ94UoO1154NHEjNS5p409tRzMt1dLh1JV8X0=;
        b=ns5LJRydZEiweGtK05cgcNDsGxLRnnXPJAaBJWMgO09fdJ2sqdvhRcUjp4JyIOzczW
         FEP6GsxS8mf3bMBueE+0GUdxSkfAx3F5g2XF9zBNQy/x78EJiVmM1NAzin4hqwDs7EYP
         PX1n5k0cMumT8BnZkLksZXQ23h26yOupTJ2hVzBd/Mw9mKTPeWTS0OqZg5RWr09nCUmI
         ac0Bcfh6l73qloZSHvCOkkqlq+9F2IyY+h4qDb24AEE7YP7k+MmU/UxksLDzp6FhhtGk
         CZ1a+4VgSLf9enSg7mJGAtOZLUAVh2pxtZ31SoX/zRB7/c5OdshQIsCJmXkUIoFmLPiz
         mQiw==
X-Gm-Message-State: AOAM530dv3Ej36ahoO+Z00ZqrD2GkrLdkplyWyils+ifXMEn7iWYtgnB
        EQGuBmREea1mBvs7rENcW7EB1VDD182iyA==
X-Google-Smtp-Source: ABdhPJxWw4JISoN0raI+gaAP851VdSmmqbUeXqojxRngLaRcW+C9FaIEqlKnjovcBOGBPZO8anLLkg==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr1623988ljn.126.1604616863153;
        Thu, 05 Nov 2020 14:54:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h5sm316345lfc.106.2020.11.05.14.54.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 14:54:22 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id t13so3299176ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:54:21 -0800 (PST)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr1598737ljj.371.1604616861466;
 Thu, 05 Nov 2020 14:54:21 -0800 (PST)
MIME-Version: 1.0
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
 <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
 <CAHk-=whPe8hpnMw9UpXyL2s+tyWX3VaG1yL57_zzwFLjP5pw5A@mail.gmail.com> <a0d87f58-7ef2-1854-ea70-5d355b20ed28@linuxfoundation.org>
In-Reply-To: <a0d87f58-7ef2-1854-ea70-5d355b20ed28@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Nov 2020 14:54:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd-jLMYaQoSz5+US0fEYCu2rLh4vn8X_WJu807k++DAA@mail.gmail.com>
Message-ID: <CAHk-=wjd-jLMYaQoSz5+US0fEYCu2rLh4vn8X_WJu807k++DAA@mail.gmail.com>
Subject: Re: Kunit fixes update for Linux 5.10-rc3
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 2:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Oops. I don't usually miss adding [GIT PULL] - will pay more attention.

No problem. As mentioned, my own workflow doesn't actually care as
long as the body of the mail has that "please pull" and "git"
mentioned.

And I wouldn't have noticed the pr-tracker-bot reply missing either,
if it wasn't for the fact that I replied to the pull request for other
reasons..

So no worries, just a note on how that "[GIT PULL]" marker might be
helpful for _you_ to see "oh, Linus pulled it, I can forget about it".

            Linus

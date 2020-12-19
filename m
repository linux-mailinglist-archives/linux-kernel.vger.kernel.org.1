Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5871B2DF15B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgLSTwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgLSTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:52:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E7CC0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:51:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so14185006lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aObHMwS2l/h8XgK38EqzKLAJLXjj3pv5v39i/PvaoNY=;
        b=Pyacy/Vj4UFv/VgYA+WJ7hm3LxlTYZ0FtXFCoPmWC8lo9AI564rFWc6JjH+1A7PbCs
         Li6X2lxbVlPRjsHHiL2x9W+F/Ulr8gzbwL8cBl5PlMVNtyYIsMTLUIkR1UWVaWaUcHp4
         ekgDZEuEw/Q189WsQ+jORKGbDamPCI8xTJiOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aObHMwS2l/h8XgK38EqzKLAJLXjj3pv5v39i/PvaoNY=;
        b=iS7trzWsFUvFUvAXe9OqMwhKS7t7Y41F1dWuogSv+sbpt0rkwZpOjeMOTYwC3TNLqj
         3dWH5D0vnab60z66giqYHuKXcZEID7AScXDWriSsJ/H5w5Hsnv2QyY1SYBWuSPWblKVq
         LWR40L9CAs/XNNgb8mWTJTnBG3L5kOTWrVCgF7ai/x15qzUfU7hRmp97KSaRVJVBouxp
         efvOBvLPW/TzomMMQhaAbGOCUkgICUGVQFL1vVWafaJi51Qq5ju43rZ1MmwiDnhZ7J8/
         UokcKvkRzQhhz8DCQzrtnbXMD2U4bg759Cr/eYk7LE3VyKbYhyPMP1OpdtfwiM/gwd8r
         IwZg==
X-Gm-Message-State: AOAM533zxNSNvzbqk5LnEWPtUTOkSTCvCwkNqFmIak5UKGBUBtxxs8nh
        TGtlnm7A7EDu8i6MT0cyo9DOSb4m9l5/6A==
X-Google-Smtp-Source: ABdhPJwFxgIxmfz9ccQCt3NKY3wSfjCbg07ImXyqijMKFLXESEQCwHEb69OkFWaRpaz1/4DLD+VKxA==
X-Received: by 2002:a05:6512:3319:: with SMTP id k25mr4029243lfe.128.1608407496791;
        Sat, 19 Dec 2020 11:51:36 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b26sm1530363ljk.132.2020.12.19.11.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 11:51:35 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id o17so14259912lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:51:35 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr4130672ljm.507.1608407494717;
 Sat, 19 Dec 2020 11:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20201218160401.2478999-1-thierry.reding@gmail.com>
 <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com> <X91QA5bXgPXCiS8U@ulmo>
In-Reply-To: <X91QA5bXgPXCiS8U@ulmo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Dec 2020 11:51:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8euU2vcbDK4_shjXL3oBx1k1Eo5Ucjf0Fvp2JmL94HQ@mail.gmail.com>
Message-ID: <CAHk-=wi8euU2vcbDK4_shjXL3oBx1k1Eo5Ucjf0Fvp2JmL94HQ@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Changes for v5.11-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 4:57 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> I didn't realize that this would show up as all new commits. The reason
> why this happens is because the first commit in the tree is a fix for an
> issue for which Uwe had sent an alternative patch to you directly for
> inclusion in v5.10.
>
> After going over the patches again as I was preparing the pull request,
> I realized that the commit message was no longer accurate, so I changed
> the commit message of the first commit, which then caused all of the
> subsequent patches (i.e. all of them) to be rewritten.

Ok, when you do things like this, please mention it in the pull
request so that I can see why history has been changed.

In general, I'm not sure it's worth changing commit messages unless
they are just *horribly* bad. That's a gray area, of course, so
there's no hard rule about when to do it. If it's just "not really
true any more", I'd say let it go. If it's a horrible mess that will
be very misleading if people start looking at that commit, then yeah,
go ahead and fix up it, but remember that you _are_ changing history.

Changing history _can_ have good reasons. But particularly when they
happen just before a pull request, please please PLEASE make it clear
in the pull what happened.

            Linus

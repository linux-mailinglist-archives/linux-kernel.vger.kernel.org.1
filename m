Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539F42D25D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgLHI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLHI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:27:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFEDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:26:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r24so21872519lfm.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XCWHt4ysn/EFBhmkpBIxyKTWH0ki1D5h+fBNmPMfm0=;
        b=R/4Ww2cc08c7iIqfaNx9Qit6Ci3xfXlqC291P5W4kyjQVjgoq5baG121BFYNDZ5JhC
         jN2fCyf8tFcaHx8WcDVqsExJDIaDdifkvaVEOX7rxcxWgBy+9PiTl8tmD9nZLyjfHSPP
         JSeGaqYq3DPl8FfDpdHYO3PoxX3ugMtm+bL4LnHtY4qYS7D1ZGOQkXPWsBckZs1I/CfW
         ljyd6TDjSpXqr+aF4oA+gMw/K6b8zmNrDBIilJoGj9yT6rk8kENdNzgZb8UdsSEIU9yy
         P9oz/T5OawZpLGkkqmVKF/fZHQG7lzaZ8vdQ+QBdz83apUCObCGtjLFdq7aUtge0DzJJ
         Dx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XCWHt4ysn/EFBhmkpBIxyKTWH0ki1D5h+fBNmPMfm0=;
        b=Gs40SeenLUF0OR5xatT47UHuGy0Jpyn7NArqXYlHXIOiwt+sQmLjzmxQos68iMO0WL
         p8a5SjhhR8KrecxpaDFXu+1vX6aHHYvScYR65W3rEtmC6cd0+QUxJLxOjI+6G2RQBFEX
         98oVkbPLf+v1d7HAOyp6m1eXpJhxEaWlqHwVG9nasnugVK1lPEIhMPC8H8qTzx9axAFx
         fMKaf91hj1Onq2UFwF93rfnL7aAiCixjTVMI9tMbQVZGw/6IfG+QJ1lOmgssYz4lSkxE
         ganDW6RTTKBml/RgFFdb9p50UgjSTIzJLu32jpEH0ia19A68U1C/JUVjYJX8KbAEDB8T
         TuYg==
X-Gm-Message-State: AOAM533vHyxmcRD34r8KmbLJ3NqT1o2BXzmW+9f8CjTqL1T7+ClKAucU
        nL51Jaevgq4OlZyzyMRNm+iAfGgbE+fB6RKulQWvOA==
X-Google-Smtp-Source: ABdhPJyr1SbGQ3T10AHNBB50oJwSz/j2jQByv6Pwgnml59Xz/oAD99kJ+Gj2hQNrZljLojbtyoUj9YUMsrOnGTPQT7A=
X-Received: by 2002:a19:cb45:: with SMTP id b66mr3266398lfg.441.1607415982808;
 Tue, 08 Dec 2020 00:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20201207071649.272eba1e@canb.auug.org.au> <3f182394-8cf9-4d50-854e-cdcc33621b5f@www.fastmail.com>
In-Reply-To: <3f182394-8cf9-4d50-854e-cdcc33621b5f@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Dec 2020 09:26:11 +0100
Message-ID: <CACRpkdYy6cFUYerfPUV8_46ge1gCFG4W+Edr_tJ8YcbH9qvBdg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 12:39 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> On Mon, 7 Dec 2020, at 06:46, Stephen Rothwell wrote:

> > Maybe you meant
> >
> > Fixes: 9b92f5c51e9a ("pinctrl: aspeed: Fix GPI only function problem.")
>
> Right, looks like I accidentally grabbed 6726fbff19bf from the 5.9 stable tree.

OK I fixed it!

Yours,
Linus Walleij

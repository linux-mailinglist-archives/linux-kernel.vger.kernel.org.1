Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F8B2FA471
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405575AbhARPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393217AbhARPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:15:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29152C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:14:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g24so17933328edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HugYEP6XhIuhW4aanJeTiB3SihjPPep0QNF5phL7i5k=;
        b=jEZrpgW8R5YlIH5aHveUsS7rToDnwcuYnBp9XYZWsoLcDm3lw7mM2+z/wCSBdkesMk
         +ylTNZRHw6KKad31zYLjllSOEE0P8c2hobeLd+FKqYf41e9R7ueYPBDjyfw3CZ+hRj1/
         UnKbTJq+Ksk+ToPUCO6WAHb4tzExB9cbiebXf5A5OKqGAFqUMf1rzYBoJTuM8T9mZ+mu
         08Y1m+uIhexLHHAeXSVKHuafBLUZyYN9Ac8+8TjRNpS5A0uwPbWLJlOyBN435AO1XGQU
         3Jtn4ry9j9CBBEJPEEMQ186gtAu4nuNkaTTOguCQEYHKSU8xSNUAwGaoAF1XZyJdgTwe
         Ke/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HugYEP6XhIuhW4aanJeTiB3SihjPPep0QNF5phL7i5k=;
        b=N9xMX8Aadyzvqf8qVGCstVB/fARyC9ZmVTAfMsmhSwHliGArZYbCmROdmkNEyk6RJc
         28aXh8YHNjjr4t05ygZGaC/n3j566TbgJl2UmE4Is1fp8kvcQ/ScCy3zt4GE+hz9tbAC
         4+30P5Ed9WGUKr5FJfixnEY18UUP+PAWD43MHFNQ02RLcCvLsTjL1BrFZnQ+8ELBOfHc
         ieWJKVNHCPjECAUMBlESrIdsXsE/je4T5iPfaSeTWy5FPv2Dp61XQiuivwrBbPGh+3hJ
         PfwBid9FDTp2dme4Vq467uOHj58OfFufihmLK1DyybdngWRVWKTtWGw69QFf+ytZytB0
         aIMA==
X-Gm-Message-State: AOAM532ZBcbscYmsXkPpMt5luirixyQm7S9LHjltY77aUome2Z8v6+bn
        3qu1kJJ+dK9qtjAb32tP61w7roVmY89QXSOQKHEZb9SreIU=
X-Google-Smtp-Source: ABdhPJxaEwCyV8L6L450Mo7UIUS7JK+undDbHYFCbzMfz9Zc7fUG6D6Ty3jDxAG1B23/Bum1pkrni8PgsxEnSER8kNQ=
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr5540387edb.367.1610982880894;
 Mon, 18 Jan 2021 07:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20201213235447.138271-1-paul@crapouillou.net>
In-Reply-To: <20201213235447.138271-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 16:14:29 +0100
Message-ID: <CACRpkdasEV9AFih-_VJQqPb69XHnD8DkkAB5qM7qyO4+D=ebrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kconfig.h: Add IF_ENABLED() macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches applied!

Yours,
Linus Walleij

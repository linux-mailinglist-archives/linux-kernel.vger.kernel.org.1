Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124D82B772B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKRHtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgKRHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:49:52 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D8C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:49:52 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r9so1555112lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpwNtBtS0AiBZf/1XElP9IWaoZooLdEmkzOBdTyXQDU=;
        b=UtQVRpMtEScbhPN9aWVDQaPgL/y8m1RcJSrBepPS3DdzBTnnbZcZbWENe1C5WoUFNG
         v9RBSt9AmEsbuW0EBPGGjeIZcjUS96wk/BYw9oe3abcDp2W3mNDbBoZOQWq35noUIB8W
         yFPwhLFdtXEpSu9SJ4lZ9nEpASsz0ypuCZ1pD5st6XAOnpjVFPQ08Rqminm2YtlDFZsT
         DJsoYCWdGXMiYWBpNjgVm3sbExjdzNsr2TgGWhbwYJP9+rAMykMIOnYogX13wTP4Eo4F
         V/j/zqcyIgn9ewupn0GohiwRckUh4pNmUnkYmDmV4/pGXCq6+umEOLSt2khGIkNwLcVz
         q4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpwNtBtS0AiBZf/1XElP9IWaoZooLdEmkzOBdTyXQDU=;
        b=YD4wrzVokycXfD9KDxUlRo9vmoIgs4QaO+YfDBLFBjBzn16fKvpIC2/ES4xQeA8EgW
         oFlwOoOvPcGwosU0b4Kdizry6AZzU1JK2LnmqsqqsxeHfdbVbQbelW8+DbxYGMJj0Loe
         KPwE5l6osb8+vGvNT5AUs7C1DN0Ic5MrqjCT8tOPJdjfrZQq9IrxdHZgmHwjHp7kGKii
         1H+1shqH2EqRZLWpPVOSajzkpFdsfW8sFgNFL+l89kxP2nuL7GnuM8ndsmLflTRNB84G
         XHaCbLqkJ8C5dh3oPEqNLq5EIZhnzj5cNyZZAafLaqcwHlRp81Lj00b8m2e7fsxHyIHl
         wuWw==
X-Gm-Message-State: AOAM532qMzM2IwxKmyjZs44e7qHFVOFTzfvTTPFrVYQ0JFI3E37c+rI5
        zz164DN37ksBS9NDWpK8AX1hqJxtar+nVJoHQr3EOg==
X-Google-Smtp-Source: ABdhPJw/Bs6fCsoaNtO/fMxb3ayxlfAN8J7JhoCsVLZA5cWMd7BteyBUxU9GD/gNcsJ4ionlZoi2pKIuFYNUzi1O4jU=
X-Received: by 2002:a19:546:: with SMTP id 67mr2986407lff.502.1605685790813;
 Tue, 17 Nov 2020 23:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20201118142445.461d3792@canb.auug.org.au>
In-Reply-To: <20201118142445.461d3792@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 08:49:39 +0100
Message-ID: <CACRpkdahE38tamkVZLx+m3nkE_dDfaN-u7gEwH48BEnf1BvsFg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio tree with the kspp-gustavo tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 4:24 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>   b8e0b635e6e6 ("gpio: Fix fall-through warnings for Clang")
>
> from the kspp-gustavo tree and commit:

Interesting I guess this is a clang tree?
Please rebase on the GPIO tree and send me + Andy this patch so we
can integrate it properly.

Yours,
Linus Walleij

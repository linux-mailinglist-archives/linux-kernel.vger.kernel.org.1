Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C35292889
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgJSNsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgJSNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:48:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C92C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:48:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r127so14210235lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvmvIl62QxxYsRuevZ4ZPz8m9zlF6eoCr1pNFZNeDvs=;
        b=GFs8v2SjypMqXg6oTSGYrihPPFXDpWYZdfEmtpwvIGCtQgl/eTXWGMn7glIOUJNlCS
         L4TnJqoK1D26JI1+aGd8HafqSMDjOnHWdEmpxQfOgNNTppNMzHOo6f0On8T0VVYYmur1
         oEOVJJDQciDQFAStYkjy/vKKYWve7dQpnEBiYM1KIY1vz+bbgmsTJwtCrYMbvZvwoD/+
         8FIY5/x0CsZYPpOsuHV3kG4BvZXKPrw6JHF2CI1dUeJstj0LsHs30w7UAbpOR2RhCNOH
         iPZR5m54arZVtw0m1paw4YVz+mX2Hz2YmWtSUAQ57enc62iGDsrVnPz4b/qeS00hNIN8
         upLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvmvIl62QxxYsRuevZ4ZPz8m9zlF6eoCr1pNFZNeDvs=;
        b=fSMKlR9VeXyJQ4R5o04lSPwEgHQlCozViMELTbAKoBL3SRY4MlOM62pPzhC79gQMoJ
         /R0GZc5yDwXSVCHyHpE3Wo8cX0tfA+ERyCxhQ26lmRBMQVVocgUQ17Ec6w+jXJfTeU04
         Y387surXdKMbljYs8t9JTEQpfAFbcNUfxEHAOp0ZH3kuKW4UQ8n7ChDjU94lSJ4BZbPe
         bqI12Ejgs80LhVEohGbb6FvnNdlqlucqx023YF1ubwAWeI9HmF++UVAlF5ogxZRREDAx
         /RnFp6abDwoUfuTKdc93mlnIgpQaIuyoaugvrpWAmJZ9IlyLRboLrbrqt408SwaRwdQs
         GtGg==
X-Gm-Message-State: AOAM5315+6mIvqReYR4B+hsJK5XWTPpRdMz+ypFsrV8jb8qUD88rgipA
        UruoxNaTsvRM9G/lA4an44MNvgqhwJbhp7CBudnwZkCcBph1DA==
X-Google-Smtp-Source: ABdhPJxMmoMICERYWMHmh24WCSuO7fGjQ3abrirvhmBz7oLlTqWrO88FLAxzgw+xdqrOkZoqTJ9smtS+SCzJIBk7USA=
X-Received: by 2002:a19:191:: with SMTP id 139mr5337669lfb.502.1603115318472;
 Mon, 19 Oct 2020 06:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkda1B3LcGWc1PhXNgi-6JxapiKY4F_94c6dk4eBLgVGBJg@mail.gmail.com>
 <20201010192509.9098-1-paul@crapouillou.net>
In-Reply-To: <20201010192509.9098-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Oct 2020 15:48:27 +0200
Message-ID: <CACRpkdZMC--Ejvbd0CU7+jTrtddGmu_01=SsuuQTGasZLi9wxg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Fix invalid SSI pins
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 9:25 PM Paul Cercueil <paul@crapouillou.net> wrote:

> The values for the SSI pins on GPIO chips D and E were off by 0x20.
>
> Fixes: d3ef8c6b2286 ("pinctrl: Ingenic: Add SSI pins support for JZ4770 and JZ4780.")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reported-by: Artur Rojek <contact@artur-rojek.eu>

Patch applied for fixes. Thanks!

Yours,
Linus Walleij

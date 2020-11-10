Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17A2AD829
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgKJN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgKJN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:58:01 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DBC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:58:01 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so17614060lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuWsqptt1n9mhqLua/Oud+hmIlWR48NHrRbAFuuuDZg=;
        b=GCc0h1EsBndLL/ZhuCjj0hiSElwGiZutwHX3KZXlV+o/pY93C+o1oTV/erVNK9cEKF
         vKSS3/WuK5jq5TTuTdME8rJCkaQuz5MARY/Q43Q4tg4xzhw/UwWji6ESx70v52M9aN8e
         JPutB91SulOk2+mAU09imr4saTEqUlCT6U7Ti15SHtHvgABhGzVrbLwnl0uud4BpD7ID
         rtRqCMq49/qZ+vU9dRgEEpvy/7GrXQpIzOCtsQjwCoG0uD11C0XIo45/j8iSF3dXzC0/
         7KI8mmelAUD7BmDONYzKnpXZHcbSPMaVQH0uEyMmdNLti7/m4CnHs83gkWczxF/ICDI2
         OXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuWsqptt1n9mhqLua/Oud+hmIlWR48NHrRbAFuuuDZg=;
        b=PdGQAn6kr4wCZJ/NivNgTSR3QxxqlNG8Vih5sAYOC7o+L81yihI5DHM2z8rl+Cu6F0
         8XRSnS2Ncx8HFeF2mZ427DY9QMAWuwOW9ME/55XeQg2A+n/6TwmP7hvWYcT17T/MYhrM
         EVIwhm9a0npqRsBJBvfPOVvZO94vjkV6SBXElJQCDRTAH8bk1R3rxe+OGzlJl6WZ4VRY
         j49KNWQQ9+enCIhK+0y//V6gK4FHn+LAe4rejRQYZHMZluJfm1TUGDWOVmp3HnsmrCNh
         jiiiXRdiMTCBlsBxIJ0brv1t2UWUEkxAtC7jINdIzyXV4YdcIsLwGgC0rpSvUxuwNqip
         EfQg==
X-Gm-Message-State: AOAM53180xqryRckK/Gr1CMn2g63rGJ/2SabEaQYOuHah9FnOm4p1YjK
        zqIdWgCC00WqboDsZuEtdx95y/pPmuDVkBlhJEViIg==
X-Google-Smtp-Source: ABdhPJy9Y5uqpU0IXwknk4/ZnEVzED9Jx1G0aAyPe95iTs9e2vO5D0sypAmSYqjfjCJHBqK80/yyAa9w3qRe89O8wO0=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr7237212lfc.585.1605016679593;
 Tue, 10 Nov 2020 05:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20201028043642.1141723-1-bjorn.andersson@linaro.org>
 <CACRpkdaBbdC5_6y=w5eL-jJ_Mk+toKWy8kj9t-UWx02wNfjo+g@mail.gmail.com> <d1c2a25e-3cb1-5d67-d038-be80094c64be@linaro.org>
In-Reply-To: <d1c2a25e-3cb1-5d67-d038-be80094c64be@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:57:48 +0100
Message-ID: <CACRpkdb=qt7rNORLs3VJCa=Wg1yzgL5-1wujOr4r+GhRUx3_yA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8250: Specify PDC map
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 4:01 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On 05/11/2020 16:59, Linus Walleij wrote:
> > On Wed, Oct 28, 2020 at 5:36 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> >
> >> Specify the PDC mapping for SM8250, so that gpio interrupts are
> >> propertly mapped to the wakeup IRQs of the PDC.
> >>
> >> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Patch applied for next (v5.11).
> >
> > If this is urgent and needs to go into fixes, just provide me
> > a Fixes: tag and I will move it to the fixes branch.
>
> Yes, please:
>
> Fixes: 4e3ec9e407ad ("pinctrl: qcom: Add sm8250 pinctrl driver.")

OK moved this over to fixes and added the tag.

Yours,
Linus Walleij

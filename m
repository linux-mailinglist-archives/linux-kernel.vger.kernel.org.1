Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C32C718F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbgK1Vvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgK1Sw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:52:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84662C02A193
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 04:53:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y10so9114016ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IlIvchaGqs0btCVgitstoAJH0DK1ZhI+B/pX56Reng=;
        b=OH9i/gOrYN/YWvHS6WhNM5CJ4lRWFY/Q25e21UL0L/6FR8LeVhM3bJCQ1xDloTmgHh
         1GF7Geg571rx7ZbRwSFaC0ymQD789o4Y1qBtBwA0OYA9IwR3sMlr+HR//CeqdBw8ffOv
         BmYOP3K0tbghFQ6HpIQmNAY2ujR2rXs4Wa3yi0OjxbPF44wWnFHrSljtm4J/4uIhuljo
         /ga8jIYUBbriUXoo7tT2jvZpG/jHGI3a85/o3bEWks3+xnXFOnPXQEMowswNde2II3/k
         K6GdyE3Ubk5d4aDjdQLqNXAkOPuKueOAavhNRdu/oO5VZpU5BM+kKJpfe5H6SEelcWJ2
         l1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IlIvchaGqs0btCVgitstoAJH0DK1ZhI+B/pX56Reng=;
        b=lywI+z1RMKWybhk+6HNW0xLjlsa5lvR6nkqGzRi+qrCnjmtI9Ft+X3eKuiyhvk+Ui0
         VPFVofPWXoBL9TjQnvhbEoh7/8yGg0DMiIbolmjYJ3jYNWW14tpImtTxFgnxDT7nydHr
         PMrejoxsrQzmOVbrP2NIZOCQUBGy2QwhbOKxxveKn7mxY7Yg0TZVgWQPTFPZUnbv4/3I
         5dnoqOFNPRT6v7uvezWsdGk5+2L1xouUIN2DnPcKyjieSuTfkeTW2oRg8ajBDEaZ2EIi
         E60r+Dr6aA8NnAkA0MSjKL4AtUzW6joSrERjf4HFkia4eeNkmUlx3uTQ1agxLyAVMzLp
         8LHw==
X-Gm-Message-State: AOAM532Q1CZCjgwTcgwS60X2VQjmt8mtn4OF1TJrNm4eUfuJyLoj1KtW
        W3oZ/OIw15ZSRuZWKhCZqJKeY1SuDYfVWcpDE7HMZw==
X-Google-Smtp-Source: ABdhPJyXw+8Oogbo0tn4XRy8/5DhuiOUOkoEyAyMRjyqKkZaMxR3y0XdezrtsN3Yyhv9Z9XVI+7hy3rvqZ3s4aNT83g=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr5396033ljr.104.1606568032506;
 Sat, 28 Nov 2020 04:53:52 -0800 (PST)
MIME-Version: 1.0
References: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de> <CACRpkdb4+av1sDrQHYXYeyKemnm2a9PFGQbu++UHEe6sspRACQ@mail.gmail.com>
In-Reply-To: <CACRpkdb4+av1sDrQHYXYeyKemnm2a9PFGQbu++UHEe6sspRACQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Nov 2020 13:53:40 +0100
Message-ID: <CACRpkdaAo9+Zm8BrQx9RR-G32DctrxejX6-6A8qJXUkW3+-p_w@mail.gmail.com>
Subject: Re: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen
 of Google Chromebook "samus"
To:     Andre <andre.muller@web.de>
Cc:     Nick Dyer <nick.dyer@itdev.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> This commit also breaks the touchscreen on the Samsung GT-I9070
> mobile phone. All interrupts stop appearing. If I revert the patch
> I get interrupts.

I found the bug, I think.
I sent a patch.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677E22A7B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKEKQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKEKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:16:32 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 02:16:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m8so999271ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzY1VkvmYL3pvQ6ooemzXER1+NGHzQExssTtwYHfu3I=;
        b=XTFQbF5935sVeuBgqmaOO5pdnb3YL+UApn4NnnwcaWSfdg4FAy6KlYTD8nryvGlxg1
         zmPsKr1X/9039LndgggUw00Pk+GXaNGvH1pRx2VVE5oowCpSYyb2407ZeNMNTnh++S3g
         jFihuaqOm1X5T2ZVRothVsfeqaqcW1kGB4eZxaC7Sp0ydjd6NRHvC/r2L4WXFLJ9SNA7
         8Ye1SiLbKEiHIeW6QWCn5epaHTPKW+nhHBOkqUlxMQg9ke6QBQ3MuX924sxywTVuTXZP
         2V1c/2Gbcq0mBXzpawm8qxP7jzSJz5xS4QNVuQlLYTMJ+lvcxQKKkfqEQvYQ/YnHtkaD
         /aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzY1VkvmYL3pvQ6ooemzXER1+NGHzQExssTtwYHfu3I=;
        b=iOdVNZdEa/jRW6VwifIohi/oIrIfbsXGv15Dr1QQZPOILkUmYPf5R+YtBlS2Uy0a5O
         nmA3A3LD18NEae+G0wun6jbUMy66mq/KbbarFUUncUrQXmBgo2QAuIQr4u/0K6WlgEj6
         6IBXDM/vjPHS0TQoGp4f3e7JhtJ+z0zGEB671jIfwEf+Pyyph4E2Y7c/BWV+B/hkviAz
         5t/uFLNferb91FKZGmUu/+6w2qxMycVVuhIwuzj0vTHcZJb7Gll+mFF4bBI9DflgtoRl
         xgxoPbMiVOcc+x+dczADRRcWXnLKjK8wTkLaN4aTWHxyz46UJAgtIQEsGxFRNJZFr7TW
         eewA==
X-Gm-Message-State: AOAM533Xq5f1eji60fjtMqOKaj02P9dcogr9KnGJ3bfvuweAJafTUGng
        vqX5yIZIA0UZLhw7CEX2XU1Nnx7cFH2F6MPQpsCIkg==
X-Google-Smtp-Source: ABdhPJxaq73gcB/JxlAqEL/i+o9calac2E7MR1bcyxAJh/tpAKN316vVzkkP8N7+kPd9X5pE5hxh+OwUmsUZtVAg2Gw=
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr668709ljg.286.1604571388670;
 Thu, 05 Nov 2020 02:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20180129005948.7714-1-bjorn.andersson@linaro.org> <CAKZGPAPrwXNeYk+bDiMBRczVf4PaBANnzhmenZie+V0BJ7OqBg@mail.gmail.com>
In-Reply-To: <CAKZGPAPrwXNeYk+bDiMBRczVf4PaBANnzhmenZie+V0BJ7OqBg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 11:16:17 +0100
Message-ID: <CACRpkdZ2UzA=Hyw+b20dCqzu8+L7_D1bTM44MKbbue2VFCY4UQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Use dynamic GPIO numbering
To:     Arun KS <arunks.linux@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        Arun KS <getarunks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:21 PM Arun KS <arunks.linux@gmail.com> wrote:

> Im only concerned because, after this change, the use of gpio number
> from user space has become a little difficult.

This makes me a bit puzzled so I need to push back a bit
here.

What is this userspace and what interface is it using?

We recommend using the GPIO character device with
libgpiod for userspace applications:
https://www.kernel.org/doc/html/latest/driver-api/gpio/using-gpio.html

Is there any problem with this?

sysfs is deprecated for years now:
https://www.kernel.org/doc/html/latest/admin-guide/gpio/sysfs.html

Yours,
Linus Walleij

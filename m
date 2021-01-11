Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02A2F225C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbhAKWB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbhAKWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:01:24 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:00:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u11so558659ljo.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVdLysk1x6ZZsXbP0Zr5h+mMevWQuwTL1CpskBya6v8=;
        b=u4OsVlAAndy3l+Ngu/fYohy/mYFqxZDi4TLDNXDuZeeg3kChazJI9iXpzSE1HPcz3J
         UBulNCJkOdWiFliA2DuqX/vmg2SByWNgmhYs9F6nwFU7kL69aOkIMK8utFqCFoMW9Gw8
         nRTHRCtzv8cSD3n/3/R6hEg4dWPf2eXdapGk9/S6u6IQpV03ZNiontp3DtUP5s4RekbR
         h/z5F4A9AIq0Rvg381fUFmRmIYQkyRJBSDApLDdZT1yQbygM/j6lmuKKJgCEZCZDpD0A
         MnBrktjJ7LQoerAsJn3KfGe346IrqAtOZXXp/107SzHRLheTBO9SjLSojxn8uwHMUfVY
         ehzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVdLysk1x6ZZsXbP0Zr5h+mMevWQuwTL1CpskBya6v8=;
        b=Mten812PaJyOFSiGSUSKD7Ujp8uhS/so0XSMyC3Xqk2APmAKDEwImtBHdYx7dk6tv3
         ewOQecbluTfQezllGyw+DPAQU10VUGiTgFEQLbBRRzG5mw78opL4QXza+6a4iLmTfeij
         UktFKKs0vI0cJ5KVbQYzvcoW6fCzGoRaPZhonTUXTH7PFiumNSfTKSMRlxWTksLLi8aF
         4zQ9R3Gd3gQtLU6yH2wdeMOti+5OBN8kfm6PuODaTqzA26099liX3lj4M8p2LleVMZnD
         E/VIJCDJmW0lvyUGvR/os4P/vzmAYgCjOM6KhFFVTjhmmJX4sHmnRVNrwM1fcQUY88wk
         Ry8A==
X-Gm-Message-State: AOAM531hvmTDGkpxqCxp89kh9CHMazdndsn7OxA2wINyVRRqCXC5NA8m
        xZjES+kYpFtu/8LlgMI/71Eru6FMEvyFKSixgCpihQ==
X-Google-Smtp-Source: ABdhPJyn6aCXyneWJOgZKxnoF9Ct2sh9Dfr16D2OhX3Out/rqGrQWppRJQJ0dfvbe8j5pKv+eDAPpyQFMjIjJbKbdMw=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr647685lja.200.1610402441598;
 Mon, 11 Jan 2021 14:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20210110231752.1418816-1-alexandre.belloni@bootlin.com> <20210110231752.1418816-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20210110231752.1418816-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jan 2021 23:00:30 +0100
Message-ID: <CACRpkdaGRujF0p-57L5HgRmP=3sZOUSBfCnwAxv67dhDwiBkNQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] rtc: pl031: use RTC_FEATURE_ALARM
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:18 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Clear RTC_FEATURE_ALARM instead of setting set_alarm, read_alarm and
> alarm_irq_enable to NULL.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

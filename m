Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D32AD781
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgKJN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:29:46 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:29:44 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so2352218edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Hjhyv1ODznxDZvv28mX53Q346Z2MPzaR8QZjz1eM74=;
        b=RXTSd0/eCptvcrfUbup7Lapd8x3eal4iaa+J2U0xlucffy89rj3SSCYfnyjSyb8e2i
         CkSmIgJg9ju8dt1ewBIdryqzQ4VtFwQhjvIHm+tmTPp/G4Tiua7hh8/LTCtlsMda+wAN
         SYEXl8GfDf0zlphnGMRgdmEA0C1ZDrRT+xQYy1xg1S2Urfhpkng1ypmZfO3aMR5XgI8T
         +Rhdn+AsPocyefwnW1Yzo7r8SVxS+vwdBL+rZvOT39wTqAyYTPqoI0DV1QAjQetUhl5C
         osoMPoFQe2e/s78tlNjwsUE3axo4SycH8zi82y8n89btzbo/+igN3Q+HHK0A18EwivFm
         xR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Hjhyv1ODznxDZvv28mX53Q346Z2MPzaR8QZjz1eM74=;
        b=HBmp8w+7xENtdngB8WARL1JODLLON3f2/FiKRAUPbdy4biYkMwEbG+PXoE5HGWGydG
         HEkLrTcvHShIhL9iwLfEcMyLgFDuIrFCpAyQxw9MOk/Il+iBEnn6Km8NAaahwd9NW5xd
         /52yUakg34mQaDBMF2SD8EQWmHrm9y62EAkizQSP4aXdPIeZSgKO0VKqERzycm+VIsTB
         EgWpkSUU8d5/5yCyheykDyjKLCbvFduAckJjeFK1jEMD+EyX89I5qJ/tvO+KQTc3DR6d
         BlEWCbzpW3SyKkauvO1MHFDvjgJ0SgIl/HcYzfU6k1DRfkLQgFc/gnQuAQD1K8w1Tw3V
         PUHA==
X-Gm-Message-State: AOAM532cnJDpUT7SmIQEV92K2B7PYvQ/nIgzT7f3rpa8guZUe7LP90Q9
        TF9AcB4S/NLX9ApUjUWcf0Bmjt50ylr7MbubHkikGQ==
X-Google-Smtp-Source: ABdhPJza93kzi5WELzMnY5jGFPnf1t9Ayc9HbuIqoLYEuFOVCRq9VhbWCOcWeIF9M/AGiFzn3mC1EDZSfIEnHErTa7U=
X-Received: by 2002:a05:6402:283:: with SMTP id l3mr21680277edv.232.1605014983110;
 Tue, 10 Nov 2020 05:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20201110123406.3261-1-brgl@bgdev.pl> <20201110123406.3261-7-brgl@bgdev.pl>
 <7f890933-71a7-28d5-75ae-8d80d6a67ff5@siemens.com>
In-Reply-To: <7f890933-71a7-28d5-75ae-8d80d6a67ff5@siemens.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 10 Nov 2020 14:29:32 +0100
Message-ID: <CAMpxmJXiuuRu0A=GPaqBg=YbW=nQX4WrBm9e-3SOkFuaT0rEFw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] gpio: exar: switch to using regmap
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:23 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
>
> Unfortunately, this one still crashes:
>

Just to confirm: does patch 5/7 alone work?

Bartosz

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4492F03C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAIVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAIVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:15:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA196C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 13:14:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so31525035lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kifOu64xMoeH7KczQZpg/DzUNcHtji8mTPLqSoxmIw=;
        b=NhC+jbemFcv+1/xo0tTBHjOZzn49yaauter3Dj9S0iu3q7J4A3OKxXFeMQq/8zQZw7
         amyf0YUWCS/vssebj7lLVz5UBV5TQ+yGfPBkmIgL7rFhF9OnM3wVCtUhWgVHXWHoyEfr
         ni8oVa7dqLYS3N/rvXCQZDnNdVLIFtAhbVFjniaTpd7SWFpiOYad2Vwy5TiXzExTcEcr
         I/zv7M5uNs+zN7BqgZfT7huo3B2BlQxW1QTSIJOhCP64nQHhOCbX9+wcvN8TaXVLvENt
         pPkTXLcHiuTFgun1yjSKG6gKFJHqyVBCzPkOQeYm1ZL20XqD5YR8J93Pwy7w2Wqjyb8y
         raSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kifOu64xMoeH7KczQZpg/DzUNcHtji8mTPLqSoxmIw=;
        b=bMrZm1Nz5eJ3NA1jF5r6mt2O3LCPjEhL8v5oBaNEu2j0/RrPAeBAR/CdEZ630WnSi7
         xl5c4lq0wFxxbz16AFiUf1EWy1TFcjS/OZc12Nlg5a89b40CiTETHzS16qyu50dHDX0L
         cjgIXshHAydDtyV6dYTmMiLMxlrVoWkKNZqiAJLVmVtn11Dk8RHLUlBlvPK88MiiMmdj
         QPPA28y3WM0YzYwCwqazKg1bqUwgKM8SRv7/uKp437/CqIZw16J4ae796PX+42FpDiRd
         nHGPd+yj+uwsgdhen2VEEhxxDEbsISyUWfMd4ij8uWSSHxJ/dBVTdYQssRhYy5YXIUsg
         XLfQ==
X-Gm-Message-State: AOAM532f6YiDSo10XCpF83G+deGTXYD+ZVW1BfzDuyWkYmtAZ/fuBXwp
        qtY8/gzx4SL0Zfcnja2fqxIn4R+A0OsK4+vLbBlXug==
X-Google-Smtp-Source: ABdhPJziB3kaeiDvLJLfYt0pvZQpZctrlx4d3aibVEs9asRPA9Z2izRha2bpKGvAT3BM4fC8P1HZj6fXD1V3n6B3TIE=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr4092858lfe.29.1610226887973;
 Sat, 09 Jan 2021 13:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20201218045134.4158709-1-drew@beagleboard.org>
 <CAHp75Vfwb+f3k2+mAj+jB=XsKFX-hCxx61A_PCmwz6y-YKHMcg@mail.gmail.com>
 <20201224203603.GA59600@x1> <CACRpkdb9RnGJbct+D-88JPDSbaVp1XS8vjhhHYosy20EPkLjaw@mail.gmail.com>
 <20210109025527.GA2918377@x1>
In-Reply-To: <20210109025527.GA2918377@x1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 22:14:37 +0100
Message-ID: <CACRpkdaOfU=OLp5D-EXK2oU9bScLZ-QjLdCSrewiSBa0SRRNwg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] pinctrl: add helper to expose pinctrl state in debugfs
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 3:55 AM Drew Fustini <drew@beagleboard.org> wrote:

> I discussed my use case and this patch on #armlinux earlier this week
> and Alexandre Belloni suggested looking at the pinmux-pins debugfs file.

This sounds reasonable.

> This made me think that a possible solution could be to define a store
> function for pinmux-pins to handle something like "<pin#> <function#>".
> I believe the ability to activate a pin function (or pin group) from
> userspace would satisfy our beagleboard.org use-case.
>
> Does that seem like a reasonable approach?

This sounds like a good approach.

Yours,
Linus Walleij

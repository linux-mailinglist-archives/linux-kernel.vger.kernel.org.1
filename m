Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8C285BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgJGJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgJGJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:31:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA333C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 02:31:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a5so1254325ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZrWrKujoAFMmf1DLSRO6/FD/g7L/54gCsjEBcTuK18=;
        b=krkBnti1eUSzArr/953tleST+HT8nwl8VH4rh/jOoqe3xUgUmb303Om8wmnr5jyhod
         Pbed0oHGRcduxLy7Eu9tu8mnshRa5mqUHaxlYBAd036agUTf0wnkghi2x6DLrclNpcgw
         HNb62yYWMGCYrTwENP1vtvJ0//3UogzYrgOaqPgOzlAMeP+nFzJl8jq5D18gzWvwSTbv
         bnnmjJJlia1D256kTZHn6eW6fYnofRp5/LmToJW0OMo6pLOMXBkJAIHPwFgcIuFQ6yP1
         5aUFvRqgkf+lTvLtXYK3EN5HVBk/On0huH/2VamqUKxSWqf6FlraSgTYAR4shIqYOAwR
         bQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZrWrKujoAFMmf1DLSRO6/FD/g7L/54gCsjEBcTuK18=;
        b=OVlEerSMtwo/h+aUrpcyUcqExIB57hw12yRL3nC/4ITPx74lTpCUJXUVXAB23AXqpA
         e+w0jdw1lBXajak2b0TdnU2M9XKjFIOk3eaXhD2Yv18AVHDLMQODEO9DHYrUQ4SafjsK
         taTx4AuSKpIorbJ6hdcNPLWTt37tyF8ZKcE9RGgUvSF5IqTDFK6XCWot7hVUp9AfDeJ3
         wZKhale31tpKy/xM8S4BsYJ8JDY9jxlc6BpdmANce1XOTa6eVvCWU+5OOMAoDZzvbX4J
         NNo/oeCpQgy9xXJCL1S/pRcxbkv2Oo1LyxtY1wCQGGldOryV6g0XkIMh8LZf8qI9Kd0w
         UgJQ==
X-Gm-Message-State: AOAM531XZLeztIm563n7hAcEM475mmBdoRb9sMjdiou90lFVTogF8Ug8
        Ze7CeanhOegkXjmFkJZoZEIYr2e/PmTS5/pJsBF1Nw==
X-Google-Smtp-Source: ABdhPJzc2qVg8X3RXvzOUBa6ZN/mUY341RdBZuxbDiVTHvWj8BywXrvBpV/ifJfQXMBdT/DSj8gwZMWbAm9jWr8J05g=
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr903017lji.283.1602063104338;
 Wed, 07 Oct 2020 02:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201005070246.20927-1-warthog618@gmail.com>
In-Reply-To: <20201005070246.20927-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 11:31:33 +0200
Message-ID: <CACRpkdbCF-qFJiPcZ_YpA-YOXVdVGocG-7CavorNm=9tB3+d7A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: switch from kstrdup() to kstrndup()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 9:03 AM Kent Gibson <warthog618@gmail.com> wrote:

> Use kstrndup() to copy line labels from the userspace provided char
> array, rather than ensuring the char array contains a null terminator
> and using kstrdup().
>
> Note that the length provided to kstrndup() still assumes that the char
> array does contain a null terminator, so the maximum string length is one
> less than the array.  This is consistent with the previous behaviour.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

General good practice! Patch applied.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACA27E55C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgI3JkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgI3JkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:40:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:40:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t16so1088234edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0Cz0Zm8YQoZqX3ZdlzcOSzBf2shLCSEiyc7EaC/Ajs=;
        b=TY5abaFEhAX8cf/YA0ezETfk+qya2no/nSWgqGwoVSy9JShJGpKxq0/9JBBA91gZVa
         ttKOPn4riaDEeLms5hRZBUgqMM0gC61qDUnDqJ8+VHRokeaj7Z3bvuxXB4vfHOfsvaYr
         8jAoDUr/LPhpUGFUl8S6zq1gAm6iRo0zM70bv19WtFckWNE60hld5hOQqXgYT1lvIVJE
         3O18evHFBU3EEJFWPjgyyzPZdTn/y39ajS+abk9qI9zUHh49B/kXXmzufu37P1zHCSMa
         KmFiUgUxQhqCN/YIDJVpp9hDoMv/ojd4NguQQP3gTWChL2plFTJNPDqvBsnQdqGDMSk/
         aLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0Cz0Zm8YQoZqX3ZdlzcOSzBf2shLCSEiyc7EaC/Ajs=;
        b=MMZFlbQgpQqdtUAkh2cKkULKBqozLiqPfXhAQmxEusZLe1lU5Gb5Q2Uyg+rEZvnKtU
         HE3e35MU5tWyuU5JBvGq+htXDMX0EvmcZ5fsirFg4Fz8Gc+OQNcDqROaLbL6JaBKBX4z
         nTh2iJE61akDt6RAR2FoJpm76N7Gr2FYHNGzbsNYIG7kY7YPeJqc9AVKA57F3NWGskBw
         gq7XVcwqkxnNHuvCaNApvQpTLngVxWsbqSeqLJHX9df5RcZSwPepiNK+PyWyy3PsLTxC
         0A39LFLLJyN1gcIom7i5rvb7nYLY40IJj2UN+HtbfALLd+DJz1x3KdStMUersViM1zzW
         /hCQ==
X-Gm-Message-State: AOAM532yi8RShBviUn5zbadkKqWR+TvToDR6bV8/yMap0R7rOPw7y50p
        HOOsaSWg/axBAjn5cFX8Lw83XFbW4bU2VTRiZRxiRw==
X-Google-Smtp-Source: ABdhPJyWWGgUn2oNtUsYmqSpl1Se2ijc4eYlRCDYw6awgB9A2KYqB+xFkLzp7nwqUKd/wq++N/1FAD+6QV2ogzXRzdk=
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr1717194edx.213.1601458815102;
 Wed, 30 Sep 2020 02:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200930092053.2114-1-mike.looijmans@topic.nl> <20200930092053.2114-2-mike.looijmans@topic.nl>
In-Reply-To: <20200930092053.2114-2-mike.looijmans@topic.nl>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 30 Sep 2020 11:40:04 +0200
Message-ID: <CAMpxmJW+we06L0cCGOQL6vOzw+ZFhwkoMtw--CpEB0TKAsCZMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: pca953x: Add support for the NXP PCAL9554B/C
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:21 AM Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
> The NXP PCAL9554B is a variant of the PCA953x GPIO expander,
> with 8 GPIOs, latched interrupts and some advanced configuration
> options. The "C" version only differs in I2C address.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'll let Linus pick it up, I already sent my final PR for v5.10.

Bartosz

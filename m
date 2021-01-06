Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047802EBBF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbhAFJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbhAFJxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:53:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231F4C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:53:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b9so4332170ejy.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vpTmb51iwCOJ0Wwqb8LfRUN99690SDwI1B/gEwAQ8s=;
        b=Usml1h+v3R1flxbHMZXUmqNbYyBPCaEIoYmJEss8DBA806qFxYbIMyG9ri+UjFFnVr
         qK9bXVYkxIT0pSVwWW5Itiu6RxPUj5YtY0znWLsONG4BccdgHBbNm4igdcZwDmbMKw/D
         O/GQSAL5cpRNt9hkUZZAUIB0tVdzMhLBYkrcc0la3J8u91ele3tHO+hSWdt8pKmMN85G
         YGMT78pSN7o1GHQIusg2xUMTE5I5mkvKIC65h633JY8uMA2v4/jNftckiLImiboB8jUy
         LEetNA69/9lbKjpDxlEd3XIsOPWLhn4k5XYeZkOG/EWY+EmbhRAbR3hqBhcB9uvVmYS1
         A89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vpTmb51iwCOJ0Wwqb8LfRUN99690SDwI1B/gEwAQ8s=;
        b=feFm5cb7pOSUGYQWihb8DLn9oooBDUSkVZ1Rym6v4vk1nYdXcF+ZEpz0aq5mZ+p3qw
         /wYoOrwdfY2AiOFkdnCNplSMrm1wUN0/D8yD3l34a42IINob78t4eTuwAkJ/tx1MNlLx
         Bap62JF8hDz76E2myHOr2ECSlnA2AqOo8+63ijLswTTs7FYSr6VQ79rWQZic0BAz76NC
         eXmbiyzm/DFo+putfaAH+L2vEC9bYrbcdsY6U7OqOH1XZr8tAt3DJR1NMYjaKZX1W78z
         0/jB4W+5ddwyv9k89oGAaVY35x7p2MAtjDaIBFp+TmGcrYYzVO1/caSt7UpqQBEW/G62
         0lDQ==
X-Gm-Message-State: AOAM531/qLcsB7iODSgv1SIe/K/+89VHzQXuNES3awCKxZRVR4Z9rJIM
        7QARXgTLB+Zh2MZVeDo0WD7mia8NhZcSyZaRESEEpA==
X-Google-Smtp-Source: ABdhPJy6LARKOOkgBvGArQvJ89I2TCnooD6z6WTBZKtSMhtK2JqxrmNN34a5nMpQwAmsY4zIFtd7LVN8pxgETRrKOLM=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr2203561eje.363.1609926784918;
 Wed, 06 Jan 2021 01:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20210105125335.GA3430233@localhost.localdomain>
In-Reply-To: <20210105125335.GA3430233@localhost.localdomain>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Jan 2021 10:52:54 +0100
Message-ID: <CAMpxmJX-OWohn0fs3KXJTDh2YnujTWUm-UADEsrUQiTKhOjUog@mail.gmail.com>
Subject: Re: [PATCH] gpio: bd7xxxx: Do not depend on parent driver data
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-power@fi.rohmeurope.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 1:53 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> The ROHM BD70528 and BD71828 GPIO drivers only need the regmap
> pointer from parent. Regmap can be obtained via dev_get_regmap()
> so do not require parent to populate driver data for that.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Sweet! Applied for next.

Bartosz

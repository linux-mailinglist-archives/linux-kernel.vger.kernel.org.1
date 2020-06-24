Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3F2074E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbgFXNvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391067AbgFXNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:51:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:51:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so1830528qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HWNNES+Y818odLI/3gSJ9ckg/fz5YcNui7c90vtLDpI=;
        b=KktHo04ISnCkBtN5rrRmMJ3YEda0xGWhl1b6QYgeUta/PZyM34Y+nxCcstwqzH521y
         qkwp7vYvXrQI4X0H2qE22hkwwEBE9G5ip2cXPNJvnnWNSrjakwlhiHXH4+cimGNtFU/K
         YZp/JrHOmEJ9UsRNOLBSqXJGACLzoDW4blSoxUupyaFcM9MIOjAWv/g2gXgiDf4WSu5U
         B53MQ49Yj0MbA+FlNEUU9gJ8vu6mjihOUqX5vqBEm8beyP5OmFV56ihVEdC8J3DN+zpc
         LJ3DIIXfNtwm7zKaKBt1H2aI9QVs0Kc1xVUnzJlUJ//1HBNh5k7gd4oYUfXp82qv4/ir
         jNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HWNNES+Y818odLI/3gSJ9ckg/fz5YcNui7c90vtLDpI=;
        b=fsckUzBRQySEuOmnzeSlaQjJyjHaKj7/Bf/vzPjP6SFkxVCwzi3D8jzoI5m7/kCVBH
         ywM1uxonuLww7+PPIA156FEzJCq40tY0UrGpkxY2nY+IGCnw04wB0tkkmYwjgRBSy5l4
         EnxfgN0wdSweixRzkvCAr+Q0LhDnWGdc0l0satmGQ9m5GL+QvPjoy88sk0tiHUmRVGnt
         yNn6AHQ9aGhuCGaAWk5TERLcyTh1Dxknnex4yAqcS2F3Sv525KkEL0Qa/MBU+aH8+DTD
         o5grfxApmZ20oUaK+FjtGtnaQKca6caAvzlWWcd1YBoHN/lsLBZNKLa6RaEXtU5SRYVs
         wAtQ==
X-Gm-Message-State: AOAM5317wz74HaE7xh/YVc+d4LRAwCEmoMzpdpWmivIW+TUkRG6gzIta
        +lV+JpyTIKHeWCQ0Iu0J4gnZYKsDhvPbFv9DeUWD5w==
X-Google-Smtp-Source: ABdhPJzH4Dgmup8sCb73pnheO53Gb7G6wtoURv+g92q9yilghYFUERJH/XrvO4SetIxMLaZvn37S10yKdnBRcYdcb+k=
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr25798514qkk.120.1593006711646;
 Wed, 24 Jun 2020 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-5-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-5-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:51:39 +0200
Message-ID: <CAMpxmJXyuLy-+h5r983fZrAVjm4n+9CwkFWUB9bDb5SuAw8JVA@mail.gmail.com>
Subject: Re: [PATCH 04/22] gpiolib: cdev: refactor gpiohandle_flags_to_desc_flags
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:02 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Refactor the mapping from handle flags to desc flags into a helper
> function.
>
> The assign_bit is overkill where it is replacing the set_bit cases, as is
> rechecking bits known to be clear in some circumstances, but the DRY
> simplification more than makes up for any performance degradation,
> especially as this is not a hot path.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Agreed and I like the code shrink.

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

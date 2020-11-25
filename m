Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4282C496E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgKYU73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgKYU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:59:29 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99EC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:59:29 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so3703379ljo.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSc+USIpYmzMEHaLwlR/SOzDt5gT00VeWyTNIbEhUIs=;
        b=M04Q+nJNQ64PNRROT/3tOL0jupqO3QrHou/ful+jKNW2Tnc5EqT1kzFVo31TvCxJpa
         vWDxJpgmyAvIdvqOfpnoO0MzXwzR69WnX9v84j9YfJsMiDuTGlMbK4mLxlbX/BW5PelV
         9a25glA2jNbCbCKda1zAE+UgGGcNVQW/u4/BqG3PNYnjqOOeX4bP5qwsvgqta2sFCom7
         eR9ArC1Vs7xf4OeBy5gHKlB0/zsq6qkj0YqSK0SzRVrzMpbjDIEYLxLTjhZvfUZ2poRe
         PYWCie8FZPdAbq7aH/rFHHxHzJXUKgp1HmEJ7lvD6xTZw1qvaDtloTnzJerZG4pN5P0I
         5w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSc+USIpYmzMEHaLwlR/SOzDt5gT00VeWyTNIbEhUIs=;
        b=qtqS322GZB//sknKQlcOAef015HbcmZv+ksAqbmqMgFKyBVobR56BubcIVcQw9NnEX
         D/ID3iQh4yZ1clJ4X0ZYlTt4ncspyAHNhIUJ0rMOji+H1awaON5nJsbiIlFaMv14vEYx
         jR8md/eMkjH0lWbTFGp+k/+mUSpCJlK/oH+3CN43ZBPsAqYim+RtmzQJ2a6+MvFO33+d
         SblW34rH7I8xcjVswjA80zx1k4vBwYHQ1Rqc6Qp6i+JoUfuiX76BHiDi7DvpiD0JNvqS
         DuU9+kOAJP4cxIihHVh4u6M20fgy1+HWbvIdY/vbh84apiwWY5XOYQVX366jO0JtWSxV
         Fg6w==
X-Gm-Message-State: AOAM531Z7r6HTsCboxh9Vi6MNAwgJE3GqAF9D/GGvERpVZ8ktt/pqvFz
        g3jjxKUQL+FdVTqM0deqKPEC2YTR30EBiPLjpI/K4Q==
X-Google-Smtp-Source: ABdhPJwVX3EcY7GPmnzEgXyZTSKFqwyBVhx9q5jqicnILRhlTpWEhBlLh80EasIgAOmyhBRHb6FiPzKjzTcZOErgx0I=
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr1997756ljr.104.1606337967492;
 Wed, 25 Nov 2020 12:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20201124121528.395681-1-colin.king@canonical.com>
In-Reply-To: <20201124121528.395681-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Nov 2020 21:59:16 +0100
Message-ID: <CACRpkdbh_d14y2a3zA2HZvfx1hSWw8wQBQ7WZGgp2f4wqzdwkw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/mcde: fix masking and bitwise-or on variable val
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:15 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The masking of val with ~MCDE_CRX1_CLKSEL_MASK is currently being
> ignored because there seems to be a missing bitwise-or of val in the
> following statement.  Fix this by replacing the assignment of val
> with a bitwise-or.
>
> Addresses-Coverity: ("Unused valued")
> Fixes: d795fd322063 ("drm/mcde: Support DPI output")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Nice catch!
Patch applied.

Yours,
Linus Walleij

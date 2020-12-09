Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36D2D3E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgLIJAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgLII76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:59:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E0C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:59:17 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m19so2085168lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4kdQcRfSBCbx7zGvesxGrfsAKDF4OGfaGjXFodrO74=;
        b=Nb0GkKIAm7dcqrmgsyIwJo38tasdPxkgHvt7bM04JX1NUdKS1KKXWNZ/f1q8kNK1Ak
         N5piWHNnX1Ci4zcrfsLQfTjHEvJ/nD7wBMuCwCjaCvGv6ziWmZjleawa5O6pjphDSdsx
         SZHGexSXGx7joKlWC0+GmJadETuk7cE+aZxxI+QktTZNcYwngVb50wGvJgU3u+7U6lCO
         ZJp9X+6uNncgp5DHiOIlBqPJFb1+PzoLTqIZmqqRtEk7rymNffpILx7NxzchmVAHxMNf
         cVl7zKsW3ByehxmxckIgQJ7UAl2YrgYuKzEemokel2bLqdnx+H4VEDE0vc799ZVn7PLh
         XX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4kdQcRfSBCbx7zGvesxGrfsAKDF4OGfaGjXFodrO74=;
        b=fXYVVsi6sqRLgKH6RkaiY6OidinqNKTbVNlGvIUzQA7BlUb3e/9VGsjh9DM1nl0eCS
         VVbA1z97f9EUoEP/31XFi5YBaNTthoYKIuoopaA9t+E6NQjDA90xJEpw0NZ9knqOdkJW
         LfbYab3FvSfQZYAmFbkxIemhnBPgv6Be5yU8skGnvN5MazZTrJpSdDkxyTa5zBB0VM42
         BpryU1zf0vQkLSi3KSKQe2cx8KVLHpqCf2DH82k2x5VOLyDwrhmuRe38XWv2JrbWVVhe
         q/ZcZXx0/nYBEL83cIbcqOjEQI4DZnFJ56L2Wn6y4YZIe0HIuCmlO2+QrLAHI22N9n02
         5GCA==
X-Gm-Message-State: AOAM5310uMWyKU2grnt34i01kti1LEKVXHOZYAPuntKUT7eL7IPlbqLe
        rLUTQiX2Duq4bdIterwcP8chMfmPX8ilBgw4zY8KNg==
X-Google-Smtp-Source: ABdhPJwHqLtksYEjPqnWu5i18QEvgN1JTjuURx6ecahj7/3lHvD3YQFzYlCPm2SD6tcxLCaRX/CcWXKFnMfDOnQpDeg=
X-Received: by 2002:a19:6557:: with SMTP id c23mr627191lfj.157.1607504355994;
 Wed, 09 Dec 2020 00:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20201208164821.2686082-1-paul@crapouillou.net>
In-Reply-To: <20201208164821.2686082-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 09:59:05 +0100
Message-ID: <CACRpkdZFy8bvsV+HkzWsu0OKjg6i82o-mL+7v3_Ev5h_QR=xiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] if_enabled.h: Add IF_ENABLED_OR_ELSE() and
 IF_ENABLED() macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, od@zcrc.me,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 5:48 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Introduce a new header <linux/if_enabled.h>, that brings two new macros:
> IF_ENABLED_OR_ELSE() and IF_ENABLED().

I understand what the patch is trying to do, but when we already have
IS_ENABLED() in <linux/kconfig.h> this syntax becomes a big cognitive
confusion for the mind.

At least the commit needs to explain why it doesn't work to use
IS_ENABLED() instead so that this is needed.

Certainly the build failures must be possible to solve so that this
can live with the sibling IS_ENABLED() inside <linux/kconfig.h>,
it can't be too hard.

Yours,
Linus Walleij

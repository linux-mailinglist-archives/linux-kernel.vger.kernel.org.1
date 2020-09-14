Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C37269988
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgINXOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINXOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:14:10 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:14:10 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r78so358467vke.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=di2Va6QiS0ibtKbu5o8+rvmL8yOxtQOTJvAeGXIj49A=;
        b=DIwwhM/aJ2/PXaNDwnC/Yt+HFlzhdpcLFKwKxZ/QSEH/2qfSfXNpHg292gjgaxV3G6
         18NtSkXh2GpKANCtwpIaeCYueZ6/lPrCqp1JAOiel9y0wygzuGlgXA+9fvrX2raPaYp+
         5yDY71OQi41U8VwFHpGqHi+uQdJvXsxDlhFZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=di2Va6QiS0ibtKbu5o8+rvmL8yOxtQOTJvAeGXIj49A=;
        b=bXFOR2DLnDH9K/zPrywi2ULBSAaMj3dknZU4L7VwOu6Gybb5wr9V5+TwNSPgTYn/le
         KWYQcS3vcrVvEPD/MczTt0exmaNtwahs+kVfEdM5s5yNgWMzK38ttM4yIikUKp52GrHV
         iZrqdpypWhXeJhxbSGL/lwiM5hYiBWvMzeRsGFn4DAgV0QRchN1BI5m/FLLjRmBoHkPh
         mjEvAYsSObIkUZ0oNyqhJhn2ZJCB3MXe1nmavbp269reKioQcWR+cQq9AX2shMp7Ti30
         6j0vm05BEcYHwvkcptdJ5M6EGOi8ajemlxKTOx+NyH7njAM1aCa7Pj8KbFQEwkoNXWoW
         7X2w==
X-Gm-Message-State: AOAM533+Vgy0OswGUbpoK01EzaOn/bs/1849zc0jMqVJsN1qAt+yJ4/9
        BGIF3kHfnC9ZUckye+oc2AI2xKjTz9x44Q==
X-Google-Smtp-Source: ABdhPJxvcRA8lnSFRiUNvxAkdd2Gu6M1b/JAGvIFbOPiq/lEyyy2Qs2EHqhoeLRJy0tUxqeFztBoNg==
X-Received: by 2002:ac5:c297:: with SMTP id h23mr8429658vkk.38.1600125249220;
        Mon, 14 Sep 2020 16:14:09 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id v76sm2040133vke.2.2020.09.14.16.14.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 16:14:08 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id h23so373343vkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:14:08 -0700 (PDT)
X-Received: by 2002:a1f:26cd:: with SMTP id m196mr8715666vkm.7.1600125248289;
 Mon, 14 Sep 2020 16:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200909141708.338273-1-daniel.thompson@linaro.org>
In-Reply-To: <20200909141708.338273-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Sep 2020 16:13:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqDpBj5YeQ6G+QeBbxwNDsn7HMAZJA297ATc26FTA_=A@mail.gmail.com>
Message-ID: <CAD=FV=WqDpBj5YeQ6G+QeBbxwNDsn7HMAZJA297ATc26FTA_=A@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix pager search for multi-line strings
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 9, 2020 at 7:18 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently using forward search doesn't handle multi-line strings correctly.
> The search routine replaces line breaks with \0 during the search and, for
> regular searches ("help | grep Common\n"), there is code after the line
> has been discarded or printed to replace the break character.
>
> However during a pager search ("help\n" followed by "/Common\n") when the
> string is matched we will immediately return to normal output and the code
> that should restore the \n becomes unreachable. Fix this by restoring the
> replaced character when we disable the search mode and update the comment
> acordingly.
>
> Fixes: fb6daa7520f9d ("kdb: Provide forward search at more prompt")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     In the long term the kdb pager code would probably benefit from a
>     bigger rewrite since the way it handles newlines is still quirky
>     and confusing. However this fix is easy to backport so I decided
>     not to hold it back whilst we wait for code that is not yet
>     written.
>
>  kernel/debug/kdb/kdb_io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Wow, more kdb functionality that I never knew anything about!  Seems
like a reasonable fix to me even if I agree that the code could use a
bigger cleanup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

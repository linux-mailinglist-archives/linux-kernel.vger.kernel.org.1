Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D32CEA7A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgLDJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:06:35 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A82C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:05:49 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id z14so4538574ilm.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1RmuEV68Av+Jl3JWjgr3+X3fYbRBbmHI7a0zzv/YsM=;
        b=dzICL31j/yQTqpa3dhgoFeea4k3Og7voZFG9iHf8AlL9Tgpc1EfSkpb7HcLrTEMxQN
         0GIBZTuN64aPg6+oWAtPgrD4LFobjNzvzAkFf5ND3SUnBR/2ovFABeu6vmOpsgAznOJz
         zrVE5noCioneaQT98ii1SJ+sLMz0WhYs4K8CBcgJ29mntCZnWjzx9BSijQJLVeyFXVBH
         4qrmOsyP0c6xYz/y1bNdkC0Xdo4ow5HXlWE5ejw/StL6LbX+xWDXblHTJ2Kxpb+KHsT9
         Khe7779CkKWeljJhVlqDzV6/lrqiyZysjLtSmHsQCz5EnZxjVy1hNBhs6dXzzyKEX61o
         ThtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1RmuEV68Av+Jl3JWjgr3+X3fYbRBbmHI7a0zzv/YsM=;
        b=q9eZb5ooedF37F1I1STKkn1OPCClItg4fp/4z6E/3RKQOxKH5D39DaTgM7I/VCBkX3
         i1+pT7dQCCj0BfW2jXDPBGg2KEqRSR+zR5+HvRj21JvYBGz9R6hea9YUD692WpxQMqXN
         hTG2Wr/pk8u7mDHSpCsXZBCsGN3UgNlDTSg6Vl2jyAVljd8CK+n/Oo4WsM+xC19J3s7w
         +RNQ3ak5PAbtbnpeRN6EIVk7lv+u2QTqgEK7hi73zDTjMepp6xDfvsgaDzQ9ht9mLV7N
         KDVUdWXUyTu460s79hgDEMGEfFIGtDTRziWu6t6UxmiCBD5jWsHzTqY19ZkhWEB62MLo
         HsHg==
X-Gm-Message-State: AOAM533fwj0S0vvOkOvcCE6ITULvDf8pQLzQqoDKkhIpp8aMFEJIppVQ
        Wv75stLm6qq5YBAz1OZp2Ff8nLpyIFpK986OZyyJ4Q==
X-Google-Smtp-Source: ABdhPJyO9aVs0TQtsNIvxVmZHsGTvt3KxuOmuUt+h110gvMMY8SU7EhopLlz5PLYT919Ze9LJsY/JQW6nY2xm2SvPXY=
X-Received: by 2002:a92:6403:: with SMTP id y3mr5165041ilb.72.1607072748632;
 Fri, 04 Dec 2020 01:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20201203225458.1477830-1-arnd@kernel.org> <CA+Px+wWmJrS46TzWgKWiufJH7ryB+mOH7H4xfGZex2j=NutfLA@mail.gmail.com>
 <CAK8P3a3qrPa0Jue-eLrXn+ufBsvY4+UQr7SQ9ZHxuEMtvoYMhA@mail.gmail.com>
In-Reply-To: <CAK8P3a3qrPa0Jue-eLrXn+ufBsvY4+UQr7SQ9ZHxuEMtvoYMhA@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 4 Dec 2020 17:05:37 +0800
Message-ID: <CA+Px+wXi1eUf2xS0NB2-fnGi8G7h8ugiD4dPfW7ZPYRqC3uxzw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: fix uninitialized memory read
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <groeck@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 4:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Dec 4, 2020 at 3:56 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Fri, Dec 4, 2020 at 6:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > In the case in i2s_rx_event(), only the "cmd" member is used.  But it
> > is fine to please the compiler.
>
> I wouldn't do it just to please the compiler. I sent this patch since
> the code clearly copies the uninitialized data here. If only
> one byte is meant to be copied, then we should change the
> function call to not pass the entire structure. I'll send a new
> patch for that.

My sentence may confuse you.  But I mean: the uninitialized data
doesn't introduce any bugs because it only uses the first byte in the
case.

Instead of your v2
(https://patchwork.kernel.org/project/alsa-devel/patch/20201204083624.2711356-1-arnd@kernel.org/),
I prefer this version v1.

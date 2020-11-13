Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A212B26D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgKMVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKMVbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:31:41 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05840C08E9AA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:31:41 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i18so10273356ots.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9BLptiQOJHn9TYF3BunT2B46fuCTxdzlPaSexof02uk=;
        b=CJm2fsJcWHON+vb7H+mlrLgr+nW5HCOUwhuxsAorRua5qkHD0uJwnab1BTb/rYq62Q
         TmO2r5EeibqgInEKPyEqAvfQE6zt1zweXSkfKQkhEUwJTP558FVAGGRZQsPejW5761UK
         BslAtwbZaWTz8wVnyMrG/Rk9rLGt3tDHHNQkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9BLptiQOJHn9TYF3BunT2B46fuCTxdzlPaSexof02uk=;
        b=K9dky7ZCqF3iSlpjDDOxAfxv41YDbtCgVejOoegSkUFgp/Axt0D2qpSKNwn74+V8Rc
         9wq9zg4YHJpFjzJQsSmf8YamohSLa1oXDOOFWWfJ1Heg6BrcgYoEAsqxwQs3g2XXJVG+
         zEp6KSfaOYclVlKxu5/JRJzJ/H6QoIF3HojJ2HEoBj/ZPEjml/hAZsdCgAWRAzfccNoS
         5HFc8bWbXhLNCZzfz1UVW6YUZe4tMcI8ib8iOmGXj/AA9XXl9f4PTvZ+Cylv4+K9Ko5d
         q5WP3q69WN4kjhGr0Hfv/YZh7oHKCpHzKMR8VGP/DiuYvyOCXXNMjvEOU2ePLcEH8Z0b
         ZcKw==
X-Gm-Message-State: AOAM530vSfaMK4xz3n7OpghhV6Kwb3yQyEdjwUztyAiP8OiXjDPez/RV
        R1JI56JB62AaDaKzAetHhXE7I/QqXILWQwdh5O5GhpWpL8s=
X-Google-Smtp-Source: ABdhPJyOcBx7Di3GK8BX+XCfjczSDp17aBUIy1Y+omg8mAjoGdwyKEUhvLMS8wIV/S8UL390wFXuY58QeB+/xm7j5U0=
X-Received: by 2002:a9d:27a5:: with SMTP id c34mr2873869otb.303.1605303100385;
 Fri, 13 Nov 2020 13:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org> <20201112202516.GA3340631@ravnborg.org>
 <20201113204959.GW401619@phenom.ffwll.local> <CAF2Aj3j6+fEFS66qg-a-0Z1XtNQ7EAEnu4ECZ9gLiH7buH=PLw@mail.gmail.com>
In-Reply-To: <CAF2Aj3j6+fEFS66qg-a-0Z1XtNQ7EAEnu4ECZ9gLiH7buH=PLw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 13 Nov 2020 22:31:29 +0100
Message-ID: <CAKMK7uEQwFLj+D4LfdQNfb+cQZCH34HZU7oJh8r=mjozuKmZGQ@mail.gmail.com>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 9:53 PM Lee Jones <lee.jones@linaro.org> wrote:
>
>
>
> On Fri, 13 Nov 2020, 20:50 Daniel Vetter, <daniel@ffwll.ch> wrote:
>>
>> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
>> > Hi Lee,
>> >
>> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
>> > > The precedent has already been set by other macros in the same file.
>> > >
>> > > Fixes the following W=3D1 kernel build warning(s):
>> > >
>> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable =E2=80=98c=
rtc=E2=80=99 set but not used [-Wunused-but-set-variable]
>> > >  55 | struct drm_crtc *crtc;
>> > >  | ^~~~
>> > >
>> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > > Cc: Maxime Ripard <mripard@kernel.org>
>> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > > Cc: David Airlie <airlied@linux.ie>
>> > > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > > Cc: Rob Clark <robdclark@gmail.com>
>> > > Cc: dri-devel@lists.freedesktop.org
>> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> >
>> > Also applied to drm-misc-next.
>> > This was the last patch from this batch I will process.
>> > The others are left for the maintainers to pick up.
>>
>> btw for patches that maintainers don't pick up, the usual process is tha=
t
>> we give them 2 weeks, then just mass apply. Now you're producing a lot o=
f
>> patches, too much for me to keep track, so please just ping me with a
>> resend for those that expired and I'll go through and pick them all up.
>
>
> That's great Daniel. Thanks for your support.
>
> I can do one better than that.
>
> Would a pull-request suit you?

We have a few trees going on, and your patches are landing through all
kinds of them. So this might be more coordination pain. If you can
exclude patches for the separately and usually fairly well maintained
drivers out of the pull it should work (drm/amd, drm/radeon, drm/i915,
drm/nouveau, drm/msm and drm/omapdrm probably the usual ones).

Or you just send the next pile and we'll see.

Also I guess I can't really interest you in commit rights so this
patch bombs get off my back again? :-)

Cheers, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

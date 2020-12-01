Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48F2CAAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgLASWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgLASWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:22:31 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:21:50 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id z136so2623249iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ouobtBm8sSQb0vz2vqGGkrgo2OjHAJ9nHVRL58pUGE=;
        b=uX0hz1qc271RdjaSAXcDDyqtvFg0GUk//wxyUkAsoxen3KpmlHi3IEYgsenDvk5C80
         v4/0ljBXXPLRJnotPXKT9MRhl3nAX1NTudLW4h5x91eDfsC3vHaL9P2xj+hoMD5OoIxD
         vOu22nw2eghmX+PK/io3Z3qq8xU2jQ6DrZWJbWXIJVfPigqXzYlq02nNIfaigGWmzlan
         bYKfGEjAplaTTjwl10RX/HUvN/N3A+ItWennAFnc3Hy2TWtSKqLj/2BNXYqlPQDcnPi9
         k/C3gOOSfhkXezcbjhASXWGhQuyTSdGrQ6fNxVM5EbaDxXVnN0EVe/OdvS5QjxCsSGKR
         1dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ouobtBm8sSQb0vz2vqGGkrgo2OjHAJ9nHVRL58pUGE=;
        b=ueoEug3+Abq5WH8mECqykYDd03Ix/MLRl4Je3DuGsK7T3kj/Gw6YVlRpMvuoO1d1Pt
         ydMLww2SrD1/eDYtQJ3jLIWpfpHpZJ9xFWJXMJq8ov6rHwXVLV3hQVtZELbmkC6cTuVm
         gMwr2+88VO+CT3rLxgy3aDFDRCXhh99g2tqgvSLYP5UbeNGhjr0JixV67Wtp+Yii3TuW
         VIsypLCTpqZdeWWWk2P9MItkbue0RvdfN9B6zHh197SiKfIeLv9+DWnKZb6WegPzZA5n
         lSx0Y5n0K/fMDTWg0xYclND8EDlT+m9yqsExQWtZOVGZ60LctX8FOTZGw97qGj1HITEW
         COGQ==
X-Gm-Message-State: AOAM5317qlKn/2GniwON1Y+9OxtFc6nwtgoObrlproF3oh0bZrjwPIGD
        JtcmbcZyWUcvnR2HAkEuJwYSpD0t/JVtEttaVvrDFT7jYfAT8g==
X-Google-Smtp-Source: ABdhPJwtX+nHYBolzK2l0oZRuVJ03EZTJvWOEnie/fZJWiF3VTwTR48gquIufwsVkdo+3j96NU3nHOCXX1vVhZTCD+g=
X-Received: by 2002:a6b:c047:: with SMTP id q68mr3418312iof.189.1606846910267;
 Tue, 01 Dec 2020 10:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20201201112931.11192-1-yashsri421@gmail.com> <f4392362e682ce7a02eee8a2036e1035342a0b4f.camel@perches.com>
In-Reply-To: <f4392362e682ce7a02eee8a2036e1035342a0b4f.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 1 Dec 2020 19:21:39 +0100
Message-ID: <CAKXUXMx8RURmeyzp5Ak7_409oaVJo622ndpC5VceN-C_f-HPdg@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add fix and improve warning msg for
 Non-standard signature
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:24 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-12-01 at 16:59 +0530, Aditya Srivastava wrote:
> > Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
> > styles.
> >
> > This warning occurs because of incorrect use of signature tags,
> > e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
> > signature tags, which may seem correct, but are not standard:
>
> I'm not a fan of this patch.
>
> There is already a "non-standard" signature warning for
> all of these cases since 2012, predating the range of this
> retrospective evaluation by over 5 years and yet these
> existing commits have been accepted.
>
> The value in actual standardization and effectively
> requiring specific signature style tags is quite low.
>
> Anyone that signed a thing a particular way should be free
> to sign the thing as they choose.
>
> Most of these warnings would also still be in the tree in
> the future in new patches as running checkpatch without
> it emitting a message of any type isn't a requirement nor
> should checkpatch use actually be required workflow.
>

Can we scale this fixing feature down to the very obvious synonyms
that simply do not add anything but confusion?

Such as for those four here:

Co-authored-by (count: 43) => Co-developed-by
Reviewed-off-by (count: 5) => Reviewed-by
Proposed-by (count: 5) => Suggested-by
Suggestions-by (count: 3) => Suggested-by

Then, we can probably also drop the rationale because it is pretty clear.

Of course, the impact might be really zero, given that it is unclear
if those authors did actually ever run checkpatch in the first place.

Joe, if you see no value in even such a minimal fix feature, let us
drop that idea and move on. There are enough other things to work on.

Lukas

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4029A886
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896541AbgJ0J4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:56:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409791AbgJ0Jyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:54:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id x16so1048889ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlZKihEU47KO2Q4wXh/mn6fHnYIgZzljB9zpEIZhZu8=;
        b=NItm7iccu0ev/qqIqm16sypSo+zBzIrorG1+c6Z1TIxSDMiFde0Hl2fmmVytXGIPPD
         LUqYzvXNdrn/eAoQPyJkQGEOzg/KQCozSg0VTGSehoiRmqxgpYU5dyPbAltUWZVWtI22
         Lcik3pFj3nyaUisDmpa6H3njzoFOP7vl8a0x5K9ZYZJ9tBIHsq8uI1RfW2HU/yiYZkZc
         62hfCxBEQCyDGv8jTCEOKes7HGS/39JLTUrwmdKXE7TtroN3BTYApJEhnfs+9YlVW4NJ
         lTJth/sVYP1UznAbFLGUOOBZaW3QbuNpIgg7jwyzRtYpztVG35s/xmhbPNSokIIBlsiZ
         3ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlZKihEU47KO2Q4wXh/mn6fHnYIgZzljB9zpEIZhZu8=;
        b=gRziPE+ekcNSCBRXFmuROIE+luEuSIaWVkwCW+KB44ivxtcyWW6v/iUxLBVmObBiaV
         sIKy5ZabZH3G8Ia2cyY6RSpmLwZ2RKyZyR5dPHapYUWS3xbj3g9qQdT2r27Vicjn5JgB
         O/AKGp0tJV012d4K2Wxh0+AtervxG163IRArKIILOrgrXtx5zjMkwQxvwB9iuRRRn7Pe
         lQ2mB1MtPMaoxS96YW+e+i509BlTI1Gh+6suCZs7Q9o6azpBneGwcc0YIABcfOSurQ4Q
         j5uImvu8yeWx/YMWJhpwH3+R/AXK4c6/nHe4zCCPZH3ENyw4fDsQX9bj2vySpwriVbS2
         qZWw==
X-Gm-Message-State: AOAM532bcvTmjGOtfKV72t8fuMSYHjleqApinrI/04+NRgR4t5A65q46
        2c7Q+vwLCjtfs6M355cJOBs4frMlV4wXHigZu/mCUMjibdesGA==
X-Google-Smtp-Source: ABdhPJzSgEcO8GMdK0RxR+ju00EjciXRlSPfuOfVG+uJDA3TOJd2ggA4xrukLCBlg743XPya5LfA3fGmXwMpmdQHRZw=
X-Received: by 2002:a05:651c:11d2:: with SMTP id z18mr694563ljo.423.1603792478736;
 Tue, 27 Oct 2020 02:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201026194110.3817470-1-arnd@kernel.org> <20201026194110.3817470-4-arnd@kernel.org>
 <20201027093350.GI401619@phenom.ffwll.local>
In-Reply-To: <20201027093350.GI401619@phenom.ffwll.local>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 27 Oct 2020 10:54:27 +0100
Message-ID: <CAMeQTsZ9rBh2W_y8W4aaGJR3v5CA4g2BLmr-wAvcoKjOQtL68g@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/gma500: avoid Woverride-init warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Stefan Christ <contact@stefanchrist.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:33 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Oct 26, 2020 at 08:41:04PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc -Wextra notices that one of the fields in psbfb_roll_ops has two
> > initializers:
> >
> > drivers/gpu/drm/gma500/framebuffer.c:185:20: warning: initialized field overwritten [-Woverride-init]
> >
> > Open-code this instead, leaving out the extraneous initializers for
> > .fb_pan_display.
> >
> > Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Scrollback is dead, so I'm not sure it's even worth to keep all this. I'd
> just garbage-collect this, maybe als the entire accelerator code and just
> leave psbfb_unaccel_ops behind ...
> -Daniel

That's been my idea for quite some time. The gtt roll code is also
broken in multi display setups.

Arnd, I can take care of this unless you feel an urge to do it yourself.

-Patrik

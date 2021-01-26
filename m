Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E5303BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405505AbhAZLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392224AbhAZLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:17:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7818BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:17:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b26so22191956lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJqpqM3wbkcxWqAe0VwoN7CRJEfVCncbbtbba4P0YSA=;
        b=hw3DhRDn9hVvc4daS4DVeWwnNPJ43qcUIN2QWA+gf50WILmLqVSXICy7r5oDz9GATm
         ECIkd4bdQNiivPf3ijI7v4uD+jrBQtDEg59kE01gsnt1PWWcw6U0buLzykzXXNG4REI4
         0GZDEuJkpmFTWd6nBzzJSGkI6iH32Wc07L8XVDpMF2OkjY2ESdR2gEjLLW4uA7KOEpmR
         AEv7CXjcMfJ0OD0n3BxS65Wfgbwe0wRE1w1MnJ2z2su9YhBjULwx1TnYrVOSk2eqG+6w
         HEQ2kdWFNBLS5tK4HQNC2rhZcdxHgCa1QSd5pJYHnQ1KDL+MWHsXGJBcz51uVQoCQiXd
         OHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJqpqM3wbkcxWqAe0VwoN7CRJEfVCncbbtbba4P0YSA=;
        b=U2YkqegXXCoiipx1upJvEu2XtgoZBjhE8Sz7+AK5/jPIw9T20vhMoFHyxG/8NOCxsd
         cg+Wl/O0F0Mk9P1ACz4uFWHGRmQb2PgHHCM3kNZ6lxBirRlCMPp9NEsvMQKO4LyBTLXQ
         fVj+/PgChhrW7ZyOOtURQunZxZ/3LZHNHgRbF65Xu2mdqY5oQQs7LjAq2yPE2WjLGXUb
         b0/wNaJRZIgkgyOyDdlN2VhXVIlIfQ2AADNXpkri2dViYL13h5VsRDTNSXictyKfaFjB
         n5LUUOvaQKs+B4UXJmyrPB5lCk6gdyg79OZQvxlqXDznjPiru84KSAXgPjXQa4lBt9tw
         O/Zg==
X-Gm-Message-State: AOAM533vl+SEQsx1aDOx2EqPPYOVttYiUY1g0f2kZPy7BVpAnQfrPttw
        HYR/qgE/GhVYUVyrNpptc2F+d2VrJBnhhmV4+2KWzN97
X-Google-Smtp-Source: ABdhPJxU3hj2FF5Ef59xxhwdUjyo3GvwTAUt+FHXSk5+CTSLTpxLfK4jBeA6EZ42XUv6i9hPnC4gUDiyWKXB5lbV6Dc=
X-Received: by 2002:a19:341:: with SMTP id 62mr2351893lfd.500.1611659835911;
 Tue, 26 Jan 2021 03:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20210108214313.GA7979@ripley> <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley> <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley> <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage> <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
 <20210125212917.GA4177@portage> <CAOMZO5DiTDQneYMtNBDpyqtYUYJ3AZ_fqWNSyfxWB5AfaNfULg@mail.gmail.com>
 <20210125221701.GA20107@ripley>
In-Reply-To: <20210125221701.GA20107@ripley>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Jan 2021 08:17:04 -0300
Message-ID: <CAOMZO5A99AJ9NVUmbFr3pE2jxXnQnGNZ+00LHtBTtG3f2mye8w@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Mon, Jan 25, 2021 at 7:17 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> I would prefer mine, because I got a wrong colored penguin on bootup
> with yours :-)

I have originally passed .bpc = 8, but looking at the panel datasheet,
this should be:
.bpc = 6 instead.

In your patch, you pass the timing parameters three times, but they
are all the same.

Usually, it is meant to be: minimal, typical, maximum values.

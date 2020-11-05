Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B22A894F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgKEVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:54:45 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAC6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:54:45 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id f7so1634632vsh.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mv8DeRATZy+n1cuxhY7i11DSC6dCUpYDT7QslX7ET9c=;
        b=bxCcEqbXmtmRJ+14a+t/hizd895SIVzEZURuwc6SrVkGEWUTv18AjWmjrrN3eYY4qp
         k9XdzcnVZz4q+RJenTuRcsaHfaxdPjDbcPE+uKqyaT84rSjVn9YIsQEW9iMn1ydlSVIA
         Y3stKICkcdJWXeeiuzrmci39rROMfOzXc1U8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mv8DeRATZy+n1cuxhY7i11DSC6dCUpYDT7QslX7ET9c=;
        b=gUc6G25HMKy2j9Ii/PRtXiTYM8yaPBKzf63z2SwP99moAbtNofXhQ/yZ3P0+UhPlFv
         fn7xua7KJFBIGVqHKRh87cJvMffpC0Xoz3yerozl8tVl12WtbG1WhOklg3CJk7gusoij
         rLiJO4W/opvRK5ug54wEeNi9/HvSTsPNPsUXLbsyN4j8JLw27+AI47wpaTb+pNXJxZck
         T7v4jEKqnd9iojvnZ7hghQQDGyK+OwC8yu9eLzrtyH0nyrkGWD8qVLYgy9/cNdfWuBmy
         /3U0L5MC/AxKQpPGZDemIuR8Eb6Up6ny1fPLwvlYwNUNd+GoOSre7Es0sJ9xakwf2RoM
         O71g==
X-Gm-Message-State: AOAM533HPItyYtID9R7XnflF3rW6s7RQjBDKaotoq5OkhQYbsCZI9eaI
        jQhYQMilqPGcuLDRp0fselPUDWwqJs6bRA==
X-Google-Smtp-Source: ABdhPJyEOV9k/SpJHDIWgFLzot3tvMYgm1vCefn9neq/s9yGYA2WbJudkRaNkpgCBjy5sfR39+3SWQ==
X-Received: by 2002:a67:7fd2:: with SMTP id a201mr3181308vsd.60.1604613283979;
        Thu, 05 Nov 2020 13:54:43 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id t1sm327490uao.2.2020.11.05.13.54.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 13:54:43 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id 91so974146uar.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:54:42 -0800 (PST)
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr2632856uaj.104.1604613282559;
 Thu, 05 Nov 2020 13:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
In-Reply-To: <20201028155617.v2.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Nov 2020 13:54:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U7PvC5nL3EudxE62MSHeha+zd1u_hCxYyCw8t5SaWUkQ@mail.gmail.com>
Message-ID: <CAD=FV=U7PvC5nL3EudxE62MSHeha+zd1u_hCxYyCw8t5SaWUkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm: panel: simple: Allow timing constraints, not
 fixed delays
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 3:58 PM Douglas Anderson <dianders@chromium.org> wrote:
> @@ -249,18 +327,19 @@ static int panel_simple_unprepare(struct drm_panel *panel)
>  {
>         struct panel_simple *p = to_panel_simple(panel);
>
> -       if (!p->prepared)
> +       if (p->prepared_time != 0)

Though I swear I tested this, clearly I didn't test well enough.  I
was poking with this patch series some more and realized that I got
the above (and the one in _prepare) totally and utterly backwards.
I'll send out a v3 now...

-Doug

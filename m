Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682812B8522
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKRTy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:54:26 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A592C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:54:26 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w142so4734959lff.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2ZA3zYNPCWpvzKmMxY8s0OO2jIVsez+rCvGxvvdC+s=;
        b=WZQ6YW8wPw8pECERhSDGtd0HX0xQE2RsEhFILpF4y/Gl84RqBLNL4eHdg7oDqF79Vc
         cmHhhtBDKhK3Q/WYOTaZUJcWK6ppR27c2kc7+7GKp8tgCFRT5HO63HqKbGrvQkSCLpt0
         Ek9PH7Igvp67beBzJBsgDWR2QSVeKGTFM+9m+rfyA4ML8ANxeyR8bgPc2ypbra8jn9z1
         +QRh8vYyXT+P9DQWwK8zKevxU8fROTreZmcP6sC37SRsypz4yc29qjvqT2eRNuAxctqu
         goOUCznBEyAf7zmVTcF8gpDNk7AbHa+mfWUsDnLWKwQItfsTpaxCcvG+HcTnkJ0TExFM
         wdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2ZA3zYNPCWpvzKmMxY8s0OO2jIVsez+rCvGxvvdC+s=;
        b=jts6u0xH4f3Q98zzKDrhfcSbTPsPiUs0kWIydutSYfG4HaTUExaMeQdtoTaXf9FaYD
         luLBy+9JXIg70Z/yvHbUfn91xs/9sr0PbxETI5rKFzxkhYfsYwPmwPy3L1UtKKGrhCy0
         93ep1yVXXs0Xpb5fWkQzC/qycjUwLbOa91lVRZlfIHg1ndw1QHsBUqJN09JCzKGxmgBx
         KEjqo0OgflN2Qi8ZwfyGkd4l8YbIq0BhPUIUgf3RBd9G0O90x0CX/vUypxxFvrRvhTeX
         aASa2WEkbyqheAxzqRqV9H2/qhSvSQo7+SDiF7r8tWLzpMVY+mAcxAEG8l/NowhxTnOK
         DDwA==
X-Gm-Message-State: AOAM5324HmkbovDb7+H9z3jfzmfWn4bzJMUN+1ZUBPqSpp2mQ3gKegv0
        zi+/ZUyG7/zqm2x6c70DeE1gPBFM66OgyRDXv4T1i6fkLuL+XA==
X-Google-Smtp-Source: ABdhPJyuLdLYL7y6xdin2BcLlL/HeSkZIrioePk1JRMdJtvrK1ayjPbHB7g3J/oZNKlVvgLdglWObKcQgHho8HbcA4Q=
X-Received: by 2002:a05:6512:3287:: with SMTP id p7mr4794251lfe.346.1605729264736;
 Wed, 18 Nov 2020 11:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20201118175726.2453120-1-shakeelb@google.com> <20201118194620.GD186396@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201118194620.GD186396@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Nov 2020 11:54:13 -0800
Message-ID: <CALvZod5WBeZB_kCGqO9EXGxqpkdPsZq7Q-MwVFv014ukECiTxw@mail.gmail.com>
Subject: Re: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:46 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Nov 18, 2020 at 09:57:26AM -0800, Shakeel Butt wrote:
> > The deprecation process of kmem.limit_in_bytes started with the commit
> > 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> > explains in detail the motivation behind the deprecation. To summarize,
> > it is the unexpected behavior on hitting the kmem limit. This patch
> > moves the deprecation process to the next stage by disallowing to set
> > the kmem limit. In future we might just remove the kmem.limit_in_bytes
> > file completely.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> The first stage was done over a year ago, so if there were no complains
> it feels like it's a good time to move forward.
>
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks.

>
> The only question I have is if it's better to return -EINVAL or -ENOTSUPP.
> The latter option could be more convenient for userspace, because it will
> be clear that the kernel is not supporting the functionality, rather than
> the passed value is incorrect (e.g. if the value is read from a config, provided
> by a user). I'm not sure though, just an idea.
>

Let's see what others say. I am ok with -ENOTSUPP as well.

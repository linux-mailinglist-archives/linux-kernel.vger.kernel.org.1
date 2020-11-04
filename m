Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215672A66F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgKDO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKDO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:58:48 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98A4C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 06:58:47 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id d24so23244009ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 06:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBA94tI3EQjgMI74m6BPVN41GViyC2ztxPzm1ZOqtVA=;
        b=FPMp+JtAH457XBNVzdLVMQn5yt2IsrHbrP/ySibBE9QTXaEvSVxyCGpdv19W/MEZjp
         Y9qTJzZM10R4D+ms68IbbM3Jxbg8ESwvK2atHydTM21B9izBAGjx/I2MM7RBC6xrRQ0E
         WxBQXjOk0Q3CI1xCRu0vKDunFY/ysY3Oo1AUGsesYonXYmsrrOhhfdzVaEgTzlUHiZ1W
         o91AHNQaJXWS9k3hG6e6ByM9Zh3EfzssToRk/F/RsA0BQyqIHQiXanreLdydPkBHDyx+
         hJdjSLIhtuOwyqaJj4lMDNa2k2Pa0Tdoj2dPMU/dJ1XFVzniyz/csFQfQpM6FcCPesDl
         4WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBA94tI3EQjgMI74m6BPVN41GViyC2ztxPzm1ZOqtVA=;
        b=hNiCLfF4zugdh5U6F8kVOCnhbF3d/mQ7chqXa+9nnLvX6fZxnX+qYP+bEMIrzZYyn4
         hu9e806wOq45tM+UFJLcGgmEI8+Plys/f2tEdD53OciGJVWNrnIz8B0wcnAjp1DLQr39
         gHMfI+j7DSNbPCc/RAkrXIUCE6RFXZzweSTzLKS/TF2gZoDdB878+BMF1DGR7276OX06
         HYzp+pQyd3Wjtagwtix/nvlZZjCcmzNJ5BfmL92r35PMX+GE+tQ0r0KcuAwfQpkeA/1J
         puphUl2pgsiRHb43PicUDdd8EXx2MHFX3t3YhcKmRP8PW72U+LQrB2RyW9x/aHQJUoGY
         Zf1w==
X-Gm-Message-State: AOAM5328VXZo1SIL35sUfcKcq3z2RhNcfef5l1hPw80qJvdn4jcovZel
        fjry/3Svek+saPGgHE1Cwb8aJK35Y8RN3zRtzD7Q3A==
X-Google-Smtp-Source: ABdhPJx6PJQd0xvP7wJ2KZHyBhiFuOL5Ry8Qn2ZN4vwEWAOyzd2P2qxthVnVXa2JcjszonuyR9zHibxE7PaTxFOr+jg=
X-Received: by 2002:a05:651c:3db:: with SMTP id f27mr8698539ljp.270.1604501925939;
 Wed, 04 Nov 2020 06:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20201103212725.3716088-1-guro@fb.com> <20201103212725.3716088-2-guro@fb.com>
In-Reply-To: <20201103212725.3716088-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 4 Nov 2020 06:58:34 -0800
Message-ID: <CALvZod5Bdkvz+zWY1TsiVO2ApriC2dkOLAbcRn7A9mFzOCFs0w@mail.gmail.com>
Subject: Re: [PATCH rfc 1/3] mm: memcg: deprecate the non-hierarchical mode
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 1:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> The non-hierarchical cgroup v1 mode is a legacy of early days
> of the memory controller and doesn't bring any value today.
> However, it complicates the code and creates many edge cases
> all over the memory controller code.
>
> It's a good time to deprecate it completely.
>
> Functionally this patch enabled is by default for all cgroups
> and forbids switching it off. Nothing changes if cgroup v2 is used:
> hierarchical mode was enforced from scratch.
>
> To protect the ABI memory.use_hierarchy interface is preserved
> with a limited functionality: reading always returns "1", writing
> of "1" passes silently, writing of any other value fails with
> -EINVAL and a warning to dmesg (on the first occasion).
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

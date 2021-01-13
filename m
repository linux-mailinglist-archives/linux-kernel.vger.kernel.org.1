Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82472F40C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393670AbhAMAnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392320AbhAMATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:19:38 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E1C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:18:57 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so524853ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDSBLu/dQ/DU7FQZj8b6YPh8lI8akCH+mH01uvaPees=;
        b=oKYBO4SPdgSBJUsDMIW5CP9v8Ehx9/bCarB8oGP/mHA4+sLd3xf01hYN8meRfn3Z/C
         VRExJAQITYqEfrJHkfEK/+BUy2bi9V125dcXdPXwnGIrz1gChJ8Eagc6sfu5NxDOsM7Q
         s4JHrGiTwBj0egpN48LNdJhwOkgrQljcrnDdfzV8s4tuYkxOP5J3ifDaVQItl+uBWKRi
         hjaQ04uwbDzWLPPYGOzdK8OrUuidnmRBgEslg8HxcWMOGc+R2HncERyeNHOejDUAcGLp
         U6ugLoGlBW/HnCUEp1wdREM2Q0knqc9CwXOGdVRuSBw5YniV+N1wwskoAEZ2xBEOuVvD
         3xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDSBLu/dQ/DU7FQZj8b6YPh8lI8akCH+mH01uvaPees=;
        b=nFZ+3wOJTsKzNd8921sMv5BKig8a9vJ0hwOt6wIFlDcm7K0RlIAO4WuoOIlSEQHwY7
         4tNaxj/Lec7LyUQ3ce03F//s86Rs+XZrVIq5H5WAvLJn22GB1IG4S4HkDEUfkbBJqn0g
         uUTn8uYv+JKtcOGKVhoBuhOV8RMBW5HJtJZhRQZvjoz5zdUg3xH8StwJUdz24HtVMqY0
         q0tbDI2leIZEbq5P4UwHW+7i2Y8pbEUaO2jnQDTm3A0ZgYSHqZE3+wVQaMcNbjuAMpPN
         oBMWJFVaHLUo6P7Hva8JeiDqw6HkoScFkk/Com+/oGl/iTaR1ynQsJLt3J1dzJmihRXZ
         R6vQ==
X-Gm-Message-State: AOAM530AF6Bf2KFHGsDcjRDfKOiVwWSh+FDpP413tayXk2Gib6FxmOtk
        SH03+IOyB/IKERIZpcMNwAmkI4wp8OsPcdUDYKiD3Q==
X-Google-Smtp-Source: ABdhPJzLMkGXD6keBgkD1QE7S34ntTTrgx2rICPfCSovNaFVK6UFbwtZ7AQr2ENR3QwGr5QWxwVbsZua9hjphAbv6aQ=
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr715148lji.160.1610497136091;
 Tue, 12 Jan 2021 16:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20210112214105.1440932-1-shakeelb@google.com> <20210112233108.GD99586@carbon.dhcp.thefacebook.com>
 <CAOFY-A3=mCvfvMYBJvDL1LfjgYgc3kzebRNgeg0F+e=E1hMPXA@mail.gmail.com>
 <20210112234822.GA134064@carbon.dhcp.thefacebook.com> <CAOFY-A2YbE3_GGq-QpVOHTmd=35Lt-rxi8gpXBcNVKvUzrzSNg@mail.gmail.com>
In-Reply-To: <CAOFY-A2YbE3_GGq-QpVOHTmd=35Lt-rxi8gpXBcNVKvUzrzSNg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Jan 2021 16:18:44 -0800
Message-ID: <CALvZod4am_dNcj2+YZmraCj0+BYHB9PnQqKcrhiOnV8gzd+S3w@mail.gmail.com>
Subject: Re: [PATCH] mm: net: memcg accounting for TCP rx zerocopy
To:     Arjun Roy <arjunroy@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 4:12 PM Arjun Roy <arjunroy@google.com> wrote:
>
> On Tue, Jan 12, 2021 at 3:48 PM Roman Gushchin <guro@fb.com> wrote:
> >
[snip]
> > Historically we have a corresponding vmstat counter to each charged page.
> > It helps with finding accounting/stastistics issues: we can check that
> > memory.current ~= anon + file + sock + slab + percpu + stack.
> > It would be nice to preserve such ability.
> >
>
> Perhaps one option would be to have it count as a file page, or have a
> new category.
>

Oh these are actually already accounted for in NR_FILE_MAPPED.

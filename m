Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715402A66F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgKDPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgKDPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:00:13 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86700C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:00:13 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p15so23335264ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fdf584HMl6Mgyxg+hnbJRvbT3eFGadTv8eB6Pu20Wvo=;
        b=vlpfwpnwi5k+74eiI2hHDewVZmlq4JFNJF3cKXCuLDMr/Sqg1rUwH5cR2V0Mv4R86F
         ZGyWNhN2T7milG3RLT+U+rqU16kox9I3XTS2z/mYxSR/BMjREfchhnrWu9lFVe1MO+es
         8RCh4fMleHla4fyygHCEAWU+N89OJxBhwqgFbjGSSAYUIuFIKqLS/XxKM9p6mpFaCimy
         NpTQZ8BjPOeEh5HjgU5YDaL9opxQfLdwDoJTZ58WwfEeqQj9RtsaROIK1y9TvhXO+cIA
         jUOPdRu8CNAGuXSaEi5A9r3npK91rm42lFMnVVnWoHevlCuvqnm4DUq6LLYLjF94ROHz
         hXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fdf584HMl6Mgyxg+hnbJRvbT3eFGadTv8eB6Pu20Wvo=;
        b=Jq0EZKoTeF0N0Gs5D9L5/6ZROB2pQqk1rv4tSYO+ERkENEJUhZ5WC3OCp+BkZQpi9C
         StJnXhTfPasBgBrttc4RhR+zdODt1J+MXgHIit78QNG/3GIQ+Da7lUpY+n13o/utzrqc
         cpRI7j9p68mb1OMprFN0TbvzXvkE2syvYME3I6pb/5ovi6aO0CV8CC03AFtT/o7Q8oty
         TTIcy4G6dYj2+tbmbBJ+2QrJIv0PMCeWYdXy4YiyD2Fw/6xn4wTghXyaXzPfMeSe4pW9
         3TWqkREtTJtmHnuOZxAIQ6uKnJJEqRi4C+/KBmUL/AlSgeCHjOtQD9vfMiiMUeXkhKfY
         XgMw==
X-Gm-Message-State: AOAM530Rt7weFesVHwZFaWIzsce1FarAuBbu2DqRAxzKzXtGFtOgSjcF
        puB9m9GmDWzSVsHSVh81P9i1WEikj5Cu5sU0vrLnSA==
X-Google-Smtp-Source: ABdhPJyQctvt8JjcQXFGdlO/aJWWoWcArbblEv0homEWqRSxyZdZK76efBccUYp+q+5o0pN/z+XnrxVrZlWXRvoBMyA=
X-Received: by 2002:a2e:58a:: with SMTP id 132mr143854ljf.77.1604502011806;
 Wed, 04 Nov 2020 07:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20201103212725.3716088-1-guro@fb.com> <20201103212725.3716088-3-guro@fb.com>
In-Reply-To: <20201103212725.3716088-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 4 Nov 2020 07:00:00 -0800
Message-ID: <CALvZod7-3VGVvBWfxzn_8acvqkGEoh7GruVKcPYDy1GoO74sRQ@mail.gmail.com>
Subject: Re: [PATCH rfc 2/3] docs: cgroup-v1: reflect the deprecation of the
 non-hierarchical mode
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
> Update cgroup v1 docs after the deprecation of the non-hierarchical
> mode of the memory controller.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

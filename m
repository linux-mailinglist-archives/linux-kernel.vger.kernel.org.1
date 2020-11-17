Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD39C2B6B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKQRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgKQRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:17:01 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:17:01 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so31147917lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbXTqX8J4PNdelvJC4wHhXHHnug3DEmJJtNJ9Q3CjN8=;
        b=ZlAxl3QD0Xa5p3JWtOf5QE0KHmZLFmGRQGLhbQLuLtJ8Oi0cUc+DIvI6G6L0gBUaD4
         0DmGd8Zfrj6WKdu80A9T0yOKJlXc1SDZxfs177XMqfdFDp6OA4JwaWy+Kuru5FQaNUE3
         sZQ0i5Ip2gKp5lDE0VBiTSp0Sn9Cp8GmWvG7uIV+KWpu7vIyERScAzNPZHkK9QljfWWu
         xM3AFr5VcMMp5CSLJaB75eI/zbsXQkmGzExREmOUFslWDMK/lUCo4vi/x13jo0SiOyBS
         RyFiihPVhI2NL4+aX/THKDerRaFF/sBunp2L/1BgvQmJf40U9iPFVo1YfVB0ylGrKsOI
         YFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbXTqX8J4PNdelvJC4wHhXHHnug3DEmJJtNJ9Q3CjN8=;
        b=CSyMv9dzWolak5CpDkSJWEmHfCZm7JM7tRoFCpL9svH2nSxRdwF204yh60pHyo61qU
         JhTVGynYo2mhCubd6pJk0z7HgQybOpVmcZhw7U+3yQIIzdzz84gwq0iTTd1k6edKRt9p
         iy37+apXC9pov5xs1+XfseP6VUFiUr/1eOkDI9TiJJkLCDTHIwN3RchYcKumrlprnrli
         0fb6EaHv4JHq3VrXwII5i5SJ2yV46zAXRPkw+dVW7QYMJKGsyNFah4kdYsUV1xD8DkAY
         K8P6R2EFbh0QOK9elYT4/eCHNIYhdSQZ3f5QXFETnCdsXfyZxLaovfplWJmQBGtYeBbQ
         vSbA==
X-Gm-Message-State: AOAM531wXESEum7pDtu58AWWQFlp0whhk2t3YUxixCrPRxFOcgP9QjI3
        i2CONxOCRMZ1xmZXS2cXM95drBlgalfJ5hVJ5oBSkQ==
X-Google-Smtp-Source: ABdhPJwVhpHrOXeGdSRSaP8iESNSjM3x3QcHIw7D8pa+PWkuVXlktckRJGWeJI7X18+aeytBGdNUP31yey8rVETh/Mg=
X-Received: by 2002:a19:cc42:: with SMTP id c63mr1938796lfg.521.1605633419249;
 Tue, 17 Nov 2020 09:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20201110195753.530157-1-guro@fb.com>
In-Reply-To: <20201110195753.530157-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 17 Nov 2020 09:16:48 -0800
Message-ID: <CALvZod5pd=Y_DC8mTs6Uc2+McPe7iEQs5hHtGbOFCA9EAVDe9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: slub: call account_slab_page() after slab page initialization
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:58 AM Roman Gushchin <guro@fb.com> wrote:
>
> It's convenient to have page->objects initialized before calling
> into account_slab_page(). In particular, this information can be
> used to pre-alloc the obj_cgroup vector.
>
> Let's call account_slab_page() a bit later, after the initialization
> of page->objects.
>
> This commit doesn't bring any functional change, but is required for
> further optimizations.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

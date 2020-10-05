Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF2283970
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgJEPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:23:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:23:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 133so4780673ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oisuTyH2B16KCT9bIXRJo+RBIlK68EwI60DD8PxYDQQ=;
        b=G9UhbmoRoEgmnDPaJWizfTZK5Qgp65885ntQAgGiZ0fze6Z6iS+sa6sNGGrBDI7lXl
         if8yesDWamsRuEddljPSsGZRny5GqcAwBwn9Sjpgkv0baAZtBtN1tQqH3CQQ1ito0P1L
         ZRkQMUK3t0I31LDWSZYdYLS9KDjbjwmyYg99lfpaEskjlFpnyBs1zV8rr1koxr0+g4eC
         1Xql4lJ3r+UPyhh2KLYaItYNf0WvOSHNrPmMDREbTbcUMxmo+0u1bGT4//tcJ6EmprsC
         Tv/g8hgkyElNKVQ2Pw4coxs6OxqGbS7QypV2vPacz2xUjMSqx48Kh3uYgAqA9aRG1/fN
         6jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oisuTyH2B16KCT9bIXRJo+RBIlK68EwI60DD8PxYDQQ=;
        b=D77DluPjmmWUtCBXjgjujVys9K5CrlPKJ9FNuFcuHj89pEt6P84z6z7LlKenLmpION
         b5lIdqrd8lKkcwwEgp1bNkaCW9ZxgD5HfzaS4rCDD3c6Qi9G7+35qanS7fdMPVCP5QUL
         g/klovER7jTVKxsAcXQfXqKmLE5YXMIGqkW7HROL+Be8KYRDP8Dw/YKt4KxUzHGeFL6j
         vB6r6EAgCqJqmO6ugW9Y11YKUkThWRO7Brya48TPVHKyssIjDfkorPpGvieU74LETGej
         zND2H8jFPVAPWU4MopKAHFmT3hQh+lXPmvY8s0nVsqIswhR69AOfPC/RULAYyPW2pezp
         jHqA==
X-Gm-Message-State: AOAM531OgD4AubHgc4G1Kfa+QfoHbf4Grff3UoVP/aqPqnZTSAb1hTtC
        4tsLwyPptWGFKJRMpZ4o0MreAOr/UeI0KRapx7o=
X-Google-Smtp-Source: ABdhPJwxvtjpnMJdyyFmg58WrNHXy9efsb6Rh5cm2bo3+IIkQeXPwy59RgQl2HySFVV+ZRnY6JK8teLvAWQKLpN/gaY=
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr62666ljq.307.1601911409758;
 Mon, 05 Oct 2020 08:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200920113808.22223-1-vichy.kuo@gmail.com> <20200920113808.22223-2-vichy.kuo@gmail.com>
 <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
 <20201002134532.GA3419175@kroah.com> <CAOVJa8HZCmy0s-H7rPVTgi6X1uYZ82YjdPHe3-a4=D+qLgi7Uw@mail.gmail.com>
 <20201004164745.GA196660@kroah.com>
In-Reply-To: <20201004164745.GA196660@kroah.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Mon, 5 Oct 2020 23:23:18 +0800
Message-ID: <CAOVJa8G+RMYvV6hU1cuJStRBM=7BbA7s1sXZavKs9OhHY8kaZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: platform: provide devm_platform_iounremap_resource
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Greg:
> Why are you adding new functions but not actually calling them anywhere?

Below patch introduce a single helper, devm_platform_ioremap_resource,
which combines
platform_get_resource() and devm_ioremap_resource(). But there is no
single helper to release
those resources in driver removing stage.

https://lore.kernel.org/lkml/20190215152507.31066-2-brgl@bgdev.pl/

That means driver owner still need to call below (*) and (**) for
releasing resource.
Therefore, this patch adds a single release helper that can be paired with
devm_platform_ioremap_resource.

Appreciate ur kind help,

foo_probe(pdev)
{
    iomem = devm_platform_ioremap_resource(pdev, 0);
    ....
}


foo_remove(pdev)
{
    devm_iounmap(iomem);   (*)
    devm_release_mem_region(dev, res->start, size); (**)
   ........................
}

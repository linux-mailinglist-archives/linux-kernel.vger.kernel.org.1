Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF51E9C11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 05:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgFADhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 23:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgFADhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:37:33 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC24C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:37:32 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n123so4475697ybf.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3kXy6Foois4p4YwmWOHbsqPi5NG9OlA8HpHEWFskMI=;
        b=Fp8ru2YzEzjxWuQL+FWVNIMbN3heKyS6JRkhel7hpnw7QyD+5Eeu3oGkcEbEylFli1
         afbaRGhIWktXw/VO3jXYZe63X+tqmpdiBWVqfeST7O6t3ce5/qZMfkVV7StGkjHRAst8
         zf0YapuP2s6yQGFSB6IUaFpe8gXroDNc5aUk7jkRvdFvBut2RSDWTYjdxjxlGvCTvFrf
         MAzutSUGG/eGym5XmwSeSXjRIl4cDNGhV7XDC94XUKv6VkG31kwr5tym/OcWyPmk7QoO
         7BhH5VN9UfkI+RTH3+J+mR4KjcB45oYKxwbO/n6zZbdCpLhQ3Qswuj4kwQf1wpkNJ+I6
         /pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3kXy6Foois4p4YwmWOHbsqPi5NG9OlA8HpHEWFskMI=;
        b=PEXQ2MDlw+APRoznNaO8ZLSz+sGKbnavfD6iwdYEtoOXwxiH0c6IBodkh8EbJkA5AD
         LoJxy9qfCOPJxbQ7NeG34BSleXRY2BQtgGEfnHceRVKOP9t4sBj130pfNswTXd4Vsqqu
         pHln6qjUvINeiqxl6ElCeUeq97zglZ94wpagheJebuBFT+5k/i567kq5CwTHAehGNz12
         f7M+MiAHrgjQ6ZD65mhhe6aRczfKFiIomrrSrKqbeiBq0KtGGN7Jqq+7ec50OskHfhbK
         TaKCb6Q4vPPztWtwK1WNDAIF09Nr/5Fz1fxcn06iACU7Bj7MKk/ejVHq1n9IRAD1Dtgq
         4Ecg==
X-Gm-Message-State: AOAM531uPClQv+1ko8iInf/2CNuZrIN8BhikGgwC4lZcxZU2wroKBqPL
        sfcD2H0kpTG5zNbS2TMBl/umfopJUxML9vhEvn0=
X-Google-Smtp-Source: ABdhPJydpKDkvSPYSJk0wcttMYKs+HSyWTjov0ZbhQNnhDIn7/fYDuUakw4pz4rV8NAtwoNzLHJuKOHwA0Hm/1ro+dM=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr30191893ybp.268.1590982651331;
 Sun, 31 May 2020 20:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200529080042.6082-1-dinghao.liu@zju.edu.cn> <CACAvsv73wZK_pKk4TDHaTeBUqxYHvK0KhLQBgPC8Be_VviY2jg@mail.gmail.com>
 <6a65a5b1.dd4b7.1726deaea0a.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <6a65a5b1.dd4b7.1726deaea0a.Coremail.dinghao.liu@zju.edu.cn>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 1 Jun 2020 13:37:20 +1000
Message-ID: <CACAvsv5kcUC_kOfMPxqY-irSAexmhm=WKO8Vk=wTZWdsbaartw@mail.gmail.com>
Subject: Re: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in gm20b_clk_new
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 at 13:27, <dinghao.liu@zju.edu.cn> wrote:
>
>
> Hi Ben,
>
> > > When gk20a_clk_ctor() returns an error code, pointer "clk"
> > > should be released. It's the same when gm20b_clk_new()
> > > returns from elsewhere following this call.
> > This shouldn't be necessary.  If a subdev constructor fails, and
> > returns a pointer, the core will call the destructor to clean things
> > up.
> >
>
> I'm not familiar with the behavior of the caller of gm20b_clk_new().
> If the subdev constructor fails, the core will check the pointer
> (here is "pclk"), then it's ok and there is no bug (Do you mean
> this?). If the core executes error handling code only according to
> the error code, there may be a memory leak bug (the caller cannot
> know if -ENOMEM comes from the failure of kzalloc or gk20a_clk_ctor).
> If the core always calls the destructor as long as the constructor
> fails (even if the kzalloc fails), we may have a double free bug.
>
> Would you like to give a more detailed explanation about the behavior
> of the core?
If there's *any* error, it'll check the pointer, if it's non-NULL,
it'll call the destructor.  If kzalloc() fails, the pointer will be
NULL, there's no double-free bug.  *every* subdev is written this way
to avoid duplicating cleanup logic.

Ben.
>
> Regards,
> Dinghao

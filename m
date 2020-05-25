Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7E1E0A26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbgEYJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389329AbgEYJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:19:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E1C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:19:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so8333785ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivv4U3PHcis2B80M8w+kgvcofnNEYSwN3GL3OCHkXLY=;
        b=C0OfrfuDAz6Y8SWn9kRPQRzJwTFuzjeUjeAv/8uYAsbDCC76OTiMRRB3ZH0+RQk5hf
         d6SKMlz8qVm52fq4TPs3/x8cC1HKxjsIszBfCqQPN9ReHPVBVX80sxUQmMTjLicxJ6Ll
         V2tEi+pOX1GvZcI9Gcusfy4292CKHUmgHILh4QOi5+Ch4uJ/EYM0+Cukfsnsm6sZoCsO
         PPB+R1yh4RELrSLsUgDkwJJst707f5SqvQ5zwLOOZwKpmQvphO63Q+vUOfrvr4BH1fGL
         YxpOQd0eW82OGV54YvnsLOwh1jtKvOQLiBnUTw9nU/Rj4dXFjmoEbCz3wwIE6Wk+Rxx1
         WPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivv4U3PHcis2B80M8w+kgvcofnNEYSwN3GL3OCHkXLY=;
        b=LHz096ZGVzBJaZ4v3nOIuVTDs/woUQFENOFY9vAtkjwxRH3daHH7MU6F4eRUMl7ry1
         geCFky/xTOlhRlDBx/jlmGAshOkZCW9M/3fuWDCW+O9aQJUvLkHB6gVrsbgQcdBRftZQ
         QxPDzF7QMCe+NeqMKw+bHDPFxpCEK0LiVE7HnSnqIW7Fg3PZfqeQ6K4BMa0PH0B4Hqny
         aO82X0eskqqD0cd43mZ9JVc1MggrNgxmcblBe2INBsEsCPLX/G5F0fshh3KO7ZC4F+8L
         IQQjyZB0aO3qXmfj/jTHYLUnY15YJ2fYFn3ZWh8X6N6ALD4C0KXCcW7CC5sJ9bsNQZ6o
         gnvA==
X-Gm-Message-State: AOAM5321BuuKEH2tKXAHzl9T/F8Y/+4hPRDyAkrmrLw9bfnNyjm2H6GC
        X9fXJ3Y0nessUh0CdJiuIQQapC04xQXq9SH5d9thbg==
X-Google-Smtp-Source: ABdhPJzt8IHf289hS0GsYDzZdfoPvoz1pPBM7421ky0044/8DIl8iWL3/ZWtvqH2cXFMUtCkODclOesP4RIwcw9FUP8=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr10498339ljk.144.1590398342470;
 Mon, 25 May 2020 02:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200520120804.GI172354@mwanda>
In-Reply-To: <20200520120804.GI172354@mwanda>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 11:18:51 +0200
Message-ID: <CACRpkda90y7p=5iBS0=WyYxDVRhMwdVUMWO3E5uvdwES=UZNrA@mail.gmail.com>
Subject: Re: [PATCH] bus: arm-integrator-lm: Fix an IS_ERR() vs NULL check
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, May 20, 2020 at 2:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The of_find_matching_node() function returns NULL on error, it never
> returns error pointers.  This doesn't really impact runtime very much
> because if "syscon" is NULL then syscon_node_to_regmap() will return
> -EINVAL.  The only runtime difference is that now it returns -ENODEV.
>
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The first patch which added this file doesn't give a good hint what the
> subsystem prefix should be so I just guessed "bus: arm-integrator-lm:".

I got a similar patch from Wei that I forwarded to the ARM SoC
maintainers that usually apply the bus patches for me.

Thanks anyway!

Yours,
Linus Walleij

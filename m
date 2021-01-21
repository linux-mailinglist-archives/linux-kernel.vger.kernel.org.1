Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A82FEB41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbhAUNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbhAUNMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:12:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:11:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a8so2417576lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SfYgMEZhXd25eYi6qDsESTLBn/H15YeTrdDgpcnnLg=;
        b=XqZam54V6WNMaJGpQ/zvStXdECi0C+QtAqbDl16uTP8QioYtk1POCI5rq4ekLBZUIz
         kqDKzYSX8IHExWGey4zMVWfm90PVJegAsI9pSoEhlbTENGMDh6pSp4b5tlefIzBvwoB7
         swLIZazE6kk/8MNF4dLmLSJIrM8sHNzVLmNYgrRKEF5y/duOdwPTw5jSGwqDUcPL2yOW
         /3gI2Ht6mM2RpqVZMAsGhxcMSW0j4+Drz600DkSUVF++LOFmjgQVLj7ePlqSQPMe6O5m
         RCXQMtC2csH8UIsDZyKtdZkpiiK+RX3uZ5/KpaVAust1eNvovi0wfgU+mm2jEKTPOJXO
         r0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SfYgMEZhXd25eYi6qDsESTLBn/H15YeTrdDgpcnnLg=;
        b=orrdmH/mCyxsaoED0Z7NHCz7ktVsVDrIQ+asJmeJ9Q4jJw/2BWW9C3+LR2/R7G+Tch
         O0WqX9Nvm65Kg6wc6eHNnWMmueW4xLMng74KC6Lhb8ImMjxcTF/7dOriOx/HPCk3swHj
         lnWqCU4/i8DxdzpwB9R2YFG4KxTR/57kIqU5aMjtVOOkMPR0LPhkXPaqFKIBGLkfb5Ga
         bPXPPN59NznIv6mqpm+ofh33g9+t+jJ/8qP6JQuiCgv3iFLOOmvMsoY7yFwGTJf3JrcL
         XShLXYDjqJ/J9QpCuhDdgL/erlEuaw1EQnOmPDS1PKNmVmTnF38Qrd99OVOM5Jy9IJhi
         CloA==
X-Gm-Message-State: AOAM530ZWj+aYhD60Fl9VMXcsnmr6atvABqIX60sR91q6Vh+AmwDnyM6
        KUVi25C4cyQv+jDcdtZanoBT2RVFZiVVgkIaaP2K6A==
X-Google-Smtp-Source: ABdhPJwFTZwp0woXY9zVcoMioOYsSx1rGdrNSXqJ/is4tl/LS3ywlrqFOWHMdDa3yy6WG1BJ0UNlQtoKVhMMhIRbxeI=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr6289121lfg.649.1611234695050;
 Thu, 21 Jan 2021 05:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20210120080522.471120-1-saravanak@google.com> <20210120080522.471120-2-saravanak@google.com>
In-Reply-To: <20210120080522.471120-2-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 14:11:24 +0100
Message-ID: <CACRpkdbEC6duR=fJQD_Nw9o=HW0DEe2_Ks3SYCgJmkOjzKz3Jg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] of: property: Add fw_devlink support for "gpio"
 and "gpios" binding
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:05 AM Saravana Kannan <saravanak@google.com> wrote:

> To provide backward compatibility for boards that use deprecated DT
> bindings, we need to add fw_devlink support for "gpio" and "gpios".

You do some more stuff in the patch so describe that too.
Especially the check for hogs and #gpio-cells.
Describe why you do that. Maybe even with a comment in
the code because I don't think everyone will understand.

> +       if (strcmp(prop_name, "gpio") && strcmp(prop_name, "gpios"))
> +               return NULL;

This part is easy to understand.

> +       if (of_find_property(np, "gpio-hog", NULL))
> +               return NULL;
> +
> +       if (of_parse_phandle_with_args(np, prop_name, "#gpio-cells", index,
> +                                      &sup_args))
> +               return NULL;

This part is hard to understand. Insert comments and tell the reader
of the code what is going on and why.

Yours,
Linus Walleij

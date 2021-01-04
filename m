Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1A2E974D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbhADOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbhADOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:30:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99C4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:29:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x20so64694578lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfZPAjnuJrUl8K10B63FjuUD62a6oBY/w9PLuYoOe+8=;
        b=EJQs+uOYf6CD8NokGZJY1K8XQFXN+5SfqUhwkl14ZcbkNhMJZrdTLgLKf766mzWB0a
         /DrA5Kl3xG1unxJPDnN+Br2rhXuKkUV8fGevo4wEtaV/9S/x0pZszyjL+ZR0Mw63nQwn
         W9VXgffKRybKyWAh7tE1hMK8TDJ02JJzIutU0dRCqGWFQCRUStEV75lgXlseVAmkfZ6K
         y8l5IsjFqpY1PBypvkUKb1qLfuDLdRhcRhqQTQ0QUnBwc/KrM61k29jp6RF9gCQbloaw
         SBiXcAMiJVs7haFrLtimMnvGP0o9Ni56dXt8nwpNOOGb5QMkXGZsvO+KzNpkoW7JHkUh
         PUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfZPAjnuJrUl8K10B63FjuUD62a6oBY/w9PLuYoOe+8=;
        b=pX1c7fzLL4M3lVHUcGdTQ4+qFDtIof+n9692tegHVxQ5+quFsUWULR0fq5Oeaf1Uqv
         dv1iZxePsu5UK8Yxq3zihiXv/7OD52Do1NUz9GbyBWY9oGjO8xuD3z9GTfzzkE2ZHgM8
         7db3I8hNkivTgRVK92JcfTpM1WiHd8oqCVD6y8jyLO446H29oVrHCmaKn3oWN31qd01i
         2Ta+U+PCzvUX9XoNZeSILXLliAqabWDyi7mK7f5vx3qBgvGtwgR71l1apUci/8GJS2/7
         BeAa3UPdrjgfBZGf9mZJbF73+LqejU0s/rbObSn7JiDzhL2vxwblWz4rnLAcKzVUkwYF
         ocKA==
X-Gm-Message-State: AOAM533kH3N8/Wx4TXBHk+vQGxC2cyOlJl2GGYCMaHJPQNXHFbt3Hln+
        MC7DLXAj6S8EftEvUCLc133JlippnjLtAYBJDFrj9A==
X-Google-Smtp-Source: ABdhPJx5c9nYTmCfGqr8Cx5BLwvCeDwET2wp+fGhwHM+T5DI/+OoyBU5IEuD6xRkd5eJ5Je5V1KY6JoUvatHv7EMt6k=
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr34324695lfq.586.1609770597495;
 Mon, 04 Jan 2021 06:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20201211084717.2371-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201211084717.2371-1-zhengyongjun3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 15:29:46 +0100
Message-ID: <CACRpkda4FuiP6x7mzgB-c_8DjOhzBtfiV46yQYzA9natp81MDQ@mail.gmail.com>
Subject: Re: [PATCH -next] mediatek/pinctrl-paris: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:46 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Patch applied.

Yours,
Linus Walleij

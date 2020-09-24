Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5027721B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgIXN0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgIXN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:26:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28ECC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:26:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so4405505ejr.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XexnDGcXtnYzxSDXXL3LsxUhuAmen63As9oxJV/uz9Q=;
        b=kgTjvI+notSvcV1G6DlP/YbBRTYIoc9l+xpy2LnM2CAUVSj4ezg/9x6dqOZ6wnrq94
         9MtdtxN11ZInl93BO1eYXIug84nACv74HI0Bou42h/R6ly+hJgJucBtFwoi55wT0shSk
         LFDbcbXi7f8wKGj9oWgR9a4BMZ8us74xQRmaL0jhunAT0o6ZPyKIS1cQ5obDH5ZVDNK1
         i/HHctQ+fqdd3KkbVaoKIPbGFGuQf7QfUZZX4jKh5f3qRC4qyq1s4k53xIqvXVLpHDQn
         oRsIhLPdVxLK/zWXUj1yCexDQd9E2st1Mz0TEywAu4kFD7takgrMpk5THLnYgtq/3ckb
         3sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XexnDGcXtnYzxSDXXL3LsxUhuAmen63As9oxJV/uz9Q=;
        b=ud/ZEqEI3QtQ0EVSnfXfWbNKMmBjpZfAx9r6miHrUaxtl3pi1AnLb4tOhGMPblpu2q
         hJ/ZsK5/uO0Iltje1BAJY1FwdRLIMTJqkz7NpZSfticGBslZqgvJvjcaTa64+WcXfIzs
         54ErqLZT4zmP3b/dn/XJod5K2xiL3ZgvyL0MOWcaz76n8GuJ+thT6Ls7NqRPeVKDpOwt
         7ujGUfDVZefCFPWanFagvM+m7KlQtZ0fZ+Khsh53ryQPlaRwr+NfJGC26PjsfP1YgyCb
         +Zulb7TFc6qIPZc0LNPzG1oEaxUhGrjei9iVwKMB8FPHyjjk4UNxjPYt6Skq/eEkzeeE
         lv3w==
X-Gm-Message-State: AOAM531Zz7aRHMK5RD+YjBmJ/JkIJQb2AP2lMPfi+jKV1oGbAm4dtGlB
        Wu2p5T0fhUJgu8Cw1N1dY3Lz8DTYLcljxXkXeJmMfQ==
X-Google-Smtp-Source: ABdhPJzL25q1kuPvZnzXILD9yCjuVJJoFdPmKYvOCzgBP1DPA6gPD4TIEnBP9L8hXZW3TjX9vVurhdi3YXx/TqF6yN8=
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr1101533eji.88.1600953966583;
 Thu, 24 Sep 2020 06:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200916094952.458003-1-jonathanh@nvidia.com> <20200916094952.458003-4-jonathanh@nvidia.com>
In-Reply-To: <20200916094952.458003-4-jonathanh@nvidia.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 24 Sep 2020 15:25:55 +0200
Message-ID: <CAMpxmJVFtx4kZOvP5UkYL1U_1UJn_FGabBZdE7cdMDxQAPoSwA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] misc: eeprom: at24: Support custom device names
 for AT24 EEPROMs
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:50 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> By using the label property, a more descriptive name can be populated
> for AT24 EEPROMs NVMEM device. Update the AT24 driver to check to see
> if the label property is present and if so, use this as the name for
> NVMEM device. Please note that when the 'label' property is present for
> the AT24 EEPROM, we do not want the NVMEM driver to append the 'devid'
> to the name and so the nvmem_config.id is initialised to
> NVMEM_DEVID_NONE.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Queued for v5.10, thanks!

Bartosz

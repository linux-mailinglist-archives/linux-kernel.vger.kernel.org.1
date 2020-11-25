Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4132C3E51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgKYKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgKYKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:43:55 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:43:55 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id w190so373784vkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6QslX1mNSHdund1C0gsdAdrG6mQg5nN7ZNoGTAqo6LI=;
        b=o7tdyw54aCLhVU+iic7R3POubn349Bpx3CuuOc2f4wZCl6WoGo1s6qwMb34XVgx+NZ
         Nk0aFpkMvxjoy1jVACkLBcg+2JL+XH5A+G5d0Y7hJgRkCM4s52bfa/HV4PnWz/ow0Dwq
         vOD9yjbArBcLs4Ngnhbss+5dn183jveH7X4WsMAP44n5ybNcstCi5nRJLDfSbVHxF/uc
         F036X9ORN/lUqAvgYHn3qgSUyNoiob6KDF4N9QZl+qBNNSFXvLPp4TgI+I8+OvZMoOph
         B84G4V8hAgkjhFatUHF637aBL079qoPLer/fN8e41BmezXS8X6oVL2W/fn4jSll1zsi7
         3F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6QslX1mNSHdund1C0gsdAdrG6mQg5nN7ZNoGTAqo6LI=;
        b=hzKgHouBcwHnqOoixDxajLwp8w9DNmUZeMWbp7SxsJB7OC0pDMSaQXjFhKUk7za+hL
         Z5ar7eEyVqitpxSuIRrXHLiDzfmnXWXAepCePj3reZx5UCXNwjLn6VSt5hJbH8mNxaVE
         shSzD40z/QSA1VOqPP8AXVj1MYSlMnE0zecqk00GQTMl+YBxAnmYhmqnSrbvj8agmQvP
         zc4xWEZ6jhPQ/QYhF/FKyj7cI71hPo/VfQ9a8CM0gBj1YkV5Xmw9/EeaN2JKvlOLJQ++
         /pzfirYp9ntPBiRQV+1pypY6Z5E6j1W788617ne0RXoZgo0pas01LyJVXAkVb3iLxpLI
         HY/A==
X-Gm-Message-State: AOAM532hDT/0bRUeio7y0GjuIU3tTtnssfE7OgPyalhK7MLfs7M1nh3y
        ZEo7TtkPdQ0hSIo7EBotjylcJgwP6ssKiw7EOHuGig==
X-Google-Smtp-Source: ABdhPJwyfbOqz8FDPkic+2J4DYD3aO4jVMdTJWgdndHlqXgc+y8739KN4jBFTTsEgfdjntgOWu0VEhXokakvoqIHHHM=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr1577072vke.15.1606301034394;
 Wed, 25 Nov 2020 02:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20201106022726.19831-1-takahiro.akashi@linaro.org> <20201125074125.GC62993@laputa>
In-Reply-To: <20201125074125.GC62993@laputa>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Nov 2020 11:43:18 +0100
Message-ID: <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 at 08:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Gentle ping;
>
> On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
>
> Any comments so far?

I haven't been able to look at sdhci parts (I will try to), but as you
know, I am relying on Adrian's help with this.

When it comes to the core part, I am planning to help to put some of
the foundation in place for the mmc core changes. Although,
unfortunately I haven't been able to post patches, yet. I will keep
you in the loop, when I get to it.

[...]

Kind regards
Uffe

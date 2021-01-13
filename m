Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5812F4A14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbhAML06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbhAML04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:26:56 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57551C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:51 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id w7so559087uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cttz/D2YdQLsR3C43ckdGIJQQ5YrOYDnbNf5IhNcLYI=;
        b=LEcwabxJhci29cnamIgXuHBO/Z3LtbMfhlsaTAGsoL9g8zKCBLZxqcS0ebx87zsJH4
         uy0zhjszBskdOKPTHR0OK4tdYaz1XJlzAREFfrO+9OW58rvWU+48/NSnwPq02leH4WCp
         cE4wcDuFxuj4hhLXqbRlGDPpRggYUEB5DzVgCR6M0jnAHD7pNY3MGX0vjOg6ZgD8FnYE
         qPo0cGJup4guB8Hwshd45R+sII1vauMATFhH1bBybUz64fCPzTizQvw7t5bCs0x8DGr2
         83s7PBi+V6jdPZYmGjo8OJ+N7Y98lWtA8ijopW+CXpTrCY28bQwhz0IVk8bVfGZE9D0w
         sJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cttz/D2YdQLsR3C43ckdGIJQQ5YrOYDnbNf5IhNcLYI=;
        b=YC5nJAxFMmcKJ4/2JxmTecoFOEecY2k+2nfocfySxuwpqLTgIbhoUhEJG5wXhCexEX
         3Cxz18bZ82UyyAZb78eymGaT61d6Ho0skJM5Rez7fnBS2xe4FmiSsQqXlnSXvcsOqDD7
         TcnDEdhhpk8HrLRTMwu2L4eGipc99RX2zsMoati7LFd1P/LO3wsIcwAgIKmnYaVAzG5V
         a8iD0mdRi7csuTp1l0jqfXQWZLGk+tt1EtdySEObFRTGGjiXGffyAuvkPyX6HgTv1DsZ
         rOtdAkiumWCcWyZymUX2SgzSAfXYgVa9ucQtR6wPKgSpXs4kAM+OS4g78Esd7LgzR/TU
         LhKQ==
X-Gm-Message-State: AOAM533QfF+TFl1gzn8DT9zym6k8Iitqp68wQkoblJfLz3e7g216QW5Y
        2+ef6Le9jYmcNlHLi79YPlJ44CjtCmXpmCQft9nH9Q==
X-Google-Smtp-Source: ABdhPJwk9cikIsLvk8wBtOv80r3nN6Wd86Yx/Dl91r0NxtDJZtYZrmyEAcUkJnDivNztwQjpv9hIZjRVGl2XX+Dffxk=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr1317060uaa.104.1610537150635;
 Wed, 13 Jan 2021 03:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20201227174202.40834-1-wsa+renesas@sang-engineering.com> <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:14 +0100
Message-ID: <CAPDyKFqBJNiV3M7MFTydLRtR7S+wok6OkLnKFrfzbi0TfPxiUQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Add r8a779a0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020 at 18:42, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 6bbf29b5c239..5908a717d2e8 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -59,6 +59,7 @@ properties:
>                - renesas,sdhi-r8a77980 # R-Car V3H
>                - renesas,sdhi-r8a77990 # R-Car E3
>                - renesas,sdhi-r8a77995 # R-Car D3
> +              - renesas,sdhi-r8a779a0 # R-Car V3U
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>
>    reg:
> --
> 2.28.0
>

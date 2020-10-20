Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA8294326
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391578AbgJTTir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390923AbgJTTir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:38:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB7C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:38:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so4447063ejy.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0t/6lxdfJB1VtvUS8CRTLcR9vrrpuLwBQkRpQbczdss=;
        b=RAVu96uCHOLD8Tm3mF3Ij513xTplm/3WaVxFJRsxQvH6/Ma53nSbEdwB37DX7YGqA3
         L3NU6hwBoZ0ZNWrfwDp7TB9I0udOnhp88Et20D3oz4Vo7eSjhLdPDOYr7aIqKoBB0zTP
         lRm3G89BwGWyNuY1CXYr3BtGY19YCKwdpuJpkArD6L0V7qCeezDGRsaexYzEYI11NEnz
         PlscX/yOkz6nEeddfgo/lQKlOgUxOL0ouEsOTLlf0RMlgVmAozJmPNpRP0lOazvlm4ah
         0pVh4ICDQ8GAbks9xr39sZwYwasCGt1rhzMcF7LO5MgtOGdM/AtO8Fm8ShPNWMDFoE0/
         Q/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0t/6lxdfJB1VtvUS8CRTLcR9vrrpuLwBQkRpQbczdss=;
        b=iXMtep8kdXUfeSYoLmhDxb86LxyqNsFKfkRLkRenQpOAdOfrsD95oVZ1HJ1a7aXT5W
         NGF4YEEa9pQY344fy2OtaTb1rgm7uqTTPRNLreTw8tjZiy5n1gCpfMS3b3Ys7vfSbehW
         zYwZV/xjXU/tdG8OaexIVpXyGsDAV4AbsJEUCIcCCYc/pXLV+Dq8kCahqo9cHAuT0G+z
         bTcQU/N/QZfj57QvybvEJFmX4F2JJbPtjG708436hX1NNFvxR/gRcCX3bh+FG9lDZRnk
         6lP7SNz7KyHnXtY3eMDVfF+0qeGtmj+x83dR4hzErbGCYH26kw/aAk5k/g835h47eN4P
         OpAg==
X-Gm-Message-State: AOAM5332MdiL4QjlUWAPLuwsRjMrJT4RBFU7ybpol/sFbr8ZKlYwNOXn
        ea6qIurVEPRaETSNAqwmHdNrBMGP9m/y5SHMnzc=
X-Google-Smtp-Source: ABdhPJzm0r+f90HVNAeb0yNZulVGpiqUvDFPFj8PANlV6Dz9Cf6ehgYOH7h2wBTMI8K/6QlolIQY2DPRGjQiWXWFH6s=
X-Received: by 2002:a17:906:cc0d:: with SMTP id ml13mr4826136ejb.2.1603222725387;
 Tue, 20 Oct 2020 12:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201019144809.943608-1-narmstrong@baylibre.com>
In-Reply-To: <20201019144809.943608-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Oct 2020 21:38:34 +0200
Message-ID: <CAFBinCBxSdhutZQz2LFkoZwQT35gW-T2W3KX6-M5mp-XfZy2vg@mail.gmail.com>
Subject: Re: [PATCH v2] reset: meson: make it possible to build as a module
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     p.zabel@pengutronix.de, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 4:49 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the reset controller driver as a module.
>
> This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

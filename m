Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A02F0861
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhAJQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbhAJQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:23:35 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD7C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 08:22:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m13so896227ljo.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 08:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTLBpzTo5LeLsTDW+FDGFlqPoi5x9gPnyhITuJXu+rM=;
        b=DSYv2zoCerXm2EH5e+7b/j5ZbK2t8jAEzGYQh0iJYcLVTAxjb5fK1Ho1Dw3FMWN7gw
         NR+wBmqoUIxB654BISsNuF5bjHox78pr5MQCdk8iOZRYoVtlsfOIqbJnuL3lcsU4bL2C
         8xubwMAexbWdugUs44dosZVFSjpQoU1ZSTMeRntrB54tPAbsPCoXGG0YNhT3YU3Hn9Nz
         uWzVohmQ0wCT+74oX+HlMkK34KQLUr0poA6ExVtoCyRaZbL3F3WdsreGL4f4oaZy/vcB
         AVfVOG0uJpwgHZP+HGVHKbR45mYuszQ3vndqE+S3LxQVFftV7491Z/6ukyYQxld/oDui
         s9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTLBpzTo5LeLsTDW+FDGFlqPoi5x9gPnyhITuJXu+rM=;
        b=FrMaORbaCeHBb1WRay/iI+O0Z83aoOrxqfvilwae7pPQXBihJ5+9bfgilV+KkVCvH1
         epYYk7U53qAXdIFFS/UyX486sGolsrVptGWc6OI+w+LnZA6SO720l4S5p2bJJVFnRiEG
         Eyy5jqmJwa/aE5eAgw7LJaO31fpeNMGkWZdzmSF41DeL7WnDk7yU1Qlda2XH8Fbn6HNu
         W45VqtRYokdBAfVwddvIwvI2zjWrXiWrRI8erQ5jUCWNwBqOhETeBCKRCNcXPDQw7ej3
         j/KEFU9xoVJn2JVp3b5OgrjWqdl7jsAGNjbI3fqCSMGYjoTq2fHu0JnDq6Ygsxo5+5hs
         7srA==
X-Gm-Message-State: AOAM530MLacyzroEVUdWVNsb5bp7ms3vFGVxBg890xQfrmWy6EE8soJY
        MCf2n01fZTIO7qrmSdDwEWAVydDBhXPIDsEJY2k=
X-Google-Smtp-Source: ABdhPJwfxTKkebF7iHh0xQPCulFMc9mmeS6SOuIeo78Q1pwvGaE4csL7+fOXZDRXARAV1qk+pExkZkGaGhfLhjSCczw=
X-Received: by 2002:a2e:b80c:: with SMTP id u12mr5589390ljo.490.1610295772934;
 Sun, 10 Jan 2021 08:22:52 -0800 (PST)
MIME-Version: 1.0
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley> <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley>
In-Reply-To: <20210110153532.GA7264@ripley>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 10 Jan 2021 13:22:41 -0300
Message-ID: <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Sun, Jan 10, 2021 at 12:35 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> the first two errors are gone. But I still get this:
>
> [   42.387107] mxsfb 21c8000.lcdif: Cannot connect bridge: -517
>
> The panel is still off perhaps I miss something else.

Some suggestions:

- Take a look at arch/arm/boot/dts/imx6ul-14x14-evk.dtsi as a
reference as it has display functional
- Use imx_v6_v7_defconfig to make sure all the required drivers are selected
- If it still does not work, share the dts and schematics

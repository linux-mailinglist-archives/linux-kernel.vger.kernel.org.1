Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDEF28351B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJELjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJELjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:39:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B317C0613CE;
        Mon,  5 Oct 2020 04:39:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d24so6464514lfa.8;
        Mon, 05 Oct 2020 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0xp8TscW6ysKMCr2r9U27WWoLB5uN36ncLR0InNu6M=;
        b=Q1QJaCwR7QmgTQpB7W9IZr6u+/K5tEtym5SGqybofKshKVP8hucO3W2ctcnfWfRd5Z
         O/9OfMUEWe7zf3C2Sba4YeLEXMojrdJAUGPPljq6Bb/S265rW1EvG4sm6djayinnNC5i
         OEfQtUV7MAGDo9tNi73VYB4T6vn0+gQpghifwMbCvQ/UXCIRWA3oX6/t6+5jTiweo5P6
         xGg4oRuPLXkrrS5DfqKlZebzYrEi9pPp+RhnN57C9BU6t6mUvSPy5yySqKXhqlRgX4JH
         L7QfW7MlYAtzcp70UYaNN+PfWhGWFKIw9y827VXrHJFSdfWs54SPSy0Etw8RlEoUO8ie
         Gqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0xp8TscW6ysKMCr2r9U27WWoLB5uN36ncLR0InNu6M=;
        b=VEw+9KMjlgWb4yKLcNQde/xqKypQ0XLYQCFurcdbJRR1BB7rlQ8lsl+np67Qg0h5Tn
         txzsafNw5crMKgcVf+PlObyNiWUAJpqj2o+jEabQR7eUn4LFhJFhgtIC/w79yKw0uA3E
         b3APFoqgo/CsBlCsJ9hKJwnZNcO3ZO9VhAwn5rCFzuYva1vxxfv8W9fhuj/PIvP+BeuB
         2OCcLF9zCPKqA4B/K8S2YU+MLBTH2n/xP8BMOMjSfByQQTGL8YDMCweclM4Knk9/Qlcw
         +cwHofep1gLrUbzc3S/SdeqHOG1czZzt/iMhl0CJBU3zbOstb2G8nuVrRcIGNPULZGYm
         E5jw==
X-Gm-Message-State: AOAM5318fbTaZ0KQ9lMpPTw5JbeclNKT3EkxLMN+c1JahorkquKuwyhZ
        1fh6OvwzTLoOxRuXd3nMQzkJZhImr+vpyM41460=
X-Google-Smtp-Source: ABdhPJzRYS2ZHOE77CR1mvVjx3e05wKh9jexyi53q9nXKBpB4NhRbGtDd4gKcn3elYJPUCptpsm1aoG6sR0AHEAR/jk=
X-Received: by 2002:ac2:4e92:: with SMTP id o18mr5941668lfr.527.1601897974630;
 Mon, 05 Oct 2020 04:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200930190143.27032-1-krzk@kernel.org> <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de> <20201001073208.GA5208@kozik-lap>
 <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de> <20201001103704.GA26287@kozik-lap>
 <7fcea21d-4651-9ba7-5331-86530296a847@pengutronix.de> <20201002082012.GA6605@pi3>
 <20201002084119.buc6z7hpesoahmg2@pengutronix.de>
In-Reply-To: <20201002084119.buc6z7hpesoahmg2@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 5 Oct 2020 08:39:22 -0300
Message-ID: <CAOMZO5BMQ_OzvYfb1WJ1C3TJ5w49UvUQa6xb1XA--_kE94wQKA@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Robert Jones <rjones@gateworks.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Oct 2, 2020 at 5:41 AM Marco Felsch <m.felsch@pengutronix.de> wrote:

> Question is what was the author's intention? @Fabio do you have any
> comments here?

Krzysztof's patch looks good:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks

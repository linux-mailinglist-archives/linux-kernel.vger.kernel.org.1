Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413B92CC67D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgLBTWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLBTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:22:44 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:21:57 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so6155895ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIr/TqJfU4iObJfpNCSE069urbnIjjxEb9dHjImS2os=;
        b=LKC2ji6lsQhUlmhtdoNmHDnB9A21BmZDoU67iZkOF3kbK5mZpsWtBpPA5KR5Cs8hfl
         CvIoKMwemrlT0XBY4mNBI+JJmbA2yyrJ7UB3Ookyp6++fYeOvOvskESIQP6YdvM+22O0
         ZmXZPjrDZm1xy/Xk3KfGIUjcQltWeobbZ+H2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIr/TqJfU4iObJfpNCSE069urbnIjjxEb9dHjImS2os=;
        b=ag04EiljasJMqiFY+fP3BureQzGEsi2DUuWBkcPztSN3/btXkrwP++a+aGJ808P7iU
         OiUrp6Nb/l5QtYyXt9/N85e8ECWgGmPHldQfAqq0YaR6dXBsZ/f+LXoSWOsJhJGdV0DT
         PHUzVi8kzUF0IB0nzU60pL0tytPkBh3bnIusDoqoZ37vSaniq8f3nl6pC7kQ2qM3F85X
         5lPovgIRCkGQrUNxu23KM9Z1xNoVAybJ2gTXO4KJzpPPclYdTNgHIqdx56IZLPTFAqLL
         segN73Ss/OmtFo4sMW6JBrYyrqQIXiY+B8RryU8ea4h18BV4Z5WP+1ul3SDq26DzREp8
         YH8w==
X-Gm-Message-State: AOAM533VikpnmwDY/GlbyKzKzTI+ry169X+AubStOeGwQFnRUNe8TNZa
        PXGu7EICQkSdsk6db3223+8yldNLHcKLtx2QTLtd6g==
X-Google-Smtp-Source: ABdhPJxN//SsN9vLgNQdENQdn0eBiur3RcH266OmmaISZe06mAc204ZNbyCYwHurY2W81B+kPJo/1zhX/+9WWCMg8Ic=
X-Received: by 2002:a17:906:7d91:: with SMTP id v17mr1274556ejo.522.1606936916614;
 Wed, 02 Dec 2020 11:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-2-jagan@amarulasolutions.com> <20201202172200.GA3490@kozik-lap>
In-Reply-To: <20201202172200.GA3490@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 00:51:45 +0530
Message-ID: <CAMty3ZC_G32xe7-VrTqXY+YW=SELMxnn8+g0Ec6p4D-dh2=tdA@mail.gmail.com>
Subject: Re: [PATCH 01/10] arm64: defconfig: Enable REGULATOR_PF8X00
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 10:52 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 02, 2020 at 05:42:32PM +0530, Jagan Teki wrote:
> > Enable PF8X00 regulator driver by default as it used in
> > some of i.MX8MM hardware platforms.
>
> Could you mention names (one is enough) of platforms this could be found
> on? This would be more detailed reason why the option should be enabled.

Sure, I will update it on the next version commit message.

Jagan.

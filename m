Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FAA2CC453
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgLBRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbgLBRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:54:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EE9C0613CF;
        Wed,  2 Dec 2020 09:53:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so6113162lfr.7;
        Wed, 02 Dec 2020 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIVogR5PxYoCOXfLUIRAAkihta0ZJw5r9X0Cq2sCzpE=;
        b=T4fU/Krao60NPZATCjE8bHbLj2mX7HtdIRGzjwKEAo7OvDQYkGkBKBLL324Cec6s3a
         v5JyEI+eKnJXWF143KBRnbbuGEb+TUDhhoETabac4UMvD4mssKjOS29l7bLDtLRLkQdB
         Vxi1myq+HdhgzQWD2wS1OjU46eIWQadER1NhiJGqxA0n8JGv5506MPdfuFHpOxrLa5wA
         DXcunum2BcgHqgSLTQj90VVADxLPpUP54ewhbFd6jVATQh9uO7rIYt13tilVvzQGmA0B
         wRwG/73nNf1SPWJd9C1fFlGFYd8HHKqSxdf1BBlI659DSf//owH3ySepEHfK6o1k0ir2
         RCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIVogR5PxYoCOXfLUIRAAkihta0ZJw5r9X0Cq2sCzpE=;
        b=Z5selbBztkh7EkmBxNFSyXFlju2zAF+sgQbO3AVW10WMQKMf3Ce3OEPBDuv9LpORcx
         I17tp8LzEMkE1AXDboB/DLCDKF24CmfN1M/CExyqujX2G9TeOjLpwjHVEz7DXpoTuZCC
         hEJnhx16eJf47RhLuNnini56ZtIQgNaQfDquVDvEtZg/VxveW2s4JmwPmZ/ZIG+xSaA8
         S9qw2nGYgYwU4VGu4hBBN2WPEnVtGpcGXijV3Qfk1UFQLO9N/ny4s2cIef/x9reTmDPn
         O7sQ3oK4aQSt/u8tZziQ8aYV12d7JgEmLSqzq0hmRHdFCvxEsdqMUANn7kfzbrfemtZO
         VoZQ==
X-Gm-Message-State: AOAM532XZkwy6l4vlW94NsvxhF5RFB4OuCZbysLjAD0/GckghaCVQPJt
        r83273LxU3KWcLk+7TItHwSo1yqIWERkP49R9Qg=
X-Google-Smtp-Source: ABdhPJzyUjRv7Ahp+C8hZbnf70s4SN498Nc4X8PM2KiZho/8mfDYbCkYUemMaiK9mb2wqxZsFmDq/gnsxRPBh8+2mkg=
X-Received: by 2002:a19:8353:: with SMTP id f80mr1782487lfd.348.1606931617876;
 Wed, 02 Dec 2020 09:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-9-jagan@amarulasolutions.com> <20201202174538.GH3490@kozik-lap>
In-Reply-To: <20201202174538.GH3490@kozik-lap>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Dec 2020 14:53:26 -0300
Message-ID: <CAOMZO5CkKw4FkpoS8aE1QcKqVeSsfw3MdungnbHLs3CRAUjWpA@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 2:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> You have multiple DTSI files to only include one DTSI. I was trying to
> follow the logic here but I failed...

Agreed. It is hard to understand the purpose of so many dts files in
this patch series.

Regards,

Fabio Estevam

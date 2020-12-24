Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8082E2E27F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 16:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgLXPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 10:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgLXPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 10:36:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E071CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 07:34:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v14so1791975wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4VEx0PTvgBUKq35FAiynj8UiOdPiRFQvDTtyEBr/dk=;
        b=fBfbqdsJUHygAgaWcVFv8LVOLVsTrsZDyYcV7UGGdJNVMRYVClVsF9aF2GYFRKr652
         JxqeaDjEQFN6740aqGRR7VvfwIpED34w9FTrXl25BP3HEiTkZ1lzR+WomrmF2mONq1xg
         Sj4hK8YiB6xHXGHmYlY8BoeFr5N8rKIVDSL0hp0T9EKTICgJic+yyeDPyK8UTFr5zBFG
         fvKTsBAcGK4qeJ/EV1iv5SdFGnUWgS2Cd0/OtDYzxd6MpQquIAqDvO3zWIgo7cuUqLoc
         PYj7GVanBdByjKLrUTSKS58H+bp0+DZ2HoOUl0ckK0kSlHeRRgI5LlV3ehibWZKxYC63
         vuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4VEx0PTvgBUKq35FAiynj8UiOdPiRFQvDTtyEBr/dk=;
        b=IiFo4cZlr4WFGbuUm1xka2RtNOWejtDIK2kJz6tnj+ySQvr6ih6IkaGI6FYnNMkNkk
         1+kpYDL5Ttlx46X+BNlwLcrzqm/fYFkPxKrdkd2lvoPigeg7mKs/FaOICPA/L7BrwGw2
         9VKi/mNzBog+N8i5o6iwKz1KHCrzVMEDusP/Ip0ERNdPtAjZLjIrobbprUGWYHmq1Iqh
         bMzc+mpP/qa88yRTKInTAyXp2Yl5UUB4k/K/Nkr2n/ajopKKiCUUWbd+ZwTknNSJICrb
         Obv7pSIFDFJwqRdmqh+94vuZDgVGZhIoP+S46WWEm157f2yefwZ2TygbFxBmbWvZLUmT
         Woxw==
X-Gm-Message-State: AOAM532X33YGqvGnpc0evcHoQRXQNDaL8iDNh//h7FS7yIJKqUI1gqdR
        9b1DBLDIJuL4Vuin1wKDs0Qte4dBzJs3gqpgVoE=
X-Google-Smtp-Source: ABdhPJyFQJiaIGi1TILGI8SMRUg7V8vI3xvTRWdT3EcfxEKVlc+FCdYcJvdIY00bE0AE5HTgPPmd5w9nrTPJwfzpI4U=
X-Received: by 2002:a1c:2783:: with SMTP id n125mr4824423wmn.74.1608824091585;
 Thu, 24 Dec 2020 07:34:51 -0800 (PST)
MIME-Version: 1.0
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com> <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1608762196-29871-2-git-send-email-tharvey@gateworks.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 24 Dec 2020 10:34:40 -0500
Message-ID: <CAGngYiXSyNXjxTHBVd13NfjexzZpOZb1dayWDWO7eV19xNr5wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development Kits
To:     Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?Q?Anders_R=C3=B8nningen?= <anders@ronningen.priv.no>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim, Anders,

On Wed, Dec 23, 2020 at 5:45 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
>  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)

I noticed that you are users of the LAN743x PCIe ethernet chip.

On non-cache snooping architectures such as ARM, the receive performance of
this chip's driver is about 1/3 of what it should be. I am currently preparing a
patch set which boosts performance x3, but it's not trivial, so I am looking for
LAN743X users who could help test the patch set - especially on arm64 or x86,
architectures I have no access to.

Happy holidays,
Sven

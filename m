Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9352781D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgIYHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:41:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CEBC0613CE;
        Fri, 25 Sep 2020 00:41:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so1518063edr.3;
        Fri, 25 Sep 2020 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7//MFWVMJUmvP+PVK07HNwtudt56GCSnNlal5EEKvv4=;
        b=LC+DqmYh+9LocgEa9+Hnlu9aLgcyNxm0CBK/7ktL/gsbYmMSQEIVcF6ZuT0kVDedr4
         x0S8gBHyMTfyfOiFKT40V3a1k/NBXfwQD3ktPl5K8tiNzv2CosJlDWVHzbO5XJm6U/Ky
         +S3QR3RPJZb8oWvkZpHOWbEv7sU6D7HynabDzE/66eGmWfN4y1oG2MNzKom4vJE3Mqv7
         ebcR+b/JE2QprEcjuYoSzLehhtNOL21e/Qs7NoCMORz81JhFBOkxMl8TD6wieTa37KIt
         rDnN4B9OTux7ODoej6gvJTJ6J9qGweF0JYgfdW0ThZ/qKmJGKxdC9Xidg3VNyeZXKPDU
         eKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7//MFWVMJUmvP+PVK07HNwtudt56GCSnNlal5EEKvv4=;
        b=pLxoD8a3697Mhi1mOARVuRMvjD0VVL2hf7ppO4oeOB+aFI5YYFjbuXCOP9H1bEDDG9
         jENoUkdzETVwkmCXHJNOElpqNdlEbQ3UwjNSPANbq4w6n3wRlLw68e/eoAQA26HdC1hW
         hdYNt94cXQNPnD5sFfKI+S+XJCDtkjdiUcCUPojqJZvggXYQQHcvqE1yBLrXbhKaoFpI
         hLo4d2TMbyLkAA/1uEq9vRLpF62qejDeeBzAjxvnEo43WY7B/Wgcb1Wi8nfFIpn2gBPh
         gTjgzqazt20erMX5U23SSXi57Gtd0RoVl66LECc6ZZ88GWPH+K9idYHuZJZ5Iqt5a4AP
         EovQ==
X-Gm-Message-State: AOAM533sjxT7jRwGxEWBwRYh+g/ggeKeM1kRSWpPcQQb9wkJuna/S7eI
        bd5t1C1wC/T2Sj2dQcP9asR4uYMqNiBB9mUBBEQ=
X-Google-Smtp-Source: ABdhPJwpE+VRluRfBzyvundvooNl3OzUjHscm1P2oCXo5Ps5VEJMO95gpsqAHjdBKNw24HTb7R8Ws/sLt2XgGtrMHxU=
X-Received: by 2002:a05:6402:1356:: with SMTP id y22mr2582094edw.110.1601019684702;
 Fri, 25 Sep 2020 00:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-6-art@khadas.com>
In-Reply-To: <20200925033017.1790973-6-art@khadas.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 09:41:13 +0200
Message-ID: <CAFBinCAJ6svwiv9OM6EHz7468D9h+jW_ULiGrorgLetcODsAKQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: meson: remove reset-gpios from ethernet
 node for VIM2 meson-gxm-khadas-vim2
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Artem,

On Fri, Sep 25, 2020 at 5:31 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> 1) fix down/up ethernet interface - need remove reset-gpios for ethernet node
>
> `ifconfig eth0 down && ifconfig eth0 up` # didnt works with reset-gpios
what is the problem that you observe here?
did you investigate further why resetting the PHY changes this?

the problem I see with removing the reset-gpios is that we cannot
fully reset the PHY into a defined state
some of the registers are kept with a soft-reset

> 2) add max-speed 1Gbit
my understanding is that max-speed is needed when (in this case) the
PHY advertises a higher speed than the hardware is actually capable of
(for whatever reason)
what is the problem that you have seen when max-speed was not set?


Best regards,
Martin

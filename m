Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4FA29074D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408915AbgJPOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405115AbgJPOil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:38:41 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BAD020897;
        Fri, 16 Oct 2020 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602859120;
        bh=Dj9uWqEbqW66sbMIJGFmXibyUPobFQVl5+7gB59p9n0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hvf3aS1MbT4THmpMjl+1T3sIdNl2DWV9lzy0OQvQ4cqSOtTJiLANqI/00SxctkNLS
         6px5oPGWl5XxHnbt4InpAi++44DtdvoE2b/YNJVeQFJI1BG53hH1+WywRayu9S6bQB
         seY/8OThcC2dKhIdgrIA4bRffhX09jbw++ST3l8Q=
Received: by mail-ot1-f41.google.com with SMTP id l4so2599321ota.7;
        Fri, 16 Oct 2020 07:38:40 -0700 (PDT)
X-Gm-Message-State: AOAM533h/VcHKOwjjpihIkR6iafhjf/4hd2mg4mT8c1fEeuLsZNq+0/e
        sECcfpJG0tvIQF5dOHBg+sbQSw9J/LSKWR0/Ww==
X-Google-Smtp-Source: ABdhPJz6Bmpb+GYefONLDo54757hps1sVxCvdYy7l4YBZKUFvQQ0PRd2mAVdl5gWfI7QYLDcWRfuXbx3j4IZTce96rE=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr2889277otm.129.1602859119266;
 Fri, 16 Oct 2020 07:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
In-Reply-To: <20201015114346.15743-1-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Oct 2020 09:38:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
Message-ID: <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and its children
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 6:43 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> 'simple-mfd' usage implies there might be some kind of resource sharing
> between the parent device and its children.

It does? No! The reason behind simple-mfd was specifically because
there was no parent driver or dependency on the parent. No doubt
simple-mfd has been abused.

Rob

> By creating a device link
> with DL_FLAG_AUTOREMOVE_CONSUMER we make sure that at no point in time
> the parent device is unbound while leaving its children unaware that
> some of their resources disappeared.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

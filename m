Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FB26AE67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIOUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgIOUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:05:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B6C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:05:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so6891807ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=929GSb0jD8VArUXhfmYBsMFwZ1mStozLOcAe1ulKSRA=;
        b=Cnotiy1xwz41qBAegUiDzJAt6Hn/SdpnzDg8KiK0nPtb0LP7VV9WTQndyQJk2LCYPO
         jhWDF/vFCQFlNnQfvfijlXLmY3p1tiPae/NwnpFl6dIxroMHd92kipIiwMfXBg1+Zmcc
         2O1jEJdBiVUAgNNKGNPBnb0gLZZ3FqWDDXv+Y4cZsEv4kfsZX5H4MX48i/unEhRs6rZc
         8Kvrlp2dsxj+NDjWKu7rbrk2u/Mtd3oPseqpLW+jlIIptp8JlQdm9pj842duMe77HlvL
         t2H6Y6w8xP/gArO7pKVrm6G0Ud64EhZcC4NkyA68/Xc9GOrExMD3BeXvG4Joz7cQ0dsi
         hc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=929GSb0jD8VArUXhfmYBsMFwZ1mStozLOcAe1ulKSRA=;
        b=aY5zQf2/vTFvbUAq+/JuTYAi8ikNgUsNIBOfaLQhmu5cW0/qA2VVcVkqPDn1qMXV+c
         NJqfGGMGcq/XtosCwxbcJkKjADU8Du6MDwFgRbbJwhGy6/uzV9pVTq7xwEPjuNP7Pft8
         Z4+7mYKnQKa9Fi6Bgg0ovqSrrYdIbjHiD/ghbxeOTk85KIP4GKK3HaXyAHfybuKUQ/T0
         bxiKpn2KXazvXanOu59MHxN14+O5u6McbKx8A6SFhyeal5EaIyo6l8KTrmno6s4UABj0
         9HsixuHYdUXI+QIUkPiYHZincYLmSGw9QpOarZNxw/+s4rRNzkwE53FxL6R6rOR6N99T
         FpQQ==
X-Gm-Message-State: AOAM5330HquG8cWZWYXBolWP95i3DVkGNzzfuTjl6FfiyYfyM5LnbtTL
        FLtkODI9TSBQMgTfvhVyQSsq2PWfbJG/BMwrjYk=
X-Google-Smtp-Source: ABdhPJyUqReON7GONBckbkkGKGZUOL4jUSZNjbi9MDzz1vg1tQm8PhqyWWXULUNsdNzDSnCGbg1/ooa3UWIpA9W8Q4s=
X-Received: by 2002:a17:906:4902:: with SMTP id b2mr21441225ejq.208.1600200345705;
 Tue, 15 Sep 2020 13:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200909160409.8678-1-narmstrong@baylibre.com> <20200909160409.8678-6-narmstrong@baylibre.com>
In-Reply-To: <20200909160409.8678-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 22:05:34 +0200
Message-ID: <CAFBinCDH8sAqvaDJ=0iZ86fw30Y7Xos0vaRw6v8ECADqeJNn7Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson-axg-s400: enable USB OTG
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Sep 9, 2020 at 6:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +&usb {
> +       status = "okay";
> +       dr_mode = "otg";
> +       vbus-supply = <&usb_pwr>;
> +};
> +
> +&usb2_phy1 {
> +       phy-supply = <&vcc_5v>;
out of curiosity: why do we need this phy-supply here?
isn't the usb_pwr regulator as vbus-supply above enough?


Best regards,
Martin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559A125C538
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgICPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgICPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:25:17 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39631208FE;
        Thu,  3 Sep 2020 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599146717;
        bh=f3U7ASbVqHoINyjVgQ54NfsvbWfunAHGWhDtFw6uEcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c063w8imevxLfowa1GOqJNf4nwV4prVK9zMHqAhuaZs3iExgbuAWY65/snmP4ySuj
         F+LfwU0aEpMs5MMhj1I2wJ7kEOvYN6xAmfEFk6/anfkxjQPyXTLt2QDEK+DWnKq8Oq
         Vm0mPfUe7Y/CbzzEAzm6Kl+3SOT3RKConrbUTmEQ=
Received: by mail-ot1-f50.google.com with SMTP id y5so3068254otg.5;
        Thu, 03 Sep 2020 08:25:17 -0700 (PDT)
X-Gm-Message-State: AOAM5316nEBuKPPIZdt7lB5IUOIFQ/XFxjbN3kGqjjvBc2aX2Kh/LQSh
        6xx5+zY204jHXpiZ/IZiEj+3WkfsOxX7M5uxqg==
X-Google-Smtp-Source: ABdhPJzXjy+69tf3xQkfYZ4SALE7mZxLKgQkVsN+qODC/aOmNuTSKjaYiWjkWkla+tgVnuSeEGz3EWI0pYzILh4sYW4=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr2025135otp.129.1599146716464;
 Thu, 03 Sep 2020 08:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200830084021.18572-1-krzk@kernel.org>
In-Reply-To: <20200830084021.18572-1-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Sep 2020 09:25:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com>
Message-ID: <CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: Use unevaluatedProperties
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:40 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Additional properties or nodes actually might appear (e.g. operating
> points table) so use unevaluatedProperties to fix dtbs_check warnings
> like:
>
>   arch/arm/boot/dts/exynos4210-i9100.dt.yaml: gpu@13000000:
>     'opp_table' does not match any of the regexes: 'pinctrl-[0-9]+'

When unevaluatedProperties support is actually implemented (there's a
prototype), this will still be a warning. You need to document any
additional properties/nodes.

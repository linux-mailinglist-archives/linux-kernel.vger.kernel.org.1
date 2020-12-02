Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833832CC155
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgLBPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgLBPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:51:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:50:57 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so4540416wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:message-id:date
         :mime-version;
        bh=RcBu922o3tVfyKdxDqhV9UdiHRuQsNmPY+MJCHp8CME=;
        b=zwaeYdccAYw13BmDlDmIMQlp3V5gQjWiEy5VGIZcFy//rbw4zSPXfmVDW0OZYrTeZU
         ShSnbyXslsbm5piPRTfE465wFxkZ8iwlEMwuQPTuXnYZdDzknC6Ksy2dk8PFdJM4hFN1
         NGtROkkRajRrOHLBJsEGC/3CA3p1T5+cmDCOYKPzEqaNma2U+1y+gt/yVv4DhGieiBp/
         fhOA9+JPwmcHw7UBB51VYUzhiUXZfHEUWJ+IO7YPEcfKTZCDqY19nygHzUgs0L02RheX
         Spe4674ENOdTBcvsqIrLsi9okBQwE0mH3XIbLnOVyxjS0h9Rc43UzKkRUbPfKiAV5HTy
         CO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:message-id:date:mime-version;
        bh=RcBu922o3tVfyKdxDqhV9UdiHRuQsNmPY+MJCHp8CME=;
        b=ZTFffKyFdEhZYg1VMW5H6O7KvyO39637+78vqWZiWXTG+IEDyweGfj51BDqm88sRiV
         yC+mXly9eYD0rPbdQpMDVkqM6SZFvup+6gOUGyrHgcH4mGQl3YZonMo7B6DwRvW9x47q
         tJtfbVESqU8Kt4UVVdStXm+33a2SnDUpAeiJM4Iw1gMuV/Kt7TggQgyq/fIqVAd8ISvk
         PdRHTKYzJZUUGpovkoNmDQfaD+yjcRXMqlaSYxLbEhxBANi2YvHmnpktgFiYFRs6KJJw
         ApEdyBJ6NEa4rsowcbTficZ2CQURE6wtZWtj41r6dWKCmsA3dz5DTIDeJB542fO/LPcs
         Pfog==
X-Gm-Message-State: AOAM5335t28DXqi3fLeoUJ0ihoz752mxzq+MN4ccYNHAJ2nuS42BUJlc
        aJcoI+Ggi+qm7T942pcDlYbOZQ==
X-Google-Smtp-Source: ABdhPJzT4JpcLXQ7BXUtHnOTWmGyrjUJjn3zD+bcX4wh7YDQSdAAMxZscMCQU7d6nB3SoGCefWAcpg==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr4267671wrn.171.1606924256465;
        Wed, 02 Dec 2020 07:50:56 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id u66sm2557125wmg.2.2020.12.02.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:50:55 -0800 (PST)
References: <20201116062031.11233-1-christianshewitt@gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] arm64: dts: meson: add more GX soundcards
In-reply-to: <20201116062031.11233-1-christianshewitt@gmail.com>
Message-ID: <1jh7p4p5pe.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 02 Dec 2020 16:50:53 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 16 Nov 2020 at 07:20, Christian Hewitt <christianshewitt@gmail.com> wrote:

> This series adds basic support for LPCM audio over HDMI and S/PDIF
> to GXBB/GXL/GXM devices that I own and have tested with. Audio can
> be extended in the future (some devices have DACs and headphone
> hardware to connect) but this gets the basics working.
>
> Changes from v2
> - Drop p200/p201/p212-s905x/vega-s95 changes
> - Add khadas-vim(1)
>
> Changes from v1
> - Drop nexbox-a1 and rbox-pro 
>
> Christian Hewitt (7):
>   arm64: dts: meson: add audio playback to a95x
>   arm64: dts: meson: add audio playback to khadas-vim
>   arm64: dts: meson: add audio playback to khadas-vim2
>   arm64: dts: meson: add audio playback to nanopi-k2
>   arm64: dts: meson: add audio playback to odroid-c2
>   arm64: dts: meson: add audio playback to wetek-hub
>   arm64: dts: meson: add audio playback to wetek-play2
>
>  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++++
>  .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++++
>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++++
>  .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 +++++++++++++++++++
>  .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 43 ++++++++++++-
>  .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 ++++++++++++-
>  7 files changed, 303 insertions(+), 5 deletions(-)

Minor comment on patch 3
Minus that:

Acked-by: Jerome Brunet <jbrunet@baylibre.com>


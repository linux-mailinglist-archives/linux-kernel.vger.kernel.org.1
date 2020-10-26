Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8C298EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780798AbgJZN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:56:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51976 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780756AbgJZN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:56:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id v5so11750324wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HgyBh+16fLRmJC5zM1itgabVQdxvIj/AWtqWUQEP6yc=;
        b=Khw6HtXiUbQUTT15ZKtC1tSHL3G0pWYJkDmyqU4U9ImTpofZ96CxkjCjZ9pg8LVRRM
         CXTTsNBHXMJo78LPCvCk6A+aSvBjPwytrmKcGGtDr75MUjLL4LIagO/lam1xV4wHMLIY
         9r6xFeE65639FT8qnuT+eZs018NUkgAA9xmkkAIKpN4LBTswNYKjvsNsEAC+lyLHJpy3
         gvxB22Jl4If0+HRow+pNI+MWIWzl9PUiloLBwEKeb+66jlRkAWg5LKwNnKv2qwihc32n
         7BQna0hcFMIRKn6JexOMZAqGcD5D3+p6uHCgFsVceeNvj5TzGk0HCFXFAQb8VfK1LKEn
         I/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HgyBh+16fLRmJC5zM1itgabVQdxvIj/AWtqWUQEP6yc=;
        b=PVOhQHMdOb59PcL1oR7suNScTt320uWt44ORYZeaUpgKod5nd98h3RRJKsZwtN1ewV
         0PGyx3KHD9u6QUJrCM+avbWzZn2WYt2o05UEOkJ7lC8Ba8v1TQDd9vOnPzi+fgACD0TH
         TBCCd7AQraxCtBWAxhCjDVzs5AUbVhT84QV2R8zgtkQsvi8o4b2w0IpZTnUDSYAXY/Gp
         1OEAVCb5nUIdKprQPPhXs46YPACl6lxw0Lfv9yH2xfMA/CFGtIdLgltAugaJUzxoGDJV
         WvjtRBdiTr63dvZVZs6KXwAHoe96zMGUK94ZvqT20esVG2Z8DZPX0OoYVn3OGRXxRxdB
         6vBw==
X-Gm-Message-State: AOAM532QqrC+rbQ63g9uCvfnmD23dTe88ENcO/itzrJgZj48ucCuKuFz
        BX7gsvvBTxD8Oyb7TqjZ3UCtzw==
X-Google-Smtp-Source: ABdhPJwhFRSy34ieLn1DstuSvVzZsmJTDrXtazaPwKq5GkCIxrsVvZ2CQeyoqavPfCy8A+wgZ4FTcQ==
X-Received: by 2002:a1c:7214:: with SMTP id n20mr16444207wmc.93.1603720600298;
        Mon, 26 Oct 2020 06:56:40 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id u195sm23028274wmu.18.2020.10.26.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:56:39 -0700 (PDT)
References: <20200915124553.8056-1-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] clk: meson: axg: add clocks for MIPI-DSI support
In-reply-to: <20200915124553.8056-1-narmstrong@baylibre.com>
Date:   Mon, 26 Oct 2020 14:56:39 +0100
Message-ID: <1jeelljdk8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 Sep 2020 at 14:45, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This adds the VPU & VAPB clocks along the MIPI DSI Host clock.
>
> The clock scheme is based on the GXBB & G12A VPU clocks, with a different CTS
> clock output used for MIPI-DSI.
>
> Changes since v1 at [1]:
> - update patch 3 commit message to reflect drm driver state
> - added comments in patch 3 for clock specificities
> - removed useless parents comments in patch 2
> - fixed bad flags in patch 4
> - removed holes in axg_vdin_meas_parent_data in patch 4
>
> [1] https://lkml.kernel.org/r/20200907093810.6585-1-narmstrong@baylibre.com
>
> Neil Armstrong (4):
>   dt-bindings: clk: axg-clkc: add Video Clocks
>   dt-bindings: clk: axg-clkc: add MIPI DSI Host clock binding
>   clk: meson: axg: add Video Clocks
>   clk: meson: axg: add MIPI DSI Host clock

Applied for v5.11 fixing 75 char per line patches 3 & 4 commit descriptions

>
>  drivers/clk/meson/axg.c              | 819 +++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h              |  23 +-
>  include/dt-bindings/clock/axg-clkc.h |  25 +
>  3 files changed, 866 insertions(+), 1 deletion(-)


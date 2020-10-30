Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74A2A0FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgJ3U7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgJ3U7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:59:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F0EC0613CF;
        Fri, 30 Oct 2020 13:59:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dk16so9830976ejb.12;
        Fri, 30 Oct 2020 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3WkoFBU74q2UUkntKKl2jUcW+YT3JWi72RY5sPwOfk=;
        b=vesqpwoVaNunwsRNYlewpH7leCs8rK5Ez+sifuWXtWFpLMB1bhb0y33nDMgYvwByw3
         tohjzgZ/ttG3vlbRT3y7ZJa+WYJ3ASCgH9VHXLHhX+FIpqlEH6rGnUyQnja+k1c/nxZk
         SLz4bWfb7lwECVgzXLuPxET1rNSJeudHd5mBOCFsRULvJOViO9/dKHLp/9oJrS9iJPyT
         qJ/wHQl7TA1n0jHpQr6bx91XwsO0AvQ66YnQeurV0oLG7b4zl3xEOttK/VK6w/GxeCQU
         HC8iVDJdVa8xV4JGvM1SeTOAInlCEwS/LsnMI4jxcaco7bGqbpcB5bQ4pPjx5aK6DFT9
         3fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3WkoFBU74q2UUkntKKl2jUcW+YT3JWi72RY5sPwOfk=;
        b=qqp8+puUBL4OywMMn9W8R4CcrqLYMTrd+Go6pHd8zyD2G/loMAfzW91pWaSJwwRNJ+
         ydNQa3dFv3gKMJBLi1rmYCHPlDSI6WgTZDBYP5DJNc5hEdVYQsBWYZoa8o4Aff8X0cYS
         oqpz4Xosox42YmJb01Uxi4vMzu+0IPtbCosQqJzuPVzv4NFwGiNZsz3qpZ1qIzAUPchd
         LjfTLquiQGewGDg2E3C5CKnblLxXjs1hWLDWEUrla/7gEXm+zh5xdS7gyJAB7nNQc8FS
         kdqJJO8z/Qxi5BTu3GBbK8w8PfpIbGVKFzYk3oQ84da/wOJui2OIkepzNyLQvfQKLZLb
         WxLA==
X-Gm-Message-State: AOAM531rk8gA768vAAUl2Dcv/RnIAYNhdZI1cZ8Qm0L9cioiiWz9HMvo
        9dIfUqI9oWz0fnt5YUgxjvg=
X-Google-Smtp-Source: ABdhPJxnmacl+QU6UAVfnglw7U9K7nUmqKXuVD/IqcAM7LsfWaAjX4Ia4WbMBk84ZIpYZC9Qp37Uxg==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25mr4478407eji.520.1604091585688;
        Fri, 30 Oct 2020 13:59:45 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe1-5-97.cable.triera.net. [213.161.5.97])
        by smtp.gmail.com with ESMTPSA id bn2sm3376596ejb.48.2020.10.30.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 13:59:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        monnier@iro.umontreal.ca
Subject: Re: [linux-sunxi] Re: [PATCH v10 00/15] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Fri, 30 Oct 2020 21:59:43 +0100
Message-ID: <1619332.Na9eyGIdAE@jernej-laptop>
In-Reply-To: <jwv361va1g9.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <20201030144648.397824-1-peron.clem@gmail.com> <160408688151.11950.1284919768798155829.b4-ty@kernel.org> <jwv361va1g9.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 30. oktober 2020 ob 21:50:43 CET je Stefan Monnier napisal(a):
> >> This series add H6 I2S support and the I2S node missing to support
> >> HDMI audio in different Allwinner SoC.
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> >    for-next
> 
> Yay!

Note that this doesn't bring HDMI audio card just yet. Another driver will be 
needed for that.

> 
> Now, I wonder: will that make it easier to add support for HDMI-Audio for
> the A10/A20?

No, A10/A20 HDMI audio uses completely different interface.

> 
> (there was a patch for that submitted earlier this year by Stefan
> Mavrodiev <stefan@olimex.com>, but it seems there hasn't been any
> progress on it since then (I think the last message on it concluded that
> it should be rewritten to use ALSA instead of ASoC)).

IIUC original author left Olimex, so work stalled.

Best regards,
Jernej

> 
> [ To clarify, don't know what's the difference between ALSA and ASoC;
>   I'm only interested here as an owner of an A20 box on which I'd
>   love to be able to use the HDMI-Audio.  ]
> 
> 
> -- Stefan





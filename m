Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7952706F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIRUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:23:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED4C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:23:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x123so4148474pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0WzdzmvXqBL6C78B+KfrEF7AYTF4BXuovwhhy80AIc=;
        b=wxLFywGKKhY1DXT0vLBHQ5770kVzTJAE75BSj5s7gyB1wAHZ3AA6RSEUiVYOmkyKU8
         oDUoMr41cxzYTeg7tArApWIRPcyV0N4mElb0vGGIEwESdhS0v220oFmi57Pq0L8nONPE
         JOf3sRO/CDsbTWAGFPrDtza9Evghcgt9bl0oD9jNqk1ZKgvzqXdm+LiBe1di/2XsnDUp
         7D7gKoaamFTDeGDtrQYtn+K3m6zAfPziUfY3UApw1m3SNLLuM76Fh8iojfevryo86k2D
         zrFwgmNAJrvElTOtUgHgIZCV8HipXdqRLmVL3WixFifYNE9AzQwYOYAxPeNU9k3ydpQf
         OtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0WzdzmvXqBL6C78B+KfrEF7AYTF4BXuovwhhy80AIc=;
        b=MMHZwJH5/DCCF5gHvT84rSLY3LPjir4q3b+IlapgwpyGmlt3GqIH7fVigWw1pWWnau
         wtP2lQ7iePVPHFg5KJojQGfW413TKVGB5PhV+vOM58TNsRmG9C9OYN+ZyPUKsbxER/7y
         h2Qht3G9GvNLZhdSHSQbSW/0u70m6rcCChC0j0rlxne0fc4VjSdTnoT7ZzrGN4i/akqT
         lslJNGZAY+jsbqIg3l6f1okv5VmpE+ZCq3mN++p0HRwuTYnPo4IfR61j4/13CrJI8o+n
         g0LTQL/Xna5XcGajW6I9Dl3/aONbvqOtZ8lDeNVdfO/PL3EL2Som2xA4vcBf+1HZWgSo
         K/Nw==
X-Gm-Message-State: AOAM533gTIdW4k1ptulMoZOPWNGq7uYa3KLk5O649pI80rMftrsSDsGq
        6EkZ6tMlRGqhCtnj4wOLoOb5Gg==
X-Google-Smtp-Source: ABdhPJzF4bHwe4qeJ4MffdzGNuPNPMggDeTVQlEXQR1Xvp4iBoIFzuNV1j2NbGmzZ/0cvzqzflbEUw==
X-Received: by 2002:a63:4656:: with SMTP id v22mr11946668pgk.116.1600460634155;
        Fri, 18 Sep 2020 13:23:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i1sm4208050pfk.21.2020.09.18.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:23:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: vim3l: remove sound card definition
Date:   Fri, 18 Sep 2020 13:23:52 -0700
Message-Id: <160046062721.27609.4386781014145624881.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200828154435.419561-1-jbrunet@baylibre.com>
References: <20200828154435.419561-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 17:44:35 +0200, Jerome Brunet wrote:
> The sound card definition should have been removed when the common
> definition was added to the vim3 dtsi but this slips through.
> Remove it now.

Applied, thanks!

[1/1] arm64: dts: meson: vim3l: remove sound card definition
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

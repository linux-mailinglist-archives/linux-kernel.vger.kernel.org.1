Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22C2706F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIRUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRUX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:23:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B87C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:23:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so3771803pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPkEsOcLuz9gTEj7lkyB7Qd0fwR9xFacocdc2fUFPK0=;
        b=g1vDEt7aNAgGkbwo8Rc35OXS9mqga9dx5J+RRHirmUm4gv+j7+2th3LAgY9eB+9wLn
         zLgwBamDT+tNVqOOGP+PSNGWHG0zoSRyw/cDdrEfO9gGImRRfkWa92kekdsqop6ir94H
         wkGmrGcIdsuSVxNvBLSZw1G7+ubyw3e6a+amOqsgV/T4kRQYwZLxFe96XBNeNXZ4gatq
         ThF/LKTTr97EmHiRx4ZTmu69PlOgBt+aMNtB6EgngCdlIyDruW8IT1rBt/ymM2InT8Cl
         WJmyEqwC1Bv38QVBtyH7ppyhlW9qIJ7z+WlzMujbVt+yvlg5rL4PZELgGiaKAPPKR3u1
         vhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPkEsOcLuz9gTEj7lkyB7Qd0fwR9xFacocdc2fUFPK0=;
        b=Cs5wVsRW99CindXz2byV27e9DH7pqy4cVeZWLyIVw7+rlSyni3dzcBUQejge1VuCyH
         TxqxUNodmjeRMqFl5KW7Ei4xQk+ll910MisNhnbl2UoIaKAhqCr3kBqcy6hdPsVdNIFF
         bC4TrqR/3cbP/IhYKj3yANGaqSi0j4a6Jd7joSmkPvej3iB6qt1qWTeR/qrKRbyUO5OY
         ovsVKhJCGm0W3oye7JBs/4ySrWG8Zd7XyJ1jdXKpvAP3MLG8utggfRyuQZN99JXrDQ0j
         YI3wU8jVntslh7PB4TpJLWhEA1bOKpUTfVd+poE4d5PgeSWeq4KrbeXty6g3NFwQkJgc
         TbmA==
X-Gm-Message-State: AOAM533MaWbV1wfPojt+EZlnOPjRV0kjkK0XYtuqpYBwmmKxOv9C2rVw
        EK4PbENQ5EKf24Oo3YggP3PLhw==
X-Google-Smtp-Source: ABdhPJwqUWUPI8LBuv/ru8S5RZsK+t1ITdDxhQ3831rllcMpbX1PU9dVn2qCx+BK1dgdiIwHeopSKQ==
X-Received: by 2002:a17:90a:d512:: with SMTP id t18mr13917899pju.106.1600460635445;
        Fri, 18 Sep 2020 13:23:55 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k24sm4213011pfg.148.2020.09.18.13.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:23:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/2] soc: amlogic: add support for the Meson AXG Power Controller
Date:   Fri, 18 Sep 2020 13:23:53 -0700
Message-Id: <160046062721.27609.17071791777862350491.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917064702.1459-1-narmstrong@baylibre.com>
References: <20200917064702.1459-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 08:47:00 +0200, Neil Armstrong wrote:
> This adds the bindings and support for the Power Controller found in the
> Amlogic AXG SoCs.
> 
> The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
> but with less VPU memory domains to enable and a supplementary Audio
> memory power domain.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: amlogic, meson-ee-pwrc: add Amlogic AXG power controller bindings
      commit: 97de44c5ecd413d3da3d4ace74272a1ad6a409ca
[2/2] soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs
      commit: 525054782a74d28503c3f585e00d9860d67d7ad1

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

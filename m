Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE151294561
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 01:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439276AbgJTXOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 19:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392392AbgJTXOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 19:14:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735BC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:14:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b26so330883pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFfpH0InGRM8MvpZTbASmzGof5hPRvFFHjnrwDY+rdw=;
        b=ZboeJElxDX6dLFmLilvQG7EbuCwQdu8U2oYHQ33WgX8II2smq0C57POZYN9BM4k/Ex
         /XljvDv+J1fLMskvhoTWi1Vda9uo8cs9rVDE2pjGqmK5Np8cF8nXQ0bqx6hVAu8hUnRz
         7zqiRPXcJ/i8vJPaQBgMLLek61DBOJlLHgImf9Yb23KBa4OJkqr/z9Hu8A7TlVIHIcxE
         3F7UnecM6cYf3pdIzJfgsDIBSEgDSlDMx+o9R9Ko/5+EFzG6KVnqnz8ZU7SgcF8mi/AG
         i9yq9BUeJZT2cYFpZbRThQz5Ynl6d6aDuKeTms/LopCA1pUze87kijb0a0jtMrnqgahl
         0iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFfpH0InGRM8MvpZTbASmzGof5hPRvFFHjnrwDY+rdw=;
        b=NGo8G8LpWF43pnn3jBSfYFe11iJtvXJEY5rm4Xus2svNCDvfNG1UB9Xn8fq0OC9hJA
         Xshx0e8ECfYM1BLPirUbz/aLAzrr7Jp7TRsDTqBbD/z/lIclaYk4pBlfRrmmDbO6HMK+
         maEOduYh+2RIwzou32tCgEN4/+K9NqlxakmXoDopMhGwoOUutbgRgrqgELeBsGkCEdLN
         QTPhfS3XYZ+DTutRCyXM1Ur0qZP11uogGqws9ohoY0cKjxwawDrDyC2yyjEA7XL/++9L
         zq9i+MzeyLCUziGtwsOLPWmH0xcSTqOSFPAxwP0jOYVTS7k+CIMcPUp2xzW9P8hmTMKF
         yGKw==
X-Gm-Message-State: AOAM533cvoTj8/OKbUvkbMQQmopsppjoGiBTk0ZjSjJeibKaDZXO88za
        zwIJSDojzam9YUGHhujR4sKsCbsvXVeC6ezZ
X-Google-Smtp-Source: ABdhPJyqjnd3QXal7AHEsNxZ8SPBaMGxoLELYgl1NWJHEaMCtzJqhHsNEva2dpyBmedACi6FlHgi8Q==
X-Received: by 2002:a62:3815:0:b029:152:80d4:2a6f with SMTP id f21-20020a6238150000b029015280d42a6fmr296770pfa.72.1603235644320;
        Tue, 20 Oct 2020 16:14:04 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z3sm195910pgl.73.2020.10.20.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 16:14:03 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: amlogic: add missing ethernet reset ID
Date:   Tue, 20 Oct 2020 16:14:01 -0700
Message-Id: <160323562909.7110.10553344711717844813.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020120141.298240-1-jbrunet@baylibre.com>
References: <20201020120141.298240-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 14:01:41 +0200, Jerome Brunet wrote:
> Add reset external reset of the ethernet mac controller

Applied, thanks!

[1/1] arm64: dts: amlogic: add missing ethernet reset ID
      commit: f3362f0c18174a1f334a419ab7d567a36bd1b3f3

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719AA2AC940
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgKIXXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:23:42 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:23:42 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so7019939pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSI6Hxh+VGHB4fhlPl5YbxM+ykFtkRO9Um5a1XP/b8k=;
        b=YUqFSFaoqWcW7XjBcNuHScwn+EC4flNhnYXz8URi1t85iGaWAZkbWknRMhOwyuVK9x
         F1n/7KXocrwJBUjodDuZxMOcZTbhilJUlKJ6iBMXq3BZvxS1wUMxOUCQUDP/7NIQfrUY
         9nV7VMU1OTKBtz2uG/Qz4PRLo0wxd+YTnEsEUp4ObHjYqDfqZAcEqVu0A0zt2Ury+d/9
         mLw47nmrosV3MnFxpuQ+uN1Ot2KpWRFQ2cAF2hrbgAyeNmLp1s1TcojIevfo9g4BvI9S
         xgTIMVvHiyQCu6PQGjdfdD7ypawJQMcW5Xc3lhwxalWTUkulzvxItImsiXeb5AEhuaRi
         G8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSI6Hxh+VGHB4fhlPl5YbxM+ykFtkRO9Um5a1XP/b8k=;
        b=JPrTPOj3sNpKco5u5JdEX3UGbSe5mqdvOLxDIYLVN1Ca9z1A8IMjHnPbM9fsfGVecO
         ui6HNWZ1/r5DKfbuOIFIpGoNXnKf1hOBBepiZi7JJ3H2MnxXFgAuJyqOlD/j0jAO0lUh
         RRLeJ6Wv86uKV8GPbLJ8gZ42Zn4aQPyU0gH7Mw0S3G/dUnXNOfCPEWG9CSxzck6X3IWh
         k633Nb7UdyHTaw39oHM0LyOtKhkjAiwhYp7OTw92rmmjhJ2dUChsn+Z9Y7YXP/l7ZMGu
         qn8HMj9TF8KVy9GD06nZs/B6x89ztjR6Vx7bjynMw6IFrPP7BDD0m+85QKDXO5buK6p8
         o9YQ==
X-Gm-Message-State: AOAM531mdj1HiMTybikYcye7TJNKn7d39x42cxsiaMYFxvrZ3LM6huwO
        V1W1NsCL8fZLD+85JopkqfYezA==
X-Google-Smtp-Source: ABdhPJwHmgicboxydybrqq+qVuzqbGMjM2UgCfdmY1g7veBRUUzzMpiV4ifMhY7XmcNco3ZD05ORmw==
X-Received: by 2002:a17:90a:a58e:: with SMTP id b14mr1558289pjq.203.1604964221546;
        Mon, 09 Nov 2020 15:23:41 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j19sm9886398pfd.189.2020.11.09.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 15:23:40 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: meson: ship only the necessary clock controllers
Date:   Mon,  9 Nov 2020 15:23:40 -0800
Message-Id: <160496421227.17768.3544175809651783421.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020075034.172825-1-jbrunet@baylibre.com>
References: <20201020075034.172825-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 09:50:34 +0200, Jerome Brunet wrote:
> There now the menu entries for the amlogic clock controllers.
> Do not select these when ARM64 is enabled so it possible to ship only the
> required.

Applied, thanks!

[1/1] arm64: meson: ship only the necessary clock controllers
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

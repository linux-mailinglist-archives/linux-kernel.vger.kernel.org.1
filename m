Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89AF3039DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbhAZKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbhAYTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:03:59 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m187so362469wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yI3OnceRYBWa4a+K3i7OmylV139r64Y53sM6tFF1pc=;
        b=vGPLomzK/0mzzIgD2mdfLDVzPGe2eqqBUu+lzY6wB3us4Vqpsn5XRQrxFMjhPPuo80
         ocCH/NDfSBUipg+dJnMgNUQlj+I/4oGhlV/hiZ5dj99C2KZZPxcouDMUT+FrTdOEuJKz
         dUIuftnunxMPaDS3yk9vvg5qOopffR4atu6jWk+WArM9V+sLeprZHUcJYHDHsEn72zBh
         664n6OrlWWYRW4YfFbIK+ZkhzM9SsHYmTK5RYoFqL/amz3h86wRKFX9TiEoqfmKSJoWH
         5hH5IA36fh2Kg3VKLaUccpbOBe/YnUL7Qi/NehOuFVbcdoaUqZBT7GBJODVToo69n2CL
         an0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yI3OnceRYBWa4a+K3i7OmylV139r64Y53sM6tFF1pc=;
        b=OY/efjsR7kOkPBb2ROBZvtHiquVdqERnenz3Adt1UP4j7AjAFJroms69SzalZSV+29
         XYlWJoh3iNoQUAumNp/3dJmpyqQfAUqXIo2u7e6Nh4edW2LVNNGimxo62pPDV/zmdFdD
         +dE6sk8oZTDSQwMC0hWrDNqKQ8jip//v4vKcFkx28voSTljC00G7rdsYqN2/EeT4IVgJ
         BU4pnE36WGE205veXUVqzyJZ05aKm3NGE0TTCmbV9Ro1UZhvdXRcBXW6nDccLMqmhT6o
         GAjVP3ToWolym4hJZl4c/cvNX6SJ7N25JSjTUo8HrFhBu4psDrFAhnXwKrLApmyeQ5mM
         5FVw==
X-Gm-Message-State: AOAM533pyE8J3kOeJvw5YaiYAiIVPTbXaw2T8wH2m2rk+pIMvRq18OoJ
        oN4Akf5L6e1/x6YyUAck3HWNZQ==
X-Google-Smtp-Source: ABdhPJxjWbtW3OMST1Kzg22DiL3G59g/5zMAsCooQ5nTJujTBchIiKDJXqs8JXFFGfzOqv/M59F11g==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr1416552wmb.123.1611601393695;
        Mon, 25 Jan 2021 11:03:13 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:13 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: second batch of fixes and improvements
Date:   Mon, 25 Jan 2021 20:02:42 +0100
Message-Id: <20210125190248.49338-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here's batch 2/3.

Thanks,
Paolo

Paolo Valente (6):
  block, bfq: replace mechanism for evaluating I/O intensity
  block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
  block, bfq: fix switch back from soft-rt weitgh-raising
  block, bfq: save also weight-raised service on queue merging
  block, bfq: save also injection state on queue merging
  block, bfq: make waker-queue detection more robust

 block/bfq-iosched.c | 328 ++++++++++++++++++++++++++------------------
 block/bfq-iosched.h |  29 ++--
 2 files changed, 214 insertions(+), 143 deletions(-)

--
2.20.1

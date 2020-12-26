Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F752E2F31
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLZViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:38:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC28C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:42 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id n9so6456988ili.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwrBklnpFrL91S6j28ouuHbOiPE4otk/2BurGfWgjtg=;
        b=o0OdlNJf9xnd/Eajm4lzE2BKLNJC9CiHQUyTOC7DjGLC+MQIcHsum2lsX+IC7VfjMc
         s0wKqnuN7cvTl63rMXnQ/wPQ2d6hcRHPJIFd6TX42UTwoOrpS+qBeEmpFyC1lAG2U/0u
         UQnIQxu627aioPvOxhvfUJjtP3wXCzUcUlcjpHamSFv0AEwppehHuUx3SGxL6my69vRe
         AoQL3KVOPhPLh0WWaDi47XLjeGd6GzL6NI5JXaMCZsO36q6cQSTkhDvOXQaV7ybHhRY4
         hY2CgseBf8kkrMK4dcXy9hxNPhiyMXPHVmczQRHEiJ+DCZl6mUbSQ8NpoIVNaINQ1mgm
         9ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwrBklnpFrL91S6j28ouuHbOiPE4otk/2BurGfWgjtg=;
        b=dlSTS49iNRxLFBmZkx2/xslBiuJB2kIuQ9XO6OpJJ4fhQqPkh693HxM8+7I0erteFI
         qERaekYwqB1JAFWMV/FzBOQ0ixNTtzdBeKYXB7QT5TFT7CJUGhYhGG2IRaGzOh/Yeaji
         9DTxpqOPaOE6bP6xHWZ66QOZJGi84udsH/AV9od1epP5u4Wbd0+CHoCmg/B6459xJrY9
         HvNZzlMrr6LgtZytKkM8qbGmKKzCUsQ+OKJ8yWtw8ec5sr3EYB5z6nDkY4U6L61QJICL
         dAeHxTOqnLqVV8NXQxIPY0mtzZGbibAfJy6uhp76BusI8sqDJkPGYyEymcXNBuvzE1/A
         //eA==
X-Gm-Message-State: AOAM5331/a7k2wHoPIoT8sOUO4Ny7xlcaZSsz89OirtOlybfJ6cb1BiQ
        AU3V4GB32jwLL7kAveCSmTj6PA==
X-Google-Smtp-Source: ABdhPJzZ+l2Sckv3oIUGmpFbKZcO9FJlXU2aOjd7ktzXiAAsC4QBNEDHffNrYLpTtWm3xg4szzrtpQ==
X-Received: by 2002:a92:dc03:: with SMTP id t3mr39190018iln.215.1609018661440;
        Sat, 26 Dec 2020 13:37:41 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u8sm30582763iom.22.2020.12.26.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 13:37:40 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ipa: fix some new build warnings
Date:   Sat, 26 Dec 2020 15:37:35 -0600
Message-Id: <20201226213737.338928-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a super friendly message from the Intel kernel test robot that
pointed out that two patches I posted last week caused new build
warnings.  I already had these problems fixed in my own tree but
the fix was not included in what I sent out last week.

I regret the error.

					-Alex

Alex Elder (2):
  net: ipa: don't return a value from gsi_channel_command()
  net: ipa: don't return a value from evt_ring_command()

 drivers/net/ipa/gsi.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

-- 
2.27.0


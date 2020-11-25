Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF652C4940
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgKYUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgKYUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:45:31 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEFAC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:45:30 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n129so3466687iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iARHdXB4BjlKr8lKVPpRSW/v+HxRAjAiiqqGZKt4F6k=;
        b=b9a6D6l42YwbuuSMR4N6CLITYQo9x+GiWOsttkkklpezEAC7KU021iJPNtvRFqWoGU
         K6s+Ogfjf7bdvG1X0TGZ116EQWNkNPrJ4anG/b9abF4npbzgJNZogjT1JhPIriiGlsc7
         4xPF47Z8gqta3JWI9C8QdLOFwok/I/ImqibVvEfDc20OLJPN4O8CDcItkvWmO14PuY7b
         WgV0qXX7fz48XlZnLpL01Erwo5uprwLp7S2JJNrP5tWSLqIfaiw5E85+X1UR4hDyVzqC
         KqIXrz3038xQ4IPQJaxTlfX/4WIvlxTv5qHYZnRO7xihBNnRZzhX+2/7YCGkvQs2sol1
         IRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iARHdXB4BjlKr8lKVPpRSW/v+HxRAjAiiqqGZKt4F6k=;
        b=alQxhEAnp5hNMnA58SjBEeK4Ul+zxhgCmwNEgdqTI4rxGNqWIZJvxVrizT24t3nKIb
         NttdMwRU26Y6F5a3GIPNzs5FLq5DtsKgaMtTMpvqkLEzX/cQH0/WqfsYG5mAbuYbdSFM
         j+1xGb+7l4R/b+praIJNDEVedKzvZPYLHS9JiWnhgzCkE3VtSPzUllIbxoLExrFTvJZw
         1ygsoAszZ4f5/0sKA3qiuzbd3QDJ0NGGLNGf9KGbFk8g8hyLMMJ6fo3G48LsLhFSaNA/
         AS22v0dlqB8u1dv91/7/+2W5WBCW8/U+YtWfAd1j7zhSnP6RaUy+oQ6lHOn/LbnJfI+K
         ymKw==
X-Gm-Message-State: AOAM533VfUpdXXzHHfS5f9P5yQxcU3b24Sy9oZS9lwAhqxpl56ylnWZY
        zBEufUbaD26lmk57WS5RZEXZSQ==
X-Google-Smtp-Source: ABdhPJyFDzBQ1RLQ/qoQYvQBu4Ei9KetC8KikgrmDbAVP9cTYlMzRy12ns6CZO3N/TxJFaSv1BJhLA==
X-Received: by 2002:a05:6638:15a:: with SMTP id y26mr4986988jao.57.1606337127097;
        Wed, 25 Nov 2020 12:45:27 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n10sm1462225iom.36.2020.11.25.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:45:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: start adding IPA v4.5 support
Date:   Wed, 25 Nov 2020 14:45:16 -0600
Message-Id: <20201125204522.5884-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts updating the IPA code to support IPA hardware
version 4.5.

The first patch fixes a problem found while preparing these updates.
Testing shows the code works with or without the change, and with
the fix the code matches "downstream" Qualcomm code.

The second patch updates the definitions for IPA register offsets
and field masks to reflect the changes that come with IPA v4.5.  A
few register updates have been deferred until later, because making
use of them involves some nontrivial code updates.

One type of change that IPA v4.5 brings is expanding the range of
certain configuration values.  High-order bits are added in a few
cases, and the third patch implements the code changes necessary to
use those newly available bits.

The fourth patch implements several fairly minor changes to the code
required for IPA v4.5 support.

The last two patches implement changes to the GSI registers used for
IPA.  Almost none of the registers change, but the range of memory
in which most of the GSI registers is located is shifted by a fixed
amount.  The fifth patch updates the GSI register definitions, and
the last patch implements the memory shift for IPA v4.5.

					-Alex

Alex Elder (6):
  net: ipa: reverse logic on escape buffer use
  net: ipa: update IPA registers for IPA v4.5
  net: ipa: add new most-significant bits to registers
  net: ipa: add support to code for IPA v4.5
  net: ipa: update gsi registers for IPA v4.5
  net: ipa: adjust GSI register addresses

 drivers/net/ipa/gsi.c          | 35 ++++++++++++---
 drivers/net/ipa/gsi_reg.h      | 24 ++++++++++
 drivers/net/ipa/ipa_endpoint.c | 49 ++++++++++++++------
 drivers/net/ipa/ipa_main.c     | 76 +++++++++++++++++++++----------
 drivers/net/ipa/ipa_reg.h      | 81 ++++++++++++++++++++++++++++++++--
 drivers/net/ipa/ipa_version.h  |  1 +
 6 files changed, 220 insertions(+), 46 deletions(-)

-- 
2.20.1


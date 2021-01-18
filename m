Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7526A2F9B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbhARIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387746AbhARIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:47:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:47:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q18so15616890wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UUgEPXEmfwW21zan6h2nz/5V5Oq0e9V8hYSvH8Oa/8=;
        b=YS95PRrGzaLyXZ+zlY6FP6GxzPoMfD7ld7GD4yHFWlfKtC86vUyZFogJdZWO8GloqH
         ZaraiQRLUarG9P/92GBE8hl6eOsnwHG5WsKNdeY6c/KtlJxGvvNGgB9WPTJeRRO/Z3Be
         kPjrPGUO6LWHcDVnf9AVLjZ7pq9IIckfzD8XC9Z2Dv2WhNCjvNN3qnbPcx/Bd307kYDK
         1MKqHEkkvtSDyoPX4NFAbOAsmrYTt/GlDvE+zaMPCayxlSAQgf06NCsjdyaS8+n4wpp0
         w3FYURCP0EkUS3/pDK6BbcCCTrnR1lUYeCMazaEO023t0gc4eU/fhauEKvO3iN1/jaV0
         F4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UUgEPXEmfwW21zan6h2nz/5V5Oq0e9V8hYSvH8Oa/8=;
        b=fhnTQsrRk+4rNZpLmChhn9bgYE/Ar+uCt7rAuaECJBoT13YHS+8TMRYpjvjpBWiJRg
         7dmLXl40svue5b3128pPjvHqUYzGtrDxrFKatMQRsumQZLw8OuK4hPOMYo4SQXsvd/Jn
         aSoEJkDnwXRoAd35/wXQeikBf5DVKHHV5pYUosN/xxNJ7YJXYNbDx1YolLOuSTkvc/LQ
         D+kek1bxUAfYAGOAzwArkmoDnB3rjVHdLE5GAsA6BPWW0b8SLpV7t5WAuxtYGNEH5dIR
         yfozs28B9qHXYGwaw0oL5sU13PC8DJ20UWYaoPbx6DeaEVXTUiyF32098doDWgV8SVux
         nX7w==
X-Gm-Message-State: AOAM531ZgVXO0oiQSK0oXFHQRJ7BgBiKf4uWiXClCdOobWa/PWlvcvko
        CWQ8SLf2R1KPChVaqcKkPIsaZA==
X-Google-Smtp-Source: ABdhPJy162AzQgvDZLFRhp0ZSucGQDuDLkT0zoPQTBMXnmb9/lOt52l/1wwvxqUeLy1T7PtxqJsWfA==
X-Received: by 2002:a5d:457a:: with SMTP id a26mr25143180wrc.53.1610959621930;
        Mon, 18 Jan 2021 00:47:01 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id y63sm26224518wmd.21.2021.01.18.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:47:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] usb: gadget: audio fixes and clean ups
Date:   Mon, 18 Jan 2021 09:46:38 +0100
Message-Id: <20210118084642.322510-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a collection of fixes and clean ups found while
working on the uac2 gadget. Details are provided in each change.

Changes since v2: [3]
 * Slightly amend comment on dequeue error as requested by Felipe
 * Drop applied patch

Changes since v1: [1]
 * Jack's patch added to the series (no more deps)
 * Warning [2] on Patch 3 fixed

[1]: https://lore.kernel.org/r/20201221173531.215169-1-jbrunet@baylibre.com
[2]: https://lore.kernel.org/r/202012291638.QiDQi3Gs-lkp@intel.com
[3]: https://lore.kernel.org/r/20210106133652.512178-1-jbrunet@baylibre.com

Jack Pham (1):
  usb: gadget: u_audio: Free requests only after callback

Jerome Brunet (3):
  usb: gadget: u_audio: factorize ssize to alsa fmt conversion
  usb: gadget: u_audio: remove struct uac_req
  usb: gadget: u_audio: clean up locking

 drivers/usb/gadget/function/u_audio.c | 135 ++++++++++++--------------
 1 file changed, 62 insertions(+), 73 deletions(-)

-- 
2.29.2


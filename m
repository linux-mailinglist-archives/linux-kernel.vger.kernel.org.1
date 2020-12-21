Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C452DFF32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLUSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLUSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:04:38 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9CC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:03:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so14738308ejy.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GOIuyVrU+RFGPTfL16iF1lbuFwHWSwNBXld0jU71tg=;
        b=OuCyfDsLA66E6tSeeNV5W3tIR6FpEBwwEByxbYdc99ny29D4QNuO0Ufm8iCqEuBuVL
         myXsOOxx+QJ1ZvZ0nwN8DBfGu/TFzcML6SAIJI3veH+uT+mmz4MXxTVGj8HLDw0FT0Mc
         nJi77ZQmqyc6e/DDY/SfAxeQFxnHZ1OdM4YttHhhqDEy52VIvv6h0ycyjYslxHRPcLPQ
         Ec1MLJdv16AI/0IWB9mPTM3TbxJCOKF9rcBDCPfuttNhI8K5xotFUnMuTEfHSZDNgbUd
         yVQ6ALlQYFriVjUN0puMieHWDP3H1T0rA3+JCxN89jBXvs20xpiyAWBaSv/tvNwAK+sJ
         MK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GOIuyVrU+RFGPTfL16iF1lbuFwHWSwNBXld0jU71tg=;
        b=jW8//nHHjVJIHPZIrvzll35lX3DW/jdMnv+MEGcapUaMByzFZyVBbFXqKuOtQB8+J+
         ErzjAFLfW0hPXY61WQN5vOA/gzKNseH4lQk9Wc7DPoGGeJaf0NeWadn1Z9cSQuPLStvV
         WYApTADg9phKyIHNslL8hR55HGxGIYl0CSOPhtPDgt4JSSl/pjLdy+cBGFJzD+A6HMAF
         HKRZ6Y5OE0lYTTqz5Cwllqkihi/N8hNFkYLWs6mL6aZN9l0IeiNxCBbP8vmONbbKgzQa
         ot62wB4LT6sXxBgxqZu3l6oEIryaPYIVNAuE7QkOSkEE6iMdmguIqiX807HcvGY4lxF2
         fcGQ==
X-Gm-Message-State: AOAM530nsLqV6t3N/Xyk2US2Z2SYwtSGiItAkQSt0o/Ks5uHYSKFRKy/
        LxHcSYDnTKwi9WzHCW3BUlOp8BBgs4EA9R8x
X-Google-Smtp-Source: ABdhPJybWoCfB9R0VudqEA60QYpK/iTjLTVj+luqFWZXhwEIkDl/80PfJixK5doWCdTu8JGitnNjlA==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr10777094ejd.374.1608572140837;
        Mon, 21 Dec 2020 09:35:40 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id dd18sm9338408ejb.53.2020.12.21.09.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 09:35:40 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] usb: gadget: audio fixes and clean ups
Date:   Mon, 21 Dec 2020 18:35:27 +0100
Message-Id: <20201221173531.215169-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a collection of fixes and clean ups found while
working on the uac2 gadget. Details are provided in each change.

The series depends on this fix [0] by Jack Pham to apply cleanly

[0]: https://lore.kernel.org/linux-usb/20201029175949.6052-1-jackp@codeaurora.org/

Jerome Brunet (4):
  usb: gadget: f_uac2: reset wMaxPacketSize
  usb: gadget: u_audio: factorize ssize to alsa fmt conversion
  usb: gadget: u_audio: remove struct uac_req
  usb: gadget: u_audio: clean up locking

 drivers/usb/gadget/function/f_uac2.c  |  69 ++++++++++++---
 drivers/usb/gadget/function/u_audio.c | 122 +++++++++++---------------
 2 files changed, 105 insertions(+), 86 deletions(-)

-- 
2.29.2


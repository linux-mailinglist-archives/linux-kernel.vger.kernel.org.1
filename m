Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC42A429F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgKCKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgKCKdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:33 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5AC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:33:32 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f38so13357863pgm.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZVixt3bJyBbHov5aMt9uShWeZEKD4hMZGn5JRPvjGI=;
        b=CH26fav4EiFBNQLGJlILxppem54CB0ajkcpfJiQokiKF8w2ciRqHiM5Vn7qWl986Wh
         nr31g4d3lCaRE4OjZDV4rLR9lblTO8dmp4YZ7nn4otbne7JfsqwQ+muFLcUXGkeD7xcu
         B6shll/g+kanR5s80BNcRLr2N4jDdo8uKJb+YZ56coqpHzHq8FbMbw5i7WKuIu/8W7OT
         IJsYqSfo+ZMRJa8RmXoaR7+CodqFlb9qTV6+SQo3SIG57qhdJhIxYKXRlaY+x7oLnYRQ
         9nnBsQ+LPkK4v1iI1JOuLhECgSruym+taGG4SZSxF/5yKHufHBXUvKEZ5uxiiObFnvT5
         uKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZVixt3bJyBbHov5aMt9uShWeZEKD4hMZGn5JRPvjGI=;
        b=l9cN7PRRPLtdCjLDHdAwGmWBBt+0UrBDVX7yPibY9EAH5GNa37Tvw5Gni1ADkjHaPH
         zF620GecF93Kf9FvratqlNAl+AQNAnBW6/VvE8bP4rcXSPT1FfmDpDzuPO8d/in9KCPL
         Tjrmdlr4gVGXyE/vidzNhjzYF57wTbWlE9HQXyRBdepctgRHpxIrAQdAt8WJ+g5Tl617
         VeniR1cnkU43nk1OzF3enCgUmYfYtkgmGzNUe7UPB8hRjLgl0P5TzpVD938b5uCuDcgv
         JRwJ23Wiaj84z7tg2aMfBoQqrFH3D7wkpr1qrQVMlZiqBOETzFTp9zUmiIUwH5A1k4ms
         bveg==
X-Gm-Message-State: AOAM533sFDhiuoyXILidyYT5NvwHFSMkF2TtMWEGdne4S2XBRgZKcz39
        wYBPOTgans0i1o4dd1A7uoQtHQ9R9eykzsMESYk=
X-Google-Smtp-Source: ABdhPJwl3L9RBgprLZouaOiIYJ3YcKEX3m/JWYT5+6JobmNGSf2xUCiX9/4D/Oo2O6SjeoZ3Kgdlmg==
X-Received: by 2002:a17:90a:6501:: with SMTP id i1mr3150107pjj.30.1604399611905;
        Tue, 03 Nov 2020 02:33:31 -0800 (PST)
Received: from localhost.localdomain (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id y4sm3041866pjc.53.2020.11.03.02.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 02:33:31 -0800 (PST)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, davem@davemloft.net, gregkh@linuxfoundation.org,
        alexander@tsoy.me, jesus-ramos@live.com,
        joakim.tjernlund@infinera.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH] ALSA: usb-audio: add usb vendor id as DSD-capable for Khadas devices
Date:   Tue,  3 Nov 2020 18:33:11 +0800
Message-Id: <20201103103311.5435-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadas audio devices ( USB_ID_VENDOR 0x3353 )
have DSD-capable implementations from XMOS
need add new usb vendor id for recognition

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b4fa80ef730..c989ad8052a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1800,6 +1800,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x278b:  /* Rotel? */
 	case 0x292b:  /* Gustard/Ess based devices */
 	case 0x2ab6:  /* T+A devices */
+	case 0x3353:  /* Khadas devices */
 	case 0x3842:  /* EVGA */
 	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
-- 
2.25.1


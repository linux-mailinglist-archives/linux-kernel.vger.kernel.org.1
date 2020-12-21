Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1012DFFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgLUShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgLUShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:37:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B4C0613D6;
        Mon, 21 Dec 2020 10:36:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n26so14809042eju.6;
        Mon, 21 Dec 2020 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWkMbxsI1o+TKi40gvIKxOy8FUWY3wrnEaa8EBZzq+Y=;
        b=YSnJ3X3KJ1HnAexXXg1QCJQQSdejcczuBUdYz9NqTnTkMwjP2n8x7yq5/4yvSgO/jD
         iPcvjMPTevnDN1Dy6+O9vIM+gtaTcl8dbIz6wiGNlx/FqKLDGNWpXzlPc1t2xr8duVVe
         wydaoV00COj0+X+mrHjieCOUZa4zYBp8cSq9/dceDzvn+adBoFZ8vgA/fYzHKIQL1PyS
         xMbuPofmZiCl9T+PIYd9WWjh4Ow3TqYq1urW32enTAVV+l2vpB0I9mbM/qshXIYjP0z0
         nkFwWhmBEPf/tLkUnXAjbLdn5BihMqkNUyjBsnL8DoCRI8WBJkb8qAIRektRryYljCyA
         Yosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWkMbxsI1o+TKi40gvIKxOy8FUWY3wrnEaa8EBZzq+Y=;
        b=finfbSao8Me/+5sg0VeFoFlQBqDFBoPtTw6J1THQDeugJGw1fpE+NKLReqQ7j4XdFA
         mQML3xUNW0qOvZ99LK4vX0qS0OoMFgeSEqV9LqPo8xRvOY/Ps8kNyeEM9ghh6HviJHqa
         VNXUMbGDSTijI6kc+wsJ8Avcw2zjd5lLpC233mR5gwHTwvgwxZtrs3zv0+LTyGzcwyB9
         oyCjcs2CQTiBstO6QRwkEg4NIv52zpAxNEkY4K7it+dg21vjWkFWJyhR1NW3uWBuXJsy
         OeXZBZ/ySTgNZktap8taNQY0GJzPtWcwuYgOSs+ILIzgwCxDex8Af3u2kSs0U0IOKIxN
         NyGw==
X-Gm-Message-State: AOAM533D5KSdFXI+73hHS5s5DgE5MQzILZBOG/4PoYgB0w8fCiQvES4w
        3gbIFI4OveuX5+ZcX5hgl24=
X-Google-Smtp-Source: ABdhPJzYTKKKK7YdSQG4z2k5CUmkaYUnguR49SQ7yzoPQZ6lp44/ihPAGPP2FhdQucQPXMQKgdVqBw==
X-Received: by 2002:a17:906:eb49:: with SMTP id mc9mr16073411ejb.487.1608575791177;
        Mon, 21 Dec 2020 10:36:31 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ld2sm9390408ejb.73.2020.12.21.10.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:36:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] clk: meson8b: cleanup unused code
Date:   Mon, 21 Dec 2020 19:36:22 +0100
Message-Id: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

these patches are two small cleanups for code we don't need anymore.
The first patch removes support for old .dtbs. I am not sure if the
"fallback" logic still works as I have not tried this in a long time.


Martin Blumenstingl (2):
  clk: meson: meson8b: remove compatibility code for old .dtbs
  dt-bindings: clock: meson8b: remove non-existing clock macros

 drivers/clk/meson/meson8b.c              | 45 +++---------------------
 include/dt-bindings/clock/meson8b-clkc.h |  2 --
 2 files changed, 5 insertions(+), 42 deletions(-)

-- 
2.29.2


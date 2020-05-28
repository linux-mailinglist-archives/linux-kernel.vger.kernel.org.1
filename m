Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BB1E6238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390409AbgE1N2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390385AbgE1N15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:27:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2F2C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:27:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so3194429wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cN8WC7B8xH4SW3c0YEgj3hG2uP+gsYVa8Phs/daLJo=;
        b=XhU9Ag1ZLhT6nRnPcN/QI44p0PvvTskUnXmbN7WZRjd0YK63lIUd2JzL7Ymo5MnHpF
         CKuiJgYA8GajqzmjbrwTZBPpRm1rdmf9aUTcTr1Ptu7f5DEizfgwzQrBN1yqo1ZynKXM
         gsHFRlzRGEEKjj4pUGIUil9HKgvMyyc+xTk3o3rxmRZ/WDY2zuuNKPNoGZvDvhFReQPU
         JmRi9ZP6d6BgpPtIXPvFqOgY2ngEhp0ozEYddVmRNK/q3inC/U8ubvRcTlBaypFAdyte
         9nV1SyMkXnOZOBNr6wmwBL5sDwijzaWBPwXlRsa4Qmfc7ohCOkuaeKf+EOcAtG2Tvg/2
         dM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9cN8WC7B8xH4SW3c0YEgj3hG2uP+gsYVa8Phs/daLJo=;
        b=K4i9PNKTDmp+ciemifGNEiWQO8p72qpvoVuTzThZe9iq01hs2PHFJoq98r5U7oZzL0
         JDdgLmF1GmkACwGxhE3VHF4VDrCmj4EvP9NGz6c2XD1BWBGSn4JgfYaOetB/lV7kz4Ev
         00X1JtdiLMkMAKj+7Kn5B28qIgtsm+c7H6i0ODoAu9TopElVO/YoW1NtyDe5oX79ygw1
         +DclHSXuhH7JG9axwgr42cDQnlF1jVSwZZ9mr+tyZXcUYT8CupUKuCVm0VxJi+9kmuwm
         TBnVneJACro8kPWYF03EJSTcpSzWmEgNV03x7399E1jc2u7SkJKfPfHJoeOPomsBybC/
         I48g==
X-Gm-Message-State: AOAM530u2qGIN8/puCEXMZ6s08hJSu5nP9sGIBySs9zrT8VOJ3N1ZXRt
        u5MDbNjANo6PYVLE2xceZs4ZMw==
X-Google-Smtp-Source: ABdhPJwGxbatIHlP4QiBp7yS7pM9Cy7ihGVx/tvTL9NgArY/12jr4DGk9+/NG/bPpKAD3mawZpovqQ==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr3345147wme.103.1590672474339;
        Thu, 28 May 2020 06:27:54 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id q15sm6175408wrf.87.2020.05.28.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:27:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH net-next] dt-bindings: net: rename the bindings document for MediaTek STAR MAC
Date:   Thu, 28 May 2020 15:27:43 +0200
Message-Id: <20200528132743.9221-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver itself was renamed before getting merged into mainline, but
the binding document kept the old name. This makes both names consistent.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml}        | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml b/Documentation/devicetree/bindings/net/mediatek,star-emac.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/net/mediatek,eth-mac.yaml
rename to Documentation/devicetree/bindings/net/mediatek,star-emac.yaml
-- 
2.26.1


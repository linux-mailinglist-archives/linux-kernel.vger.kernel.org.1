Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A72C9176
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgK3Wsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgK3Wsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:48:51 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC8C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:48:11 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c1so11063pjo.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Q7I/gLM80QOUJ29h8NZUceaYOmEn3jh/fTr59l2Sd+U=;
        b=ONcvrS7NDPgCMLvdczj3/dCLgTHmDlXypEuvMQXDUy++qe6a0On86tehN/hShHrfLg
         1LCEwcm9QMis8tWSo1P3Na6/dtK2Ir4leUQXH72aUiPS4TKTQIjHo455+zaEBhNCR3yf
         C/EA2/14dsH1YdKT7U53GyvOFicFc8mWUGCQfmZ3UBv6/Tla8eEKOGEYozwDbIEAp4QV
         Bmv+Rrxv9oWo1kyryPk6NrmLptbcuk93gXAU5hZa38U7c4uCXKGUyHQB4a0di5sXZ6Wo
         8anndDxcPZgPXEuatVUZd2A9vmI+GoUS/ETjd33gooc4uLr73qZB7zc4ww2MAz/UIe3j
         nkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Q7I/gLM80QOUJ29h8NZUceaYOmEn3jh/fTr59l2Sd+U=;
        b=alYAllO9s4bpc/GTFskMXRMP8n7kZuDv0EsAN0eMdmhikt8cv/f3eFEgn60jPbu8oh
         lbLWSd8Bs5599b7M56809e7srSdCydQgbwu+UhUYyJXqaoLpWxeQciPxE4v26NbM9xNM
         d7zvlr13HibTRNESmmCE+FDixCz8mqZ7qBsrR+TwmYOfSBSw9oAVqkGNUvnzBQ4LSLOx
         wZoFY6fTNDa15gav0X+1so0p19XP7ay3/M3cUtEQuWeuyMalZgPWSPr1263JDkI75qUq
         Q/9/LGQJho8QsymW4NAaCHKhsqysIiZF2sTnC2GUuSfpK56uPPd+wh9ReIyGLHeIrEAe
         t6Wg==
X-Gm-Message-State: AOAM530+s2wreP2z0CjxDGYwA53Jfsc8om5rGyx8njr3YV0KHrT1yfke
        ZQKEc008B1yHXdyhvrKDfKkyqF2mvRkl9HzIzjY=
X-Google-Smtp-Source: ABdhPJwTeJKVzaaMicXzyd7TBuEni9hNg1wu+vXCPIYYQOvV0bylLk0wu6TGhwSA/R8sdmiYphB1QK5F8yFL7Da3+/0=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a62:ce4c:0:b029:198:1f1:8743 with
 SMTP id y73-20020a62ce4c0000b029019801f18743mr21027885pfg.79.1606776490772;
 Mon, 30 Nov 2020 14:48:10 -0800 (PST)
Date:   Mon, 30 Nov 2020 22:47:52 +0000
Message-Id: <20201130224753.1569357-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 0/1] gpiolib: Don't free if pin ranges are not defined
From:   Will McVicker <willmcvicker@google.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes commit 2ab73c6d8323 ("gpio: Support GPIO controllers
without pin-ranges") where an imbalance of requests and frees to the
pinctrl driver were introduced.

Edmond Chung (1):
  gpiolib: Don't free if pin ranges are not defined

 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.29.2.454.gaff20da3a2-goog


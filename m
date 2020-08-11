Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2940241684
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgHKGxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgHKGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:53:14 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B60C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:53:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mt12so1363468pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVyLaU4+BT0CbBg8wXnS9t25mJ9x+rEfYROdR9As1Es=;
        b=l/MvN3zSLaDAVf/ZEMGuKIVX2W6b0GobJ7BNF386lIwvlgxAF2o6tm6X8QapJ3+Zqg
         W5gN23ay6ZI+/HTNvAhPozVVbnnJh9jMX2kab611Gb9N1Il70xK7NIXLVo2a2wv/yB3v
         YP7Cb/9cGoQsX6+3CiLXlfmITwhmg2TeDX9hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVyLaU4+BT0CbBg8wXnS9t25mJ9x+rEfYROdR9As1Es=;
        b=r47PjfM6M+3Gge7sgMggWAltEfO2uQEFEJq+v9LNdMCx1ya9eUyov0e1PAQPv4pR9w
         jUXA/SQ6MnzoA9uG28kAD6eToq4aIaNHI9Yv3H1eymnL/7LONJSg4oQFcE3P5itbW1Kx
         A18t2l7Nnx9WxPCpeSb1JjUdrXwjRjeA0zqQYeP911EZ5du02LaFPkrgNb3zwtMm8dRW
         73dJhLZ1QZzcFf0v/uyZ3caHKzFYy0bX1N+r62mj62Q94AyjYBeocCd90iELn5U+3xgQ
         SzyoCMhCjd++awzr7Q6IRLN4TMBDFEdoCpLXBzca1mnYX1ahnpgovx1JOIq0dfTaNDCZ
         rbpg==
X-Gm-Message-State: AOAM530/JmC7Oiv+qpFa7d+4lst9PI1Hp5Ryn8zyzZnfVCaoWGJ+ZyL6
        RC2xFizFW2IIUfOTePm3r9zWdA==
X-Google-Smtp-Source: ABdhPJwQHLudf/hU6n2fobVQ1fVT/hk2E3bs045RNnDZoeghFT3resIKbQ30X2QKWnezkqlPSna/vg==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr3214695pjb.91.1597128792275;
        Mon, 10 Aug 2020 23:53:12 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id q13sm1667351pjj.36.2020.08.10.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:53:11 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 0/2] power: supply: sbs-battery: fix presence check
Date:   Tue, 11 Aug 2020 14:53:07 +0800
Message-Id: <20200811065307.2094930-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gpio detection is not supplied, presence state transitions depend
on every smbus transfer result from get_property(). This patch tries to
check battery presence again with well supported command before
state transition.

Changes:
v2: combine get_presence_and_health functions to reuse

Ikjoon Jang (2):
  power: supply: sbs-battery: combine get_presence_and_health
  power: supply: sbs-battery: don't assume i2c errors as battery
    disconnect

 drivers/power/supply/sbs-battery.c | 99 ++++++++++++++++--------------
 1 file changed, 53 insertions(+), 46 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983212950ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503026AbgJUQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503017AbgJUQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:38:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF821C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so4184574ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEj2dtHf+HnkoupGy9xjTu6l00O4rrG2/m0FBk6LmZo=;
        b=cusYKGkTIwI9uDRArPoxsPYgtC0mWm56iG0865ZA3IhoHDIqFs/EAzX+zyGG/z3e/T
         RMVISkIpP2NTz/McTpiWynxFhelUGwWaDwRppi0BOqJRx/Gx+yJ1x146SW/k4JfdftKk
         lJ+Ri94ZaPq8sAmSrnw8tiBwf/Sk7l0piWFlMFR4pS+FG+woZoYuq62thqe2jSCkrRtv
         aM7GVbuERHoHFyn0DFlTGlv+RPVF2YZM+WrxZf0aScigWLVkUUtCVj94HpF6nQUzni2c
         g0h2wevwOQD2LIZsDhQmz9nOmuXYxJgEIuEeDA3QMeJbmAAHGDZH877TMYYLEQll1Of1
         U14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uEj2dtHf+HnkoupGy9xjTu6l00O4rrG2/m0FBk6LmZo=;
        b=hnDR7UNc4z8aupW8++XtwfmFzAwCDg0lIEgBJBp7kfA1EOq1vT2/P45M1869tjtC3p
         Qpz/La7VtiSDe0ENQBN6WPVH0COr/BfDXE38f2UwOwGZmg5OKEk/+RSNtIQIg9dN4uzt
         +xJfoacPuiwwruN1Atbg5diHFhTfN1HsdxTz7f02Wn2REULKbaKrNrDyxv4TmVBNr/Zs
         OGDQJWuSN+yf0Wm9lZFo8x7bETqRiXDSPHescoaVSZCKwzW07JdUGGVaRGwteU1u9fa7
         mMDq065OxMj5P0+2FCEnugWTYOQ5RIhq9c2To/sIwjswydrzBftLiClkoKuAE1PccQ/Y
         Mpuw==
X-Gm-Message-State: AOAM533kz74Fx1HXSUESAIQE0BuCQv5vzXmPExlyfElDBb+QIey+q1BQ
        AJ3iAAiMBTJViCCPqzx/in+M+Q==
X-Google-Smtp-Source: ABdhPJzxYoh8vi5BHrv2k+io/DSMYqitDUc10vHXq6uKSsyqTQW320C8E0qpi/qiJaROGdWmub+2lA==
X-Received: by 2002:a17:907:20b2:: with SMTP id pw18mr4225896ejb.159.1603298332372;
        Wed, 21 Oct 2020 09:38:52 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id f26sm2549747ejx.23.2020.10.21.09.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:38:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] clk: add devm variant of clk_notifier_register
Date:   Wed, 21 Oct 2020 18:38:45 +0200
Message-Id: <20201021163847.595189-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds memory managed variant of clk_notifier_register and
a first usage of it the amlogic clock controller of the g12 SoC family.

Jerome Brunet (2):
  clk: add devm variant of clk_notifier_register
  clk: meson: g12: use devm variant to register notifiers

 drivers/clk/clk.c        | 36 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.c | 34 ++++++++++++++++++++--------------
 include/linux/clk.h      | 18 ++++++++++++++++++
 3 files changed, 74 insertions(+), 14 deletions(-)

-- 
2.25.4


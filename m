Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCD2B887D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgKRXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKRXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:40:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35202C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:40:46 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b3so1892712pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4eqbUws5OBh+zSDmGIZGynXeE/GCKmhJYh2f9F/2s8=;
        b=MM/2GIKGWDzxw4aO+CK8E1czrZG9hJLEpzvnEQAQlaPwjmdtFuk3rlBdbPs8q+3uF9
         88xHc/Q9LHtK2qtfZlFJ0ZWcZXGWjHDwAbWd70kuQxRzVpxeSj+VbA17o5K+gKYn4G6k
         6nBxH+6s5j3GjdnOcWGf2UwpUEIgDW3X5H/Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4eqbUws5OBh+zSDmGIZGynXeE/GCKmhJYh2f9F/2s8=;
        b=S3s+iDZ3de1lR8YdXLiNtFga15N33JuK9hrYgEXIfkg62Xsvk9tCrUrrS4aNVk59+w
         5sfEYtlMjtiZYic5FPydbsALG0N/3adkUVD6nrpmY8xjKiB0wIs2gtWa/ZrJ8+6KlHFb
         hSqYaNnQ8Hw+WPgoVaorP+NMUqw5Z/E/2obm68mRk5lH/Iw58kZriD4Ih7C/dI5mLi3C
         59TC78puWuSE9aq31f2JciZJbR+OQBMaKUoPxin4dJw+oP6jbdPZp3Lb19lrWW8haR5q
         2dMzld8UOIFKGVUM5QY/3Nq+/jMEpC8pSRcS1KR6kiWEq73r/a5CzE3IeKkZ4yZLuRTY
         UDZQ==
X-Gm-Message-State: AOAM533U7TBcsne4/F6ev3ahqQoDGlrOnDEATWVcGt6lbmHQAOYlHC4K
        Iu1Nf2T7jG5jkvONSuEbKuyA7w==
X-Google-Smtp-Source: ABdhPJwWRoldri4GORHGp02TpBVqgoRyd8LQW83YaMGnQCu23Xf4ZLp8w8bW2PEESszAm0RJA8sFSg==
X-Received: by 2002:a17:902:56e:b029:d5:d861:6b17 with SMTP id 101-20020a170902056eb02900d5d8616b17mr6679168plf.17.1605742845769;
        Wed, 18 Nov 2020 15:40:45 -0800 (PST)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id t200sm5210979pfc.143.2020.11.18.15.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2020 15:40:45 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Evan Green <evgreen@chromium.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 0/2] i2c: i2c-mux-gpio: Enable this driver in ACPI land
Date:   Wed, 18 Nov 2020 15:40:23 -0800
Message-Id: <20201118234025.376412-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-mux-gpio driver is a handy driver to have in your bag of tricks,
but it currently only works with DT-based firmware. Enable this driver
on ACPI platforms as well.

The first patch is a little dinky. Peter, if it turns out you'd rather
just take this all as a single patch, feel free to squash the first
patch into the second. Or I can resend a squashed patch if needed.

Changes in v3:
 - Introduced minor &pdev->dev to dev refactor (Peter)
 - Update commit message again (Peter)
 - Added missing \n (Peter)
 - adr64 overflow check (Peter)
 - Don't initialize child (Peter)
 - Limit scope of dev_handle (Peter)

Changes in v2:
 - Make it compile properly when !CONFIG_ACPI (Randy)
 - Update commit message regarding i2c-parent (Peter)

Evan Green (2):
  i2c: i2c-mux-gpio: Factor out pdev->dev in _probe_dt()
  i2c: i2c-mux-gpio: Enable this driver in ACPI land

 drivers/i2c/muxes/i2c-mux-gpio.c | 112 ++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 30 deletions(-)

-- 
2.26.2


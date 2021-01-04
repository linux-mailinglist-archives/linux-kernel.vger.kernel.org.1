Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527CF2E960C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbhADNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhADN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:29:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27912C061794;
        Mon,  4 Jan 2021 05:29:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t30so32196883wrb.0;
        Mon, 04 Jan 2021 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDDJAO12mWdz81SfN4SE3sY3sSE4phZfV6IOzBfLb7o=;
        b=AyaxGkK9oSW0SK9rGSfs/YkEz0nbaZL+5Dwqi481jU7zFdo7XjalMR6LACJzF0XoyX
         oo1MnoovVrTOpSQZ7R8ZKfGgMh4LuWrBMerzLzMMsueH8JzpoRl86ngySyP9L2KGFYXK
         ayOyuYQDqd5fik7dZ8rth5yW1Qxd4sU5utVUjK+5z5eJzI7zCFbHbUM+InVT6XAl/bvo
         RuAnvBo06ICfWVinxhaNREti7PGMLSBpstoEB5r/xxGNHuHScBHC7QJtROeQIuV9kB76
         2WbadKjxcRFYqadH7JHItdR77FJDpv8J+m70xc/1WfuyfvyZAMnhoRgTQtiLChJeZfs1
         oIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDDJAO12mWdz81SfN4SE3sY3sSE4phZfV6IOzBfLb7o=;
        b=qM7iA+XMgHW9mNsviqBmKLWmWODENjOiihYu79GBD7IlWkte+iISAWeytfvFrXnH3v
         hvfAvz35sRwefVOu3OeQ5vXVmtN2VqcB+cUA2inCi525Zcg14pigfTyedO+oK8rrLm4p
         to7Zki4/35VwTZOuUEqSNRqPVHbY7dR0hHJzIcNzppR32SfIqJal0JnIGp0WWX5MY683
         sM2C/bIJ585g22x302il4LSi7070O92ZGOdTmD7fPGTGtNxsvalhPGuJCxytPafBUL+3
         kuiyBmh5b4I4Q7Yf+DbhSGG1bUD9NFCnwzMylTOpfwq9B60mCQCdKk+vyFfFbEkatj7n
         /9Hg==
X-Gm-Message-State: AOAM532fybqUb1t+ul/M4pE6zOcRqy0Q662h0EcTPjsYAc2tH3iJ9lsG
        5gfkND8v7at9Ff620anuOVQ=
X-Google-Smtp-Source: ABdhPJz/siaI9EgHKtZAcRboER3/TG/xd8msE9THKkBWgr54MlNu7TX7+/jsGA0gUsDV15EpzqOcfA==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr83048697wrw.247.1609766951899;
        Mon, 04 Jan 2021 05:29:11 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:11 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/5] clk: meson8b: video clock tree updates
Date:   Mon,  4 Jan 2021 14:28:01 +0100
Message-Id: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

this is a small set of updates for the video clocks. I have verified
these patches to be able to generate the video clocks for 1080P, 720P
and a few other video modes.

The main "mystery" is still how the rate doubling happens. However,
that doesn't affect these patches as with this rate doubling the
"hdmi_pll_lvds_out" (which is a parent of this tree) is doubled as
well. That's why I am sending these patches because even with this
unknown part about rate doubling they will still be valid once that
unknown part has been figured out.



Martin Blumenstingl (5):
  clk: meson: meson8b: don't use MPLL1 as parent of vclk_in_sel
  clk: meson: meson8b: define the rate range for the hdmi_pll_dco clock
  clk: meson: meson8b: add the video clock divider tables
  clk: meson: meson8b: add the HDMI PLL M/N parameters
  clk: meson: meson8b: add the vid_pll_lvds_en gate clock

 drivers/clk/meson/meson8b.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  3 +-
 2 files changed, 79 insertions(+), 3 deletions(-)

-- 
2.30.0


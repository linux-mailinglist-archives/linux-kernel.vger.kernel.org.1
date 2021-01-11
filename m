Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAB2F0C91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbhAKFn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbhAKFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:43:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC191C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w1so7727839pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMMmd7niASL0GbkxyQPnOxVIMiI8ncl5HbzeLIPpHis=;
        b=W8GdeCg0Uv4Qa9tjMNDZRbfwkndQtOZnj5X4CyYAcgpr20Bp9YjN8VAAQhqfS9jPAU
         u7nH9gzeuEi2aMLL8PGj74SiItupw0gjOy8nheZODCbqV/GBse57aB1jV3Hipi4UALow
         11QgCoY9R219S+84gCL/aqim5DljdcLbshAmIZBgf+jzEAI59sd88pSWCnbyVHf/nFmu
         91NCM9qkWBzV9n1ehCBlOWngUIoNx20WZ5ooxGlv/xXTAUyUu5Ua+hkC+rOtRXDIOo8p
         vFevAnvF0+AFarL3tYGqyUMh86054aOdviMaiuCslePriMBCNAqV/37mWvH6vbNRrjjx
         JdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMMmd7niASL0GbkxyQPnOxVIMiI8ncl5HbzeLIPpHis=;
        b=FFCe0PQWfqHaCb19IdhPH94Cruj9wp318LjFn7t+y+u4C9Wk4XG2UaFVt8IqRPfu2j
         J3QsDSON8Xtyd5L0CfeRiKe78PWwc6iUUPoZURG438P6Vs5deC3/LNih3ZT/OlVi+411
         uOX+DuXRI4lxapaXj0ew7f0HM4ppVKtYrkl121bzK3gTyAdYtK4Kfpdylia7nkAKM0y5
         gdk228WfhvU9t/+ZU5U8trmxJ4ioiX0uOwPT+2GXMvlQp2yosG2+SsTQomH26ic3D29T
         /kPOm6HgKEVAea9PshK+gvxVcpXMRRYZyQeqKB9kIwjwdCC/ZSyLWy7b+BfxgsLXXQtz
         KMJA==
X-Gm-Message-State: AOAM5335JLX4aRupU9G6/lcFDRC2w8V121Cb2rY3Z0rOpcF4MZGtIIRO
        BJ1AqE5oJiYKW5IhU4+AN6ypiA==
X-Google-Smtp-Source: ABdhPJyNb71bO/KS+r+7CKUUk+mowNqb7YK+RxJx1uNuYKPOlFd4RP6N6FwKZPOgBH+uiYZrb58I0w==
X-Received: by 2002:a17:90a:4402:: with SMTP id s2mr16311396pjg.37.1610343795412;
        Sun, 10 Jan 2021 21:43:15 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net. [61.231.198.38])
        by smtp.googlemail.com with ESMTPSA id x15sm16726267pfn.118.2021.01.10.21.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:43:14 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v3 0/4] ASoC: rt5645: Enable internal mic and headset on ECS EF20
Date:   Mon, 11 Jan 2021 13:41:37 +0800
Message-Id: <20210111054141.4668-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are trying to fix the jack detection and internal
microphone problems on ECS EF20 series laptops which are empowered
by Intel Atom x5-Z8350 CPU (CherryTrail) with Realtek rt5645 audio
codec.

---
  v2 -> v3:
	Restore the accidentally removed terminator of the
	dmi_platform_data[].

  v1 -> v2:
        Invoke callback() of the DMI quirk if it exists, because
        the dmi_first_match() doesn't.
---

Chris Chiu (4):
  ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
  ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
  ASoC: rt5645: add inv_hp_det flag
  ASoC: rt5645: Enable internal microphone and JD on ECS EF20

 include/sound/rt5645.h    |  2 ++
 sound/soc/codecs/rt5645.c | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.20.1


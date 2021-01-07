Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF102ECC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAGJHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:07:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB9C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v1so1095160pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DoPhwpxVpcCeNa7xRylUEVANyqRa0budKloP0YXXbk=;
        b=Ny4WfLB5f/tyTudlrLm+sC0kTXjRmuKvXnRfUVfCkRy7KJL72UFlIw+uLDqA+1ft+p
         0bidtRs3/bwRkD+5CECBcoZaG7JO9Zatu2mTUWFrysiOZfy2BZoGu0AkusnaP1rSQz3V
         uTB49MJhiKZ/HS6y3rYl/vJZmlNWJ/MwlD7bmBsUcjOqFhaBuBm9gRcHu592QoEG/sN1
         Pv+VO3UWGU0ePTSPmdQWOHX9bt2UeqSDw05g9NtQFPDx2jHyqw1DZGgcnISdL0RJlBIa
         0Lc+oZrMrW36cOtwKCG6qR7A89ErN3U6Y6vYQNBLRlzM24Cn1L5WTmeVHMjA8KxDZuNv
         auTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DoPhwpxVpcCeNa7xRylUEVANyqRa0budKloP0YXXbk=;
        b=ttXoj/pGwTB7VdgEm6Tqh3+6Y16qK7RPPkUXCSQTkG2+y7w9rkvv/Xy4DrK/OW3ifG
         vmL2Ah3KA7vcLgBruu89ftYh2y+XXs+IHxCWxw1sbozNepsQEoWc9b6Lc73ey2nup14x
         yiYqTc0qWiI0pr7TQ9KyWcytCnOPkw94aYiKwojkEBRdMRXYY7MA3EXVonznqitL7qhU
         wj5cEKUwRwDuH1sGSEQVYxdrUE2xfHxbN023g8dcbE2p99qVkMMtieISErnvXzIufuG0
         Ah9UqUfRYhkTo2Y8eNOyW3PnDUtUnj/xAjfAKqZ2et5L2JlVNM3nhbxb81/9N1q0OVJg
         sd9g==
X-Gm-Message-State: AOAM533Unz4KCWfTSaIbYxERBi0CBg7k4vmEgDnmI2srxmIylwNqW5Rh
        TwjaNAnnY0o4ygP1UcEnLjPHyw==
X-Google-Smtp-Source: ABdhPJz8cAvssJCyCm+bYYDR9GUQ7MmaQlcbn+bpw/86jcMpufKrAup3HXnGKUy1j8gkLaveTjhJsg==
X-Received: by 2002:a17:902:59d0:b029:da:69a8:11a8 with SMTP id d16-20020a17090259d0b02900da69a811a8mr8185541plj.63.1610010399008;
        Thu, 07 Jan 2021 01:06:39 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id b2sm5006394pfo.164.2021.01.07.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:06:38 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 0/4] ASoC: rt5645: Enable internal mic and headset on ECS EF20
Date:   Thu,  7 Jan 2021 17:06:21 +0800
Message-Id: <20210107090625.107078-1-chiu@endlessos.org>
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

Chris Chiu (4):
  ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
  ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
  ASoC: rt5645: add inv_hp_det flag
  ASoC: rt5645: Enable internal microphone and JD on ECS EF20

 include/sound/rt5645.h    |  2 ++
 sound/soc/codecs/rt5645.c | 46 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.20.1


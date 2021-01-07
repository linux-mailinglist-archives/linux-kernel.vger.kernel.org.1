Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13A2ECE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbhAGKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:54:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394EC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:53:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l23so3478258pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wj1ygJR5+FaqE4ft+YDdxBj7ZFRXR4m0BwjI6oUvI+E=;
        b=UzAWpcLJBQSsqf6X+xsUgXjtFcgW393dKOcDhPA0nzD3e1PFuOgSL64k4cDABYnTlT
         lobfa801yCVwreawYN27jxjEUyj3dZ/WHR3vF0364EfQ1VASGxmXjpQjDpksxA2TmfXX
         8Vk2hTssx9SUVtT3m1nTcB+xGl98vLiCEAFsL0uL5sW8TPt8oX8EwDgQcUOsvihLCkZ9
         vu4QrSgHyH0AkyX2Ci5cUijIscZmdQxd5Ca9hh2308Cxi6+V0RxSRzM9RfE7qSXSlE4D
         ePCoWvJV+3qtybmcV/oCMwwXRDzHDjIcn3ny57XD0hVZ5iSwZReOJFLGNv3d/tKhJXAu
         dd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wj1ygJR5+FaqE4ft+YDdxBj7ZFRXR4m0BwjI6oUvI+E=;
        b=rAIoP0X8sewraFbu4rMgltJydG6gHU0HKkSM9MfGl/92HCPxgzhaLv1M6ttEEemAWD
         UEl6r9/oSY0GLyvLdkSdWQMfsUBu+VXEb9Yn3EeSvNshjTJ6VeohKqwrkKZnOzG67kdx
         1HVssQwOm6hXuAzBLCEHjixT8F6dtf+huNAroWK/nOuS2diSj9bsEpPBIKKDh9UlZAPk
         8q454BbFUiLjoOVBhN/igycd+6t7DvDsBAcRcs4uYjtXdR9kjPBo5KYLv4Nq3/Rutkv5
         g9RucK5CCzSBZv9fsVW3T5q/wCBz6DtG3dACN0oUZdHa5skghXvxMhe8TXaNfG79aLLk
         5UKA==
X-Gm-Message-State: AOAM5303Kfr86cQfx0D2lceRwk2FDqspDOT4IraAq67C3fg8wnPgq+np
        gLLIw3lhhbAimfQV3Q69WTOmBQ==
X-Google-Smtp-Source: ABdhPJxObwz+sTsR5viQerIB0RWI0i44SwygcnPBJnPFMGURLrM2mImOiO/zb4QdmtgohbFdEDiB1A==
X-Received: by 2002:a17:90a:d70e:: with SMTP id y14mr8641686pju.9.1610016836314;
        Thu, 07 Jan 2021 02:53:56 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:53:55 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2 0/4] ASoC: rt5645: Enable internal mic and headset on ECS EF20
Date:   Thu,  7 Jan 2021 18:53:25 +0800
Message-Id: <20210107105329.146988-1-chiu@endlessos.org>
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
 sound/soc/codecs/rt5645.c | 48 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.20.1


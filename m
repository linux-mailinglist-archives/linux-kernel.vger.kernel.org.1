Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08F2AE249
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbgKJV71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:59:27 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:59:27 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id l12so61585ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34u/FsKjU5JEH21Mbeeqb1FNSVhPfOUCDpBOlpNDehc=;
        b=QSH8GEAkf83/tL0jZ9bgHJVnBUW/8KF0qTiX/oMhQ7Ta4RRwLsp7FWr2ASOBbbvMW8
         9rGLOCCIdI4Q6kapvVWuqwP8Ic3QAL25Vf2dkMH+/wJAICUjUc0HFY+l9ekvDVY2UKAe
         xCjMRDeYWv9okRZ6p8nsOHMJ+qf95Dr1eLHEA6kIqsm64lk9vpqZT3qIgB24GmSZYJn0
         qhzNjR1cx6ZXw9gPhfbPVNaxaRenMn7FKQBKcZ9bVfdQDuoSCpDrDDR73vWRwlqZ+q5+
         i/ihpPE1IaKTrCsjqxJ7kumDNuXqhpzwPrI/Ey/6DdxmHHOaksGhQtoSHEEeK8k87Co4
         0RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34u/FsKjU5JEH21Mbeeqb1FNSVhPfOUCDpBOlpNDehc=;
        b=GXsmtnFEbZBK26NZzpMc/IomBMRtBvqppz5bLnR9yZtOXwgbaBgAUsfbGd3GzILzL5
         BkpSaBSsFHGH3lR3GyHdLjAAGTLzePh8RVLViiCB2hGlLkuqJfWDU/vE1MyxHjCGiVWb
         uWgR4ND8elHnwMkk7vpTBUxcTkrRU1Ic26hLDQALEZa7op4bpf8ItyJKiVXsnpkKMhyX
         +3vb+oscEUR/SZDzkiNot8h1dVToPgMqYQV7P+XqcPkmlSEeActnQuWXD7I7ECwEkpiR
         XbbeGojwn/cRhHHU2qG5Ht3mIeJqzsUi0BHhyhmwC/6HQEJJQg8TT+grMaXcyPEzmqyy
         9phQ==
X-Gm-Message-State: AOAM530bbofwZ7iBKibWZiWBaaJHbCcHI9ZVKps0RsNaWbVu3xniEfdZ
        N+iVmS2tUH83KjcHmJVJylxFUw==
X-Google-Smtp-Source: ABdhPJzhsZ+ENqTCiV4KCRGDhG8JZJ7lEftSNWX0XUsfw4V+fx3xTndq+mto2M62r+HsJZC890cKRw==
X-Received: by 2002:a92:9f0c:: with SMTP id u12mr17100337ili.113.1605045566474;
        Tue, 10 Nov 2020 13:59:26 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d142sm102010iof.43.2020.11.10.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:59:25 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: GSI register consolidation
Date:   Tue, 10 Nov 2020 15:59:16 -0600
Message-Id: <20201110215922.23514-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series rearranges and consolidates some GSI register
definitions.  Its general aim is to make things more
consistent, by:
  - Using enumerated types to define the values held in GSI register
    fields
  - Defining field values in "gsi_reg.h", together with the
    definition of the register (and field) that holds them
  - Format enumerated type members consistently, with hexidecimal
    numeric values, and assignments aligned on the same column

There is one checkpatch "CHECK" warning requesting a blank line; I
ignored that because my intention was to group certain definitions.

					-Alex

Alex Elder (6):
  net: ipa: define GSI interrupt types with enums
  net: ipa: use common value for channel type and protocol
  net: ipa: move channel type values into "gsi_reg.h"
  net: ipa: move GSI error values into "gsi_reg.h"
  net: ipa: move GSI command opcode values into "gsi_reg.h"
  net: ipa: use enumerated types for GSI field values

 drivers/net/ipa/gsi.c     | 89 +++++++-----------------------------
 drivers/net/ipa/gsi_reg.h | 95 +++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 91 deletions(-)

-- 
2.20.1


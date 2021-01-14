Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4202F6030
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbhANLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbhANLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:36:34 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:48 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j1so2772332pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TktqevA8aRkFmrMbxkkdvPIFhPHaEZezQz/aoRFVng=;
        b=TNUSFgpjYqY77U3gHE2sLGc/y6BYcTK8p+HT7WVOwP7WSCt01u5I0UNjyaBQvJ+HiI
         nCDVv7XvnNyX9yNXGluQsDOln7AewWmnUc+5rE3sHdyhCLcxSg/akxlIT/0MPvP3jaoc
         uq71J03wV2VT1Igm2NIYqz+GT2JesUb6j8+38zYAn3Vfk+tSSP8nP7e0uYiV1AqleAd2
         aeRNSZBfK0x6S1zdK2wsd4M8cMs6s1lscVtIO8creMkqzHCr6vNR7wAaMQ6vsMLHYHWC
         v1OuT3Pk4uMAp8MGVyWWnvfByGZxQVfI9foicND7QUOOs7tqE4crjxsJ/sCVdC5GjC1X
         bZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TktqevA8aRkFmrMbxkkdvPIFhPHaEZezQz/aoRFVng=;
        b=QePHj9zXZSr4DrlNCKD8qkKJX7TpoCHLBZYzqAjqqbPbdaoclZCqKeAAPUxryeeO5N
         yd4AvOEQlOlo7PfHmzGwA/FXtpYPa11CyU5zVY/pzsl9c1poIkhOCNd23ZdUO4DfkcoI
         o85kHUodq5yPnBQ8ZxdZBcpoVpWW6xCP5dhgerFxZUn9A/D77X9awEd9isZzgI1TnCTA
         C0DDLHSYJCOiKeltqonTPuIuMzBp3GKX+bffeN0Z49nhsse2DpYDyZzMeCfmJgfR3u6o
         1qqdeFnboA8MFR4ddYyNi2Q5YOmBbGH9+SI5wt7ZLnTzkbHfTDoOL3vKCQ//lK83yXC5
         J6CA==
X-Gm-Message-State: AOAM530PHsEw+uTZQHsyEXa1FoVS0cNvMCgsJfVlxGaOzaOFPiBV6ROS
        hhyoqloGqkiwPDjl0o+n3mjcAQ==
X-Google-Smtp-Source: ABdhPJxnBNQDkI/AQYrAgqsSsn8eW5JbHXkD8iJf7xwnkeQLAJ0B0iT8Ad6kIb/jJX22k9gZrEuWJw==
X-Received: by 2002:a17:90a:fc8e:: with SMTP id ci14mr4633127pjb.181.1610624147623;
        Thu, 14 Jan 2021 03:35:47 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id z3sm5160679pfq.89.2021.01.14.03.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:35:47 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Brian Cain <bcain@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] arch: hexagon: Don't select HAVE_OPROFILE
Date:   Thu, 14 Jan 2021 17:05:17 +0530
Message-Id: <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "oprofile" user-space tools don't use the kernel OPROFILE support
any more, and haven't in a long time. User-space has been converted to
the perf interfaces.

Don't select HAVE_OPROFILE for hexagon anymore.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 6e00c16a36b5..44a409967af1 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -7,7 +7,6 @@ config HEXAGON
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
-	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
-- 
2.25.0.rc1.19.g042ed3e048af


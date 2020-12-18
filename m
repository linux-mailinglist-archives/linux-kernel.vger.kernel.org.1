Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62F2DDF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgLRIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLRIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:12:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22864C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 00:11:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v14so1429506wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J4+WRUOVvjgeuDQuczNvQoHzRDmKAjYM9upWC4MOLY0=;
        b=fZ+ogRG5SnnrxPFEAf76aM5POZ6jWaIQcQz0kKvu2hg4JCrWqT0Yxk3f3JuzTYBkYD
         jJ2wVKATeDh4qcpfJrFgnyZan1KLLKtMHgagm1rP4tur1VBblGti6A7ajC/TMYP0lOeR
         robbtuZXqwGqpEGokyVtOg0aX2OAIzfnsKAiLskzNiY8Rvt5HNzc85qq3AN+/6GJOmkw
         pqOePWBQUEPk+hGsZA74cDiTH/4WC9Q+UYs5/y4ydE+ODCv3et3/fo65apG1Gq6gj6h5
         crUn4eRVBH6nK/lYL20Pdi+/PdgPW+WKJVRqOVmbwkjWUmSlp9wFoyEPIsxJfrZ/m2/X
         Vqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J4+WRUOVvjgeuDQuczNvQoHzRDmKAjYM9upWC4MOLY0=;
        b=ksh6AfCK1ZUk1wHCiJko9IaiMlOxadbLjskc9wN5EfFJpmj+T2U58U/n0qH+iuXjIV
         TajVsiWz/E67C2bLOH14g9a5PBeaQHap6QsMUfoFfeW7QVCE1ksOYgVNSz8LxWOvD3Wn
         G+E7fMQ4+ARetVA+iH25Et9r2nNKRyCbATAlKqfALYD4ZQmn1af15nw42NQa49oUxNix
         KW0GSiSBsCYfCJTnyAZb5skW2UISq90AJK72j29IjzIvdCoYBt/Kt4CiQCJSdDN8nC76
         rcgHAt0D62EFz6ruIzJ6TDc64SAT3EjyfWTfmAQOBQv0mH5F6xSbQNdbySIDjaub/Nh6
         W7+w==
X-Gm-Message-State: AOAM5335DWkVnenGc5+xyiabWrElBiI/yk2qn5ix1AfGtyuAT0jANxl8
        l0HVQD7Yb3YHTWv2rG5cQw11TQ==
X-Google-Smtp-Source: ABdhPJxxIvPozHNLtLiLzic9XlUEp5gsTY143T7fnSR74l/1SlnjDojLV3AXs5bkd58D710E7PsaUQ==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr3025085wmc.187.1608279112621;
        Fri, 18 Dec 2020 00:11:52 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead? ([2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead])
        by smtp.googlemail.com with ESMTPSA id u9sm5796202wmb.32.2020.12.18.00.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 00:11:51 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.11 #2
Message-ID: <bdda0e0b-56b7-025b-ad86-f790517c65b8@linaro.org>
Date:   Fri, 18 Dec 2020 09:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

please consider this trivial change which fall into the cracks. It adds
a couple of ids in a array.

The following changes since commit 4401117bf7fc11dc738c0963fa0c94814abc8dcd:

  thermal/drivers/devfreq_cooling: Fix the build when !ENERGY_MODEL
(2020-12-15 17:03:56 +0100)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.11-2-rc1

for you to fetch changes up to 67698880ac9d56367ebf22f8336ccab6234f9feb:

  thermal: int340x: Support Alder Lake (2020-12-17 15:29:30 +0100)

----------------------------------------------------------------
- Add Alder Lake support ACPI ids (Srinivas Pandruvada)

----------------------------------------------------------------
Srinivas Pandruvada (1):
      thermal: int340x: Support Alder Lake

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 2 files changed, 2 insertions(+)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

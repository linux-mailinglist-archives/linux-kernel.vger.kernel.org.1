Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A782EF127
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhAHLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbhAHLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:17:38 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377AC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:16:57 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id h10so6033491pfo.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/XWdQvC1a7Oc8D7QxXhIReTPnOWlmRBh0y1lPu5q2g=;
        b=icksVoKDYYNfn5rdwnSOBcMLNlP6MhJd2ZFb/pONRQBEQzS38LrULGYD2h3Q3HrxGH
         ubIA73q3SDojeHSyhDNbeX6rNQnRIx+Eo78DxysU/CoUQbIQ94YYzoZUUURr9LYuEEmh
         ao9fjibWRXkhsDvBL8MAt5Ou3qKFVK9ZtWekdxSjEr6sb1hlUN2ZaS1oxe9PN1oJizF3
         eKKCdOiDStswsUuWwRlukYAicKR/BnPiIT6Ajh5J32xTdo9SE2KfqlfCEZUbn8bpjBjO
         DbVvkGSmO1oBKAnRLVmjvc7uyYdW5/GwHelli3ksUooaDHMAeprRwtnTZW7+zJY30pX1
         ZtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/XWdQvC1a7Oc8D7QxXhIReTPnOWlmRBh0y1lPu5q2g=;
        b=WRIQqwnJ431/CtoIatZLNL+BuGARmGXN05y9CoWYL7SILtkPbZeWgNlh42wOPBWLT0
         nYpcscK4miwkdHXIRkAYieRM402Vq148CeTIzeF7TgaKLTDTxIvGayy2kYYCgOuh9VIM
         0VOvByFb8YZrIRFnMfXabXmf+xV23pTH8FAoXdZqSEoXXW9JUxFuriaBxuQkvxYY5kW4
         8AP2aCGI0xM9/hZwCYpcWqNB/hQfARqf/GxJ0QfBJ36VcAf6XMKdZaiznFaLQ8fM3w2v
         Hb8WWu6phMo/tspkqmGBEp+XuTeZND6SB1hd2iNkGOrbWQrYAm9zbcTckDcHc21lgB1R
         anZw==
X-Gm-Message-State: AOAM533HgK1niAbgpISe55qly7NlWMgWYoqadiLENEQ+ynM7srDjAjlH
        74o9EXv1yJwK2CzFlYOJXvjEAQ==
X-Google-Smtp-Source: ABdhPJyUnRgZNlqgTFgRb3iIu3JSH9H7Ol328tXDqCK8GlfctTgvTf23aTGBnb+vqPe1YzQsS3R8pQ==
X-Received: by 2002:a62:fc4f:0:b029:19d:d060:27ca with SMTP id e76-20020a62fc4f0000b029019dd06027camr3154919pfh.66.1610104617471;
        Fri, 08 Jan 2021 03:16:57 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id 8sm9767211pgx.48.2021.01.08.03.16.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:16:56 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/3] arm64: topology: improvements
Date:   Fri,  8 Jan 2021 16:46:50 +0530
Message-Id: <cover.1610104461.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the V4 with the general improvements for topology stuff. This
cleans up the code and makes it work with cpufreq modules.

V4:
- Added Rby from Ionela.
- In 3/3, Print cpus instead of amu_fie_cpus and make it pr_debug
  instead.

Viresh Kumar (3):
  arm64: topology: Avoid the have_policy check
  arm64: topology: Reorder init_amu_fie() a bit
  arm64: topology: Make AMUs work with modular cpufreq drivers

 arch/arm64/kernel/topology.c | 115 +++++++++++++++++------------------
 1 file changed, 56 insertions(+), 59 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af


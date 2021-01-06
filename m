Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365A2EBEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAFNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:35:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF74C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:34:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so4947019ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V9B7raZK8rBhLHZShdZs4HBw8U5jiarf7Kd3iXod1S4=;
        b=IU1FORvnf+xQqvabn4tC7CrK/8aJwG12BHhqr4q0H/6nbUp4ZArqQm1RqR/MUXsESO
         OG9sRm//0YQXXqsq83vwnwxtrqb4Zxb6mGA9b4LpX8gFvvYSvjQy2+8vRx405MeHyKJ1
         79BOBMEpl9S09ZX2XsfNXfo753aXs62WvOPkSKyj1qeBIa6UtfMNKdEpGdlhuYbmau3/
         IuS+YCs2bi0TSZyEsfeznp6EtqXPmpGxx7Jyc6/RRcxBgNKuWMxpdXbNYoQN/B4AQ9LB
         SoiT/iIv/zjhD6guKw+ZF7rVUJm9jwh7raYbmdcNwILte7KQFFJ5NQV/qg1UUOvU2xOu
         RFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V9B7raZK8rBhLHZShdZs4HBw8U5jiarf7Kd3iXod1S4=;
        b=oeeIdhXVEps50PGYlofYlzaauoZDRHEIjLwHEwN4woj0aazBBAhp+w39kJuO/oVF6t
         IUnIibRMNRiGFC29i3ziW6pclLHmZKyRvsJLLSGUiGJQ/JgFwc8CCkqEyuzsxDZ9nv+n
         IaoBrAPhlkVFI4DYhBBulmgHkA0YpIJKgc93NVac71eWwVFt1qzmz3pZgw0VyK4CDIUP
         S8O2N/TnoxcHJLdVBvbWsujUQ7PsDfJ3msJYMRUu9j0eLjqXSDB/jAJdJiPmEzLC1aRe
         JG7w6QJ8XdpDFjzj3l5oyfmgPv/Nf3sclWL76FmcQzY4b2RBX9uC5rmVFCX9LZHvSSiO
         lqqw==
X-Gm-Message-State: AOAM533UdXO7f/RWzmOeUB5G/6snl88rPoithPr6+XhcWMH8awH62Z6y
        lbYNRMtUdNtwbBJ03ensHmnJEg==
X-Google-Smtp-Source: ABdhPJwXZeF/MER2CmxzcU/8w2RFz3tdx+z89+U9r7kHVEdZr7z8eKgc24+fXZhvtSh8BZ6AReRuyg==
X-Received: by 2002:a17:906:a011:: with SMTP id p17mr2848366ejy.30.1609940082510;
        Wed, 06 Jan 2021 05:34:42 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b599:da0e:e83d:2b44])
        by smtp.gmail.com with ESMTPSA id u24sm1264081eje.71.2021.01.06.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:34:41 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/3] Reduce number of active LB
Date:   Wed,  6 Jan 2021 14:34:16 +0100
Message-Id: <20210106133419.2971-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few improvements related to active LB and the increase of LB interval.
I haven't seen any performcne impact on various benchmarks except for 
  -stress-ng mmapfork : +4.54% on my octo-core arm64
But this was somewhat expected as the changes impact mainly corner cases.

Vincent Guittot (3):
  sched/fair: skip idle cfs_rq
  sched/fair: don't set LBF_ALL_PINNED unnecessarily
  sched/fair: reduce cases for active balance

 kernel/sched/fair.c | 51 ++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

-- 
2.17.1


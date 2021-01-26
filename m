Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1366303CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbhAZM1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404446AbhAZKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:51:59 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63DCC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so2024045wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db4DEJ/Q3N9d5WkZ8df7AudDavBMLE/1f2NlVKxQEYc=;
        b=bJDXC2xJZS7knr6BW2QWR8M8TSd0BR+jcFln03nh0fNQax817QqmDhTQaYwzcomcIl
         5YGDhdc6N6im+5Eqx5VrrMi9zyD7rc/fhsPvns6iiBvdbfoiox3Tf8lyRkBfVORwtnn+
         Ti5+OzxAtiZGa50gUVEhgUtGCn41lAGTBmGEhPpjotAgvQ1phHe4z2zALtIGVlwoDcTi
         w90Ft9Km+r4MxDyNB2Ru/mcdTQ0TRDX1wlemfB2yK42g4QfxFSRh6OeZ2USQn7/HJ+4R
         EDUna/KZP+I70HioD5w0lXzl7G/iRxFJFN+yFMPhGiowrbBQpR7IVzBNxWi/YQXevdsZ
         nIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db4DEJ/Q3N9d5WkZ8df7AudDavBMLE/1f2NlVKxQEYc=;
        b=YwvWQgyqX8me2Rm8x19lKFSi5CVk2lWwcfmipnWbqdvpFcWvg+mjllstRE9vh/Ej1x
         /bpCU8UgJAZCMODv1oxZRmO4vkewkVqIYS9dqaDMoyiFj2YqRk5fOiXSJGJfIPd8r3Rs
         uwuuYlOb+rcXDl1VOHbT3Dy6xz3QQE0fZ6GnxXszGjrbr77/ioDJ51iU7K/HYQXZKVuV
         31r/yAkkl22TzXDNlz1QdtInSt515owj/0lGudhT2BNXW6wryeCWvbHFwg/bPHbhdYiG
         DJ31bLgvXOwdr5HYucA1X3DpWPR1AH/oVISgRrCgSqMXx6NyzsX49/xS3QyVNNRc4nvO
         LBCA==
X-Gm-Message-State: AOAM532PpoDKd5fXHVKQBiTkaf4wjs7xGqm9DqjIhLDmA8CK8WEBFFrb
        GqNzbhIXSxdifDUAuGRueeYxFw==
X-Google-Smtp-Source: ABdhPJxoS0T4r1Eh0KBwNxa9jC0eIUTyCqRnQWHyZXkLnzTtqnA+eozhZd6XzKMfp0e9nXlw77AalQ==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr4044123wme.175.1611658277465;
        Tue, 26 Jan 2021 02:51:17 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:16 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: third and last batch of fixes and improvements
Date:   Tue, 26 Jan 2021 11:50:56 +0100
Message-Id: <20210126105102.53102-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here's batch 3/3.

Thanks,
Paolo

Paolo Valente (6):
  block, bfq: always inject I/O of queues blocked by wakers
  block, bfq: put reqs of waker and woken in dispatch list
  block, bfq: make shared queues inherit wakers
  block, bfq: fix weight-raising resume with !low_latency
  block, bfq: keep shared queues out of the waker mechanism
  block, bfq: merge bursts of newly-created queues

 block/bfq-cgroup.c  |   2 +
 block/bfq-iosched.c | 362 +++++++++++++++++++++++++++++++++++++++++---
 block/bfq-iosched.h |  15 ++
 block/bfq-wf2q.c    |   8 +
 4 files changed, 365 insertions(+), 22 deletions(-)

--
2.20.1

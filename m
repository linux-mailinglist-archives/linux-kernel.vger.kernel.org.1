Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF502B9F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKTAKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKTAKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:10:52 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A6C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:10:52 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id y17so10409547ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7dG0dg4E3NLlKUFNDbFJJFxzbQvFvgfvzbTLirmjNk4=;
        b=i8GUgZ5XXzaDNy811FBeq9/DdfF5OWAgeDJDJmcZiq9KhFIo1tNWkdVosgQ1BkN/Dq
         yzxWnA2w2+bGqyIJ3dzGPf8T9uiFHq1pjKgRqb/jgMH5ZJtut++ejYtayHvfclowlhZR
         DDNsq0PCzHC14EfgviGiflnDaQdHcuTcMJWkqiWG2ePa1OTYbi7j348s5eIEfCaczNkR
         EZrzeIFGBoRyCKMOaTCBypxl3lq5wGSD0rGPtrkAGs4lcoKnupnB0EnpQr9kMpEnYsqH
         tQXQj/kUZ1kNTsG15pZEbUxMiMd32weR2WJ5eKB4RCuSlhR5pjz2bGGw6Zda5yHL7WCk
         xl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7dG0dg4E3NLlKUFNDbFJJFxzbQvFvgfvzbTLirmjNk4=;
        b=bqy8mWC1aUSMvSPGQnprp2HLYFWvjEgEfCovyv2s8PTRV+iiOpoZ6n2vvXRgomlUv/
         D2k+0K7Ii0cdXMMpRz7AUnW3ab/B9ObdOLiyTSnoHvh9MGPblHg9OxFAEYbquYSiS7kh
         pLjedU2W/5jW+T3D7chENKF0a4EnJwkJfnRxwNSS88VW4HAtty+HggsQwDP3sHTi5ABF
         ZQEwZXuz15kltsKG00RqRjwZV4TU7lu4yEKj41BTH+TYA449YHYwmA+UNIF4JMPSq/QS
         wWDIGijvXRfufbAkOLJ0zdxeTalU3fAbfWC+mK1Aj+NQVrvYcbg5I4CVh8GEGYuwUASN
         0zjQ==
X-Gm-Message-State: AOAM533GNudzOm0Uhqyn63Ozb3gQLpJCQZY7DmVUAlUeFPtDS4QkCmrc
        RGBuaxUJM3MhOoryy4aUNlHaFv8WP1Dx34aA
X-Google-Smtp-Source: ABdhPJz4wSwCpoWSimdFX3rb6VO9QZZLwOIpG3VZbypdf2mZjHX3BdpMPferAgvq2Ep9LxytE0gq7A==
X-Received: by 2002:a17:906:5841:: with SMTP id h1mr29897557ejs.342.1605831050673;
        Thu, 19 Nov 2020 16:10:50 -0800 (PST)
Received: from localhost.localdomain (hst-221-4.medicom.bg. [84.238.221.4])
        by smtp.gmail.com with ESMTPSA id k23sm383556edv.97.2020.11.19.16.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 16:10:50 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/3] Venus encoder improvements
Date:   Fri, 20 Nov 2020 02:10:34 +0200
Message-Id: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a series which aims to improve encoder staility.

 * 1/3 makes encoder init session to be issued only once.
 * 2/3 refuse to open the encoders/decoders session beyond the
   limit
 * 3/3 forces firmware to raise soft interrupt when acknowledge
   a synchronous command 

Comments are welcome!

regards,
Stan

Stanimir Varbanov (2):
  venus: venc: Init the session only once in queue_setup
  venus: Limit HFI sessions to the maximum supported

Vikash Garodia (1):
  media: hfi_venus: Request interrupt for sync cmds

 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/hfi.c       | 19 +++-
 .../media/platform/qcom/venus/hfi_parser.c    |  3 +
 drivers/media/platform/qcom/venus/hfi_venus.c | 74 +++++++-------
 drivers/media/platform/qcom/venus/venc.c      | 98 ++++++++++++++-----
 5 files changed, 133 insertions(+), 62 deletions(-)

-- 
2.17.1


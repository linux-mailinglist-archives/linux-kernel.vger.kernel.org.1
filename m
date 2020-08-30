Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD2256F56
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgH3Qax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 12:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgH3Qaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598805050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mYvzFBs63TbpVmhIX3wGRs+LwFoNle22iFtiQP17T/I=;
        b=IPaM3F0ETL6IvtVvdhHK9dI5IddMLMm+2MRUDpBDVaZ0calwpRaDba59O3WTd02TJawiCi
        xbsvefg95k3G0qFm9QhP1IqyQ7fz2iZy7OIH9DFu9kQjfhqDem3ti0OzHw9UzWBP4HWoiP
        vph7LqY3bpfUSjZP8mwdSWYYqUyhiQ0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-4m_jXl6OOZ-COJelsytctQ-1; Sun, 30 Aug 2020 12:30:48 -0400
X-MC-Unique: 4m_jXl6OOZ-COJelsytctQ-1
Received: by mail-il1-f200.google.com with SMTP id f20so3415191ilg.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 09:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mYvzFBs63TbpVmhIX3wGRs+LwFoNle22iFtiQP17T/I=;
        b=SJvFewlp/Q9X+h5vVSmpdMAgp6f7pPOeLr6IENKWt8nLUQjLi04YTyR4634/o0Ojw3
         pLIrYkUQild3PgyJumTZJHir4l2ulYTcXeY363VWLQb3CgvawRI2dIIKegGYpFmJLkbU
         cPnbscBa3I70lypLLNq0JnzSU+3+If6uYycWJpcaem4lHn20/pZJ2mLPe3+j27Fg1AWw
         j311xAoBivl8kw5Y6PhC+gLEj47AhSDTLpsmKoWVquEvP3ObFXNhcq2dCD2cYz6FBGbs
         M6YbezmGVZp+D+v2QM3jG67fYfkLh/v5n7Odl4nt/rrUYlwbFQFxgw8rF7P0LZd8G4Qh
         uYdA==
X-Gm-Message-State: AOAM530hTB9COMHowUjSnUQp5617QWBrLR81EVtSdzgjhACQKyxqiGfe
        aJacNLAYFvsHx1tqnfPl1/9jH/ZBxKZV9OcjQ01CN1nCuZiTXnRI9lRIg7o2bTSO4VwQ67bJxmo
        /rU0usxtJVZeOCqRTBBd05qVo
X-Received: by 2002:a5e:8c0c:: with SMTP id n12mr5694770ioj.147.1598805048117;
        Sun, 30 Aug 2020 09:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwObfN6L0TDNnE8gtLMDpGDLrvSEVrNnpNznkakgT9w+mf7UKzkbWb/k5DT7vV3OKKAEbjvCQ==
X-Received: by 2002:a5e:8c0c:: with SMTP id n12mr5694763ioj.147.1598805047936;
        Sun, 30 Aug 2020 09:30:47 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k18sm3104399ils.42.2020.08.30.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 09:30:47 -0700 (PDT)
From:   trix@redhat.com
To:     matrandg@cisco.com, mchehab@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, p.zabel@pengutronix.de,
        hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: tc358743: initialize variable
Date:   Sun, 30 Aug 2020 09:30:43 -0700
Message-Id: <20200830163043.10317-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

tc358743.c:1468:9: warning: Branch condition evaluates
  to a garbage value
        return handled ? IRQ_HANDLED : IRQ_NONE;
               ^~~~~~~
handled should be initialized to false.

Fixes: d747b806abf4 ("[media] tc358743: add direct interrupt handling")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/tc358743.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index a03dcab5ce61..c724bd1591de 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1461,7 +1461,7 @@ static int tc358743_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
 static irqreturn_t tc358743_irq_handler(int irq, void *dev_id)
 {
 	struct tc358743_state *state = dev_id;
-	bool handled;
+	bool handled = false;
 
 	tc358743_isr(&state->sd, 0, &handled);
 
-- 
2.18.1


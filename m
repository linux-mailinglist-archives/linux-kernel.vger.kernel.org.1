Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894D62DC80C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgLPU6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgLPU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:58:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825BC06179C;
        Wed, 16 Dec 2020 12:58:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so7652051plx.0;
        Wed, 16 Dec 2020 12:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rHPKvXbd9G4NLF4cwZueyf4EbXXpqooiJbiYonUVyEw=;
        b=s/lp7BmDfEgRxo2mtqf4bvWmOOwnCzUUIL1qQV7kWdKtAU9XneYtVTfdRr8P/um6ja
         3NNiG9P3JBYddyLUUhywdiIr9KgIr8Pi89Gf/UTOYGHjWsaZkjHNWpVVhFC0kLgfdXp+
         WQQ1exDp9scHpMNje/uoraTdE7trp6mK+4ilVdrjW/guXWyqEFMMsO1pEoII2PistUZ1
         VxDrBrnt0+ysFfFUlPajov/pJLZ0tSoXvXoSb0kE2D/cb4mDr0qwVW5SIVcleVNSlWIr
         rXMiqllGyKCT7orPUAqPlIiMdhgHAZ2n60fG/bHDV43e2XBfkeAWqkiT+8/cl/NQn2rN
         dT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rHPKvXbd9G4NLF4cwZueyf4EbXXpqooiJbiYonUVyEw=;
        b=mksBp2vQI0PzEd9UDhy8RbmOG5fzsNe4yjku2p17yeNQO6GN+w2KTOD7fNhS/ZGjn1
         ixb1mvNzYA1xPe+6Nlw7ivZnqqBrXFb9S5xStZSeS5ofY2A7LiStW/WwvObhlCp+9NrH
         WpgrMhRrif1nu+XjKqlNgoydn5JkOop7NMUrflQwLyaS6UkVRNvDeBeZ+UAjamQ3Vj1y
         YTXNRiDmu8T2EoXFngLvnQzNRjbi4VMS1XaCOM+QUAOzGENEmR6b7Ui1M6vvT5ae2liW
         wALF7DyCQOs/m3wmcUj6Oa7MhmBVujJVjzUBpSjEOh87hszbFEtJ73wDLFMnyeFVYNlh
         n19w==
X-Gm-Message-State: AOAM533TYN5MuZXWzYWd03pd1xYmaqy5zub2v1SDN0hD6imCuf13HQeX
        vIhIDe8QlowUkfMPQS7in4k=
X-Google-Smtp-Source: ABdhPJyAFcmGVTr5r3IS0nJFwkJ+LTIMmCBS8hNICI/p6QYeCePdT2L/XTNESAmmo9VXk3AW9M6fgQ==
X-Received: by 2002:a17:90b:242:: with SMTP id fz2mr4709349pjb.39.1608152292683;
        Wed, 16 Dec 2020 12:58:12 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id fs12sm2866598pjb.49.2020.12.16.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:58:12 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
X-Google-Original-From: Jim Quinlan <james.quinlan@broadcom.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Wed, 16 Dec 2020 15:58:00 -0500
Message-Id: <20201216205805.4221-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -- Changed interrupt name from "message-serviced" to "a2p" (RobH)

v2 -- Correct commit message, s/msg/message/, and remove extra WS on
      "dt-bindings" commit (Sudeep)
   -- Change interrupt name to "message-serviced", move irq assignent to end
      of function. (Sudeep)

v1 -- original.


Jim Quinlan (2):
  dt-bindings: arm: Add optional interrupt to smc/hvc SCMI transport
  firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt

 .../devicetree/bindings/arm/arm,scmi.txt      |  8 ++++
 drivers/firmware/arm_scmi/smc.c               | 38 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.17.1


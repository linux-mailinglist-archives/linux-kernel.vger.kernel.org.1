Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727F29A6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509319AbgJ0IsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:48:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509311AbgJ0IsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:48:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id e7so495315pfn.12;
        Tue, 27 Oct 2020 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9TLfBrV8KVh23L/Op4SjOv1GP4gPCDdsTo4qQcDWpA=;
        b=M8jUjs7gzNU2l2qVUoCGysqaatA/6NOzhGxtdbdVUUWy9tdei6Nbyiimdli+KWw6wT
         a4ilVPjpJJkW9hLP3qPtQ8VKjt1q/IqOfrvt6ySS4ZUhwbNXjgdz7n/g9IV0a44dFdHb
         HGO6/7ldKaNrJxtLogb+E2eoW8TKOAzL65FcYlEuW/VnC/Z7yROxzEFGKRIVRw8cT2BF
         6GMMYjD44OgvwRh+6BmZdOMk/yDwDb5qXnwCpcgPGpwP4OFMYvkU/dqlpNp/XuR07N9k
         PWrXk323g11fTNGNORkklKcRQ7u75ebcNajPbG85I9SAzZEpF+4YurylbziYtKyGRCt5
         Awgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9TLfBrV8KVh23L/Op4SjOv1GP4gPCDdsTo4qQcDWpA=;
        b=N34AaZLUeFXttmYcF9rCOShHMmqT+UH1BkfU3Fa5ffxv4KeH52ux5wg//RciKskTiE
         gAK4ek7HWeX8wGUr3ULC8pvdah+XWliCbdfeI/fG1lADGuKigVBVcB1FyT76mKS3zwtZ
         Qt3ZGkYVEgsk5Ih9lnVP6N+NwlMUcV94NDRt8IrkGLlEDT9OZ1x0RVcgP9IF/zXAcX3N
         I/zHNlchz0ViNzmdpe3yS3JDPf2Y/Bvf4sNPJEfZndr0Q7NQDJTHHKOkRWw15AX2OjLe
         0YKdK1UMfb+jUjgBkVec2d++F9GifYIl4AS4jgSFpnHOsuF+pGOT4jtdi4Wd9LBDXSiI
         Y3HA==
X-Gm-Message-State: AOAM530etnY8wV7uuh3Zy9xF6kZGlaQAol+OvRNHs2HNZvHotLsm3B0T
        upNux6j5ScwL6FchzXXI7e0=
X-Google-Smtp-Source: ABdhPJwAGRiB4Q38wB9HnWPNumWqsfuNe6Q7apetu59MEWhOfD71OuJWw5rpXcwkcX1gsaloHB91Cg==
X-Received: by 2002:a62:1ace:0:b029:163:9dce:5496 with SMTP id a197-20020a621ace0000b02901639dce5496mr1199205pfa.72.1603788491958;
        Tue, 27 Oct 2020 01:48:11 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id n7sm1291988pgk.70.2020.10.27.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:48:11 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH 0/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Date:   Tue, 27 Oct 2020 16:48:02 +0800
Message-Id: <20201027084803.17368-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add FriendlyArm NanoPi R1 support.

Wiki:
http://wiki.friendlyarm.com/wiki/index.php/NanoPi_R1

Schematic:
http://wiki.friendlyarm.com/wiki/images/a/ab/NanoPi_R1_V1.0_1809-Schematic.pdf

Yu-Tung Chang (1):
  ARM: dts: sun8i: h3: Add initial NanoPi R1 support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 199 ++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts

-- 
2.29.0


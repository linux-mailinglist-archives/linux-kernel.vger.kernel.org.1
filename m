Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602D22EF490
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhAHPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAHPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:11:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D7C061380;
        Fri,  8 Jan 2021 07:10:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw27so11522760edb.5;
        Fri, 08 Jan 2021 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv1Cd7yjkWa6SiXfOYc2/ThBFnWGdgOOaqiI+T4YVvU=;
        b=ISM7io9NxWtXYCEJtzD7rih2PcZf6Tj6x7AZQjcYcYbWq7SWTPmFan4+UF/rxApTTY
         5UgYkmt/sIsRaGz/tnXGGnn2HcLGvqlqtWhDDkeQiIqmh/klcBRG4rUDxgEUNPkdr436
         UyylC4fRDqE+5y5uC8DyQVykfkjSl0m58sjot2xy+NZHVg6Ti28gduJ1kBR8nrmitBfa
         lJpebXYagcD8TCwENvbEkHybXRFw5LIYG5+glipe2W+KQhCx/L7nWATxkK06X+3zD0WS
         FBOxgcvlqnk33vJkzrnRUfbb59qod+6TgTgehgjoFX2ZQ7fLiRwtLOuYfLkBMUUGAD5N
         IiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv1Cd7yjkWa6SiXfOYc2/ThBFnWGdgOOaqiI+T4YVvU=;
        b=fxk02B6QuRmtgawzRJYhydgRwaqM2m6uw+nIO9bHSjwMkqMVh2EN3RTeGeY30fkeEX
         5faj/SREkfwgEJIRJ0B5MCWFax6n14c0utK0sXKHQQOZ9n/J8KfDAoWW8/l1c1Jjl/kU
         x9txWlfhFWaVQRx+HF7nlQv73gAFLlzpee3B2wqB6XFJAwvUCXtmjDY8v0Vrw4dEHnaW
         66FIXY0PMZpSHXnmVClOG6mtQ5moJCxrLZPyzTG/d4AKQYRA4UzBXImENoc3zqVLR4/U
         Ic8Iaao/cXAMdLNTtPhJ6ywa4q/KICDS1bXoLoTQMtIDLLtcaBvlPmFMGFybJ3n6VG5w
         /sEQ==
X-Gm-Message-State: AOAM531w4+TnW0OIcNh1Id9KjonNWhhlP7dtf08tW6KqBGCvHz6WILmr
        HpoSweK11J9OF3DHsznUxw==
X-Google-Smtp-Source: ABdhPJxoepKz8v6G+i9nSzXAadPVyX1jnM/Mpr31ibtS4FGr/ETI9yCKbb9OQz28l/TtkW85zUE0CQ==
X-Received: by 2002:a05:6402:404:: with SMTP id q4mr5788509edv.295.1610118638748;
        Fri, 08 Jan 2021 07:10:38 -0800 (PST)
Received: from demetris-TA770E3.lan ([212.50.117.154])
        by smtp.gmail.com with ESMTPSA id oq7sm3669286ejb.63.2021.01.08.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 07:10:38 -0800 (PST)
From:   Demetris Ierokipides <ierokipides.dem@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Demetris Ierokipides <ierokipides.dem@gmail.com>
Subject: [PATCH 0/2] ARM: dts: rockchip: minor tweaks for rk3288-miqi.This series adds a missing mali GPU node and two additional CPU opp points
Date:   Fri,  8 Jan 2021 17:10:34 +0200
Message-Id: <20210108151036.36434-1-ierokipides.dem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ntemis <ierokipides.dem@gmail.com>

Demetris Ierokipides (2):
  ARM: dts: rockchip: add gpu node to rk3288-miqi
  ARM: dts: rockchip: add extra cpu opp points to rk3288-miqi

 arch/arm/boot/dts/rk3288-miqi.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1A275558
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIWKMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgIWKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:12:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C4C0613CE;
        Wed, 23 Sep 2020 03:12:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q4so2972374pjh.5;
        Wed, 23 Sep 2020 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZBx9wsYnF/skErc7f9ulQ7PEZnlU/1O8MVjFVsPTO8=;
        b=QgThLIi2YwJNvJLC5O3XyS8pnwKGK6l4jwdxU8PmhTbnv1Ag78EeAaSt4QsL87g+FU
         OurFR0+ER2X1PBGVSawiQMeHbrNALz+mvMZj331lrq6JYsKDQzCO1Tv7bL4AkGjW0c2f
         Rje+V9ky0ufbdpmk6tKqE7/fpk57HgU1bL9NONBVQlpKF5bY9SMho/JpsfvXPWN98sbB
         mRrBqzdbFRBY4OX8rW7V9n6iwRQtWWO2ymVPRjPm9wJ0HSyA6NTgCM7KgymJh0y8qBUd
         ng0PYL54xhnyZ4Ec05WQzelya0s8xNNwxdG5/H1JXj4WnRgN6sqCeHPwIJ/yB2iummaw
         ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZBx9wsYnF/skErc7f9ulQ7PEZnlU/1O8MVjFVsPTO8=;
        b=OhEaUwHT0xnEIAR9MXFesZ8S02nLrYNpPUSC+JCoH5yn3hmxwGIK2ds3tVuux4XVk7
         6O09f93Acmh3T1BnRLus6qoLdCYlrjW4UVuvNDtqlledcmt74IqumBXO/eV9xwQ6kWec
         eCO0tVPwygSsr/1olBTfTUdrngbfslKWdW6EoxCNDGtGnfqmNkYud/rd8jz+QCEmxfWz
         sZnuctRmnBfNhiW0uBGGZ1ugc9S/CZ/UULUFIdQ8wj/eVlJNH6+SEW/hacy4iSxu4LI0
         EqFzyTTq3OfsDvnwxM4eNvJrsFwSk/mIPbvM2DDwqEXn2ny3i0kqcmj7w+fj3UBW9B2U
         C5iA==
X-Gm-Message-State: AOAM530c/rfpG4k/6tk/W8x+YBSaJUU+Hltkg8Zca4aDGZExSh60Abwk
        RRz4D+PlEeuA9YaOvww4WtA=
X-Google-Smtp-Source: ABdhPJxsZc5eLmECszJgF0JFdZSS86bTS61BihmO2u+ZIXxDLVz5lk+ewSyqQmtsTwIkFh52FpDyBw==
X-Received: by 2002:a17:902:146:b029:d2:5615:5700 with SMTP id 64-20020a1709020146b02900d256155700mr1715219plb.84.1600855954886;
        Wed, 23 Sep 2020 03:12:34 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id i1sm17678549pfk.21.2020.09.23.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:12:34 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        art@khadas.com, jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick@khadas.com
Subject: [PATCH 0/2] arm64: dts: rockchip: rk3399-khadas-edge: missed nodes
Date:   Wed, 23 Sep 2020 18:12:23 +0800
Message-Id: <20200923101225.1513392-1-email2tema@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Lapkin <art@khadas.com>

add missed spiflash and ir-receiver dts nodes to Khadas Edge Board

Artem Lapkin (2):
  arm64: dts: rockchip: rk3399-khadas-edge: add missed spiflash node
  arm64: dts: rockchip: rk3399-khadas-edge: add missed ir-recevier and
    ir_rx pinctl nodes

 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.25.1


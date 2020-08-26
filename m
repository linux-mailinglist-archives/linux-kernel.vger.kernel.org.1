Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC2252BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgHZKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgHZKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:49:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D0C061574;
        Wed, 26 Aug 2020 03:49:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so764132pfn.11;
        Wed, 26 Aug 2020 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZdoBCKVRuvYYbqZgZKgMCJZ6Rhom1CCtkDlusoa4B08=;
        b=LllienEVsS0/YjEfXtvj5rzxdou1vCQqakXHq/OJq1M43/7W6Tuce2RiG3zpoyoenK
         xvZU1CKhfVuAvYMO1FUfFmxq/9zXDnkRUSsMVUEkO9k57kIvlvQM4a+za/PYjNyyNt84
         DvS4G2CHiG57/KJqI1BiaW0cUZ/LizVqlduxg8n36+2sxP7B0lN/dhN/RE74bWwscmMx
         ZyeiqtzgqcuIWazjMhtO3y4fmjHYkdQ+QEipKr/Tx6BFfJswaLNhq8DkEuRooKGcrj0Q
         5v7Ifi+xwuIIW9thT/QhR8ozQwp8yLuUODd1+Zhf7TLOXwklQD3NnsTEr5+dR3JpX43Z
         3uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZdoBCKVRuvYYbqZgZKgMCJZ6Rhom1CCtkDlusoa4B08=;
        b=ihS2ZqtQ44HYv46GBjmgk5x0kphq63QJiaDFhtOGcXH810ZWHMKGPPfMU7AtvQa54J
         HK6As9w8dxIxaKq35EKQvN5gMRttTjz3dz+sGCgx66EdnAVyzvn6dgNtcAUd8bCj074o
         YTpeIOAAPrWsYaXQRWga1UeRLLStN6Dr+IIUd0dlSmDsY54LHoo4A0LIuDHF+bH5UFUG
         tILahDKrAxtUtbhfRywJOnlC+MsGqWFC4JXGpNot36QdxIeT9oDf9Zki+mfSMoyuN04Z
         qEYOhBcNQ9Htn9v+KM84cWD2mMfgxEQR93FL9oMskqJTTfyoJH1OZ6VTVOQOLlhwFVqw
         rj0g==
X-Gm-Message-State: AOAM531z0h4C9DoSuIt+xBQ+3ij1bFnvyua+XsX/nNIk7tUi600AMQjL
        CFuEJhrIrojAKtVOcE0/9Is=
X-Google-Smtp-Source: ABdhPJxwc1Phv6qBxJ2Uh381P86SiHzLD+oSSBz+RODYM2sy8PuJJw64PLZ/dXz5PJcQKd5fcw1f8A==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr9908486pgd.225.1598438974128;
        Wed, 26 Aug 2020 03:49:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:2197:d2eb:7e49:dfa1:a882])
        by smtp.gmail.com with ESMTPSA id d127sm2540349pfc.175.2020.08.26.03.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 03:49:33 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v4 0/2] regulator: mt6360: Add support for MT6360 regulator
Date:   Wed, 26 Aug 2020 18:49:16 +0800
Message-Id: <1598438958-26802-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add MT6360 regulator support contains driver and binding document

Gene Chen (2)
  regulator: mt6360: Add support for MT6360 regulator
  dt-bindings: regulator: mt6360: Add DT binding

 Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml |  113 ++
 drivers/regulator/Kconfig                                         |    9 
 drivers/regulator/Makefile                                        |    1 
 drivers/regulator/mt6360-regulator.c                              |  459 ++++++++++
 include/dt-bindings/regulator/mediatek,mt6360-regulator.h         |   16 
 5 files changed, 598 insertions(+)

changelogs between v1 & v2
 - regulator: merge regmap to mfd driver for r/w with crc

changelogs between v2 & v3
 - Move regmap define to MFD parent driver
 - Add bindings document

changelogs between v3 & v4
 - replace of_node binding table by platform_id_table
 - set regulator_desc.regulators_node find dt


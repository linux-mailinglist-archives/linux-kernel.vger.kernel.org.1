Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1E1C692D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEFGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 02:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEFGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:42:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA5C061A0F;
        Tue,  5 May 2020 23:42:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so351600pgl.9;
        Tue, 05 May 2020 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Liq4U1nmJp+k1QseFVbXa0y7jGlGm2IcoibIba6bIN4=;
        b=QJXMohOTAWtXIbpZubPh2LhaWiMq0ZGIq0L2bnRHMjcmGM/qNb2cfMeJlBM5rLvlte
         T9eOd/OVDHbQWnD9mwKEjWvtsl0lZ3psBAWlOFkDkmKKLNS11BtBtYhlaIKBPxQK0L22
         NNBB5H7yrCzqTh2ZrpSlqlsBFK/9ikpvANfd+ZT86mABSQfaKlAwhE/Brp70ZaXBQSu1
         CN5fL0eDswOdCzd1tjhv87EdSymR4nUIIZ1qI+BnM5d/q/HlHuwL06b4Pg3YYcvELMgB
         DCBxUPHcHkX5kfPsYbD4mqMkAZJ+AQCY+6Szf7RjtpS+S+AR/y81bNKUJvM8e2CJ/ETY
         nuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Liq4U1nmJp+k1QseFVbXa0y7jGlGm2IcoibIba6bIN4=;
        b=cMViMU2lKnB13uqDY+Yo7zxFTPImkGp6ItWOUU7onqNnepPsTuHmMuasU9t+H2KaHN
         KWsRicuW04j0sIdpW0K+ZXusbZ3vvym1FvpdLkr+JOxZ9K9CWbOpAsbV0n9fL5TIISIr
         mYoR31/SN346ikETBXyUJU+y44Seq537ssJV+e2bYxp5/0ZQriHdg4/oi/kjriB7vCJu
         fdoOr0pg3V30MLK364RhC9dW8cWMDucERh3nemnhesS/5KdAYqbeGRda4b7ChmYQrWgE
         FG5LlEhSwsKgpwJuymo2k2cH12wQrHpZ+6MXqOul6QAZ3H4fOEHot7LD8EHogGpU6WYT
         P9Vw==
X-Gm-Message-State: AGi0PuZzkRVM1Diajb5PkLM5bn5rGEL77DjRfh3WuUJK5NvTIRCLNJwf
        Aov4jDer/CmY7Q+8ud24tFs=
X-Google-Smtp-Source: APiQypL4f1fBXLMhRTVK8DI+lv01KkC0rfikO3bHWD+7BkH2eVp9KWSsqAGBycmCNOlzG+hbh0ZLcg==
X-Received: by 2002:a63:4503:: with SMTP id s3mr5973180pga.85.1588747366086;
        Tue, 05 May 2020 23:42:46 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id b75sm3793254pjc.23.2020.05.05.23.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:42:45 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        sam@ravnborg.org
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Wed,  6 May 2020 14:42:37 +0800
Message-Id: <1588747358-31306-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix stm32f429's ltdc driver loading hang in ltdc clk enable. set clk_hw to the
wrong offset of clks in stm32f4_rcc_register_pll, should be PLL_SAI

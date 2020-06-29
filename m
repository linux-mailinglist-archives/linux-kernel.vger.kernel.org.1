Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2120DFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgF2Ujq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgF2UjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:39:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3943C061755;
        Mon, 29 Jun 2020 13:39:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a1so18153633ejg.12;
        Mon, 29 Jun 2020 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDcfDi33is5NY8p30BbC+tdqixJSzaPLxC/pjqPob+s=;
        b=D215U9PlHx8PJ9SEK+W5s386BoBCjwOl7sEWwACwHjGfRs4myi0BKaXRwKfuiF2LgH
         aTDMRGFRTdYU8Psuvc1vbWw4DbK9tURwNNRf9isVbJTOsg1FmT1N6Z67k3eRZ0M59jrf
         dgt4RAOjy5T1Eu0yXfCnhDvheP6Uo7EpwhEaKlLUaFuHHdQv9WcRBJ0COXGyadig3/CP
         e7fCuQLZr/A7RdsHg+s+MznW9E4P7yEqlGzuzdjO2ZqDeJt/WTEsTaj1esfsOy3p2uKC
         Jd+2gjg25pyo0RmyBb+ZeMC725UaQsw9zq1NyX3XsPH/Ux9jNj4shk77aSwo5aofORWV
         vnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDcfDi33is5NY8p30BbC+tdqixJSzaPLxC/pjqPob+s=;
        b=eyqRPUlCaTxFxx7iyq+8raThq+FvI/n2rfSud6/ER87PxZHzpUFoXPAKd8HY+CALuk
         9ZFDVwGfdEfy0RHtWdNJbk9ASP+AgFoKE7zjYlhKjuLRE1T2FKfR5BLdXzuloRcDucbJ
         B+rkmZdQu/VbtJZjUgMSqtB3Mx750IusQoYFglE1aP1a8A/0FnoYD8763P+29noE6KBE
         RuaxIocgZFt2ooNs/gMaEqWUzHEVLGFFGhWcqtE0kJkajS1+Y+E+C3tJniBX6lbysDQq
         bdyA6o5kqG3GEWwBoQxqg0aWhfQJZowWRrsG/C3NocPIPEwRrfgkdBn+sSOaIwWwLj5u
         svgw==
X-Gm-Message-State: AOAM530k4UjWZABHcuCUcV8SZsZXc/QmRGEMR1uK+WBw61CKeyXqX1yR
        VKLkRVQwxi4AL7B9Rq2R+Y0=
X-Google-Smtp-Source: ABdhPJznGeaPUprOzPLGXLcxSwmKDdYs7ILTrx7FQdFileRyIvg1SNNGT6TjxGnbAO7dm9g6osvOkQ==
X-Received: by 2002:a17:906:364e:: with SMTP id r14mr5016296ejb.258.1593463151413;
        Mon, 29 Jun 2020 13:39:11 -0700 (PDT)
Received: from localhost.localdomain (p200300f137396800428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3739:6800:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j24sm706741edp.22.2020.06.29.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:39:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] clk: meson8b: add two missing gate clocks
Date:   Mon, 29 Jun 2020 22:39:02 +0200
Message-Id: <20200629203904.2989007-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to figure out how to set up the video clocks on the 32-bit
SoCs I found that the current clock tree is missing two gates. This adds
the missing gates based on evidence found in the public S805 datasheet,
the GXBB clock driver and 3.10 vendor kernel.

I didn't add any Fixes tag because this clock tree is still read-only
and the HDMI PLL (the top-most clock in this tree) needs more work as
well.


Martin Blumenstingl (2):
  clk: meson: meson8b: add the vclk_en gate clock
  clk: meson: meson8b: add the vclk2_en gate clock

 drivers/clk/meson/meson8b.c | 60 ++++++++++++++++++++++++++++++-------
 drivers/clk/meson/meson8b.h |  4 ++-
 2 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.27.0


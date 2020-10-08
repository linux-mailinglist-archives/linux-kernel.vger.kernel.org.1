Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A827287ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgJHWw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgJHWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:52:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2B4C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 15:52:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w21so742517plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TclpIUFbPJmx7jd4wjkCDiKLMdsvfFtLGqEMlN1qODE=;
        b=aSTriDnhy8WA2yhH1dmnwySm3U/eCcx4a5wVHYjjC7SKI08hjSIIhtvsvG138hvdG6
         xNQ5YxzWAEtvW378mP2NIngwUBa73yAfzZQz2JtrrJCrgwR0p4czWoe7lvyaIqBrar64
         MeMoo7pflUE6NEPaH1DktP1+4jhU6DEd6dVmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TclpIUFbPJmx7jd4wjkCDiKLMdsvfFtLGqEMlN1qODE=;
        b=UePvJQ+addS8usP46719v5xMwV5bVaJw1DQR6k19CweNh5i8eVZP85k6CICeNQxnqX
         anYLrmgVdtbezQPpx17dRv74rNhrgNbtCFs540T8X0SJQdNH0v+OptSVhHxOWq1mjO3Y
         ZdKceP8DN0MxW9corQLz54sqoBOKm0f1vhJPv+8NnhNas3NmmZ4eBvxNN82Fjy+oz57B
         1Mo/xJ+3bmUPJp453SzCy0Od9CpvgFuQHrVpmFRZDi8uzsj5TNskZMnGtgDmtRvtSWkC
         ExAn0dny8y1MqzmNO5sIm1gGPacAGuiyVG/nTMyd16jvOip7mWJiZ8/8+u4gBhxWjjx+
         nY7w==
X-Gm-Message-State: AOAM533oYwkv1xAhaTCvr2asMwpT8wzN6gLgut9aNyu7uhZTBiRcOO4V
        yvzJrHM7IXdfBjVeTaXqOyKM8g==
X-Google-Smtp-Source: ABdhPJw9fZEBNb18jdN5tiTRILbitG+mnoSktgbmJd8YKbZmPr00V1ysQLwUPW5ZetjIbSp/1VWlNA==
X-Received: by 2002:a17:902:14f:b029:d2:562d:e84 with SMTP id 73-20020a170902014fb02900d2562d0e84mr9468217plb.64.1602197574849;
        Thu, 08 Oct 2020 15:52:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id jx17sm8386369pjb.10.2020.10.08.15.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 15:52:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-i2c@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] i2c: i2c-qcom-geni: More properly fix the DMA race
Date:   Thu,  8 Oct 2020 15:52:32 -0700
Message-Id: <20201008225235.2035820-1-dianders@chromium.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously I landed commit 02b9aec59243 ("i2c: i2c-qcom-geni: Fix DMA
transfer race") to fix a race we were seeing.  While that most
definitely fixed the race we were seeing, it looks like it causes
problems in the TX path, which we didn't stress test until we started
trying to update firmware on devices.

Let's revert that patch and try another way: fix the original problem
by disabling the interrupts that aren't relevant to DMA transfers.
Now we can stress both TX and RX cases and see no problems.  I also
can't find any place to put an msleep() that causes problems anymore.

Since this problem only affects i2c, I'm hoping for an Ack from Bjorn
and then all these patches can go through the i2c tree.  However, if
maintainers want to work a different way out to land that's OK too.

NOTE: the 3rd patch in the series could certianly be squashed with
patch #1 or I could re-order / rejigger.  To me it seemed like a good
idea to first fix the probelm (and make the two functions as much of
an inverse as possible) and later try to clean things up.  Yell if you
want something different.


Douglas Anderson (3):
  soc: qcom: geni: More properly switch to DMA mode
  Revert "i2c: i2c-qcom-geni: Fix DMA transfer race"
  soc: qcom: geni: Optimize select fifo/dma mode

 drivers/i2c/busses/i2c-qcom-geni.c |  6 ++--
 drivers/soc/qcom/qcom-geni-se.c    | 47 ++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.28.0.1011.ga647a8990f-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC22BC3EB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 06:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgKVFle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 00:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgKVFle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 00:41:34 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8EAC0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 21:41:33 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id o20so535910oor.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 21:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhieI/Etrh/oLPSGfJ0G28Ub6VKedDTj5ibAz+QRjJQ=;
        b=yt8RZtRJhxjtMa3XNP71tJYZVjVo40qof8Yw+gB9yKFvN0uZuj6ccy3760pdFSKX3f
         lTR1ycIF1XdnB6rfKgckevdqE0HCFCsVL4mn52X4qXWwf1U8b6Rhg1CQfyYK9/o4LJcY
         bQ4Lk+aiP1NbQ22//pCZuwVwyGh87msQlBxmub5380Izxi9uNJeQYH0QVbrOlPJ5RpBi
         sfn3O3jH2L/9CwaBkvpRWwvUlP2J9z8CI+99qmA1MJC5Q9H8O7xa8+NwRRFYlCdfBj7T
         d34YCiJcYXxdJZhN8p1iPUpYReQsG8PiTOa7m8Zf8A+BKtwy+iAeon4VhoPQEp6HPdIs
         VQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhieI/Etrh/oLPSGfJ0G28Ub6VKedDTj5ibAz+QRjJQ=;
        b=YZqdMt+30iFMUvw3zzxwKXDPcx2cAPZQ3BmuDk+xvyZACjVpPL1B7a9nZ33Vg3h0W4
         MZ/81GJ4bsjw4zrRYz/VewaGL9xLX32auyPr4SaAdHqEvM1hOn2wWHvAcP7e0whMMavf
         82e8DreMdcpzTuz2bqvWdBmM1drwAtlJ7C4RSBwAqvANg9DikUmVpHjxehXmZywwnmvo
         Qp/BymUuysGC+bBPl2tBe8+3NGkJZ7w67Z3k1BFoVqFtKdtHPWUOD8JDVHNCxWWH+rXV
         YIdjLBp+c7Tu6U+XKuHIoD+fpoYBK6p4jeqh7FviXT5+8kW1cIV5ojnMCtJcQisIlIIF
         qGdg==
X-Gm-Message-State: AOAM5321YQM2Hnq1nY8dDDljJCk78wL3DUO9G0/8O/u4oqxXuFbWbPnF
        d7Xd0F7PtQqWT9xRotSbJC5TJA==
X-Google-Smtp-Source: ABdhPJyFNu2dmTei1U58jC06Dd+Siul99APlr0Ea81Zpgxba2pcqJhTAmCB+lTzbiTVaxoG91fAwpQ==
X-Received: by 2002:a4a:7b4b:: with SMTP id l72mr2355888ooc.45.1606023693019;
        Sat, 21 Nov 2020 21:41:33 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s28sm4303132otr.4.2020.11.21.21.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 21:41:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] remoteproc: Improvement for the Qualcomm sysmon
Date:   Sat, 21 Nov 2020 21:41:31 -0800
Message-Id: <20201122054135.802935-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core part of this series is the update to the sysmon driver to ensure that
notifications sent to the remote processor are consistent and always present
valid state transitions.

In testing this I finally took the time to fix up the issue of the SMP2P based
graceful shutdown in the remoteproc drivers always timing out if sysmon has
already successfully shut down the remote processor.

Bjorn Andersson (4):
  remoteproc: sysmon: Ensure remote notification ordering
  remoteproc: sysmon: Expose the shutdown result
  remoteproc: qcom: q6v5: Query sysmon before graceful shutdown
  remoteproc: sysmon: Improve error messages

 drivers/remoteproc/qcom_common.h    |   6 ++
 drivers/remoteproc/qcom_q6v5.c      |   8 +-
 drivers/remoteproc/qcom_q6v5.h      |   3 +-
 drivers/remoteproc/qcom_q6v5_adsp.c |   2 +-
 drivers/remoteproc/qcom_q6v5_mss.c  |   2 +-
 drivers/remoteproc/qcom_q6v5_pas.c  |   2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c |   2 +-
 drivers/remoteproc/qcom_sysmon.c    | 119 +++++++++++++++++++++-------
 8 files changed, 109 insertions(+), 35 deletions(-)

-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571AB2CA76D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgLAPvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLAPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:51:19 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:50:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so5055701ejt.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDI3S9p1V5lm4gwtH3LDrcbJfLot1UMo0jmhnlWM+Lw=;
        b=IpW/9qcj9tT9HmfVc8wd5tP0bt1bf8vY8Ljn4wMcfCDzRbDaG8ZkcYdg51XTLe3M9A
         6PGwcE/rbtzkL0fNq+RD0EZVw515cPyBfCfk+iXEMjnS2utVyZHTu1yoGG53cebfdgd7
         DlaoLa8e2LbJ70cJtS1yc0sJEa6kYg3+5yjMc4yOjjXi54uUL+KPRLEi/SPq+o5IdlkY
         ZJ2URfL0t6JSZpvqrPM+3RHCqzAZ1V0qbvWz+ZCLA1DRbuuMaymnGZXJz+3SlDIvz5qt
         d6nxS4pf2L9YqTWDyygt/yS6X25R/9gIFaAMy5WicIXNofwrLvZCZZsb4eT/uXOxr4lL
         d9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fDI3S9p1V5lm4gwtH3LDrcbJfLot1UMo0jmhnlWM+Lw=;
        b=YBkibfnTNOMvhnrJTBzuzM7F1zeoXh64o+ZmuyOL2W29i4ABytcY3064hXnAtws9zI
         DFRiGOEAEfR7rMZ8wSCXA1SmrF5cCsRW78YfA/uSgn9kAEKoBG7+RelcH09eqv2en5DG
         2Olt6idVoLzTGhD6r0rIJwk2SJ/nIE5ScDPwXW+270Twx4N4HkVs2DlTXqUjHYSQJ/yy
         FbO4KujO4899LPTvKuM/YTgRG8HQHoqHYy8ZY+4f5nP8ZSwIGtxNWr7B7tHJlZC8YaRG
         RmA4OUmSIixaAygrODP7tjKzWVkpAyxx2zPKCQAOMKOVtiQLn1VAFemrHXt5m+xT5UUh
         jrHA==
X-Gm-Message-State: AOAM53174GsNcbk0Ii7jdLwqbeVfnU9LFoDetr/o+th9SWiWODphk3/B
        T8qlu+QzEbGtLNGyut4rCfJfNo7xgheWQJwU
X-Google-Smtp-Source: ABdhPJyRatoW7nXYJ80fmOenF6KAcGnKEPNp432UVMFWSUd3awjvBz0J2EvttYo0h7hfI4z4bESFJQ==
X-Received: by 2002:a17:906:c82c:: with SMTP id dd12mr3706100ejb.66.1606837828419;
        Tue, 01 Dec 2020 07:50:28 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b9sm89692ejb.0.2020.12.01.07.50.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 07:50:27 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] firmware: xilinx: Clean up series
Date:   Tue,  1 Dec 2020 16:50:23 +0100
Message-Id: <cover.1606837822.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for being able to review new changes more effectively it is good to get rid
of existing kernel-doc and checkpatch violations.
That's why this small clean up series.

Based on
https://lore.kernel.org/r/e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com

Thanks,
Michal


Michal Simek (3):
  firmware: xilinx: Remove additional newline
  firmware: xilinx: Add a blank line after function declaration
  firmware: xilinx: Properly align function parameter

 include/linux/firmware/xlnx-zynqmp.h | 45 ++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

-- 
2.29.2


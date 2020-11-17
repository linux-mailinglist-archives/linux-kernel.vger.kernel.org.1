Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF12B5C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgKQKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKQKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:02:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF67C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:02:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so16986478pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26jUaXgkOpdN+N/zxNBvWC7RCK+cgJsa+0NL5In8szs=;
        b=d+TRbT7DnLWPzB0SCStAavu+nQwfwhdt25ut79ivY+kq7c5ate3R9C3W/U+m6aZKz4
         +wy3LW7qslQ0i2/GQwanm/a3aWVFgtE19GhE+AvrlUdXe280m/581oH9pyJkPlf00Z5l
         qw1n5IF2kZp5AXPHVGew/GXKqfFaHfaEh9wbBCh8+NVf/49G+dnWMOOUXg+dLKw2hYWc
         jR0dfhQVjNPGg4hQYvxaYY7D60FKKo4hmcFnAlHDjowad14qF87enx1A1N2tc0tiD3uX
         AWVsXkz1h3CsYHcB8iPNmA2QSLyMfH4GRewHQvZiiL5qM0O2DQjrdgWtHqcwkEVVc9zN
         U2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=26jUaXgkOpdN+N/zxNBvWC7RCK+cgJsa+0NL5In8szs=;
        b=JI/1dn58Pv3c9XKZ90aUQ+9ck/vs6WMyRm4++3SS62zuIiUSLE9QdputsJLQadswSG
         u69h6u/sL8tFgHRv2+m2r8kDmCdU1xLryutVt9Bm0bhFMOliM6KOQqDSYAk3W2Vu1p+c
         Q8HI5HI+eum7JBO9DmRpnQrHPaPSonZae6LVr08zkOTBDR2JkTDoNt8sAvbhv3JpupSm
         U+mS/k7B0QfaPyOTRlHptJz7tlCcDn0yLRt6LaUqONdIo5YLutt50/DUCdllnqvB06/O
         bG45AlzalHfExGXR6PtrIQMQTyNUXg4JYlgDybC1/QD9RDtdrO3I9EJJwBM5K4qTx5J9
         cVpg==
X-Gm-Message-State: AOAM53120kgeC2i7tXHtaaabbHBKCB0x07vBXnpbv5MeFLp0Tw+x4e3z
        +WIFB9Lp2/2WNf4Ul1fMEP19bw==
X-Google-Smtp-Source: ABdhPJw72mee3Ie/hh9YLmqwohDfqLW9HAujs+K05Oy97webs0QsO+cpBnSCMvCThhs3BNs2tO09gw==
X-Received: by 2002:a63:c90b:: with SMTP id o11mr2985326pgg.453.1605607331298;
        Tue, 17 Nov 2020 02:02:11 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id x66sm5770248pfc.43.2020.11.17.02.02.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 02:02:10 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Sudeep.Holla@arm.com,
        morten_bp@live.dk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Usama Arif <usama.arif@arm.com>
Subject: [PATCH V5 0/2] mailbox: Add mhuv2 mailbox controller's support
Date:   Tue, 17 Nov 2020 15:32:04 +0530
Message-Id: <cover.1605607138.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

Here is the updated version based on your suggestions.

I feel bad that I haven't implemented the single-word protocol as a
special case of multi-word one in the earlier attempt. Perhaps I was too
consumed by the terminology used by the ARM folks in the previous
version of the driver and the reference manual of the controller :)

V1/V4->V5

- The binding patch already had 4 versions, while the driver had only 1.
  To send everything together, I had to bump the entire thing to V5.

- Removed single-word and multi-word protocols and introduced
  data-transfer protocol which works with 1 or more windows.

- Moved register names to small case.

Rob, I have kept your Reviewed-by tag as is, please let me know if you
would like to revoke it.

--
Viresh

Viresh Kumar (2):
  dt-bindings: mailbox : arm,mhuv2: Add bindings
  mailbox: arm_mhuv2: Add driver

 .../bindings/mailbox/arm,mhuv2.yaml           |  209 +++
 MAINTAINERS                                   |    9 +
 drivers/mailbox/Kconfig                       |    7 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/arm_mhuv2.c                   | 1136 +++++++++++++++++
 include/linux/mailbox/arm_mhuv2_message.h     |   20 +
 6 files changed, 1383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
 create mode 100644 drivers/mailbox/arm_mhuv2.c
 create mode 100644 include/linux/mailbox/arm_mhuv2_message.h

-- 
2.25.0.rc1.19.g042ed3e048af


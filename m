Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436AE1C4C84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 05:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEEDNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgEEDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:13:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F0C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 20:13:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o18so393951pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYizcWQEdFFMME7plWgxGUqZtB5T/alBirdJJTamDl0=;
        b=OpgztqxbjjIWT0S0o1w7IFpGpHzmzY39WXydiZMi6ldwkil3Y4q4qejU5vjDm3/nUe
         fEbipUBhO56RPrSNWfIWQCFHFBpbKJLw1sKyAEBOzfq4LHO5St/jUkn5GRAaJv8IaDNi
         edyX5q2ArkjAFFHnUrW3ROVTOSpJ39tUMixto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYizcWQEdFFMME7plWgxGUqZtB5T/alBirdJJTamDl0=;
        b=pOrUX5U8akDnouPumKUJNrnshikUOkm4aeObvxgAFbe6ekr9ByEpXvbbcwmJ+266If
         WTtW25/YJUKTPTQktpRLTfEBlqZ0+zPsb12iXO91ACXlk7I/a865IFmG7b6agjrPb679
         C2xN8cVdMqA1dCcB81lK7qMzXyHQYlSHv102zLg5lI2CAGWfV3GsVhwhTCJLkSgM4xnK
         Im0BfytH5heaRn5wNT4+BcVSWW1iQuzul/MRzkqq2Dy2Zbf8DTPSFBPNve7iFCV27Edb
         f9zwmxo3rtaed/OnLlpj1mQbWuBUeS+YWThM5NfDmy8F7a1NtD8tN8pjditncsWGJpql
         82Ew==
X-Gm-Message-State: AGi0PuZqC2UFVDqoh8KSrqpcqeW0YOASXbqsz0Agcc3uSpk8pS+ALbsc
        uOXuRnyJx/eLQ+XpJTad8NvzQoTmZ4g=
X-Google-Smtp-Source: APiQypI+UM9kyqMuWaig7fH+0C3WOrdDmMQJzXMbRfY/YxLoaAju9lVlr4yyrM8odb3a1HXE2WF9Fg==
X-Received: by 2002:a62:e803:: with SMTP id c3mr1104548pfi.228.1588648425913;
        Mon, 04 May 2020 20:13:45 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id a12sm398974pgv.14.2020.05.04.20.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 20:13:45 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, xingyu.chen@amlogic.com,
        Evan Benn <evanbenn@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
Date:   Tue,  5 May 2020 13:13:29 +1000
Message-Id: <20200505031331.122781-1-evanbenn@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently supported in firmware deployed on oak, hana and elm mt8173
chromebook devices. The kernel driver is written to be a generic SMC
watchdog driver.

Arm Trusted Firmware upstreaming review:
    https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405

Patch to add oak, hana, elm device tree:
    https://lore.kernel.org/linux-arm-kernel/20200110073730.213789-1-hsinyi@chromium.org/
I would like to add the device tree support after the above patch is
accepted.

Changes in v6:
- Don't use dt default
- Use default arm,smc-id value if non provided by dt

Changes in v5:
- Change compatible to arm,smc-wdt
- Make timeleft return 0 on error
- Use type punning on smc_func_id to save an alloc
- Change compatible to arm,smc-wdt

Changes in v4:
- Add arm,smc-id property
- Get smc-id from of property
- Return a1 instead of a0 in timeleft

Changes in v3:
- Change name back to arm
- Add optional get_timeleft op
- change name to arm_smc_wdt

Changes in v2:
- Change name arm > mt8173
- use watchdog_stop_on_reboot
- use watchdog_stop_on_unregister
- use devm_watchdog_register_device
- remove smcwd_shutdown, smcwd_remove
- change error codes

Evan Benn (1):
  dt-bindings: watchdog: Add ARM smc wdt for mt8173 watchdog

Julius Werner (1):
  watchdog: Add new arm_smc_wdt watchdog driver

 .../bindings/watchdog/arm-smc-wdt.yaml        |  37 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/watchdog/Kconfig                      |  13 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/arm_smc_wdt.c                | 188 ++++++++++++++++++
 6 files changed, 247 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
 create mode 100644 drivers/watchdog/arm_smc_wdt.c

-- 
2.26.2.526.g744177e7f7-goog


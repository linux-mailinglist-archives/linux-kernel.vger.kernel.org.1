Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAB304EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404903AbhA0BaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391638AbhAZSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:35:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899EDC06174A;
        Tue, 26 Jan 2021 10:34:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so11981696pgl.10;
        Tue, 26 Jan 2021 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3OYVEIwm+T4ixSU3W7nTuuzBIOgDZrgCxBKI23Xg2k=;
        b=aWqpP/8ZYWxQO2rlpi9fOnuC5FKRWeBOie91OqM77Z3KnNXl/qMnmCpkmXGrOgf+1I
         FBbZEfzttwMQnY7vVgtQiJ9SBzPZqvBB2sXD7gYcddrD0MqL2rkhP1izJAXo3cG3wWLh
         LZFiphBSg6bbQ8rcrsQm/AuuUegtZHjS2VCZrWFanbJ1xF2Qpv/ibHb9qq+CMt79ZwO5
         X1C+wvrW/wjvDWUyaoCsy2udTx+5E84sK9P5tei/SfRhyP7XvR09pHTIokbRiZV5fHuq
         TOQ/e3wTTTV7fFrjDMUvZb/pGI2Ogx8Csyqpq9embp8rA2IfXsAe2gloKgibspeP5g/a
         i75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3OYVEIwm+T4ixSU3W7nTuuzBIOgDZrgCxBKI23Xg2k=;
        b=FvF1I/Bn/ExN60P1r/L+I/OcQQYrC4AnbIodGi6LJ6pMElHpE6ANJh8/muyHM4sWSN
         M7iPFsV6Z2e3Ttf7Hv8dDwGA5SBOiufbyqGhAOoPOtD04SbH4LpHLL7tqzHtpcb7Pc72
         lMdMlh0PJ7vSJ//pUnK557eRRvZPTTGMio5tE72F5z4FtSpSn9LEWiFI453RAvE7jR+D
         LLffmhAxKMcxARAIZmVQEPv3/1ZJ/ANcKpWjjp16TfrbAn/ZuNZdtIBmoIRx4A1vz8eR
         S6x0SL8IRoEU+QgsCazp9edeNm7wSLF44TWF3yBEFofiA08J+N/TAkYrpb+dV/Yogofz
         RAnw==
X-Gm-Message-State: AOAM533Sq8Q5WWo1mAVhlzH9VEfYqbLRKPfeH2xoFkVnKKmJCUuYGEs4
        zewajLKw1unsYnT08gc/8A8=
X-Google-Smtp-Source: ABdhPJyhDR/U841s6Lt31J2RW54n4sNXu+MSTO3NGOQvGyykBztGypP+Oa6R3w25Y8TQbRQ/ufO7gg==
X-Received: by 2002:a62:6503:0:b029:1b4:4580:1abd with SMTP id z3-20020a6265030000b02901b445801abdmr6516507pfb.30.1611686063904;
        Tue, 26 Jan 2021 10:34:23 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id y75sm472711pfg.119.2021.01.26.10.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:34:22 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Liu Shixin <liushixin2@huawei.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>, Tom Rix <trix@redhat.com>,
        Evgeny Novikov <novikov@ispras.ru>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] drivers: usb: misc: update to use usb_control_msg_{send|recv}() API
Date:   Wed, 27 Jan 2021 00:03:51 +0530
Message-Id: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_{send|recv}() API provides an improved way of 
using usb_control_msg(). Using this, short reads/writes are considered
as errors, data can be used off the stack, and the need for the calling
function to create a raw usb pipe is eliminated.
This patch series aims to update existing instances of usb_control_msg() 
in drivers/usb/misc/* to usb_control_msg_{send|recv}() appropriately, and
also update the return value checking mechanisms in place (if any), as
necessary so nothing breaks.

Changes in v3:

  * idmouse, emi26 and emi62 are left unchanged, and are not updated.
    -> since control transfers in idmouse are without a data stage, there's no
       real advantage in using the new helper here.
    -> in emi26, and emi62, FW_LOAD_SIZE = 1048 (> 1024). Thus, if we try to use the
       new helpers, it will result in either build warnings, or memory being allocated.

  * Link to v2:
      https://lore.kernel.org/linux-usb/20201130013103.2580467-1-anant.thazhemadam@gmail.com/T/


Changes in v2:

  * Buffer variables that were previously dynamically allocated are no
    longer dynamically allocated unless they have a variable length
    (since that threw a warning).

  * Link to v1:
        https://lore.kernel.org/linux-usb/20201129160612.1908074-1-anant.thazhemadam@gmail.com/ 


Anant Thazhemadam (12):
  usb: misc: appledisplay: update to use the
    usb_control_msg_{send|recv}() API
  usb: misc: cypress_cy7c63: update to use usb_control_msg_recv()
  usb: misc: cytherm: update to use usb_control_msg_recv()
  usb: misc: ehset: update to use the usb_control_msg_{send|recv}() API
  usb: misc: ezusb: update to use usb_control_msg_send()
  usb: misc: iowarrior: update to use the usb_control_msg_{send|recv}()
    API
  usb: misc: isight_firmware: update to use usb_control_msg_send()
  usb: misc: ldusb: update to use usb_control_msg_send()
  usb: misc: lvstest: update to use the usb_control_msg_{send|recv}()
    API
  usb: misc: trancevibrator: update to use usb_control_msg_send()
  usb: misc: usbsevseg: update to use usb_control_msg_send()
  usb: misc: usbtest: update to use the usb_control_msg_{send|recv}()
    API

 drivers/usb/misc/appledisplay.c    |  46 +++++------
 drivers/usb/misc/cypress_cy7c63.c  |  21 ++---
 drivers/usb/misc/cytherm.c         | 128 ++++++++++-------------------
 drivers/usb/misc/ehset.c           |  76 ++++++++---------
 drivers/usb/misc/ezusb.c           |  16 +---
 drivers/usb/misc/iowarrior.c       |  34 ++++----
 drivers/usb/misc/isight_firmware.c |  30 +++----
 drivers/usb/misc/ldusb.c           |   8 +-
 drivers/usb/misc/lvstest.c         |  38 ++++-----
 drivers/usb/misc/trancevibrator.c  |   4 +-
 drivers/usb/misc/usbsevseg.c       |  60 ++++----------
 drivers/usb/misc/usbtest.c         |  69 +++++++---------
 12 files changed, 198 insertions(+), 332 deletions(-)

-- 
2.25.1


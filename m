Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC8528C1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391240AbgJLUAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388882AbgJLUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:00:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A91C0613D0;
        Mon, 12 Oct 2020 13:00:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so14555420pfp.13;
        Mon, 12 Oct 2020 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o3Wbk4nmy56F9IkEZJ4ABSgYwO4Ym2YRvtidSEb89cY=;
        b=FsCy3E1nuWYY7boGvXjmaLcuYPvaPNuqoSgMs2izSqYwTNKc5/7WLBzrnK68SFJwio
         wXs+YdOhdtVv9TruBBIRYThnNPvexrTGBmwNmJl5iESJpTOt9JwWsadtJd/gtn7eY0qi
         NcEb4RJTp8/fJOvrZEKkrO0ipTtBh+/mPERnOrZmVHPV2RM79z1f5UJFq6723eh7cHch
         RtWiEHD993/IdIfFf/xvIcmvKH9QhiRQs/vpCKkYCBoecrskcKGDcUR1GkL40CkZbSmr
         GtzuXrRO5ySDC1Z8XtFMIu2oOzGModKtRljaDBOSLWtq3pWAZWd7IyF/4i0y3N9k2ozU
         PPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o3Wbk4nmy56F9IkEZJ4ABSgYwO4Ym2YRvtidSEb89cY=;
        b=B+g4KEV1CU4dUaRqEVSrBcjVXjmfVEp2t/1FkbDKmxkp+XYJZE0SBn7q78WEf9zd7E
         8HcIsvkU2E1WQujE8RDJUfpEWiYN0gj7WzSTBvkXPsTdyxPsptpejMsNV+k7TuYYT2Uk
         7P13D8WbRDeWXCvCA3//+a5MBHwRSsPWHB5YxD2C0Hol3hrWNDxsiRf/RmfvTKl3yAUP
         j7EFlNnF+lDcbLG+Gy1uQDbofTvlA9bGkYu1nxYVevwTRIPNHVh9ELzBlIi0LVR2UiOp
         WHZjmMHyRi37iTHtNtTueNQDoaSzV9EojvXBkzbmw8U8WAfOiL9oMwt8qoRpcbixx7X5
         xfLg==
X-Gm-Message-State: AOAM533roizMbvqK0KM5NLu8snPY6JrviOpidFpmThbSUgIU7ScsKMMb
        lJDDOASrnFUUNN3YpbEV4r1vd8ujF9M=
X-Google-Smtp-Source: ABdhPJxIDYig0BsxgX1Ir49T0xvRyJ+8raBmM+C1zFU2TuBwuW8ORdh5G+zn1HH5Ao1VtT6EYra3tw==
X-Received: by 2002:a63:f60f:: with SMTP id m15mr13755095pgh.298.1602532825050;
        Mon, 12 Oct 2020 13:00:25 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y124sm13556909pfy.28.2020.10.12.13.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:00:24 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/2] usb: Add driver for USB signal re-mapper
Date:   Mon, 12 Oct 2020 16:00:05 -0400
Message-Id: <20201012200007.8862-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3
- Add MODULE_AUTHOR(), LICENSE and DESCRIPTION() so the driver
  can be built as a module.
- Improve Kconfig default entry

v2
- Move file from drivers/usb/host to drivers/usb/misc
- Combine Kconfig/Makefile patch and new driver patch
- Fixed bindings .yaml document based on feedback from Rob Herring
- NOTE: There were suggestions to use a pinmux driver or
  GPIO aggregator, but I think agreement was reached that
  they weren't a good fit.

The Broadcom 7211 has new functionality that allows some USB low
speed side band signals, that go from the XHCI host controller to
pins on the chip, to be remapped to use any GPIO pin instead of the
limited set selectable by hardware. This can be done without changing
the standard driver for the host controller. There is currently
support for three USB signals, PWRON, VBUS_PRESENT and PWRFLT. This
driver will allow the remapping of any of these three signals based
on settings in the Device Tree node for the driver. The driver was
written so that it could handle additional signals added in the
future by just adding the correct properties to the DT node.

Al Cooper (2):
  dt-bindings: Add support for Broadcom USB pin map driver
  usb: Add driver to allow any GPIO to be used for 7211 USB signals

 .../bindings/usb/brcm,usb-pinmap.yaml         |  70 ++++
 MAINTAINERS                                   |   8 +
 drivers/usb/misc/Kconfig                      |   9 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/brcmstb-usb-pinmap.c         | 351 ++++++++++++++++++
 5 files changed, 439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 create mode 100644 drivers/usb/misc/brcmstb-usb-pinmap.c

-- 
2.17.1


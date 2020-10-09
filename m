Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFFF289190
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbgJITIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJITIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:08:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BA9C0613D2;
        Fri,  9 Oct 2020 12:08:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b26so7663988pff.3;
        Fri, 09 Oct 2020 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MNA1eOiOa0mlN5gGQovR+g9Bvr/1OjdEhyuDq+3Ke9o=;
        b=K5twc43ZuTYJxAfhoHXFAfM7cVdmQI2VkYfomiSK5WAZ9W/KJueRegEDi/L99GUKOH
         hrG5VB1P5NBXDxa0H+0qJz45uMcj6Ac0IB9DR9FIH5JYCAJfCTYY6NmmcN3ojCxY+RAH
         tz4m9Xz/PSuzY/4pRk9CMHBB2Ot+JgUYZIPoCgHqJTbkrxSP9fgYVf5D80ViAjBjwUyL
         B8DvDvfJEUXWRty+HVXJtSxtTPWKSkvE8ZFJy3Avo5p5S7q5pvJbKJFdzPdINAYlrXru
         C3hQqhkvMDWMBSt68L8nfFANX/kAsVvWFG+JKdefEYBfQh9q7pvvhpIIOmiAfr2Dko6k
         7yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MNA1eOiOa0mlN5gGQovR+g9Bvr/1OjdEhyuDq+3Ke9o=;
        b=KbLqiqv0Dze+3TWkP3LQcXHxUy2CWCqekb3mOVm/XZ6PJVIvk3ONN+0i1MjpQJVmq5
         LEn8BWDrG5TolDumkftP0rDADbucgHsm77JYQbJQFxgKR0P+FEQ8mqRcCEtAas706bZR
         XW2O8Mqm3jcz1VhzVkglHBzXGBMbjRT9HFAhm9smns33kgMOT+WLk4nD4fPxtI0NbXMZ
         yy41EN2gKYMMroDc3gDOP56ODFNA0CZYXru23FrfCSK7a7uqz5tBUnuTdRqUoKO+xjF2
         v62rZemrhYb4/2fodPBtT1VBoKzog8UF5YT9MdMgOUSewfrnJvMe1y14/MgMOD51EjMe
         GRKw==
X-Gm-Message-State: AOAM533AKwiYCxU6CTn8F18imbUJataUk5dUxe61svhlqoE1IlVbTB9u
        EqH+gYMp7myyH1XP9dEx4akrSI3XNpQ=
X-Google-Smtp-Source: ABdhPJxUh2CrfNZ2pJE0t6+0rwHu5YaUMSSVb0GWA3DxPOk0t6UHgWOKAP9V+lCNBzAr21Bp1+Q77Q==
X-Received: by 2002:a65:6487:: with SMTP id e7mr4400334pgv.409.1602270529071;
        Fri, 09 Oct 2020 12:08:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o20sm12281043pgh.63.2020.10.09.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:08:48 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] usb: Add driver for USB signal re-mapper
Date:   Fri,  9 Oct 2020 15:08:37 -0400
Message-Id: <20201009190839.12612-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2
- Move file from drivers/usb/host to drivers/usb/misc
- Combine Kconfig/Makefile patch and new driver patch
- Fixed bindings .yaml document based on feedback from Rob Herring
- NOTE: There were suggestions to use a pinmux driver or
  GPIO aggregator, but I think agreement was reached that
  they weren't a good fit.
  
Al Cooper (2):
  dt-bindings: Add support for Broadcom USB pin map driver
  usb: Add driver to allow any GPIO to be used for 7211 USB signals

 .../bindings/usb/brcm,usb-pinmap.yaml         |  70 ++++
 MAINTAINERS                                   |   8 +
 drivers/usb/misc/Kconfig                      |   9 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/brcmstb-usb-pinmap.c         | 348 ++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
 create mode 100644 drivers/usb/misc/brcmstb-usb-pinmap.c

-- 
2.17.1


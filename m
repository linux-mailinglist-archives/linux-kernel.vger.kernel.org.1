Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA2286E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgJHGQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A78C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r2so4394945yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=T4vVxHg0jWuJU3/weOf8EWjxPeVJ3q0t7eVU5tuJhQ4=;
        b=uL/m5Nc/wk1SghKAS+1XPTxV14l7uCGLV443ij9UK67AhghirlYQFzHoo9qLwdaGc+
         JRJQYi1KgNN4Ej8AGzv02IZiNeGCaPqjirTJrNnIMAcqN6qeMM69umrdd/n2lcTLoJBL
         dZ6wuOZN+RxRtjLlLbviMghqVXzZmRi63TjXJzjXY2f6nfsB1W+VGEAr4yd/39aMSm5V
         q5FZK5WSIuihuudt9nl1B1jWtZRrleCbNESmpiJ9kY4zQaw8c6XBRsLFKrtTUqyK8uFg
         Bjv2WflwvwuGaAk7mrthxjEmAbWJpYbMWGpdA6OS4rUuEVSFR5oTjZL1TQe/7HWllt63
         kIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=T4vVxHg0jWuJU3/weOf8EWjxPeVJ3q0t7eVU5tuJhQ4=;
        b=YeN7BSBFJ55mClnzrKTBqi0pgsVBJlOPZC6a6guLeVQc10abY7ih9wNzPo7SUGcrht
         T/MrdzntMf1U4WyJvqr5j1uLMCjonMEBag/r5QtAvQ8HrfPv+c+fWMqLBU/VyDLY6y0x
         Am/SD5t1LmfBxJdHvXTeg4Y+mXk/Tw3HhPfmQcit83l8UjSkf0otayMhXeCesWnM3L28
         VkQPUd9WkJzywlXV97vM48y1Vc6irnH+IyVrXUDtXOnk5q5ZxJUEboCzF2nk6myXlqjB
         uKar+cQ293w+vTeEO5vLR5HDBgIDCHzCcnzpAE1CPaSMxKI8sB2gPzE9b8OZ37EW/wnb
         s+rw==
X-Gm-Message-State: AOAM530tMmFpmEtTtiZEUWwh5Jtbu5J4vvyvmLCFu1RWXmC8Ze287TZl
        GsJpYjuQHN2eVq2YycTlKjx2uuqvlPs=
X-Google-Smtp-Source: ABdhPJxLS/RfTDIN+nFQbBU4u8/u4Feie2kGAhF2xE8cO096wTc0hg+Jmnsa1koXKOqk0cBpTJVgWW8Zts0=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a5b:1cc:: with SMTP id f12mr3821857ybp.150.1602137762501;
 Wed, 07 Oct 2020 23:16:02 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:41 -0700
Message-Id: <20201008061556.1402293-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 00/15] TCPM support for FRS and AutoDischarge Disconnect
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Made two changes:

1. Added "additionalProperties: false" as suggested by Rob Herring in
https://lore.kernel.org/linux-usb/20201005144618.GA154206@bogus/

2. Removed FRS dts binding constants to address Rob Herring's comment in
https://lore.kernel.org/linux-usb/20201006182940.GA2574941@bogus/

Thanks,
Badhri

Badhri Jagan Sridharan (15):
  usb: typec: tcpci: Add a getter method to retrieve tcpm_port reference
  usb: typec: tcpci: Add set_vbus tcpci callback
  dt-bindings: usb: Maxim type-c controller device tree binding document
  usb: typec: tcpci_maxim: Chip level TCPC driver
  dt-bindings: connector: Add property to set initial current cap for
    FRS
  usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
  usb: typec: tcpci: Implement callbacks for FRS
  usb: typec: tcpci_maxim: Add support for Sink FRS
  usb: typec: tcpm: frs sourcing vbus callback
  usb: typec: tcpci: frs sourcing vbus callback
  usb: typec: tcpci_max77759: Fix vbus stuck on upon diconnecting sink
  usb: typec: tcpm: Parse frs type-c current from device tree
  usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
  usb: typec: tcpci: Implement Auto discharge disconnect callbacks
  usb: typec: tcpci_maxim: Enable auto discharge disconnect

 .../bindings/connector/usb-connector.yaml     |  26 +
 .../devicetree/bindings/usb/maxim,tcpci.yaml  |  70 +++
 drivers/usb/typec/tcpm/Kconfig                |   6 +
 drivers/usb/typec/tcpm/Makefile               |  15 +-
 drivers/usb/typec/tcpm/tcpci.c                | 102 +++-
 drivers/usb/typec/tcpm/tcpci.h                |  30 +-
 drivers/usb/typec/tcpm/tcpci_maxim.c          | 504 ++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                 | 299 ++++++++++-
 include/linux/usb/pd.h                        |  19 +-
 include/linux/usb/tcpm.h                      |  27 +-
 include/linux/usb/typec.h                     |  12 +
 11 files changed, 1085 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
 create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.c

-- 
2.28.0.806.g8561365e88-goog


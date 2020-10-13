Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1D28D08E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbgJMOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgJMOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B9C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:45:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id p15so20729545ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9edqb5x1hDx2fmb/AQX+uLZnlObOSp2lA6s6SJzO18Q=;
        b=u8AEZInu/u2J5znTIxSlmJ+UbfzvtkomL1HfWc3P8MKYrJwvX+k/f1NodCf4S0ldAV
         6vNF8gZMjazFvP1k6osN6CEWZtrKVzmWcVKQlVcjecAE1xJYJFDc/6dTZJt+WN8XMGN9
         i092iuDDbSSpGF2yOvZPvlWMtAo/jdYfQ3HDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9edqb5x1hDx2fmb/AQX+uLZnlObOSp2lA6s6SJzO18Q=;
        b=GQICHrUPQW6iJhYgBHN96tbmDQ1rGCb0BJ7gVZxx+OtvFbvt0HdPKw8JIgzUfnLua1
         L/9RmA2s+KJw3dp1Z9K7s9OsYvRdGAJaI30LOm0kK5wHW4XE49prffUw1DqFlj4MusLq
         5dqMOgxrZZ9zeMQk4xQwhxNYtEopXvIfdDnm/BqMNaCjzlXz3PlAffLM0iB99rOZIZ3y
         +usYGzjn9GdJmWwD+ZBpbmiSC8XiLNZ8llLAzB1e3Sw3ymZwMfp3jBdSVIxCf0chP1gB
         V7h/fMqEGnTP7rPTpVNTsQmblnzorifnUJb9e90ZdanHhulHXInIm1twIlD33x46HI+R
         MIhg==
X-Gm-Message-State: AOAM531WSeBCdukqfP08BDJaZRYlw1MIZq+52X/XYGQBfMEdPooVnhmv
        KRamvl2dhCcHTB0eVuh1JOQIew==
X-Google-Smtp-Source: ABdhPJzG4EoAVlSK0YMNnG2TCpydpGCLOT0CQKlDJj+Hy/PpfnS/i3lDQhuCHFRwl15pZbNdF9wZNQ==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr13434318ljk.428.1602600318348;
        Tue, 13 Oct 2020 07:45:18 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id x5sm4356334lji.78.2020.10.13.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:17 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:09 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v12 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for LiteX SoC Controller
and LiteUART - serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Changes in v12:
    - fixed descriptions in yaml files
    - simplified probe implementations
    - introduced litex_{read,write}{8,16,32,64}() fast accessors
    - added formal documentation of litex_get_reg()/litex_set_reg()
    - fixed possible memory leaks
    - removed spin locks from CSR accessors

Changes in v11:
    - added Reviewed-by tag
    - reformatted some comments
    - switched to WARN instead of BUG on CSR validation fail

Changes in v10:
    - added casting to avoid sparse warnings in the SoC Controller's driver

Changes in v9:
    - fixed the `reg` node notation in the DT example
    - added exporting of the `litex_set_reg`/`litex_get_reg` symbols

Changes in v8:
    - fixed help messages in LiteUART's KConfig
    - removed dependency between LiteUART and LiteX SoC drivers
    - removed `litex_check_accessors()` helper function
    - added crashing (BUG) on the failed LiteX CSR access test

Changes in v7:
    - added missing include directive in UART's driver

Changes in v6:
    - changed accessors in SoC Controller's driver
    - reworked UART driver

Changes in v5:
    - added Reviewed-by tag
    - removed custom accessors from SoC Controller's driver
    - fixed error checking in SoC Controller's driver

Changes in v4:
    - fixed copyright headers
    - fixed SoC Controller's yaml 
    - simplified SoC Controller's driver

Changes in v3:
    - added Acked-by and Reviewed-by tags
    - introduced LiteX SoC Controller driver
    - removed endianness detection (handled now by LiteX SoC Controller driver)
    - modified litex.h header
    - DTS aliases for LiteUART made optional
    - renamed SERIAL_LITEUART_NR_PORTS to SERIAL_LITEUART_MAX_PORTS
    - changed PORT_LITEUART from 122 to 123

Changes in v2:
    - binding description rewritten to a yaml schema file
    - added litex.h header with common register access functions

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

Pawel Czarnecki (2):
  dt-bindings: soc: document LiteX SoC Controller bindings
  drivers/soc/litex: add LiteX SoC Controller driver

 .../bindings/serial/litex,liteuart.yaml       |  38 ++
 .../soc/litex/litex,soc-controller.yaml       |  39 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/litex/Kconfig                     |  19 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 176 ++++++++
 drivers/tty/serial/Kconfig                    |  32 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 404 ++++++++++++++++++
 include/linux/litex.h                         | 103 +++++
 13 files changed, 831 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10F2980B0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767845AbgJYHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 03:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764917AbgJYHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 03:37:48 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BACC0613CE;
        Sun, 25 Oct 2020 00:37:47 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CJqYz1hK4zQky8;
        Sun, 25 Oct 2020 08:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1603611460; bh=RwpRBjOX0sfd/IJIBkY0KD7OCWjRpRmva
        tMRCzW5rQo=; b=PQWP/N8iDAVHYyfjIGJppbvsAr6Yz+bTYf6nUGTeq4nkACv8k
        mHY8hmBeD0LLTGjX6fBv5KNsjMG9nRdaG1vZ4mE5QjHe3HxK0aw/u0EXDCxe8Vjz
        EjYcacvzQEiI6Vtvdz0g0qf7wNCG3eSYYhA5GjVAswDISOFUlLEALYPOPBCXXRcJ
        Bqpe6XeZf0B+aA9YxGZYKejh/IgxAenwSpj2XL7uQpbGGPFRecUTpCxjAq6h8j2d
        4dFZyf6iSFly68wbd8l1EjhbA6VvBiw1KYpEnQGXhtAl4RWjpnTo8IMV10DJRvyH
        oX7J6FGHApA/ywnL3Bdf5zFyQ9TQXZYcxFY0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1603611461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kgsUvn19JD7HWTkCNex3jfxRvN8LqUI7gEX2U819Na0=;
        b=UIhaDrbc3swnWsNhFMDwXwQJSJLNEn2LghUA69LLnlVePgVxIpmMb9shDFOxIYWmpedJrz
        3F3J08n4PnYUIOF0kSn/HBtq67mX0Fci+DbUEm37ZE1GT38NOJBhenHerhzGiXGfqkqerL
        aXoABLaQTLcFPtkFoqA4ZKw8qdkBaKVRiM086dqW1kgVP0mTxZ8Jgj18QJbis5Nv0e5Jo2
        A88ShbFzqMcgnwI1QKxwfBaOVi7z/e/B1VfV2b25/MetcqskuB0aLE3bp4dUlfV7wFkPiX
        ggLx7G0VIJX0nnWY+VtH1XV1X+lxiMOfIMzBaYilXRIOWAsKOmjDSwrkSTw31A==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id AdOyirGvWpnS; Sun, 25 Oct 2020 08:37:40 +0100 (CET)
Date:   Sun, 25 Oct 2020 08:37:37 +0100
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 0/1] hwmon: add Corsair PSU HID controller driver
Message-ID: <cover.1603609465.git.wilken.gottwalt@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.71 / 15.00 / 15.00
X-Rspamd-Queue-Id: 35ADAEF7
X-Rspamd-UID: e53a40
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Corsair digital power supplies of the series RMi, HXi and AXi
include a small micro-controller with a lot of sensors attached. It can
accessed by an USB connector from the outside.

This micro-controller provides its data by a simple proprietary USB HID
protocol. The data provided are temperatures, current and voltage levels,
power used, uptimes, fan speed and a lot more. It is also possible to
configure the PSU (fan mode, mono/multi-rail, over current protection).

This driver provides access to the sensors/statistics of the RMi and HXi
series power supplies. It does not support configuring these devices,
because there would be many ways to misconfigure or even damage the PSU.

This patch adds:
- hwmon driver corsair-psu
- hwmon documentation
- updates MAINTAINERS

Wilken Gottwalt (1):
  hwmon: add Corsair PSU HID controller driver

 Documentation/hwmon/corsair-psu.rst |  78 ++++
 Documentation/hwmon/index.rst       |   1 +
 MAINTAINERS                         |   7 +
 drivers/hwmon/Kconfig               |  12 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/corsair-psu.c         | 664 ++++++++++++++++++++++++++++
 6 files changed, 763 insertions(+)
 create mode 100644 Documentation/hwmon/corsair-psu.rst
 create mode 100644 drivers/hwmon/corsair-psu.c

-- 
2.29.0


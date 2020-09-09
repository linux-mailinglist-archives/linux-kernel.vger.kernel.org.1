Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CD263362
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgIIRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:02:48 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37493 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgIIPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:17 -0400
Received: by mail-ej1-f67.google.com with SMTP id nw23so4265840ejb.4;
        Wed, 09 Sep 2020 08:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4p1CDFl+PUlfhhnDniW1eQduDkR/YtBDlZGh6mzJu5M=;
        b=PelLgJ+C9E9GxzT/H6XzcZovYk8DTceQGlvSLRujUr490z07Tc2Cip83asU/CW4EGL
         +KCYiqEnmpeihpDXj8W6OYruJ4HxZRkv1bNczGUnmaCxrYKsQtmbQjSXhP5u50KenHjN
         SVuOylbpiw+G+WVHyWm173MQ+Oq6RCP2zByVE+cnxF7ESIS0HLt90t/HoLi77wlBZ+LT
         1iV/t8FMd9dvF6jdrJktRAqfWlQWkUs24BluGn+5S+03n2cIDJjv81zQHDp4nyqmeslv
         kNwX45PRiL9NiBeRiXwNEpV4MK1qNq5EhyCHNp7CSB8Omjl8IvodTY/qm08RnhyRrQuR
         3jIQ==
X-Gm-Message-State: AOAM5317vNKQeo2qjEH+qF6V4Aws23xHSEZ7e9csunevCqxyOPq91pHB
        jYrq48aXTpkeqhCh8woD4vlRgP4jpJg=
X-Google-Smtp-Source: ABdhPJzi/hYyGq1JVy+Kg6/YyIph1e7w9rOfhptzmNpInhxHnS6FKRNKDBWHCfA1x1z2+q3bOKx8iA==
X-Received: by 2002:ac2:5298:: with SMTP id q24mr1992050lfm.164.1599661891028;
        Wed, 09 Sep 2020 07:31:31 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h20sm789811ljg.51.2020.09.09.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:31:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kG18A-000414-4b; Wed, 09 Sep 2020 16:31:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] serial: core: fix console port-lock regression
Date:   Wed,  9 Sep 2020 16:30:59 +0200
Message-Id: <20200909143101.15389-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix up the regressions introduced by the console-detach
changes after which the port lock was no longer initialised for not-yet
registered consoles during port registration or during early console
setup.

Some of the reported driver regressions have been addressed by patching
individual drivers and later by a work-around for the first issue in
core but the early setup issue remained.

Johan


Johan Hovold (2):
  serial: core: fix port-lock initialisation
  serial: core: fix console port-lock regression

 drivers/tty/serial/serial_core.c | 44 +++++++++++++++-----------------
 include/linux/serial_core.h      |  1 +
 2 files changed, 21 insertions(+), 24 deletions(-)

-- 
2.26.2


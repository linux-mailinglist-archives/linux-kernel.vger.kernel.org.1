Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9102B25BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMUod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:44:33 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33298 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:44:31 -0500
Received: by mail-oo1-f66.google.com with SMTP id f8so2477576oou.0;
        Fri, 13 Nov 2020 12:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ME8CGuVzeaEeQ0eJUKBVltCEd/6H1KvgQeaVHs+oC8c=;
        b=meiiByNBgnzNRshqaojvVA3EMcekfmRO09Q/jtrR1MUPlYOG8YTWVMrY1d7M/FXNKM
         +/QxEgZBwcKvQevqCDz/za7nm8Pa6PZXRHM1lcmClCtqKP5gr1jympu0GGaphp97jKnq
         qCvpqkuKZ9cQkbXaL9hmKcw+zyM1nXxDPovxwsyQiQQe03SzVu3UfJB/d4VlcDUMBJtB
         6XMKbQ/0kT5LY1AxjOSYmQCFtzyxs63/ctfO07u4sJdAiS+BuMXUiNrST6Nkrxb/oddb
         RkypUBWXznFXyAbLcvrSR8uHP+JdkF7Z5sKwEv5iOuZXYaIfywuG0p9AaqMIa2QdtBWH
         cxJg==
X-Gm-Message-State: AOAM531yJXs9X3brbbALz4ZizEAFRAKZXnNqqbCRVosi0WPPcb1x5TZH
        d5jlE64pbdtUq4Sz7JWniA==
X-Google-Smtp-Source: ABdhPJzdJ9U1xJiS6M6L33cDAMgPWChWT3qJ/Y/ZHNieOa5v3/JDjtc+KwtaNrx/jb/iZbwS9RnSEg==
X-Received: by 2002:a4a:a217:: with SMTP id m23mr2927488ool.26.1605300270775;
        Fri, 13 Nov 2020 12:44:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm2304305otp.0.2020.11.13.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:44:30 -0800 (PST)
Received: (nullmailer pid 1963767 invoked by uid 1000);
        Fri, 13 Nov 2020 20:44:29 -0000
Date:   Fri, 13 Nov 2020 14:44:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [GIT PULL] Devicetree fixes for v5.10, take 2
Message-ID: <20201113204429.GA1955280@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes. The 3 flexcan related commits haven't been in 
linux-next, but then neither was the 5.11 material that went in for rc3 
and broke things. :(

Rob


The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-2

for you to fetch changes up to bdac39a3bd28891fb0ded91c9152459c57773462:

  dt-bindings: clock: imx5: fix example (2020-11-13 08:49:59 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.10, take 2:

- Fix Flexcan binding schema errors introduced in rc3

- Fix an of_node ref counting error in of_dma_is_coherent

----------------------------------------------------------------
Evan Nimmo (1):
      of/address: Fix of_node memory leak in of_dma_is_coherent

Marc Kleine-Budde (3):
      dt-bindings: can: fsl,flexcan.yaml: fix fsl,stop-mode
      dt-bindings: can: fsl,flexcan.yaml: fix compatible for i.MX35 and i.MX53
      dt-bindings: clock: imx5: fix example

 .../devicetree/bindings/clock/imx5-clock.yaml          |  2 +-
 .../devicetree/bindings/net/can/fsl,flexcan.yaml       | 18 +++++++++++-------
 drivers/of/address.c                                   |  4 +++-
 3 files changed, 15 insertions(+), 9 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9134728B840
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgJLNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731894AbgJLNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:48:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6377C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:48:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q1so15982644ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yfRoKaqmRgeR+8jopqBpSvNrANdCePtVj0jbsp9eEUo=;
        b=ykM40YuLL1xQWSUN6QiiXycTN9V8U+sojtx8g+EpoEFiknICOX2RZvhPtbOYJ13OLk
         Y4OnzpGsXHUjvJltUBBDau0a9FytMoYcqreIJU6RuqWnhgkM0KH4olQjdbvKKvhbcxp9
         ns2TAZRbP/y0apHiyCweTiku1zvcikn4WCQkAP08GDSYKW/+ksy3yvxNn7ExmmCroLrY
         2BF+MR6g65e5R89oascw+AJzE145Re/5abs0D+t59cCHCSAYpkrqi4iPT0jZtleXTWCO
         dTGVQHESTOjYkE6ROet2osxyB87WKzGmNzJJFdAHg3VzgJQ3XbAe03jMpj4iL8Q8T+3e
         494g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yfRoKaqmRgeR+8jopqBpSvNrANdCePtVj0jbsp9eEUo=;
        b=h7cLVaA4dY1oACMtRvBRlydFI3+o5SUMOC7S5kNRg1FxZkGSHSutKqyGp3HW+2ACOh
         YvP9MWn+Q/XIlH5oQTPsy0Yn1Hi/pJOJmgR/MRkainX9RAxnPAUbjIbKlnKLBdqZhJUO
         hHlp2U/axNljWaCy3t6GdiA65uRa5l2jNiv5BGpZVt/0B7cBuQmv9UISzO4CZnWRk2Nl
         1i0UzTItFhWxfIyMamH/S0VBhT01+4nINAJ2YeGCM+CsTvD7elfb227AkVwmMgSpu1VO
         1XEtPPVvua7NUMu1mdMG0fbvrzv06USsLB/32BlX6zTbFnUgpDMfnoKsjQAHx8LCFGUf
         rl8A==
X-Gm-Message-State: AOAM530boOpFZDKi9rpwlvGnl0uwxvJP52jnLITpJDgaN7hcST0eiZDc
        kOEMd41NHH9LmnmLAZ6blhf6WfPr4qPOsQ==
X-Google-Smtp-Source: ABdhPJzXKR43snLCYU9HEqNgWLsb1aJQXTQVI1R9BZTLmoyh/zsSR0adYgFcMfuyWUVLSQgkmjtUuA==
X-Received: by 2002:a92:c507:: with SMTP id r7mr20050416ilg.52.1602510496739;
        Mon, 12 Oct 2020 06:48:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k198sm9383648ilk.80.2020.10.12.06.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:48:15 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata updates for 5.10-rc1
Message-ID: <d4e07ddd-092a-256a-5b25-841e95fa3fcc@kernel.dk>
Date:   Mon, 12 Oct 2020 07:48:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nothing major in here, just fixes or improvements collected over the
last few months.

Please pull!


The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-12

for you to fetch changes up to 45aefe3d2251e4e229d7662052739f96ad1d08d9:

  ata: ahci: mvebu: Make SATA PHY optional for Armada 3720 (2020-10-09 12:47:56 -0600)

----------------------------------------------------------------
libata-5.10-2020-10-12

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: remove LIBATA PATA DRIVERS entry

Gustavo A. R. Silva (1):
      pata_cmd64x: Use fallthrough pseudo-keyword

Liu Shixin (1):
      sata, highbank: simplify the return expression of ahci_highbank_suspend

Mika Westerberg (1):
      ahci: Add Intel Rocket Lake PCH-H RAID PCI IDs

Pali Rohár (1):
      ata: ahci: mvebu: Make SATA PHY optional for Armada 3720

Yuantian Tang (1):
      ahci: qoriq: enable acpi support in qoriq ahci driver

 MAINTAINERS                    |  9 ---------
 drivers/ata/ahci.c             |  4 ++++
 drivers/ata/ahci.h             |  2 ++
 drivers/ata/ahci_mvebu.c       |  2 +-
 drivers/ata/ahci_qoriq.c       | 20 +++++++++++++++++---
 drivers/ata/libahci_platform.c |  2 +-
 drivers/ata/pata_cmd64x.c      |  2 +-
 drivers/ata/sata_highbank.c    |  7 +------
 8 files changed, 27 insertions(+), 21 deletions(-)

-- 
Jens Axboe


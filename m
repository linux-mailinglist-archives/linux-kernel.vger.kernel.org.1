Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4792FD6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404139AbhATRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404092AbhATRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611163072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VgDQfCPtQBys8MT2VsZyOXdV6pltJWywaOJZjqOfM6o=;
        b=Gwtl4jzHtl4a6O6bxDZUky34tA+74qKlsVrTVeIil0PXzUXyvEMitWFdEiBHMrFDqzOkvB
        cNOSO6ClAf6itv/DRN2/u+aNm6Q4YIPKkRuK+bEnRC9UVYW5A0qeKLEDqXT4IL6eg/wFdZ
        epvAXnWpbBN2uFIEXkYKA2yMoQoN3Kc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-TzHNMdvJMQCT_n44ubWu4g-1; Wed, 20 Jan 2021 12:17:49 -0500
X-MC-Unique: TzHNMdvJMQCT_n44ubWu4g-1
Received: by mail-wr1-f72.google.com with SMTP id w5so11834826wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgDQfCPtQBys8MT2VsZyOXdV6pltJWywaOJZjqOfM6o=;
        b=QAnKX01Vz5dlP68XFHOW9lSlDvrCYyCoGBPYhgftAJe+/OGvlSjWmMKRBHN2Aaih+C
         Vk1Tr1zJO5NIUdQw5ykD2UgHLXQy+SWzc8Q3a/78f9NgiFmoaSIPTaNqDTp6o1C3VZKA
         FVbFuTkrfy7eULCwrjEtC0YDn6jBoJUQZ51/3tbBRyT11rcFXFPOpoFLYCblR+7rSjA3
         3bUVd2frQTAd01NmRrDKFhsEsV37PcCJGuahd5CHuBsQ9/Qst0UwTZnxJg9t9IHdg+rR
         lXV9Tb2d7RuxbynjeydDCRy7YJrRQyyzmjxQe8e56KWDp/21ioICZwtmKXTfNmEfP1jC
         tHAQ==
X-Gm-Message-State: AOAM531O2/JS/IpHG0scVMEoXOWCbmqnOmiZ1ir6Q0dEoT64h5Mr2bRc
        VVhB7BXdXoLto+uJ19+m8vIq4dYHDO33wqG5lbM87YDWTrW3ODQHDl3rzwfKMFVGmIs2lkaJK5P
        qJPSO1GHQaHBvunkmF7E7Lvvtak1eMQgGV662Rqo437Zoyt7sGlB5mCErU0NpTQJhEVM6pF2/u5
        5z
X-Received: by 2002:a1c:10c:: with SMTP id 12mr5360385wmb.186.1611163068088;
        Wed, 20 Jan 2021 09:17:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGKhN/2NYR2T81zX9s+0t8pvkyuYr5imMnERQIJpptWc9hpg0Dlvkm1YAcD3S5poubpx+etw==
X-Received: by 2002:a1c:10c:: with SMTP id 12mr5360373wmb.186.1611163067945;
        Wed, 20 Jan 2021 09:17:47 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o124sm5444077wmb.5.2021.01.20.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:17:47 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 0/5] arm64: Prepare instruction decoder for objtool
Date:   Wed, 20 Jan 2021 18:17:40 +0100
Message-Id: <20210120171745.1657762-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support arm64, objtool will need to be able to decode aarch64
instructions. This patch series adds some instruction definitions needed
by objtool and moves out encoding/decoding functionalities that do not
rely on kernel code in order.

I'll post the start of the arm64 objtool backend shortly.

Thanks,

Julien

-->

Julien Thierry (5):
  arm64: Move instruction encoder/decoder under lib/
  arm64: aarch64-insn: Add SVE instruction class
  arm64: aarch64-insn: Add barrier encodings
  arm64: aarch64-insn: Add some opcodes to instruction decoder
  arm64: Add load/store decoding helpers

 arch/arm64/include/asm/aarch64-insn.h       |  552 +++++++
 arch/arm64/include/asm/alternative-macros.h |    3 -
 arch/arm64/include/asm/alternative.h        |    1 +
 arch/arm64/include/asm/debug-monitors.h     |   14 +-
 arch/arm64/include/asm/ftrace.h             |    2 +-
 arch/arm64/include/asm/insn.h               |  476 -------
 arch/arm64/include/asm/jump_label.h         |    2 +-
 arch/arm64/include/asm/uprobes.h            |    2 +-
 arch/arm64/kernel/insn.c                    | 1416 +-----------------
 arch/arm64/lib/Makefile                     |    2 +-
 arch/arm64/lib/aarch64-insn.c               | 1426 +++++++++++++++++++
 11 files changed, 1985 insertions(+), 1911 deletions(-)
 create mode 100644 arch/arm64/include/asm/aarch64-insn.h
 create mode 100644 arch/arm64/lib/aarch64-insn.c

--
2.25.4


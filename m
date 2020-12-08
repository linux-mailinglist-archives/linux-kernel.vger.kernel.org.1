Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1B2D3533
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgLHV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHV1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:27:00 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C38C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:26:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b144so28532qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7bksUnXGm2SRwxtGt7t4Adwh+RQG8TGIYIzlogr6KQ=;
        b=VE+oO/mW1kZeC63M0fcA/fQ9J/rYwFwBCnjW/EOJ+mjRrFjh+VOWWnLRrVB90de2/H
         9yJonsDzaZXELVUBTrf8uefJ8ZXZCCJbcaACmRwXF3/J7rPeWIRVT8nNe/OUXkgBJOc1
         9TGbIjDzraC0JBqAacQJSo/4lbZaldHIwf7D5gcrtM3bIw1t0gfAwIIJzrRTs7QvSaUo
         +v3WsILM7x2Grzf1PtoeVECkYfSGYNcgz21bmyitALShC3h16aVfqFjxz3gxp3HAtytp
         8EmGl1ZXvG/lMjNkgIibXwMAGG5c0FA8P4fApBmoOCL1mpEjMcm+wXolPZBCuNB91Zby
         XS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7bksUnXGm2SRwxtGt7t4Adwh+RQG8TGIYIzlogr6KQ=;
        b=YASCHxLM2zRcB6h16qBM7PUDTpkV8iQCi8018Ga5jv32pkTL60FEnUcsQn/hmz29vW
         PS8OJx7/xIaRQdMgFBFMqNMdGC2q9LR2+EeL5Fgp0Ji8Od4AR1LWWIcw3wxxeQvD+duf
         pckGx7201Np3VNweDQNPEk9hIuy7u86yx7XHSkpPBUD28UP2KJJ+T7q4FgJaMB+eHGpG
         wohW3kCqQZGOLzxCKXZntWEz06BF8vh99CBZb4AOxEbgmpB3O4bDIEWCOUNc9lpGIA/4
         Hl7u1XMYk3k9QZiE23f4i0vYkBJIAk67SA+Yb0lL095ELdt39wLqzztfYPBGn96VDPpg
         /F7Q==
X-Gm-Message-State: AOAM532D5O0dtmFb1L0lyJ+xI9jeNnzNpDNtCbUrYxCRpA4E9nWt3oCU
        /MEMYa6rM5DlRwBmPXbVBXM=
X-Google-Smtp-Source: ABdhPJzYqd4nyTEXCSHNT2uAtJH8FaTn0IkgekF1EZ+gCKlaKSDQpRxcq0/C6lJmS0n7iLvifX51Hw==
X-Received: by 2002:a37:6717:: with SMTP id b23mr2711910qkc.100.1607462779271;
        Tue, 08 Dec 2020 13:26:19 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id l1sm16018572qkj.101.2020.12.08.13.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:26:18 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ALSA: hda/ca0132 - Fix no-audio issues and add documentation.
Date:   Tue,  8 Dec 2020 16:25:40 -0500
Message-Id: <20201208212546.428392-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series attempts to fix the no audio at startup issues that
have been occurring for some users, using information gained through
reverse engineering the ca0132's onboard 8051 processor.

The issue of no audio on startup seemed to be caused by two separate
problems: not resetting the codec upon initialization, and not making
sure the DSP allocates it's DMA channels correctly.

Tested and working on all cards, except for the AE-7. The AE-7 shouldn't
have any issues, however, I don't have one on hand to test.

As an aside, I'm not sure how to classify which commits this necessarily
'fixes', as it's covering multiple areas. Please let me know if this is
necessary.

Connor McAdams (5):
  ALSA: hda/ca0132 - Reset codec upon initialization.
  ALSA: hda/ca0132 - Add stream port remapping function.
  ALSA: hda/ca0132 - Add 8051 exram helper functions.
  ALSA: hda/ca0132 - Ensure DSP is properly setup post-firmware
    download.
  ALSA: hda/ca0132 - Remove now unnecessary DSP setup functions.

 sound/pci/hda/patch_ca0132.c | 567 ++++++++++++++++++++++-------------
 1 file changed, 363 insertions(+), 204 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4704D2D6132
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403804AbgLJQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392345AbgLJQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:08:03 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4609DC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id u21so3990351qtw.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWcL1BT1QnuDHTcH3v/ubnDXY+zwmaZ9OopY/z1kEGs=;
        b=BbuUNdyzevxIabi7TLgvhg09a3l3rlMVzOrqHgXrwq1KJl/vitSwd6WlcNDBm+oM7D
         eeFGQEeECpb36rhNTEbLjd3tX4ZJeSxkrmc1MZi3LLF0FHtq7yO7RymW0wJFpuUqrcgl
         HBk5OYlFWLhi7JHM48BtAISHG9k4PeJAswUpg0py0Yjqed+A4RCouWuQ2uDVfKpEMqex
         izHG7Xw3iU9aMyp9vu+29D91cW5EIlrwj7py6s/C3tCL/DdoYQXcsf64pDHuYdZthoU2
         wORc5RXFFo8Zo5cNMInUmIIj4tWj99tdl4D23xq7u39u93KxDd8J5jR2kKboHUGd6Y4g
         /oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWcL1BT1QnuDHTcH3v/ubnDXY+zwmaZ9OopY/z1kEGs=;
        b=kilFjz4himTIe+8agdZ52/GC8up/ZrasxpHUazhLD7pYKZy8b/DewduTQiKjao77Al
         YccXJYMPQE1yeViNkKf5DiV20RftIkf2ZpGaVPB8txI5t/Azlne6UIsHn+1tnlId4dr9
         TE1UvKinZzNSnch0fNenmHMbRlnqeVB/maqINKm524a63FXQ4UiOYhs2HNheVTw4ch7B
         D0mJU+yN2VWwrwfuwmDGMrtA+95lByly837xhSXy1OQqpLAxgjdRVKHGSgEUMqZId8qa
         hl2F9TwpRNw/BMQFSIaRoADCga2Z0W5DbCOKffIo4SDRrRUltEMF5/HTzyoxAidUuRCh
         I8VQ==
X-Gm-Message-State: AOAM531hrrmyGOn4fVYgFUBHLRyOjKjVPSIq06dhjybopj+xfWSyNBB8
        eoU/FWhKjRVE0z60RQfoIIYAhVpDOgg=
X-Google-Smtp-Source: ABdhPJwUjH70nFSoAI0x9PvKB6ZmS8lQ3yjwtIsKxQRfxgl3pLZr2BSXQm9apIOqjGjNbGnWBrOVhQ==
X-Received: by 2002:ac8:7111:: with SMTP id z17mr10060844qto.369.1607616442534;
        Thu, 10 Dec 2020 08:07:22 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:22 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] ALSA: hda/ca0132 - Fix no-audio issues and add documentation.
Date:   Thu, 10 Dec 2020 11:06:52 -0500
Message-Id: <20201210160658.461739-1-conmanx360@gmail.com>
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

Connor McAdams (5):
  ALSA: hda/ca0132 - Reset codec upon initialization.
  ALSA: hda/ca0132 - Add stream port remapping function.
  ALSA: hda/ca0132 - Add 8051 exram helper functions.
  ALSA: hda/ca0132 - Ensure DSP is properly setup post-firmware
    download.
  ALSA: hda/ca0132 - Remove now unnecessary DSP setup functions.

 sound/pci/hda/patch_ca0132.c | 558 ++++++++++++++++++++++-------------
 1 file changed, 354 insertions(+), 204 deletions(-)

v2 changes:
-Remove conditional mutexes from patches 3 and 4.

-- 
2.25.1


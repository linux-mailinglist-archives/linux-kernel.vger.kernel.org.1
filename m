Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C042E317F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgL0ORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 09:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgL0ORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 09:17:20 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB5C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:16:40 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 19so7024176qkm.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0AMXmohgDXh67JQTuG0L3iD6jFpb52IIJ0q0yCMfrzM=;
        b=xchUb5W33cVPXF6LiijPHUZj5P1x/gepTtXRQ14tdQkonshBBFe4ljo+8cw0KoOEkS
         z+CP8qswf+WkAyGTjT6kxsTLL/W2qG/aDqo7Rfgdq7Wzzj20IfiO4PnHSC6MaRXl7LJa
         HxuFrDEXZ6YMbRksYvOB9UWTDPpqBbtC02PbeXAn9pmiyAFnfnAsBMV24zTFeYlmU/Ue
         xlKisqQf9SFlMdsIobqV/vVAXnVZBwy6KZuf9SxWO0+zySFZIcWCKPz3RkeEqnYoMxJ9
         JOu7o5Y8pITi3b/tn+USstbUcVjps8Wwo3i7S9OQPY+lfbOjYzElwoOWTtkbT6DfqJry
         c8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0AMXmohgDXh67JQTuG0L3iD6jFpb52IIJ0q0yCMfrzM=;
        b=HA3hz4tG5YkIGcmG2/WPVxnFCKTFVgvZWrLccvbc6IOuv3HLHIF7CDwRi1sEaqHQ8B
         +CujmwjwsiTexYbhG51Wmhmrs+CaDPam4tctFNWISySXcWL84RmgdpJPKMRQMsmTj6r7
         OnjzPe4eCHsCvZNgmFRaSOlBa6+FddFsmtIj9199BGxLM12Ivnp77pS5iI8xcxwlQJnY
         F1j94HIWZpbYyyRZaTNlQfhugqil3VgSP4bAq0q3lDz0OtRdAq/SIsTyraooCcPAyDtW
         a6RF+tzC4weQgWXI4UI2IA6JRQIyCDJIyb34dFMRLMm20gE7Yzs48auYADOAEl/Gr7bI
         N9kg==
X-Gm-Message-State: AOAM530bVMdZu4eqNGpjwAnH2Y1wwT3qU2X0W4eAEI3cG47Un7mkK3/r
        OLW4rXd+Aqb7zC1+zYwS9karm8ESM6FGNg==
X-Google-Smtp-Source: ABdhPJwhAMDbcuIV5a8Q3m3EI+05Agd/ft9XZBb4hn8SuQNCEkOk5lExdBWolw1U9C+kw/jmb5jIUQ==
X-Received: by 2002:a37:a495:: with SMTP id n143mr41220702qke.362.1609078599101;
        Sun, 27 Dec 2020 06:16:39 -0800 (PST)
Received: from localhost ([2605:a601:a606:1b00:b541:53e0:ad17:6f6])
        by smtp.gmail.com with ESMTPSA id a194sm21323259qkc.70.2020.12.27.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 06:16:38 -0800 (PST)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Sun, 27 Dec 2020 09:16:38 -0500
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.11
Message-ID: <20201227141638.GA11393@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for v5.11.  Please consider pulling them.

Thanks,
Jon

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.11

for you to fetch changes up to 75b6f6487cedd0e4c8e07d68b68b8f85cd352bfe:

  ntb: intel: add Intel NTB LTR vendor support for gen4 NTB (2020-12-06 18:18:03 -0500)

----------------------------------------------------------------
Big fix for IDT NTB and Intel NTB LTR management support

----------------------------------------------------------------
Dave Jiang (1):
      ntb: intel: add Intel NTB LTR vendor support for gen4 NTB

Wang Qing (1):
      ntb: idt: fix error check in ntb_hw_idt.c

 drivers/ntb/hw/idt/ntb_hw_idt.c    |  4 ++--
 drivers/ntb/hw/intel/ntb_hw_gen1.h |  1 +
 drivers/ntb/hw/intel/ntb_hw_gen4.c | 27 ++++++++++++++++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen4.h | 15 +++++++++++++++
 4 files changed, 44 insertions(+), 3 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1402C3F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgKYMBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgKYMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:01:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A41C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:01:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p8so1655145wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3zKQZ7VBivnaM9jKVduh3uJv6aA9cicflV82nD39vUk=;
        b=MG8XG7i4qZ2aAl0KJfacSV/mXUJm4RuaSstWRnLq+rjtfnlRsrJPmv9vZdhMpahPw5
         gJYNCqr5udg3Tbc84wNKxWAGptNVmvhCpQ7Aw5oJZ6iljJVOTvgabXljxICB8Mpq7F3B
         gjaVsqLXUDUdMx3NrBBOFyP23sMw6R7P8oZpWUmIi7DWGdSskr5lqUEhAxtY0xHNVJ/B
         VFkW3h4t5iVlrCjLvOZt+K97K7h1kghq/ufGII6JQWpMIrccXrQIo2TeqEGUENvkVSe3
         nkZvw59bfdrkmuLmlCwmhCgWSb/WKfERC2ZOjSohmYMMbR0RsZ0pARqlh/sGqSO/wuxZ
         r7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3zKQZ7VBivnaM9jKVduh3uJv6aA9cicflV82nD39vUk=;
        b=UOsaUI98BF84XBWYQc4ifj51VHiHn2gVBMheJ2/AJaF+88aWVLDEpKX1eOHVM1yRQ6
         MnW5BSzoky2biLkPjadLk+6mdpvl4j/GtQmK8fIzil1QGwlZ/hSYMDM1+ck5OG3g5xTv
         clKlXnD/Csv26yfLbrqY73j07J2jvsm27Hn26EE9w2NKZjK9wLTgPsofM8mea3E19sQ4
         i3FYoBbLZr3ZxLULDOWcVBlOu6iJGfOfOrgoCpVAJqFYCKDeDOgv/dEGVVp8Pr6SY0k+
         sZ60vzcThgIXuXgqQnU0KEK3zEhX2SYudxdHR4czFO1pY3E7a+yhWyejoh1nlY6oaMcD
         duRw==
X-Gm-Message-State: AOAM532Y9pLXY+gIX7TCMtKdht39452wAJA+w4y6XQuX4jsKj9reaoPZ
        iqV2pr6MG42gUwkdW+12pYTAendSv9owNmAT
X-Google-Smtp-Source: ABdhPJzrCqLUpGNxv8G9Y12RnxZPuIc8lbx4JFE9WG0UPE1mFNyOkP4AgFKAq9W08gdTHbBWhv5iaw==
X-Received: by 2002:adf:d082:: with SMTP id y2mr3805368wrh.301.1606305696769;
        Wed, 25 Nov 2020 04:01:36 -0800 (PST)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id j6sm4336173wrq.38.2020.11.25.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:01:36 -0800 (PST)
Date:   Wed, 25 Nov 2020 13:01:34 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [GIT PULL] OP-TEE driver for v5.11
Message-ID: <20201125120134.GA1642471@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which allows the OP-TEE driver to work with
ARMv7 based single CPU systems.

Thanks,
Jens

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-valid-memory-type-for-v5.11

for you to fetch changes up to 853735e404244f5496cdb6188c5ed9a0f9627ee6:

  optee: add writeback to valid memory type (2020-11-25 12:51:52 +0100)

----------------------------------------------------------------
Add writeback to valid OP-TEE shared memory types

Allows OP-TEE to work with ARMv7 based single CPU systems by allowing
writeback cache policy for shared memory.

----------------------------------------------------------------
Rui Miguel Silva (1):
      optee: add writeback to valid memory type

 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

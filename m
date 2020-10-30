Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4429FD68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 06:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3Fnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 01:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3Fnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 01:43:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54923C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:43:37 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id l2so6364174lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eYsl1BqzDufF9gIkRU7zyQPQ1SqyaF7NvuXYCWLKpRY=;
        b=T8NbNm3wa7kgY64kooCg64o9gGVQGN2NnYNPeaqHUsl4AEeugsgu7YlQNs1CgoumOX
         IPcIP91uYUsg1vIoBaElFr019oK//ALfkUuvzy9U3SbsFVErIRCwQYPNdHRzknndASMN
         JcNH7mSuZ8xi46JGGfvd8gl7vZEJAjz+tLK5fBs7xjQpP9as9XfnkPUqFMlaRo7HBp0g
         6wr+Pfq+sHfVr1G+0v3mS1g5G5qaQ57dolUQxaCsRUMgop5nQM7+O29Vbsp+mMCdncl5
         CeS1hG4q/bflq3w0t9pHNObKzk1xl3SDc2Ox1F/HyRBkuZJv8wCu1UVCTb/qrly61TKR
         kTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eYsl1BqzDufF9gIkRU7zyQPQ1SqyaF7NvuXYCWLKpRY=;
        b=lac/j1tC/VSlg8Kd1zc49xclgLu1iiXflVbacUKoz0jMJ8Svp1/SOo49PpG+q/pPbD
         Ek2C8ht9A44qnqwOz0lhXq74pOKAMJxJnEX1tHGivX5tOlHB0xnMHxl0oqozsIsPTxG0
         0OtxdmrP4RhxBYIUqplUDUQw8MEET6CML0t/zBTNWsTpCpLdYknNWZ+7H+yCoCZnbn9u
         Hi4OmhjhY+O1wSxT/HK1h006jes1C86crob/bcPT3g4pzEP/gEH5NU5pZHCdrTDa/AwN
         eIiGrbQHvPsiF3chvZbmOdkRv/dzQBZ22C4/dP4+wNR4cgdiVWZaabce1FtsFqkChIq+
         89AQ==
X-Gm-Message-State: AOAM531TSjs+PyyJL4BqblcN5L31sqjt+w6I47KCvRxkJjrR1lQifisL
        xUv6vDItGM6MgsjmNhy2BH6YzW2/EKpC+2CoV+jIJ0FyNlkk7A==
X-Google-Smtp-Source: ABdhPJze6wqLrQvDmAiLjR0MEbcBF/Rh3vVVuXUEfsLkrypL1JQlNWJvbyiJ6vJdGrZhiVUd/W5cxdbXEQ5yga4FVp0=
X-Received: by 2002:a19:64b:: with SMTP id 72mr212866lfg.47.1604036615192;
 Thu, 29 Oct 2020 22:43:35 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 30 Oct 2020 00:43:24 -0500
Message-ID: <CAH2r5msNpjEaBV2er7anqRsDE-9vYRZnsDif0+odOJAYL_aV6w@mail.gmail.com>
Subject: Ubuntu mainline kernel builds now failing not able to find module.lds file
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I typically build cifs.ko for testing using the latest Ubuntu mainline
build - but building a module in the 5.10-rc1 kernel - while booted to
the 5.10-rc1 ubuntu mainlinekerel - e.g. "make C=1 -C
/usr/src/linux-headers-`uname -r` M=`pwd` modules
CF=-D__CHECK_ENDIAN__"
which has worked for years - no longer works.

make: Entering directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'
make[2]: *** No rule to make target 'scripts/module.lds', needed by
'/home/smfrench/cifs-2.6/fs/cifs/cifs.ko'.  Stop.
make[1]: *** [scripts/Makefile.modpost:117: __modpost] Error 2
make: *** [Makefile:1703: modules] Error 2
make: Leaving directory '/usr/src/linux-headers-5.10.0-051000rc1-generic'

I don't see a file in scripts/module.lds in
/usr/src/linux-headers-5.10.0-051000rc1-generic/scripts directory

copying from scripts/module.lds in the 5.10-rc1 git tree to
/usr/src/linux-headers-5.10.0-051000rc1-generic/scripts fixed the
problem but was wondering if this is just a packaging problem with
Ubuntu (missing a file in the kernel headers package for their
mainline daily builds?)

-- 
Thanks,

Steve

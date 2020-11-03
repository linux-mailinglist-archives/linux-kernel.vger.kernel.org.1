Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71032A573F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgKCVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:40:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39282 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732733AbgKCVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:40:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id y12so19984956wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBJK6gAc4A6HKX1XSgfdTrGrZFL3pG4DMAC+mbxLKTw=;
        b=NCESA9uq93W4x2E17t9GTXR2uJJgsW2oWiX6zg+4v8Hp+mM8fH842k44d2n7D5VSJg
         Ds9xONO0lCNJUP2qb2rrvrhvbrsJHE3RUQeT6Y8x8TSt5/7+kYFTV+7SVB0WsNdZAh6e
         GWP6Vbuoo062r8oSPhYCEYL7Z/YDC3c701e8i7UbZyXjh59l+VWOC7u+ZoBvOZqGdF4L
         joee2idKRLUJAio7FPwQZBFs1TVGYmfkkV4zZsrzqQufUZ2c1uLw7Ce8ucksSAZ55NB1
         QFRdy55t4ul1utOVv/k+m67SJlZG1Rbw9NjW4wSYRwxZHiRn3Tl5t5opTVXko3Kr0NeL
         UXoQ==
X-Gm-Message-State: AOAM532u+hDaxg3REIF/nq8syEeCTiA/7a2nLj1hUeJn5maHZxRVVmnb
        Bws5aHQauCUrmRM224iSWK9Wh4fCyvSueDYM
X-Google-Smtp-Source: ABdhPJx0D9M/FGVDpY32siW0SgrcYDYopddy1ngexK6ScQJOpCT7Tv2mS4B95pDslRd0+VTWAdoNkA==
X-Received: by 2002:adf:f687:: with SMTP id v7mr30129447wrp.179.1604439628982;
        Tue, 03 Nov 2020 13:40:28 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-5-95-179-145.cust.vodafonedsl.it. [5.95.179.145])
        by smtp.gmail.com with ESMTPSA id o63sm84450wmo.2.2020.11.03.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:40:28 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/3] fix parsing of reboot= cmdline
Date:   Tue,  3 Nov 2020 22:40:22 +0100
Message-Id: <20201103214025.116799-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The parsing of the reboot= cmdline has two major errors:
- a missing bound check can crash the system on reboot
- parsing of the cpu number only works if specified last

Fix both, along with a small code refactor.

v2->v3:
Revert the offending commit first, then fix the other bug.
CC stable
v1->v2:
As Petr suggested, don't force base 10 in simple_strtoul(),
so hex values are accepted as well.

Matteo Croce (3):
  Revert "kernel/reboot.c: convert simple_strtoul to kstrtoint"
  reboot: fix overflow parsing reboot cpu number
  reboot: refactor and comment the cpu selection code

 kernel/reboot.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

-- 
2.28.0


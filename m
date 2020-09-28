Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F927AD99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1MOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1MOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:14:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C236C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:14:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so8172339ejf.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ULrSf82cVDYxU3BYbb7m6MDttIpV3C4Y47Llm1GUmmM=;
        b=RYu5+Otf5FEX6f56j8YIX5wR0ismZYUj9KwUidK4Ky/3nHe91MMusAiJHvYtzUj3ZS
         83Blo43RlqTcu00g7T/v2HJeD7FskeRP5dKU8uqUL7sROkb7zAD4jFpx05gofs/9FmK4
         GoeBfl1scYDfuGddxFU7mhF22O8A3jiCEp7YBrBSkp3TcbfPQqdr+l7cOYHX/trJL9d7
         6IT/QtfYLj3AvCfxnC/ss8B4FceydqW4DLBQ4NAL21+37tB3ZCs7UEJlFStEJHdBV+/m
         oxxi0goCOQHHK6M68btJy2raPmpyXwT9kBNbXdVmrBk5lzSMmHeeFmAPZCk2jTh/f9Ft
         H2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ULrSf82cVDYxU3BYbb7m6MDttIpV3C4Y47Llm1GUmmM=;
        b=Ftn/iKXPi/rYU7nRNHdWg2QVL9YbPOG0s1+ufpVOaWMtbyxO+Abtw5gL3ufc5+GBA4
         jNWKR3NSC6rq2quw7905GeWhRvBoDrp+4sV//kQkyTEfGMSU1zv5yFznX/qEyXEjwvBA
         2TeSS2PPTD0N+chbZXJgFdRoOHN/cH2K3nY1N6FCQBzDlaHOsTX37G1Emuq3P1qHqfx0
         6EYLetI88ouQT3mcrgb3UQGzYezp3gh7to9kNQhCBAbU+ZRcil9rJ1JPAYuurwxwRJTZ
         PyI5iSer7sP8OAjbT5a6YdH/s0AUH2M3P/F8KR7qnCjwi+LXQ+qPGoPzr1v04rGR0pH0
         QmPw==
X-Gm-Message-State: AOAM530x1GF/wYg08VeOBHuCSLIJNBhe/QRLi0+05egSHWzaSDclisQZ
        13WB7Az/nEMzfSHC78Zewqz12Q/7m7y6UR6L4BdwdQ==
X-Google-Smtp-Source: ABdhPJzyXErbSkHAJICjNnqPWiqQnKU0mMtCMTF0AauvxqADR4UegaiDlNtrxhZJCdOOpXcvF6uv/dIltrwioMVI26E=
X-Received: by 2002:a17:906:f6c9:: with SMTP id jo9mr1312638ejb.233.1601295277452;
 Mon, 28 Sep 2020 05:14:37 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Sep 2020 14:14:11 +0200
Message-ID: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
Subject: SPARC version of arch_validate_prot() looks broken (UAF read)
To:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Khalid Aziz <khalid@gonehiking.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From what I can tell from looking at the code:

SPARC's arch_validate_prot() looks up the VMA and peeks at it; that's
not permitted though. do_mprotect_pkey() calls arch_validate_prot()
before taking the mmap lock, so we can hit use-after-free reads if
someone concurrently deletes a VMA we're looking at.

Additionally, arch_validate_prot() currently only accepts the start
address as a parameter, but the SPARC code probably should be checking
the entire given range, which might consist of multiple VMAs?

I'm not sure what the best fix is here; it kinda seems like what SPARC
really wants is a separate hook that is called from inside the loop in
do_mprotect_pkey() that iterates over the VMAs? So maybe commit
9035cf9a97e4 ("mm: Add address parameter to arch_validate_prot()")
should be reverted, and a separate hook should be created?

(Luckily the ordering of the vmacache operations works out such that
AFAICS, despite calling find_vma() without holding the mmap_sem, we
can never end up establishing a vmacache entry with a dangling pointer
that might be considered valid on a subsequent call. So this should be
limited to a rather boring UAF data read, and not be exploitable for a
UAF write or UAF function pointer read.)

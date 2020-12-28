Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F362E69DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgL1RvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgL1RvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:51:03 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56231C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:50:23 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id et9so5263110qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZMfCfjHbif2syrZaGixEYwXg5QwVzqeWzIKkiTTdBE4=;
        b=gV6ksufRtAkuL5xKIiYHzgXP+k4lTwFRxFlgyXAWKgvH0I+1OtNxHkrNmbg2O7pDHC
         wj7zqhUMeHbX/cSSxmZp1qcmq3BH4Efe2S1MTI57Nb20hUFMMVZPBqnbcsx897jRpBmz
         Fc/chi2YRddKt66mKky9KJtZ4d1Z2qtF3ls3D/OrD05ozmzAuz9c2G22ACI/YVgmOf4E
         CbO6XTSl+Cx9BNxNSS/3BNidMj4/kgSzw7WdZNJCfj+p1XuDF0PwQoyNjqZXPMd4rGvb
         q81Eii/rMDEDVCRxUm05ijfLQTj9DFMmGxGIBBS1UlbPlWhSPEg+YEJcKGZpNfojYDr/
         T4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ZMfCfjHbif2syrZaGixEYwXg5QwVzqeWzIKkiTTdBE4=;
        b=S7kA8iyDOXDhP92TOG8PzcfoZWvDfGvFQi+456h50LJmtbO6eKtubq3Ik2p5nN3sdQ
         GY8ocAmi19hVMAZ9zonkd1Dh0NU7F7BExSorFAc8ig/U2jeUaiujxFEMZXYnNhJ1nKJI
         Hqhrm99/Zr+mbd1JbcifBGshSFnWU7rttV7EgEkYMB22UNhvumO5Tm2nyJNqFi1RrwYl
         lfZJ7Njx9TlkLssbkJT11qN9rwVO9/ooNkAdOu7Pg5wNYvVVWjOQnccwVewzwLfJ4YqK
         Jrceuzk/euUIkSe2njmRTDKpVbNSYnVFl4DqfahOhqBlAiMmuaQIm5pnhphcK0kcDAsD
         cH7Q==
X-Gm-Message-State: AOAM531tDLD2cdB5dFHi1yR0TlnnqoGxbYwBvhffKhTFacVxsYw/0GQd
        tAq4wpPKKkExhdfuWqZQuvA=
X-Google-Smtp-Source: ABdhPJwFzFW6MReKZpZ1zPsma6IkUvgRspZiLsERIe8ejATwJUKD7UxkL1UoK6tskWlvyZk4XRs6zw==
X-Received: by 2002:a05:6214:a94:: with SMTP id ev20mr48150602qvb.56.1609177822430;
        Mon, 28 Dec 2020 09:50:22 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id d14sm24645100qtg.97.2020.12.28.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:50:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Dec 2020 12:49:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for v5.11-rc1
Message-ID: <X+oat9YaT6+ZKTL5@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, again.

The same as the cgroup tree - one commit which was scheduled for the 5.11
merge window. All the commit does is avoding spurious worker wakeups from
workqueue allocation / config change path to help cpuisol use cases.

Thank you.

The following changes since commit 127c501a03d5db8b833e953728d3bcf53c8832a9:

  Merge tag '5.10-rc5-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2020-11-24 15:33:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.11

for you to fetch changes up to 01341fbd0d8d4e717fc1231cdffe00343088ce0b:

  workqueue: Kick a worker based on the actual activation of delayed works (2020-11-25 17:10:28 -0500)

----------------------------------------------------------------
Yunfeng Ye (1):
      workqueue: Kick a worker based on the actual activation of delayed works

 kernel/workqueue.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
tejun

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8D1EAD89
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgFASqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 14:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgFASqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:46:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC601C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:46:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so507761wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fX7NmrPN5XxhBSXNanaz2PuQSRXaxuBDla0rSDY6J40=;
        b=SNNL2yI2h8wbX/wOH2WC/tSn3u9+PxY6lJ1O/HxaEVGmbgK7QBYCK66v/DFlD87ra2
         4KRCN22e81nV/CAjX2/2YFJwaoOq4Xo1qeWo31dd810bOX069WAbrrzpFv1GSb2iaGbw
         wKpK/2qwKNm+hWl3aNFMf+99rucwpXScnYQa1oGvDqFhMH7f1eS66HAnU9eHiw5AZU8l
         8w28NWufEgo0tw/uK0uquX5+3yW67EpZS3RM4IGQ2YzfhuuBkcpgQ2kPzOyJU7m56PwD
         JdFKyNAO11+7tVT3jHJnU1Y4lFTVLJk+o2uEUMd44JNtDy+6pK/BSn3TZTnO4iGro97n
         dmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fX7NmrPN5XxhBSXNanaz2PuQSRXaxuBDla0rSDY6J40=;
        b=F8N7K0MwBHc3rDjOb3ibi4aI2S4dx03eSeJWzrr8V4YwYL+i0opfQ7Z8whZbXBKMMz
         7Ya752X4Wd+bRC5t00fIzXrkPrD1NQyRyw7vciVyvwbmoqi/m0UmPLTINMPskgKbLT+Z
         kvIkqzUnd95uOif/Z4HodBC8+X4k1A3PW6K3F6+eO2AVuOSJl6zDe7OgcC+aTCvd0ioT
         de5goGRPJbmQjaHHplY6kFV+fasjrRAClpVivVN8r+Q3o7VkOE3ioW9b8/9uMEVBjGTC
         L59Q/GO6aCzlgCYNUkqku5s2m0y2Ai9oTCjC+O58PtJc97cBncVumHN2YIzZJB+n+iTj
         HbWg==
X-Gm-Message-State: AOAM530wpPWtgUqrq/XXeD+uGPIMY8h4U9taoBjT3MwoF2MEZern7D1G
        VCUEt0QPPk1znYuZdl+XISX0/TjmOA==
X-Google-Smtp-Source: ABdhPJzgUhvADPEohaPwuf9YbRKa7JO6sEkag9lpLrxnybqLr1hg0mPihiIlw+QK7Ryq/MzVjIKHNQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr568101wmi.43.1591037169366;
        Mon, 01 Jun 2020 11:46:09 -0700 (PDT)
Received: from earth3.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.googlemail.com with ESMTPSA id 23sm302229wmg.10.2020.06.01.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:46:08 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, paulmck@kernel.org, mingo@redhat.com,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/5] cleanups
Date:   Mon,  1 Jun 2020 19:45:47 +0100
Message-Id: <20200601184552.23128-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jules Irenge (5):
  rcu/rcutorture: replace 0 with false
  rcu: replace 1 with true
  rcu: replace + with |
  x86/ftrace: Add annotations for ftrace_arch_code_modify_prepare() and
    ftrace_arch_code_modify_post_process()
  sfc: add  missing annotation for efx_ef10_try_update_nic_stats_vf()

 arch/x86/kernel/ftrace.c        |  2 ++
 drivers/net/ethernet/sfc/ef10.c |  1 +
 kernel/rcu/rcutorture.c         |  2 +-
 kernel/rcu/tree_plugin.h        | 22 +++++++++++-----------
 kernel/rcu/update.c             |  2 +-
 5 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.18.2


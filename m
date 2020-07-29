Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31711232109
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgG2Oy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Oy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:54:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D42C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:54:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so24693460eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/j3pJPti7R1Nqu8T1x4sAge6ACW4MRCL8TqgNXrRSNI=;
        b=K0lpBnlVwN/Tv31K/lm00Qc5/I3qKKP3rZBncGBLp3KDPLG5m+602elHLkUNXHgBCf
         clm/dR8w0uaphMXyXKzfXx8FBFgXGAM+KLf8CRWyva/TKe7TxbZh2l9uKVZ6C57TfVD5
         t7xIJ01lAtBgj+6J3MRChtls6iAwR6W8LPJNqKVLujFbP6SYvdB3db5m0v7DA16ErjN2
         UVDmsKMek3zxEx3BbpqUzoawdvuMGTPawh0RgS+OA2QHPzMp0E+kVLP7GBTLA14xNK0d
         tUq0pYn1fechJNGUoynovtzdf4GFaogbn3YnpvzLwSCyEpkcJao8i2A1ywvXXt889sou
         sGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/j3pJPti7R1Nqu8T1x4sAge6ACW4MRCL8TqgNXrRSNI=;
        b=CZf1Vuv4gcNyNjPGDMRpSdin69D2BlUwPouUQeqd/RcGMXwTDq0KtL9+SQwTlonSsb
         GR2I7aebqE8lwTNeFcNM15S7ecDk3aTwBJnRGSCJzdGLUWTjaPgolElztu8mk9fo2oWZ
         pLoABzebVEl//VpzFSy/+y0TMd3FYRLcsmX2A9pMIBjion27iW56b7wRI+Y/plKAsxX4
         sVB2/1kWfuboN9WBPa55WDMHvWFchbM5lay23Ky85pes/ByshqYpANwLL886upo9AY8X
         iP/Qp5/gffOTtepdSr+BF+f8+PyUjnlyCC8mkb0t1bOUt4N/NeQ6pJY8ZPZlQpw1kmgq
         BkAw==
X-Gm-Message-State: AOAM532O4XLdjyDEQAhl9DK4UFXPdECKZqe2mikhcK3qcAkad0BnxC56
        irlDgUMHDlg25cgywBz6YFD8Y33ZEHetQCFtfKl0
X-Google-Smtp-Source: ABdhPJxwfYn1Mu2F17YhaCWm+kTXC8ZtBnhObRT2ImFztho3D6TcXmKev1bBGPm4t52I3PTiibPkl/XINFHdUaFi8BY=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr14596804ejn.542.1596034464837;
 Wed, 29 Jul 2020 07:54:24 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Jul 2020 10:54:14 -0400
Message-ID: <CAHC9VhQSq87=vk63=Wr-0mdOZ3ExAKG3s6_9AMS=n_s8zGjhBQ@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.8 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small audit fix that you can hopefully merge before v5.8 is
released.  Unfortunately it is a revert of a patch that went in during
the v5.7 window and we just recently started to see some bug reports
relating to that commit.  We are working on a proper fix, but I'm not
yet clear on when that will be ready and we need to fix the v5.7
kernels anyway, so in the interest of time a revert seemed like the
best solution right now.

The patch passes our test suite, and as of right now it merges cleanly
against your tree.  You may notice a force-push on the
audit/stable-5.8 branch, but that was to fix a spelling mistake in the
commit that was identified after the patch had been committed.
Generally I try to avoid force-pushes, but since no one really uses
the audit/stable-X.Y branches as a base for development it seemed
safe.

Thanks,
-Paul

--
The following changes since commit 9d44a121c5a79bc8a9d67c058456bd52a83c79e7:

 audit: add subj creds to NETFILTER_CFG record to
   (2020-05-20 18:09:19 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200729

for you to fetch changes up to 8ac68dc455d9d18241d44b96800d73229029ed34:

 revert: 1320a4052ea1 ("audit: trigger accompanying records when no rules
   present") (2020-07-29 10:00:36 -0400)

----------------------------------------------------------------
audit/stable-5.8 PR 20200729

----------------------------------------------------------------
Paul Moore (1):
     revert: 1320a4052ea1 ("audit: trigger accompanying records when no
       rules present")

kernel/audit.c   | 1 -
kernel/audit.h   | 8 --------
kernel/auditsc.c | 3 +++
3 files changed, 3 insertions(+), 9 deletions(-)

-- 
paul moore
www.paul-moore.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC228F844
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgJOSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJOSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:15:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFEBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:15:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qp15so4988525ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hV2kzljzkPtlmabMiMR4tfaBM+VlAVmvUSlWLpICaPs=;
        b=VQcnZxYNoqwWWKhsVR9IcKy7FA5LslWVlI7LkqdXV7QDISXJtrEr7hdM0qXaD18BvI
         u1v5WkAly0t9EDxfyBHEDAqjyC9WOAsEb+d2sdss9TF/1NTLtysgYR/SYJsB4gbHDr03
         MBlwWDi7RwFVCPkhqB3xjwh1dcr9zDvi9XVuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hV2kzljzkPtlmabMiMR4tfaBM+VlAVmvUSlWLpICaPs=;
        b=RV8lyc2R4JR66lk3Htq7N7FY1/b0JOdcKdejT26eBD3jGBhXBerF56FgV07QAHG4+f
         hzUkUk/crH5mYTihg5ojK7q+6m5QBBuqNKeJ2GWKythKhQ8KVNbp1waqzA9QSrZbwmU8
         amyW0qJ0zUxYcIS4UA+pve2wsn5GtUBOZfQOeS/6aRBKnZ3H+SFDL4G1yiq4u4jaxXLc
         a1NN6A5DFWj7a7cazM/KIdVL7NmBhPV6uT3UtZOrWn1dNP2kD/sqinB+AIoZyTloIGBH
         /41wVuclctYk63U2J9RBlfs2mtRuVovwm71DTVk20Pk+2clBI9Y6oPIdhP7Ruk3JuUA0
         eQbQ==
X-Gm-Message-State: AOAM532iZwfNNQ0fzIFlEUpN5VSx2M3ML4kRKie5h+WKf4WKnspfQIvh
        cTneo1+lSimpaevC5sMRjCfhDX6/Qpwz3unKrRF6NA==
X-Google-Smtp-Source: ABdhPJy0H4kXoNR3cKvxKxNi/cMqUcFkeks5ROSvOXlaFHJgTp0Fq4kw3L79EnQiNzORlO6xBDY8GEyzvA/5x5lhPA4=
X-Received: by 2002:a17:906:6d0c:: with SMTP id m12mr5820394ejr.498.1602785728757;
 Thu, 15 Oct 2020 11:15:28 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 15 Oct 2020 11:15:18 -0700
Message-ID: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-5.10

for you to fetch changes up to 03ca0ec138927b16fab0dad7b869f42eb2849c94:

  LSM: SafeSetID: Fix warnings reported by test bot (2020-10-13 09:17:36 -0700)

----------------------------------------------------------------
SafeSetID changes for v5.10

The changes in this pull request are mostly contained to within the
SafeSetID LSM, with the exception of a few 1-line changes to change
some ns_capable() calls to ns_capable_setid() -- causing a flag
(CAP_OPT_INSETID) to be set that is examined by SafeSetID code and
nothing else in the kernel. These changes have been baking in -next and
actually were in -next for the entire v5.9 merge window but I didn't
have a chance to send them.

The changes to SafeSetID internally allow for setting up GID transition
security policies, as already existed for UIDs.

NOTE: I'm re-using my safesetid-next branch here as the branch for
creating the pull request. I think that's fine, not sure if this is the
normal workflow or not. Also, I use 'git rebase vX.X' to put my commits
on top of the latest stable release. Again, I verified with gitk that I
don't have any weird history in my branch that will mess things up so
AFAICT that should be fine too.

----------------------------------------------------------------

Thomas Cedeno (3):
      LSM: Signal to SafeSetID when setting group IDs
      LSM: SafeSetID: Add GID security policy handling
      LSM: SafeSetID: Fix warnings reported by test bot

 Documentation/admin-guide/LSM/SafeSetID.rst |  29 +++--
 kernel/capability.c                         |   2 +-
 kernel/groups.c                             |   2 +-
 kernel/sys.c                                |  10 +-
 security/safesetid/lsm.c                    | 190 +++++++++++++++++++++-------
 security/safesetid/lsm.h                    |  38 ++++--
 security/safesetid/securityfs.c             | 190 ++++++++++++++++++++--------
 7 files changed, 336 insertions(+), 125 deletions(-)

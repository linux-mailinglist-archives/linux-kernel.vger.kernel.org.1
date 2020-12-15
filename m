Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3E2DA5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgLOB7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLOB6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:58:52 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E13C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 17:58:11 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id w1so20707189ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 17:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BWor9jDGgk/8IhRKUrohi4NuTLT40ILHKt+r7aTsdEU=;
        b=ss9oQqNKTkQLfrgs7Ya1jqrhIOlLZTNk42ulfhz+/qBHu81Nl+dch1TpSZyjTPScOj
         GJetmz6N2n8ilXEoNbfLt5Jzd6BAgVhMVMRCt+LByLqQMGqgBjE+K+mxaK+x2Q8Q4yJX
         3EeJuAVHMCs12E8bt5RQNzemg+U3KH1SvP65QsY1TqWYuvTm9HmUZXb4K/8nlD2AiiW0
         6lQ007jN1kyYusb2O0dI7YFv5fg1swJfleG+9fVrimKOjd6RNVIvcdoc8XUHiYW9ay4l
         1jY4Za2xSvwKDGc08+gA2oMd5AtGuNTX9rD3+raEoTLMhitLUnx5g1bUyDwSZ6jjngAZ
         cRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BWor9jDGgk/8IhRKUrohi4NuTLT40ILHKt+r7aTsdEU=;
        b=ccnH2GisealD5xaDjuP4a9fy4r5uLTabcJBgPiiDWEJLuLS5SGTbWFzrNCTFjJ/yq8
         AKz27Dcxbx/6P/KvDO+EykRVJY8WVSK1oz+Bax6mJ0GozcDt7GJdy0CqTC7PbCA8YLfF
         Kxf9X3RBhdXjLe3Ut+rjxmd7Z2fyl30vWSNRQwx8qEk3SnZ25HhRcfq+xNMVnLvlqEXt
         39xiumyZCqKD7IGffLrMvQcw4nofjdYio0KkLnVTA2SAwqfZhzv5Gxbh4joAfUycfDTC
         vg2Wpcu9KgYbxIKQMNFPkahyhODj8+29dEBV80I/ycEP51jgL0NQLb2+qXFaIbVtNs/p
         UjuQ==
X-Gm-Message-State: AOAM531gBaPbOD0Edv7mzCsbjzCpe4XPl4MDrAGPv0KcIyGk/c3VmRUT
        VSVwX6yjkI7/ziepbIeu/colghreFPtJT2RutKIA2elnoi04
X-Google-Smtp-Source: ABdhPJwHqjyHQjik6xtuRcSclby847RqniajM+UtDbYwuM4gvAH+K1vb86g3lQoxYhtSa2gi9e/13jJ8Y7cs/5O0xHg=
X-Received: by 2002:a17:906:2e82:: with SMTP id o2mr4625104eji.106.1607997490305;
 Mon, 14 Dec 2020 17:58:10 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Dec 2020 20:57:59 -0500
Message-ID: <CAHC9VhT5ZQaz48+DNLTKqA5x1yMQL65iQyMW7=Qby5toyc2_0w@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small set of audit patches for v5.11 with four patches in total and
only one of any real significance.  Richard's patch to trigger
accompanying records causes the kernel to emit additional related
records when an audit event occurs; helping provide some much needed
context to events in the audit log.  It is also worth mentioning that
this is a revised patch based on an earlier attempt that had to be
reverted in the v5.8 time frame.

Everything passes our test suite, and with no problems reported please
merge this for v5.11.

Thanks,
-Paul

--
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

 Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20201214

for you to fetch changes up to 6b3211842a115d697fbf78d09f3e83852200e413:

 audit: replace atomic_add_return() (2020-12-02 22:52:16 -0500)

----------------------------------------------------------------
audit/stable-5.11 PR 20201214

----------------------------------------------------------------
Alex Shi (1):
     audit: fix macros warnings

Mauro Carvalho Chehab (1):
     audit: fix a kernel-doc markup

Richard Guy Briggs (1):
     audit: trigger accompanying records when no rules present

Yejune Deng (1):
     audit: replace atomic_add_return()

include/linux/audit.h |  8 --------
kernel/audit.c        |  9 ++++++---
kernel/auditsc.c      | 38 ++++++++++++--------------------------
security/lsm_audit.c  |  5 -----
4 files changed, 18 insertions(+), 42 deletions(-)

-- 
paul moore
www.paul-moore.com

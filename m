Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6D26FC83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIRMa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:30:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:30:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o5so5432905wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cfigHf/Gg1SoDIydRHg2XzLs0cREa+KB51wX6EyQyrI=;
        b=KAFLW98BkTsg7t7LIH0JLP25MZ+ZmackLo9XpmhZmaue0VmYtlkXA/hkH8t4840kqX
         9MogcgpRKHT4LSqGj35ZxH+eyVh8b/cReF9j8x3mfL+YXyAmykO/mMDhuLw/o/ZMPWsG
         GIOSmtFbyFsSVM/jQCvovi/futCjA5OvIzJUKXNYooJXAgcQexwl3UOZoocMSJ35/ILa
         uVvewHct+FfglHLjY93E63X4wOB46nmfM44kvSA0HEQxQBm6UMgPDiYe0JW4YrSwCCUm
         rQxToZsvPiZIVuDmQW5jX6MpdcvzDy+Dnu5n50oCunmn15ZlA6AWmHiCdqFG3rMqrh2S
         dFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cfigHf/Gg1SoDIydRHg2XzLs0cREa+KB51wX6EyQyrI=;
        b=VRHqTBc7ptjM7uzOfJOTAc5fEPCw9ByR3wiPIwTSr0J/4MyGvQcZH7Xwd0IYgCUpAO
         LEwgrLkWXsljI6xF/86BDkF4Ie+Hb5Y/9IZGRkR6Z95+62rjXFAcFwscmm1biGkY7js1
         GUi568+S9ELvmv/2C+7fP+mWG5SgSbkTZbA+CDzWB3yiqmGBPhiICh/k9Un2EyNvHJeP
         8Mi1Ej0aLs9fRG2/Xo6sLv5aLK/bAUcYIZI1srqbKs5Mg3FucPrdpK2yCw/Q5c2nK88s
         tWViWqDyfqgltXqRkc9Be6mWHRUQq+UyznZmlHX0lneQ7D9aa0fCVDYOty0Yxx2JwmD8
         M4rg==
X-Gm-Message-State: AOAM5311WqpIzi3fTqQp9p5qBjYz/HU7Z+7BHd5vUdRmNlfFFbK7F9+x
        pasjHWlaqa9fjMG7A7qAoQzjf/qOmWWdkplpaQ0=
X-Google-Smtp-Source: ABdhPJxn7l7rq+Xpt8yXLOjtI9FKE3XsXftfbkK9kqpSNRZQVElC2ZqQKVa29ztkFpBXdjFKpmTzaWTlGN/tj+VZbQg=
X-Received: by 2002:adf:f846:: with SMTP id d6mr40397666wrq.56.1600432254777;
 Fri, 18 Sep 2020 05:30:54 -0700 (PDT)
MIME-Version: 1.0
From:   Idan Yadgar <idanyadgar@gmail.com>
Date:   Fri, 18 Sep 2020 15:29:22 +0300
Message-ID: <CAOGVgQEAZS9FkF-wqs9ypDEwdZmUYFEbKXQNo7KffQoOOL=kCA@mail.gmail.com>
Subject: Allow preserving capabilities when changing user namespace of a process
To:     christian.brauner@ubuntu.com
Cc:     serge@hallyn.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A process which changes its user namespace (unshare or setns), or a
process that is created by
clone with the CLONE_NEWUSER flag has all capabilities inside the new
namespace, and loses all its
capabilities in the parent/previous user namespace.
This poses an issue because some operations require a capability in a
user namespace other than the
current one for the process.
The manual states multiple times that there are system calls which
require a capability in the
initial user namespace (for example, open_by_handle_at requires
CAP_DAC_READ_SEARCH in the initial
user namespace), but this cannot happen in a user namespace other than
the initial, unless the
process is owned by root.
So if a process (with uid != 0) has CAP_DAC_READ_SEARCH capability in
the initial user namespace,
and it tries to create a new user namespace (as part of a container
for example), and use
open_by_handle_at inside - it is not possible.

Solving this problem can be done by allowing (via prctl or any other
mechanism) a task to save its
capabilities for a given user namespace, even when it isn't a member
in that namespace.

I would like to hear some thoughts about this issue and the proposed solution.

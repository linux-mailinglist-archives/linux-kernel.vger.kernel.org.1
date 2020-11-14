Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDE2B3109
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 22:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKNVg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 16:36:28 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:39185 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 16:36:28 -0500
Received: by mail-ua1-f49.google.com with SMTP id t15so4151525ual.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 13:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6Bm6To4mLIzf5vAmwyulHb1ZoyA5Lm0EbLMIcNlfojY=;
        b=HiPk0XwW/+QjncigVrTTyF7uz/jakwKs9rvDDffhPwYtIrVm6ZnbZt41KtitsypEm3
         iv4JSg+xKoIicgVoOPLdemBe9cmxnFF3unf2jtcq3AWCWo3cBIcmcAoiEobukQfxNpom
         UD+MVxX1qVi8SQvpsgO4brYElpRiQR7sOzTLHd9k4Qg8/R1dMIBNu981MsnZ+uSywNuI
         v0Flk80gNyL6E67Jlmv85/VC0716JQiQn+bVJ0x8EjSU+i1J/8qHbel39NaTOotyeVZo
         l6dSzwabqb/PcacfxvCGCY/IhG1EPOwuF6nu7M0jbaPzdqnjoOb6wR51XcVIrSoUwneZ
         uHoA==
X-Gm-Message-State: AOAM531RlVn47WGAOmfcYE6y3S43Od9nrAjETTM1OpDShzORyOTaqg9V
        HTr7Rtw5dy7oaNxTsbPPEfIIeSk2+j4=
X-Google-Smtp-Source: ABdhPJxwQXNhLuTppiMDs2BSYQWOBQklaWNvn7u9qiILW8RcN5Ot/QzVF7gzzvUpiHFuSfq4bjpRhQ==
X-Received: by 2002:ab0:2984:: with SMTP id u4mr4650907uap.22.1605389787166;
        Sat, 14 Nov 2020 13:36:27 -0800 (PST)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id f25sm1622872vkm.41.2020.11.14.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 13:36:26 -0800 (PST)
Date:   Sat, 14 Nov 2020 21:36:24 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu fix for v5.10-rc4
Message-ID: <20201114213624.GA1126012@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A fix for a Wshadow warning in asm-generic percpu macros came in and
then I tacked on the removal of flexible array initializers in the
percpu allocator which was discussed in the 5.9 pull request.

Thanks,
Dennis

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.10-fixes

for you to fetch changes up to 61cf93d3e14a29288e4d5522aecb6e58268eec62:

  percpu: convert flexible array initializers to use struct_size() (2020-10-30 23:02:28 +0000)

----------------------------------------------------------------
Arnd Bergmann (1):
      asm-generic: percpu: avoid Wshadow warning

Dennis Zhou (1):
      percpu: convert flexible array initializers to use struct_size()

 include/asm-generic/percpu.h | 18 +++++++++---------
 mm/percpu.c                  |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

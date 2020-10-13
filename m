Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536AE28CE53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgJMM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgJMM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602592141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WGXCaU67FieVgGooevqAzXyML/TMiyX7cvaxSfDQ0OM=;
        b=ECQQrOMfzHo7eX3z+KKKSVYAYaqaAdXZc/kZFdz7LC1IdrxscLCoYqQ50u0Dc+8X7/YEeb
        SW9b1ZpOJRclXyX5/V0/1vCBHvm201BTQE+g8Cbm6FCvdxxmf97EqSrX+whgD4by2e7dYA
        DvtGAEkBazU/MXItvtWnj3QBPavFzuk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-FELRfh63PniaxivSdHJ1qQ-1; Tue, 13 Oct 2020 08:29:00 -0400
X-MC-Unique: FELRfh63PniaxivSdHJ1qQ-1
Received: by mail-pl1-f197.google.com with SMTP id r9so14087443plo.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WGXCaU67FieVgGooevqAzXyML/TMiyX7cvaxSfDQ0OM=;
        b=Qxol8zRLEpv+P2jOzFB8PCPON0JTw78YWpevCnTgj2EI7gGCGQ/FSJxUdFLhWmCW7o
         BGyAAKzEZZ6hBRoo3PhR2XeIH0kFMxunY0jVGGDLfJxx3AIFplD4Qn6uSC5nzw39H1aK
         x4nDW5GjBoE14u8Ze0b24Ua1JiXZOMfR0JjiqOZob4g+IWswaIpADzCKZdqF7N+2sHQS
         B089mp28NI5odR+WcxwzdTqsPMTeTB3k5eGg3fuo/A4UQ+9FTa5vb/5E22Kdq8QaaUPs
         TNCR0/lfKvnuM4mSH7gfBelMxQvcxB9kGpTcwXZKuH922hOGBk4B86gJ0lwDqJHBqfLp
         xnlA==
X-Gm-Message-State: AOAM530B/vwVxob1Ifu8GWNwArMlE6ChpWpSVPuVHY4f82f+aaaL3iGO
        5U9IffXgKSM3u+V7lxxeWDy5rdRGVo1dbiTTtF3FkReK+8Go7vdqXJ9yFRP/Ox6nLP5Ru5aO4Qw
        nebMHXoWU623njf+rXoEsH8FR
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id ay6-20020a1709028b86b02900d4c98bc314mr15646400plb.48.1602592139269;
        Tue, 13 Oct 2020 05:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUcl6wtJ7HnOp/yr+4xV7u2SG+7tIFyYatx49CXeVv7QLxSDU47ZqAF6powlDSDzvZ4PjcpA==
X-Received: by 2002:a17:902:8b86:b029:d4:c98b:c314 with SMTP id ay6-20020a1709028b86b02900d4c98bc314mr15646365plb.48.1602592138943;
        Tue, 13 Oct 2020 05:28:58 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 17sm17568228pgv.58.2020.10.13.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:28:58 -0700 (PDT)
Date:   Tue, 13 Oct 2020 20:28:46 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [GIT PULL] erofs update for 5.10-rc1
Message-ID: <20201013122846.GA12025@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.10-rc1?

This cycle addresses a reported permission issue with overlay
due to a duplicated permission check for "trusted." xattrs.
Also, a REQ_RAHEAD flag is added now to all readahead requests
in order to trace readahead I/Os. The others are random cleanups.

All commits have been tested and have been in linux-next as well.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc1

for you to fetch changes up to 915f4c9358db6f96f08934dd683ae297aaa0fb91:

  erofs: remove unnecessary enum entries (2020-10-09 10:37:42 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix an issue which can cause overlay permission problem
   due to duplicated permission check for "trusted." xattrs;

 - add REQ_RAHEAD flag to readahead requests for blktrace;

 - several random cleanup.

----------------------------------------------------------------
Chao Yu (1):
      erofs: remove unneeded parameter

Chengguang Xu (1):
      erofs: remove unnecessary enum entries

Gao Xiang (4):
      erofs: avoid duplicated permission check for "trusted." xattrs
      erofs: avoid unnecessary variable `err'
      erofs: fold in should_decompress_synchronously()
      erofs: add REQ_RAHEAD flag to readahead requests

 fs/erofs/data.c  |  2 +-
 fs/erofs/super.c |  2 --
 fs/erofs/xattr.c |  2 --
 fs/erofs/zdata.c | 48 +++++++++++++++++++++---------------------------
 4 files changed, 22 insertions(+), 32 deletions(-)


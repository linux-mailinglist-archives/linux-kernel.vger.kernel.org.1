Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC482DAAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLOKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgLOKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608026951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=D+6s0jfbb+iw290X2QFg1tX1hHyRCtrb4U7UKAwjZ6Q=;
        b=Ck3MXqFi2Xi7xQ+YtyVKZpYsObjcvTTdGrvFQPMFZSR9cwcB0DxB4ZTeLrr0v/Byyv6UPk
        BfyaVYGzNjG2SNTGvGTYX1BcdUPxtVcVSJCjJzPuSHajTENDj+osXUcL8Q3Ccn40BbA6gD
        j75L5SOXZDDUCerK/egs1QEwer/YlOw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-87bdv_gaOYy4jsMOZ-ttSw-1; Tue, 15 Dec 2020 05:09:09 -0500
X-MC-Unique: 87bdv_gaOYy4jsMOZ-ttSw-1
Received: by mail-pj1-f70.google.com with SMTP id bj5so6248187pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D+6s0jfbb+iw290X2QFg1tX1hHyRCtrb4U7UKAwjZ6Q=;
        b=r4lnwuwr99FPLFbFjA3S+IzJGPbqROPbvKilhu6o9UI5AqmpzZqV1zSFzcKL1eFgKb
         0NyIW28sEdCiNln+CdpOFa6Z+pjNQ8c88rwrP3cHsJ+zO+qHO4aAMjzkiPm3oqbv0qaT
         bJBTGWyS9CBoNv/8pwJADOwIp8KCPp/BJEfFTS+DOFTj4mZVicul7lY2e74j/Z595AIl
         SY3HUWjKh+BAAjy2jCJQi5iZ0Oy5PMdbzYMjL2sTy7LqAxtpLxGsgb8UUkzynX/9Pevi
         Jd9JL7bEoxM8VXGLFQPMZ63JkDru778UhsKS5yeqt13+nS2eIp+Bg3lmKeE1AmIf1QYD
         ChEA==
X-Gm-Message-State: AOAM530yN90UF+vGL3xyfOpufc36ZsCdDEID2y+LBptwxy1B970XcD7f
        j2OIokuLjiVZ1rYzzyyeXg3i6IMygsNwF9rWm7cIAFbV0RdBk1gV2exioJIjrPRRrcgfWb/LCI+
        o4IzqUebh7j1Hiq0fMa+Ji3GU
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr29645896pjb.196.1608026948330;
        Tue, 15 Dec 2020 02:09:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ+QJQeZhC7fWPHn8H4CTLpBoBip5gubOtmctdcTGKI/LOLgvsGcRi1coYDETI/ag/8TCvFg==
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr29645882pjb.196.1608026948125;
        Tue, 15 Dec 2020 02:09:08 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b4sm20887252pju.33.2020.12.15.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 02:09:07 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:08:55 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [GIT PULL] erofs update for 5.11-rc1
Message-ID: <20201215100855.GA581189@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.11-rc1?

This cycle we'd like to get rid of magical page->mapping type marks
for temporary pages which had some concern before, now such usage
is replaced with specific page->private. Also switch to inplace I/O
instead of allocating extra cached pages to avoid direct reclaim
under low memory scenario. There are some bmap bugfix and minor
cleanups as well.

All commits have been tested and have been in linux-next for a while.
This merges cleanly with master.

[ Additionally, there is another lz4 inplace decompression fix [1] due
  to some different overlapped memcpy() implementation which was reviewed
  and added to akpm tree, hopefully upstream for this 5.11 cycle too. ]

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20201122030749.2698994-1-hsiangkao@redhat.com 

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.11-rc1

for you to fetch changes up to d8b3df8b1048405e73558b88cba2adf29490d468:

  erofs: avoid using generic_block_bmap (2020-12-10 11:07:40 +0800)

----------------------------------------------------------------
Changes since last update:

 - get rid of magical page->mapping type marks;

 - switch to inplace I/O under low memory scenario;

 - return the correct block number for bmap();

 - some minor cleanups.

----------------------------------------------------------------
Gao Xiang (4):
      erofs: get rid of magical Z_EROFS_MAPPING_STAGING
      erofs: insert to managed cache after adding to pcl
      erofs: simplify try_to_claim_pcluster()
      erofs: force inplace I/O under low memory scenario

Huang Jianan (1):
      erofs: avoid using generic_block_bmap

Vladimir Zapolskiy (1):
      erofs: remove a void EROFS_VERSION macro set in Makefile

 fs/erofs/Makefile       |   5 --
 fs/erofs/compress.h     |  54 +++++++++++----
 fs/erofs/data.c         |  26 ++------
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/zdata.c        | 172 ++++++++++++++++++++++++++++--------------------
 fs/erofs/zdata.h        |   1 +
 6 files changed, 149 insertions(+), 111 deletions(-)


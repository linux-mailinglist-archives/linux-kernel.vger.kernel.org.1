Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70A2ABEE6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgKIOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730098AbgKIOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604932840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=I/Q1jINkP3Xtm3EvEAfNeb/q7P7VJGLtTGjJrvhjYXs=;
        b=Tf4xOnFhNJr6dAKAghQdp7H5qHoVOHTk78QTgdjAx7ejBHED9MCepIhgxnY2sUWO3os4s2
        yMts+PSInjl6ltOQbXQ+Cs/CjsT9ARkJTLgifL9xtomJBlCgur5gblQ9xnv+IHWVF5hejv
        4V81LNubxyPNQSrOvmSqKu3sZZ4jVd0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-4V3GvrFhO4WpYIDD_wju2Q-1; Mon, 09 Nov 2020 09:40:37 -0500
X-MC-Unique: 4V3GvrFhO4WpYIDD_wju2Q-1
Received: by mail-pl1-f200.google.com with SMTP id p15so4251054plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I/Q1jINkP3Xtm3EvEAfNeb/q7P7VJGLtTGjJrvhjYXs=;
        b=BVaYdqtsEZHytDr1UHZVC1alSQH122tftGRcAYxDrrH57odc73nHMH8MmZqQy/H/+N
         6I6A/p9lsG8Zj2qcZ0IkMPWI7Dbl8/nSqrFa3MRJvy5jHz0sKSZR/Su8PfXy90cfSdf2
         d6VuAumRcPWzNZHrOlalURu3QK9cZEROVSmIlNTXA/G/9R9Z/zqRuaM8dCNzZTjIVxG7
         59KWEdrSOfLeIBf5yFSPjBzrB1KU5+grdz1ctLJ0HMtDqGU0cbhpzBpM5puzduLxUgtF
         pBcnfs6iAqeY2P+TZwbhhouszNqUYl8CbpLAnY3GhAumorVMsDOtEkhGeJW7p0C+gpK3
         fwPw==
X-Gm-Message-State: AOAM532HCWRj6x7gqG/oJSccmxfk4LzffVV86HtjZyyfk5N3JklTBoHT
        TgO5GnmlANg25yXuK2o97pKuXFfCXq/3WcwI8HgVOSbesvRCtWjS9fhHICeH6xdOojVxIeVa/Rx
        OQwQOSR0N4RG1EifBokTJsYq8
X-Received: by 2002:a17:902:82c8:b029:d6:b42f:ce7a with SMTP id u8-20020a17090282c8b02900d6b42fce7amr12700018plz.23.1604932836374;
        Mon, 09 Nov 2020 06:40:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgapOqkxKFrpo7nLldnvouaKn24P8F3ngFyqamK2WaakqTMfsV3ADaacKnD779TOHnd/Cwaw==
X-Received: by 2002:a17:902:82c8:b029:d6:b42f:ce7a with SMTP id u8-20020a17090282c8b02900d6b42fce7amr12699999plz.23.1604932836129;
        Mon, 09 Nov 2020 06:40:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b6sm9899704pgq.58.2020.11.09.06.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:40:35 -0800 (PST)
Date:   Mon, 9 Nov 2020 22:40:23 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir@tuxera.com>,
        nl6720 <nl6720@gmail.com>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>
Subject: [GIT PULL] erofs fixes for 5.10-rc4
Message-ID: <20201109144023.GA2232414@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these 2 bugfixes for 5.10?

A week ago, Vladimir reported an issue that the kernel log
would become polluted if the page allocation debug option is
enabled. I also found this when I cleaned up magical page->mapping
and originally planned to submit these all for 5.11 but it
seems the impact can be noticed so submit the fix in advance.

In addition, nl6720 also reported that atime is empty although
EROFS has the only one on-disk timestamp as a practical
consideration for now but it's better to derive it as what
we did for the other timestamps.

All commits have been tested and have been in linux-next for
almost a week as well. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc4-fixes

for you to fetch changes up to a30573b3cdc77b8533d004ece1ea7c0146b437a0:

  erofs: fix setting up pcluster for temporary pages (2020-11-04 09:15:48 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix setting up pcluster improperly for temporary pages;

 - derive atime instead of leaving it empty.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: derive atime instead of leaving it empty
      erofs: fix setting up pcluster for temporary pages

 fs/erofs/inode.c | 21 +++++++++++----------
 fs/erofs/zdata.c |  7 +++++--
 2 files changed, 16 insertions(+), 12 deletions(-)


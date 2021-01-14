Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93B2F5968
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhANDeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbhANDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:34:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE1C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:33:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c22so2823163pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=M5N5hogdb1VE5N+GuBnvP2hTDvEwQA42F7hxBNyZMt4=;
        b=FEqCHqMKatXUgxZo1m9x9XWMmJmnZLrMOpBLIkbng24V512Il3r0ZQNAi5YHI/s2R1
         jau3yFgUJELL5UKibd7Q+RdwJfmPO6VUTfxHGI1Fvo3b+OXTuqIXNOKJ9EuXHdWcpsfP
         Z56E1Z56qn5TiRUlQPzBOzUmZlpSLF9suPKq54/u2GWIMt6H5b/3wla+uMVvIU6MUs2N
         RhYeiH4AADdHT+10avtmDmWydRpeILPcsagg4Dh7RPBLV5kR0KnjmzyBt1eyMABFzrq6
         4Q0IpMrPCVk9hdMawRcOc1y7AaS3gQtK4BSbUAZzVimkJYuwmS2xjK5oW7wu4y5RUAkN
         QmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=M5N5hogdb1VE5N+GuBnvP2hTDvEwQA42F7hxBNyZMt4=;
        b=FD6FE/G8RLqTRwZTUnYuLjQPbBfcfh+9eVLanTp0d00nbAKIRLVTXkeerXA4rs2r30
         7NRxh9HxNhFiXyPCdYdxuIxTh4cW2Uh4MlnocdeLSjOMcbLl76OcmR7jY5G2h4yK3EzN
         z3tCZaOSeqwIjmqdHVaUv+/yc08X5nkMJEFopLe/NWv8O6tmHfNj3d13wTOieUHGZpux
         i4az17lChKdk4cqofNlAKGWYCsyzHCLR7e66/jANChHe2xrgLKK/cJs2NFnb73dkXXlF
         V48NXvwAkICt4Gv24Ujd0iENtmWY5AuTPkrMUCLdRHvXhCRcbXCYiOKADpNlC5r24e51
         nX2g==
X-Gm-Message-State: AOAM5330aor080oLb33IU+0of1Bz66SHPIytNQ82Jadz2ZOO0TBlL9mL
        YkS+LwzEYdnOd23kdVtEjKg=
X-Google-Smtp-Source: ABdhPJwiK1AxhqNUts0GEcLWi4jomLrxuNv7CTGtOmpeAc78Pv+9YmYaaJopyRQaoE1OdGlIACQ6og==
X-Received: by 2002:a63:f512:: with SMTP id w18mr5354005pgh.154.1610595208352;
        Wed, 13 Jan 2021 19:33:28 -0800 (PST)
Received: from localhost ([100.87.84.221])
        by smtp.gmail.com with ESMTPSA id o129sm3611513pfg.66.2021.01.13.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:33:27 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:33:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Suleiman Souhlal <suleiman@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: madvise(MADV_REMOVE) deadlocks on shmem THP
Message-ID: <X/+7dkbhNtAVV+wd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are running into lockups during the memory pressure tests on our
boards, which essentially NMI panic them. In short the test case is

- THP shmem
    echo advise > /sys/kernel/mm/transparent_hugepage/shmem_enabled

- And a user-space process doing madvise(MADV_HUGEPAGE) on new mappings,
  and madvise(MADV_REMOVE) when it wants to remove the page range

The problem boils down to the reverse locking chain:
	kswapd does

		lock_page(page) -> down_read(page->mapping->i_mmap_rwsem)

	madvise() process does

		down_write(page->mapping->i_mmap_rwsem) -> lock_page(page)



CPU0                                                       CPU1

kswapd                                                     vfs_fallocate()
 shrink_node()                                              shmem_fallocate()
  shrink_active_list()                                       unmap_mapping_range()
   page_referenced() << lock page:PG_locked >>                unmap_mapping_pages()  << down_write(mapping->i_mmap_rwsem) >>
    rmap_walk_file()                                           zap_page_range_single()
     down_read(mapping->i_mmap_rwsem) << W-locked on CPU1>>     unmap_page_range()
      rwsem_down_read_failed()                                   __split_huge_pmd()
       __rwsem_down_read_failed_common()                          __lock_page()  << PG_locked on CPU0 >>
        schedule()                                                 wait_on_page_bit_common()
                                                                    io_schedule()

	-ss

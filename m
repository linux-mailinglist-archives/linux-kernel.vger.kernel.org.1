Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26C2A05BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgJ3MsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgJ3MsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604062079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lMNtjlr6gjb2YrjS0I4H09JLNpBeTtIglmY6iniNrA=;
        b=fdAZ2jZZKhFE+55D63c+sL9223+b8+/8h0XAH8lP+na3CB12vfbh2uMbKzIbA1HTZR5ATv
        FHvfeWEXWRKnPLwn1wm2CC3AE2dzcsWrV6Jbsy+1nYo+cNIZ9RixaotdK4+Q1376uZs820
        C7FN5N27E0lqxfG6I6DddxUGwq3JMV4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-uPMd_mYYPhGmriqxiyZaLQ-1; Fri, 30 Oct 2020 08:47:57 -0400
X-MC-Unique: uPMd_mYYPhGmriqxiyZaLQ-1
Received: by mail-pg1-f200.google.com with SMTP id u4so4551916pgg.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1lMNtjlr6gjb2YrjS0I4H09JLNpBeTtIglmY6iniNrA=;
        b=qWYL5K5IniXUZikVybPRsXbsGc611UDJgIPIubIKOIuO8HR8wr04y5UQ4+d3As/Jp1
         9g9YHHYM4B+3lgxq9N/cyIpZ8piJr2HZMdaAj4c4h2fa/CNy7qy+sdpchTRYEeDzJ2Dp
         dwRhtSjl2e4JVGO3xui2ncPSwevdyt948/D9M07Mnl9LQ6abXt7w5+ZSwCP9XA9I7PdE
         COnf4JA1w9kG0xhcbg5wNzC7FWSk2h8hXGt7v452CRU4201Fk6V4k176PwPq3CLygC3R
         cndPu59ESTGwVzVuvuG2WQEvmMqAlTeC1bdDWDThIZM0ZD/x7PXOV/MUNhmA7WXp62g4
         SS1A==
X-Gm-Message-State: AOAM532Ayusioh0zaagcE/9+qf6B9aUHoADgvG0eDkg/fqVUTI3RHChl
        afs8M9SBxdEYGyAHyfYvcIWs+4mRrxfZ5f7AowDvr9pyWeOLh4jYPcY6gBgWZgq6CY34mPu34kE
        A4twXYigk3Dty9gbS0HQcfzWZ
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id n3-20020a1709026a83b02900d5e98f2437mr8367912plk.38.1604062076408;
        Fri, 30 Oct 2020 05:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGsuBRDlsXsTIzJIYaK6ow5wMfYV7EJXHglp/ovpVhBHRB23c3B4lEpVGxAU1cASw4dVCOYQ==
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id n3-20020a1709026a83b02900d5e98f2437mr8367895plk.38.1604062076140;
        Fri, 30 Oct 2020 05:47:56 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o195sm5926051pfg.10.2020.10.30.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 05:47:55 -0700 (PDT)
Date:   Fri, 30 Oct 2020 20:47:45 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@aol.com>,
        stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] erofs: fix setting up pcluster for temporary pages
Message-ID: <20201030124745.GB133455@xiangao.remote.csb>
References: <20201022145724.27284-1-hsiangkao.ref@aol.com>
 <20201022145724.27284-1-hsiangkao@aol.com>
 <ba952daf-c55d-c251-9dfc-3bf199a2d4ff@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba952daf-c55d-c251-9dfc-3bf199a2d4ff@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, Oct 30, 2020 at 02:20:31PM +0200, Vladimir Zapolskiy wrote:
> Hello Gao Xiang,
> 
> On 10/22/20 5:57 PM, Gao Xiang via Linux-erofs wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > pcluster should be only set up for all managed pages instead of
> > temporary pages. Since it currently uses page->mapping to identify,
> > the impact is minor for now.
> > 
> > Fixes: 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
> > Cc: <stable@vger.kernel.org> # 5.5+
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> I was looking exactly at this problem recently, my change is one-to-one
> to your fix, thus I can provide a tag:
> 
> Tested-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Many thanks for confirming this!
I found this when I was killing magical stagingpage page->mapping,
it's somewhat late :-)

> 
> 
> The fixed problem is minor, but the kernel log becomes polluted, if
> a page allocation debug option is enabled:
> 
>     % md5sum ~/erofs/testfile
>     BUG: Bad page state in process kworker/u9:0  pfn:687de
>     page:0000000057b8bcb4 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x687de
>     flags: 0x4000000000002000(private)
>     raw: 4000000000002000 dead000000000100 dead000000000122 0000000000000000
>     raw: 0000000000000000 ffff888066758690 00000000ffffffff 0000000000000000
>     page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>     Modules linked in:
>     CPU: 1 PID: 602 Comm: kworker/u9:0 Not tainted 5.9.1 #2
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
>     Workqueue: erofs_unzipd z_erofs_decompressqueue_work
>     Call Trace:
>      dump_stack+0x84/0xba
>      bad_page.cold+0xac/0xb1
>      check_free_page_bad+0xb0/0xc0
>      free_pcp_prepare+0x2c8/0x2d0
>      free_unref_page+0x18/0xf0
>      put_pages_list+0x11a/0x120
>      z_erofs_decompressqueue_work+0xc9/0x110
>      ? z_erofs_decompress_pcluster.isra.0+0xf10/0xf10
>      ? read_word_at_a_time+0x12/0x20
>      ? strscpy+0xc7/0x1a0
>      process_one_work+0x30c/0x730
>      worker_thread+0x91/0x640
>      ? __kasan_check_read+0x11/0x20
>      ? rescuer_thread+0x8a0/0x8a0
>      kthread+0x1dd/0x200
>      ? kthread_unpark+0xa0/0xa0
>      ret_from_fork+0x1f/0x30
>     Disabling lock debugging due to kernel taint

Yeah, I can make a pull-request to Linus if you need this to be in master
now, or I can post it for v5.11-rc1 since 5.4 LTS isn't effected (and it
would be only a print problem with debugging option.)

Thanks,
Gao Xiang

> 
> --
> Best wishes,
> Vladimir
> 


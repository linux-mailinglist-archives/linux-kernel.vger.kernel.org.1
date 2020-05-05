Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EE11C5B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgEEP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729365AbgEEP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:28:41 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F21C061A0F;
        Tue,  5 May 2020 08:28:40 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E0CF5737;
        Tue,  5 May 2020 15:28:39 +0000 (UTC)
Date:   Tue, 5 May 2020 09:28:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 00/29] Convert files to ReST - part 2
Message-ID: <20200505092838.4b1ff075@lwn.net>
In-Reply-To: <20200428130128.22c4b973@lwn.net>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
        <20200428130128.22c4b973@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 13:01:28 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> So I'm happy to merge this set, but there is one thing that worries me a
> bit... 
> 
> >  fs/cachefiles/Kconfig                         |    4 +-
> >  fs/coda/Kconfig                               |    2 +-
> >  fs/configfs/inode.c                           |    2 +-
> >  fs/configfs/item.c                            |    2 +-
> >  fs/fscache/Kconfig                            |    8 +-
> >  fs/fscache/cache.c                            |    8 +-
> >  fs/fscache/cookie.c                           |    2 +-
> >  fs/fscache/object.c                           |    4 +-
> >  fs/fscache/operation.c                        |    2 +-
> >  fs/locks.c                                    |    2 +-
> >  include/linux/configfs.h                      |    2 +-
> >  include/linux/fs_context.h                    |    2 +-
> >  include/linux/fscache-cache.h                 |    4 +-
> >  include/linux/fscache.h                       |   42 +-
> >  include/linux/lsm_hooks.h                     |    2 +-  
> 
> I'd feel a bit better if I could get an ack or two from filesystem folks
> before I venture that far out of my own yard...what say you all?

It's been another week and nobody has complained, so I'm taking that as
assent; the series has been applied.

Thanks,

jon

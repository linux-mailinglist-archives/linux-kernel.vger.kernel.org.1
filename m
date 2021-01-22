Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0C2FFD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhAVHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbhAVHOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611299608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4J2S4qmOnrxHWEUrrh2BfDWoHlugSLluoK77+GUCNE=;
        b=K9LUNN3sXuscc8mNCZxuhhhAuKRh86hXKoK7Cj+kSwDcHXDRcLY08PUtScDxrh472qWKzq
        94+K2gAu6FDjmsYPoevf7VTRSD5KSalb2936obNnZ/xKnojjR4jyISccz220klVv88XqwL
        dyHdeqRlQSb9SJBYTvkim1cTQms85wE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-aqnfb7YhNu-s1F5JCIkPdQ-1; Fri, 22 Jan 2021 02:13:24 -0500
X-MC-Unique: aqnfb7YhNu-s1F5JCIkPdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6BDE18C89D9;
        Fri, 22 Jan 2021 07:13:22 +0000 (UTC)
Received: from localhost (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23D3410023BF;
        Fri, 22 Jan 2021 07:13:18 +0000 (UTC)
Date:   Fri, 22 Jan 2021 15:13:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com
Subject: Re: [PATCH v4 1/4] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20210122071316.GJ20161@MiWiFi-R3L-srv>
References: <20210120045213.6571-2-bhe@redhat.com>
 <202101202302.EE9LLAFu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101202302.EE9LLAFu-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20/21 at 11:47pm, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux/master]
> [also build test WARNING on linus/master v5.11-rc4 next-20210120]
> [cannot apply to mmotm/master hnaz-linux-mm/master ia64/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
> config: mips-randconfig-r036-20210120 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/1bbb0b35dd2fae4a7a38098e63899677c2e53108
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-clean-up-names-and-parameters-of-memmap_init_xxxx-functions/20210120-135239
>         git checkout 1bbb0b35dd2fae4a7a38098e63899677c2e53108
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/page_alloc.c:3597:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
>     3597 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>          |               ^~~~~~~~~~~~~~~~~~~~~~
> >> mm/page_alloc.c:6258:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
>     6258 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
>          |                       ^~~~~~~~~~~~~~~~

Have posted a patch to fix this warning as below. The patch is based on
this patchset.

https://lore.kernel.org/linux-mm/20210122070359.24010-1-bhe@redhat.com/

Thanks
Baoquan


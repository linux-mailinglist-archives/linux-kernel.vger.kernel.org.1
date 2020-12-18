Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A662DEA10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgLRUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgLRUPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:15:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026AFC061285
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tsFXi74Czj02JDF9/OuTcw7Z9zt3ff2QLJVrYO5uDG4=; b=jszN6HtG83b0un0SVKOh6aX60G
        BeI5zZ3g0lMPofZBfaMzd2GPSYpO4+KYnQFk4pqPQtMNnDlzm+0EPWRJiJ9xUvPcxeAQT8nsweMtz
        hQY1skK/ro43KugfxAc51sKxsbHkBaBsNBcxnraDEh7j9oExvLmdwju5w4YXGwXSVQsl+ubvD77Sj
        4uqQkD/7mXPPqSB8YXxAmAEnlab7UMnGcU5ZSF3e/A/yIMBgSZonn6RceOkRxaM2W7g5u2JIVdvEf
        yH7MzhGrkVv7jbKBebUwOa9ZcZXoAFuClge+xMVYXpM2/TaI+uYGN8wOxpcViAMKJO/BVFO5PBDR+
        w0iGQqbA==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqM8p-0001Cd-VP; Fri, 18 Dec 2020 20:14:20 +0000
Subject: Re: [PATCH] JFS: more checks for invalid superblock
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        syzbot+36315852ece4132ec193@syzkaller.appspotmail.com,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <20201218051920.6229-1-rdunlap@infradead.org>
 <202012181528.QLtx4Ix4-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0133786-91d2-1d7e-3ebb-00ee63b62eb6@infradead.org>
Date:   Fri, 18 Dec 2020 12:14:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202012181528.QLtx4Ix4-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 11:23 PM, kernel test robot wrote:
> Hi Randy,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on shaggy/jfs-next]
> [also build test WARNING on linux/master linus/master v5.10 next-20201217]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Randy-Dunlap/JFS-more-checks-for-invalid-superblock/20201218-132143
> base:   https://github.com/kleikamp/linux-shaggy jfs-next
> config: i386-randconfig-s002-20201217 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-184-g1b896707-dirty
>         # https://github.com/0day-ci/linux/commit/11cb0575aca69504da8b7984fc7f3e439b1a2331
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Randy-Dunlap/JFS-more-checks-for-invalid-superblock/20201218-132143
>         git checkout 11cb0575aca69504da8b7984fc7f3e439b1a2331
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>>> fs/jfs/jfs_mount.c:373:17: sparse: sparse: restricted __le32 degrades to integer
> 

Thank you. I have fixed that.

-- 
~Randy


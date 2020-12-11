Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905272D7A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406580AbgLKQM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:12:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:33133 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388137AbgLKQMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:12:45 -0500
IronPort-SDR: 81RmHkD7ztFHL3KzKqFuvqDFgSgjrl9UCqadUslck1uEeJ2Y/6jZQc1wybyD9UUF1BfUbPUc4v
 w36+TsTWXu1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="162212773"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="162212773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 08:10:56 -0800
IronPort-SDR: 9OJu6nPre7BFFBOUqE5Jvb6XVh1IGnY4suPVLQdotjXmEJB/mX2h3/yud5zDGrO0efxXU37gaO
 r4PB9MdTlR4A==
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="349543931"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 08:10:52 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1knl1O-00Dgsj-Cs; Fri, 11 Dec 2020 18:11:54 +0200
Date:   Fri, 11 Dec 2020 18:11:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/find_bit_bench: fix the unmatched iterations cnt
Message-ID: <20201211161154.GV4077@smile.fi.intel.com>
References: <20201211085039.GA7619@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211085039.GA7619@ubuntu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 05:50:39PM +0900, Levi Yun wrote:
> We should have same iteration count when we walk the same bitmap
> regardless of using find_next_bit or find_last_bit.

I didn't understand why is so (I mean "same", I think you rather talking about
same order of amount of itterations).

> When we run the find_bit_benchmark.ko, we sometime get
> unmatched iterations count below:
> 
>              Start testing find_bit() with random-filled bitmap
> [+...] find_next_bit:                  875085 ns, 163755 iterations <
> [+...] find_next_zero_bit:             865319 ns, 163926 iterations
> [+...] find_last_bit:                  611807 ns, 163756 iterations <
> [+...] find_first_bit:                1601016 ns,  16335 iterations
> [+...] find_next_and_bit:              400645 ns,  74040 iterations
> [+...]
>               Start testing find_bit() with sparse bitmap
> [+...] find_next_bit:                    9942 ns,    654 iterations
> [+...] find_next_zero_bit:            1678445 ns, 327027 iterations
> [+...] find_last_bit:                    7131 ns,    654 iterations
> [+...] find_first_bit:                 551383 ns,    654 iterations
> [+...] find_next_and_bit:                3027 ns,      1 iterations
> 
> Normally, this is happen when the last bit of bitmap was set.
> 
> This patch fix the unmatched iterations count between
> test_find_next_bit and test_find_last_bit.

Can you provide before and after to compare?

-- 
With Best Regards,
Andy Shevchenko



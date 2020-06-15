Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4634A1F93BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgFOJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 05:41:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:57794 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgFOJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:41:54 -0400
IronPort-SDR: XGWzS8kzO93NA/Gzto1g7fKx8rik/HCQUsXh92DB/Xk5V2O8yHHa2T36celafpr7onnWPD+7lu
 yb6w3rVvh3hA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 02:41:54 -0700
IronPort-SDR: Cxr9pJYHDZFZqKxTcvGlQBTMy0aM2cKnvw0G7LWO4JNRFqvf2l2p2afzB+DOgQp31I68v2k3Oy
 qO2cUkYRVkQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="475956207"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 02:41:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jklcp-00DXNw-B6; Mon, 15 Jun 2020 12:41:55 +0300
Date:   Mon, 15 Jun 2020 12:41:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bitmap: Add test for bitmap_cut()
Message-ID: <20200615094155.GQ2428291@smile.fi.intel.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
 <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 07:40:54PM +0200, Stefano Brivio wrote:
> Inspired by an original patch from Yury Norov: introduce a test for
> bitmap_cut() that also makes sure functionality is as described for
> partially overlapping src and dst.

Taking into account recent fixes for BE 64-bit, do we have test cases for a such?

> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
> v2:
>   - use expect_eq_bitmap() instead of open coding result check (Andy
>     Shevchenko)
>   - don't use uncommon Co-authored-by: tag (Andy Shevchenko), drop
>     it altogether as Yury asked me to go ahead with this and I haven't
>     heard back in a while. Patch is now rather different anyway
>   - avoid stack overflow, buffer needs to be five unsigned longs and
>     not four as 'in' is shifted by one, spotted by kernel test robot
>     with CONFIG_STACKPROTECTOR_STRONG
> 
>  lib/test_bitmap.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 6b13150667f5..df903c53952b 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -610,6 +610,63 @@ static void __init test_for_each_set_clump8(void)
>  		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
>  }
>  
> +struct test_bitmap_cut {
> +	unsigned int first;
> +	unsigned int cut;
> +	unsigned int nbits;
> +	unsigned long in[4];
> +	unsigned long expected[4];
> +};
> +
> +static struct test_bitmap_cut test_cut[] = {
> +	{  0,  0,  8, { 0x0000000aUL, }, { 0x0000000aUL, }, },
> +	{  0,  0, 32, { 0xdadadeadUL, }, { 0xdadadeadUL, }, },
> +	{  0,  3,  8, { 0x000000aaUL, }, { 0x00000015UL, }, },
> +	{  3,  3,  8, { 0x000000aaUL, }, { 0x00000012UL, }, },
> +	{  0,  1, 32, { 0xa5a5a5a5UL, }, { 0x52d2d2d2UL, }, },
> +	{  0,  8, 32, { 0xdeadc0deUL, }, { 0x00deadc0UL, }, },
> +	{  1,  1, 32, { 0x5a5a5a5aUL, }, { 0x2d2d2d2cUL, }, },
> +	{  0, 15, 32, { 0xa5a5a5a5UL, }, { 0x00014b4bUL, }, },
> +	{  0, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> +	{ 15, 15, 32, { 0xa5a5a5a5UL, }, { 0x000125a5UL, }, },
> +	{ 15, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> +	{ 16, 15, 32, { 0xa5a5a5a5UL, }, { 0x0001a5a5UL, }, },
> +
> +	{ BITS_PER_LONG, BITS_PER_LONG, BITS_PER_LONG,
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +	},
> +	{ 1, BITS_PER_LONG - 1, BITS_PER_LONG,
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +		{ 0x00000001UL, 0x00000001UL, },
> +	},
> +
> +	{ 0, BITS_PER_LONG * 2, BITS_PER_LONG * 2 + 1,
> +		{ 0xa5a5a5a5UL, 0x00000001UL, 0x00000001UL, 0x00000001UL },
> +		{ 0x00000001UL, },
> +	},
> +	{ 16, BITS_PER_LONG * 2 + 1, BITS_PER_LONG * 2 + 1 + 16,
> +		{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },
> +		{ 0x2d2dffffUL, },
> +	},
> +};
> +
> +static void __init test_bitmap_cut(void)
> +{
> +	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
> +		struct test_bitmap_cut *t = &test_cut[i];
> +
> +		memcpy(in, t->in, sizeof(t->in));
> +
> +		bitmap_cut(out, in, t->first, t->cut, t->nbits);
> +
> +		expect_eq_bitmap(t->expected, out, t->nbits);
> +	}
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -623,6 +680,7 @@ static void __init selftest(void)
>  	test_bitmap_parselist_user();
>  	test_mem_optimisations();
>  	test_for_each_set_clump8();
> +	test_bitmap_cut();
>  }
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04129763B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbgJWRzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:55:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:55275 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753922AbgJWRzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:55:00 -0400
IronPort-SDR: UpTNeiOKZFv9q4BNOfnPDXlGcLuIbgv9xvDBgmge061lRr0jHsmPtkprbcYomCF+RCA7syicy7
 76SDRZu3kKvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="164216992"
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="scan'208";a="164216992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 10:54:57 -0700
IronPort-SDR: rLW6t0Bc42cjZ7lHitvsI1tmc02RzdLUHxVmNRlpynZTNAnVCJiOtAuybyz0O+hcA44VBg3Rue
 FWcnNNOoHqzw==
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="scan'208";a="317161403"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 10:54:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kW1Hy-00EGUN-HM; Fri, 23 Oct 2020 20:55:42 +0300
Date:   Fri, 23 Oct 2020 20:55:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Eric Dumazet <edumazet@google.com>, NeilBrown <neilb@suse.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 46/56] list: fix a typo at the kernel-doc markup
Message-ID: <20201023175542.GY4077@smile.fi.intel.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <5c710f3b33c4572b5065a4f1e085c5d09dc04c7d.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c710f3b33c4572b5065a4f1e085c5d09dc04c7d.1603469755.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:33PM +0200, Mauro Carvalho Chehab wrote:
> hlist_add_behing -> hlist_add_behind

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index a18c87b63376..f72a7a778722 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -901,7 +901,7 @@ static inline void hlist_add_before(struct hlist_node *n,
>  }
>  
>  /**
> - * hlist_add_behing - add a new entry after the one specified
> + * hlist_add_behind - add a new entry after the one specified
>   * @n: new entry to be added
>   * @prev: hlist node to add it after, which must be non-NULL
>   */
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko



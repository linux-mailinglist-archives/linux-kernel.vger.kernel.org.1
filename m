Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7263C27D17B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgI2Okb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Sep 2020 10:40:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:6246 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731420AbgI2Ok0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:26 -0400
IronPort-SDR: vRDWGH6FOVcYL5eSl+8FzHWbSGlUb5ZOiiLgWdt1GNZlJ+4R+iLln+eTQDY6SWhDAwNIZVhavZ
 7OaSzg3ZGe3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="163078429"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="163078429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 07:40:24 -0700
IronPort-SDR: +wZ7CksQQGgpYoSu7T9vjla7Z7LXHP4nUC66KD+iy+ZE+tDTtX+LPy1y98ZBdBUPec+1xZycL9
 aYqZuQ+jA89A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="324693822"
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139])
  by orsmga002.jf.intel.com with ESMTP; 29 Sep 2020 07:40:24 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Sep 2020 15:40:23 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Tue, 29 Sep 2020 15:40:23 +0100
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] list: Add a macro to test if entry is pointing to the
 head
Thread-Topic: [PATCH v2] list: Add a macro to test if entry is pointing to the
 head
Thread-Index: AQHWlmaO97X0AF+CMUuhSjA0mQ6lcal/rq5g
Date:   Tue, 29 Sep 2020 14:40:23 +0000
Message-ID: <5f95bede9603416ca9f1c6ee17d54b35@intel.com>
References: <20200929134342.51489-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200929134342.51489-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-29 3:43 PM, Andy Shevchenko wrote:
> Add a macro to test if entry is pointing to the head of the list
> which is useful in cases like:
> 
>    list_for_each_entry(pos, &head, member) {
>      if (cond)
>        break;
>    }
>    if (list_entry_is_head(pos, &head, member))
>      return -ERRNO;
> 
> that allows to avoid additional variable to be added to track if loop
> has not been stopped in the middle.
> 
> While here, convert list_for_each_entry*() family of macros to use a new one.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: converted users inside list.h, dropped ambiguous description

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

This is a good addition to the list of helper macros found in list.h.

When looking at below:

>   /**
>    * list_for_each_entry	-	iterate over list of given type
>    * @pos:	the type * to use as a loop cursor.
> @@ -617,7 +626,7 @@ static inline void list_splice_tail_init(struct list_head *list,
>    */
>   #define list_for_each_entry(pos, head, member)				\
>   	for (pos = list_first_entry(head, typeof(*pos), member);	\
> -	     &pos->member != (head);					\
> +	     !list_entry_is_head(pos, head, member);			\
>   	     pos = list_next_entry(pos, member))
>   

it seems such helper should have been here a long time ago (notice the
usage of helpers for initial assignment and cursor update while the
loop-exit check was devoid of such).

Czarek


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDC303D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403972AbhAZKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:24:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:10878 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732002AbhAZB2C (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:28:02 -0500
IronPort-SDR: RJO4O+mUX+3OSrwgfa89EM5KoV2WBNJrJwS//OzuMYWMPFhSTc8rkMkDhe768MjFrKurb9Klzi
 56wEnAnHWAYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241355582"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="241355582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:20:56 -0800
IronPort-SDR: dDJmSZwGA96dlEzfV5Lz/swJN0DJJPkbYsyqGAQUwx0Qazbg5GB0xnFHKJd1FKsa3/TY+fz1Qh
 ZNqTVrwvSOVA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387598889"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:20:53 -0800
Subject: Re: [PATCH v7] perf stat: Fix wrong skipping for per-die aggregation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, ying.huang@intel.com
References: <20210118040521.31003-1-yao.jin@linux.intel.com>
 <20210120220735.GE1798087@krava>
 <dd75cc3f-9440-c33b-cea3-529134c33e80@linux.intel.com>
 <20210123225709.GB138414@krava>
 <de88878b-b184-b1a2-ad91-1069d81c4e53@linux.intel.com>
 <20210125094554.GB245791@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7ab33f63-ec8a-4b44-c6b0-521aad41225f@linux.intel.com>
Date:   Tue, 26 Jan 2021 08:20:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125094554.GB245791@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/25/2021 5:45 PM, Jiri Olsa wrote:
> I believe that the less ifdefs te better, if you could squash this
> change with your patch and send it, that'd be great
> 
> SNIP

I will add your change in the patch and send the v8. Thanks so much for your help!

Thanks
Jin Yao

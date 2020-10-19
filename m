Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD08292A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgJSP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:26:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:38590 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgJSP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:26:58 -0400
IronPort-SDR: IQkfUETGL72+XlVqdfgh78+jp+OuNaBO04hpE+rzKHqqnyx8gIZObhHYjDqbqXt05r0JOkQB9m
 tcVdJ8+hAoFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="184661539"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="184661539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:26:58 -0700
IronPort-SDR: X/puYn9tz2AVmatKIqgYLOxOfIFTADFCC1BNhCc8B8Xosq7FGkUh6Czzqn3sC71GTPpxnm4shC
 p0DH/9jkG+yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="347467027"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2020 08:26:56 -0700
Date:   Mon, 19 Oct 2020 23:24:11 +0800
From:   Philip Li <philip.li@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>, 0day robot <lkp@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@intel.com>
Subject: Re: [LKP] Unreliable will-it-scale context_switch1 test on 0day bot
Message-ID: <20201019152410.GA14293@intel.com>
References: <104775100.27222.1603114052224.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104775100.27222.1603114052224.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:27:32AM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> I pointed out an issue with the will-it-scale context_switch1 test run by the 0day bot on
> October 7, 2020, and got no reply.
Thanks Mathieu for the feedback, we had added it to the TODO list but sorry for
not reply in time.

Zhengjun, can you help follow up this mail thread?

> 
> Until this issue is solved, the results of those tests are basically pure noise when run on
> SMT hardware:
> 
> https://lore.kernel.org/lkml/1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com/
> 
> Who is maintaining those tests and the 0day bot ?
will-it-scale itself is from community at https://github.com/antonblanchard/will-it-scale
and we will look for the support if we don't have quick solution. 0day bot basically wraps
the test and analyze the result to find which commit leads to change.

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

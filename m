Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2327AA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgI1I4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:56:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:33517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgI1I4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:56:45 -0400
IronPort-SDR: ZEMMiTcGXgKB1lsDRvq/UyUAMePDtY3hOFFwi/ws/P/Rfs7PZMPZcikdS971EQ7X9ZneHqekwY
 MZugMsvKhH8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141977267"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="141977267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:56:44 -0700
IronPort-SDR: 06b65tFj8TWhDah8Ly+MQNX0OFW8Y1qqFAGhbyEIkXX+pO/DmKzOvlxOpZ/wecjJIoOYgKSS/s
 J0Jw1w/nsCcA==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456744432"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:56:42 -0700
Date:   Mon, 28 Sep 2020 16:56:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200928085640.GB22244@shbuild999.sh.intel.com>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200925172437.GM16872@zn.tnic>
 <20200928070723.GA25109@shbuild999.sh.intel.com>
 <20200928083420.GC1685@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928083420.GC1685@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:34:20AM +0200, Borislav Petkov wrote:
> On Mon, Sep 28, 2020 at 03:07:23PM +0800, Feng Tang wrote:
> > Thanks, it looks good to me. One thing is in v2 we supported ',' in the
> > long name field, but that's minor as we could avoid using it in .csv
> 
> We can always use ';' or some other symbol as divider if we wanna use
> ',' in the long name field but I can live with either solutions.
 
Ok, will check both the them in implementation, and sent the v3 RFC

Thanks,
Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

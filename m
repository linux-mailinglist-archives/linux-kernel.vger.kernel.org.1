Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A908326DD96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgIQOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:10:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:62082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgIQN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:59:49 -0400
X-Greylist: delayed 698 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 09:59:47 EDT
IronPort-SDR: 5X/T5Y+/+9774rez6Zkb0cILEjXj+bVgWSdMubk2gk055y2SUP09PPnnLT6Zf3p02S5vxa3yZq
 siwLtgjmrIXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="221244291"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="221244291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 06:41:07 -0700
IronPort-SDR: GnxXXdI1dQORnZaL+LevvcTM3Wkv1o/WUFqmlEf8pJXQwLtFiH3cSed350XtDpr5gdBSGuBZBD
 dEKw6rgXMLwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="307470976"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2020 06:41:05 -0700
Date:   Thu, 17 Sep 2020 21:37:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
Message-ID: <20200917133722.GA21986@intel.com>
References: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
 <20200917061220.GB31960@zn.tnic>
 <20200917073620.GA4946@intel.com>
 <20200917080044.GD31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917080044.GD31960@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:00:44AM +0200, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 03:36:20PM +0800, Philip Li wrote:
> > The 2nd type is this one, which is a summarized report of head
> > to provide an overview. Most of time, repo owner can receive the
> > bisected mail. For this time, the issue is reported against peterz-queue
> > repo which has this 767d46ab56 head firstly. Since the head later appears
> > in tip, we just gather all issues and send the summary to tip related
> > recipients. But no more bisected mail.
> 
> Yeah, but that second report is not very helpful because nowhere it says
> it is a summary and nowhere it has that link you pasted above so that
> some other maintainer can go look.
> 
> Always put yourself in the recipient's shoes and ask yourself: "what can
> the recipient do with this report and does it have everything in there
> required to be able to reproduce the issue?"
> 
> If not, then it needs changing.
thanks for the advice. We will provide update in 1-2 weeks for the progress
to make the report more informative and useful.

> 
> > We will consider how to show useful produce info in summary report as
> > the feedback here, which is quite useful, such like pointing to the
> > bisected mail. This would take some time, and we will add to our TODO
> > as high priority.
> 
> Yes, that would be much appreciated. You can also tag your reports with
> a unique hash which is then in an URL so that one can go and download the
> .config and what else is needed. For example...
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9C2DF004
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgLSO3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 09:29:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:51869 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgLSO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 09:29:51 -0500
IronPort-SDR: SpV+synNydI4tUejbzQXbUSrIlS6j36Kqid1gub3Nn4rYeT1H4j/GHy5HAuBG4nBnuVivCFJRm
 sLRLWe+B+ZAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="237146495"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="237146495"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 06:29:10 -0800
IronPort-SDR: sqhsoL5kNJct1TA4VoCAvonuTwTKBMQaN17fuZTz8ztMf6evkcZbYHeBd+Td1ATU+Zt8ohsrc0
 i7nidyJ89sPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="341150361"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga008.fm.intel.com with ESMTP; 19 Dec 2020 06:29:08 -0800
Date:   Sat, 19 Dec 2020 22:25:26 +0800
From:   Philip Li <philip.li@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: [linux-next:master 13538/13785]
 /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'
Message-ID: <20201219142526.GA20452@intel.com>
References: <202012191403.y8Aomjpm-lkp@intel.com>
 <20201219075606.GA20870@amd>
 <20201219102820.GA14085@intel.com>
 <20201219104006.GA14905@intel.com>
 <20201219131528.GA18240@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219131528.GA18240@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 02:15:28PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Crazy robot, stop spamming. This report is obviously bogus, yet, you
> > > > sent me 5 copies.
> > > Thanks Pavel for input, sorry for the false positive. It tries to
> > > bisect error like below (the new error), but it may be related to
> > > assember support. We will adjust the system to not report this out
> > > wrongly. Kindly allow some time for us to resolving this.
> > > 
> > > > > >> /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Whoever is responsible for this, please sign emails with your real
> > > > name!
> > This is Philip who maintains the 0-day ci, and lkp@intel.com is the
> > mailing list for the team here to be contacted.
> 
> Yes, so... 0-day bot normally does a really good job (and thanks for
> it).
> 
> But getting emails from robot is slightly annoying, and it would be
> nice to include name of person who is primary responsible from the bot
> somewhere.
> 
> If you are primary person responsible for the robot, your name should
> be somewhere in the email. Or perhaps the link in the trailer should
> lead to explanation somewhere.
Thanks for advice, I will consider this and add the appropriate web link in
the end of mail after polishing the current info.

> 
> Best regards,
> 								Pavel
> -- 
> http://www.livejournal.com/~pavelmachek



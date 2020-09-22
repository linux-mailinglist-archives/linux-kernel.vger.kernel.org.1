Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBC273B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgIVHHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:07:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:5955 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgIVHHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:07:31 -0400
IronPort-SDR: UkDjaQT3hrM4DVY1XfZPKhV8XstBoBC15L9dTASKf4dlNPqN7Y6swQPTxfPb1vZ/YkXDaVMJgI
 KdsOA+n5J79A==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="178611777"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="178611777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 00:07:31 -0700
IronPort-SDR: uV+Arf2krlvG4v2YQ5M33nIRn5nCbo/BcRIYDkVVj+6ef4TxPZdbS/cNZY5ryGpuEJbavViVOw
 XsIKWuc972uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="309404721"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2020 00:07:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 26882F2; Tue, 22 Sep 2020 10:07:26 +0300 (EEST)
Date:   Tue, 22 Sep 2020 10:07:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
Message-ID: <20200922070726.dlw24lf3wd3p2ias@black.fi.intel.com>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
 <20200917175217.GD29887@dhcp22.suse.cz>
 <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
 <20200918055637.GB28827@dhcp22.suse.cz>
 <e4eb32bb-f905-d15b-8596-13bf387b9f57@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb32bb-f905-d15b-8596-13bf387b9f57@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:07:23PM -0700, Vijay Balakrishna wrote:
> > 
> > I would recommend reposting the patch which adds heuristic for THP (if
> > THP is enabled) into the hotplug path, arguing with the consistency and
> > surprising results when adding memory decreases the value.
> 
> I hope my reposted patch
> ([v3 1/2] mm: khugepaged: recalculate min_free_kbytes after memory hotplug
> as expected by khugepaged)
> change log is ok:
> 
> When memory is hotplug added or removed the min_free_kbytes must be
> recalculated based on what is expected by khugepaged.  Currently
> after hotplug, min_free_kbytes will be set to a lower default and higher
> default set when THP enabled is lost.  This change restores min_free_kbytes
> as expected for THP consumers.

Any scenario when hotremove would result in changing min_free_kbytes?

> > Your initial
> > problem is in sizing as mentioned in other email thread and you should
> > be investigating more but this inconsistency might really come as a
> > surprise.
> > 
> > All that if Kirill is reconsidering his initial position of course.
> > 
> 
> Kirill, can you comment or share your opinion?

Looking again, never decreasing min_free_kbytes is the most reasonable
policy. Sorry for the noise.

But I would like to see a scenario when hotremov will end up changing
min_free_kbytes. It's not obvious to me.

-- 
 Kirill A. Shutemov

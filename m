Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B608F1AB7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407849AbgDPGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:21:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407768AbgDPGVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:21:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B277ACAE;
        Thu, 16 Apr 2020 06:21:01 +0000 (UTC)
Message-ID: <1587018059.32139.22.camel@suse.cz>
Subject: Re: [LKP] [x86, sched] 1567c3e346: vm-scalability.median -15.8%
 regression
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Date:   Thu, 16 Apr 2020 08:20:59 +0200
In-Reply-To: <a5b0b58d-54a9-0f06-c822-3087346a0ae8@linux.intel.com>
References: <20200306051916.GA23395@xsang-OptiPlex-9020>
         <a5b0b58d-54a9-0f06-c822-3087346a0ae8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 14:10 +0800, Xing Zhengjun wrote:
> Hi Giovanni,
> 
>    1567c3e346("x86, sched: Add support for frequency invariance") has 
> been merged into Linux mainline v5.7-rc1 now. Do you have time to take a 
> look at this? Thanks.
> 

Apologies, this slipped under my radar. I'm on it, thanks.


Giovanni Gherdovich

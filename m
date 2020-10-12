Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C7828AFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgJLISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:18:30 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:45353 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgJLIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:18:29 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 2D879C102E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:18:28 +0100 (IST)
Received: (qmail 30399 invoked from network); 12 Oct 2020 08:18:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2020 08:18:27 -0000
Date:   Mon, 12 Oct 2020 09:18:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] [fs] b6509f6a8c: will-it-scale.per_thread_ops -12.6%
 regression
Message-ID: <20201012081825.GR3227@techsingularity.net>
References: <20200706012029.GZ3874@shao2-debian>
 <6b301f34-f8fe-c626-e5e5-9af5c257c5c3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6b301f34-f8fe-c626-e5e5-9af5c257c5c3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:20:26PM +0800, Xing Zhengjun wrote:
> Hi Mel,
> 
>    It is a revert commit caused the regression, Do you have a plan to fix
> it? Thanks. I re-test it in v5.9-rc8, the regression still existed.
> 

The revert caused a *performance* regression but the original
performance gain caused a functional failure. The overall performance
should be unchanged. I have not revisited the topic since.

-- 
Mel Gorman
SUSE Labs

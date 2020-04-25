Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E21B86AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 09:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYNBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:01:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6EEC2AD57;
        Sat, 25 Apr 2020 13:01:46 +0000 (UTC)
Date:   Sat, 25 Apr 2020 15:01:36 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops -14.1%
 regression
Message-ID: <20200425130136.GA28245@zn.tnic>
References: <20200425114414.GU26573@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200425114414.GU26573@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 07:44:14PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -14.1% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 1de08dccd383482a3e88845d3554094d338f5ff9 ("x86/mce: Add a struct mce.kflags field")

I don't see how a struct mce member addition will cause any performance
regression. Please check your test case.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

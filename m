Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE261E1F96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgEZK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgEZK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:26:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C1A20776;
        Tue, 26 May 2020 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590488768;
        bh=lmcLb8+M+6Qz8n5wFOSYGTrAgIGliGsm6Wgl/neWLe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5HGb9WmqFFPwxXwxPi1zRvi8opVRLcbwCw1s6EbDHTiGStc7Dg2K91bx0xK3Wc6p
         hyc0qAhNV97ABhWDV0r1bgYfa5nDac6nFZlQsZZ57G9GDeKnbTE77OSGFQi1PZ4smQ
         MPvwush2j+LLXl9aeZ6h/vebHCCq6xFa87z+7bbY=
Date:   Tue, 26 May 2020 11:26:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200526102602.GA27166@willie-the-truck>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522030919.GE32389@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 11:09:19AM +0800, Leo Yan wrote:
> On Mon, May 04, 2020 at 07:56:22PM +0800, Leo Yan wrote:
> > This patch set is to support synthetic events with enabling Arm SPE
> > decoder.  Since before Xiaojun Tan (Hisilicon) and James Clark (Arm)
> > have contributed much for this task, so this patch set is based on their
> > privous work and polish for the version 7.
> > 
> > The main work in this version is to polished the core patch "perf
> > arm-spe: Support synthetic events", e.g. rewrite the code to calculate
> > ip, packet generation for multiple types (L1 data cache, Last level
> > cache, TLB, remote access, etc).  It also heavily refactors code for
> > data structure and program flow, which removed unused fields in
> > structure and polished the program flow to achieve neat code as
> > possible.
> > 
> > This patch set has been checked with checkpatch.pl, though it leaves
> > several warnings, but these warnings are delibarately kept after
> > reviewing.  Some warnings ask to add maintainer (so far it's not
> > necessary), and some warnings complaint for patch 02 "perf auxtrace:
> > Add four itrace options" for the text format, since need to keep the
> > consistency with the same code format in the source code, this is why
> > this patch doesn't get rid of checkpatch warnings.
> 
> Gentle ping ...
> 
> It would be appreciate if can get some review for this patch set.

I was hoping that James Clark would have a look, since he was the last
person to go near the userspace side of SPE.

Will

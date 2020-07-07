Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE52216796
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:40:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85618C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5z5P6kkBRDwV4ACNzzQRP/E27ooFknK0lrMgzBi/ZKE=; b=PCXTGsWAFuuB8lH46eW6r9kT+l
        xpf8ahMVydHMXt9AZ4KdMi4QTVHu95SzE5g32Biwn+KGaWA+48+RpaqM6qNPzLB/mUaM3MV2UN6RV
        4/ubjv8UOCwwQPN97Uz1bkN+nWtdvCVQOXK9I2zgUIn/GrrLCfC30CrGHac9JFtfynRIIJPf3fFe4
        sGtVjQqLk0yzhZHz+np6J9y3tWfkamm3OamuNORWT52KLG8Hq//ucNOmCCSF/exaOokgU94e8KSBq
        wFouMqNTyl8hG04RuxCbePY/YQE/KPhhBJk7sMdOe/cBCvhO8C2diEqa+jd4XQXFkmDl1EMfUUErs
        BklzN2JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsiD4-0004dU-Ae; Tue, 07 Jul 2020 07:40:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96C3D3006D0;
        Tue,  7 Jul 2020 09:40:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80A42213C912F; Tue,  7 Jul 2020 09:40:07 +0200 (CEST)
Date:   Tue, 7 Jul 2020 09:40:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V3 13/23] perf/x86/intel/lbr: Factor out
 intel_pmu_store_lbr
Message-ID: <20200707074007.GI4800@hirez.programming.kicks-ass.net>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
 <1593780569-62993-14-git-send-email-kan.liang@linux.intel.com>
 <20200703195024.GI2483@worktop.programming.kicks-ass.net>
 <bf63dee4-d25f-89d8-1893-572d84cfa667@linux.intel.com>
 <ddfcd90f-ca77-edf4-09b8-183efb2ae2f2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfcd90f-ca77-edf4-09b8-183efb2ae2f2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 06:29:58PM -0400, Liang, Kan wrote:
> On 7/3/2020 4:59 PM, Liang, Kan wrote:
> > On 7/3/2020 3:50 PM, Peter Zijlstra wrote:

> > > If I'm not mistaken, this correctly deals with LBR_FORMAT_INFO, so can't
> > > we also use the intel_pmu_arch_lbr_read() function for that case?
> > 
> 
> There is another more severe issue which prevents sharing the read of Arch
> LBR with LBR_FORMAT_INFO. Sorry I missed it.

No worries, I too missed it.

> For the legacy LBR, the youngest branch is stored in TOS MSR. The next
> youngest is in (TOS - 1)...
> 
> For Arch LBR and LBR PEBS, the youngest branch is always in entry 0. The
> next youngest is in entry 1...
> 
> The growth of the legacy LBR is in a reversed order of Arch LBR and LBR
> PEBS. The legacy LBR also relies on TOS. I'm afraid we cannot use the
> intel_pmu_arch_lbr_read() function for LBR_FORMAT_INFO.
> 
> I think I will only send a patch to support NO_{CYCLES,FLAGS} for all LBR
> formats.

Thanks!

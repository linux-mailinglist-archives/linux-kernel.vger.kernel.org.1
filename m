Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC76F2AD618
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgKJMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKJMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:22:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1943C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3/1Uid5NXV02fVcliXKfyabT8T10rQnq7Svabpzfx6E=; b=2A+m1iHAGoU/HdwXwcZvWhxWWB
        zBiXeNqBCfidAPG4wb63pWEAew0Euxzpf95/s5gQsQTIXoO/xsTN6a7Nhxq4Ez0speEvRt+Oa6LI3
        haNxoh8Vpu9nos/F6X88HLocpfqNRE6cu+f963lqiC6+F4uPu4EARml6MtTkTrAFcBNsMBdKrvGX+
        XeJ2vybnjj5kax2+tdrpZFKcDlTVDGOS08ogV6OUal2kUfre5zvmdDCV0vE6pd7qaesEqrrV3VLwS
        hVRUbI2w41KR1tixNhice0ZmQHw0U0tOdZXEnIvfTsH/xiDomNs3yJVlWsZghoMsJEPf+H9dg76m0
        Sz+g9Wig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcSfR-0004R9-Ov; Tue, 10 Nov 2020 12:22:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85EFB30705A;
        Tue, 10 Nov 2020 13:22:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7744C2C29A9E4; Tue, 10 Nov 2020 13:22:32 +0100 (CET)
Date:   Tue, 10 Nov 2020 13:22:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201110122232.GH2594@hirez.programming.kicks-ass.net>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110080716.GU2594@hirez.programming.kicks-ass.net>
 <20201110115426.GA348806@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110115426.GA348806@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:54:26AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 10, 2020 at 09:07:16AM +0100, Peter Zijlstra escreveu:
> > On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > > Adding support to carry build id data in mmap2 event.
> > > 
> > > The build id data replaces maj/min/ino/ino_generation
> > > fields, whichc are also used to identify map's binary,
> > > so it's ok to replace them with build id data:
> > > 
> > >   union {
> > >           struct {
> > >                   u32       maj;
> > >                   u32       min;
> > >                   u64       ino;
> > >                   u64       ino_generation;
> > >           };
> > >           struct {
> > >                   u8        build_id[20];
> > >                   u8        build_id_size;
> > 
> > What's the purpose of a size field for a fixed size array? Also, I'd
> > flip the order of these fields, first have the size and then the array.
> 
> There can be different types of build-ids, with different sizes,
> flipping the order of the fields is indeed sensible, as we could then
> support even larger build_ids if the need arises :)

3 whole bytes.. whooo!

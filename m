Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808C254164
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH0JCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0JCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:02:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D2C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ylU9/vtiYnFMWckQjyu+RBxGySTt3HohEKFZO4nkt4=; b=eczCmhbNWwGSwC1ZX86Bah1k6s
        YTLJJq8L2QEJNwjHQrTkzIy/pMU6jJCGuCk6DtsTfCQkBlfUPmLmQWbppThcPgwfMZ66ktuPEVDMp
        yeF4Qn1/SYT1Ne+iZYGNPLTVt7MoxZk4Lj6ybGJV5nYNqQ0vaQnm7DOxmI7LfHeViIREe2cK4Jfja
        P4TW4tP4yz5i4m2VBaQNLcdjnv5rhHjl/54TdswVHubvyOlAxfoh6qzBE/9UFu538YzwRnbXWV7I2
        zLjpVSeqnya7MgBNj8GHB1nNsGwaq4ayhprdZpdCG+Ne4QkvowdbxE8gSoy5u6jalhkObxjsfOD1u
        kmHOX88w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBDnc-0005Sv-4P; Thu, 27 Aug 2020 09:02:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4501A301A7A;
        Thu, 27 Aug 2020 11:02:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F05B62C2E3429; Thu, 27 Aug 2020 11:02:20 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:02:20 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200827090220.GH1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <20200825221555.a2d72c9754284feced6a8536@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825221555.a2d72c9754284feced6a8536@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:

> Yeah, kretprobe already provided the per-instance data (as far as
> I know, only systemtap depends on it). We need to provide it for
> such users.

Well, systemtap is out of tree, we don't _need_ to provide anything for
them. Furthermore, the function-graph tracer's ret_stack, which you said
you wanted to integrate with, also doesn't provide this.

Ditching it makes things simpler in that all kretprobe_instance's will
be the same and we no longer need per kretprobe storage of them.

Anyway, let me try and preserve them for now...

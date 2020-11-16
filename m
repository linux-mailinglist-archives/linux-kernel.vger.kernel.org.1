Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46BF2B465D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgKPOtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKPOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:49:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB0C0613CF;
        Mon, 16 Nov 2020 06:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDf2G1ey+OqMdRV7SqRvnp7FIZVqoCW/+CXV/+/I1ZY=; b=r01iUwUpGWhjIXd1GUDYNDdyxI
        mBMuNuRjP05KACKmLNB4FTSzhKktN+B+bjDWs6klVUUN9tT9qQz3EpsHUpK1LE59EqLFsFqfJeMDf
        hjglFpwHbTPdbeKATYnBa+OLOAGfpEmTQto/iMzFwtET/gWM8TsRuKAp8Yc/gfYZevoMaNGap9DF/
        bUKBrLQb66A7qdGAvEj8p3TccvPxxHzmxv6QloBQ10WeJ9shTqxUS3pqbolT3euO4pflznUi+g8cU
        XApQxY6rY+GJ1ul2XnfRMsCf1PFbGynUK5eM2Tw6ARtqKZgEhYNM8YY/Bc/hW1Fvo5uIh6VeUGJEa
        dc1PjY1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefoh-00037S-7e; Mon, 16 Nov 2020 14:49:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4A5E307A49;
        Mon, 16 Nov 2020 15:49:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8500B20299B60; Mon, 16 Nov 2020 15:49:14 +0100 (CET)
Date:   Mon, 16 Nov 2020 15:49:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201116144914.GE3121378@hirez.programming.kicks-ass.net>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113210327.GJ17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 09:03:27PM +0000, Matthew Wilcox wrote:
> I think almost all of this information should go into atomic_ops.rst

No, we should delete atomic_ops.rst. It's bitrotted nonsense. The only
reason it still exists is because I can't seem to get around to
verifying we've actually covered everything in the new documentation:

	Documentation/atomic_*.txt

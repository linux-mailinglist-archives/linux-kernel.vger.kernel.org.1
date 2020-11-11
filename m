Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2D2AF5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKQER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:04:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D8C0613D1;
        Wed, 11 Nov 2020 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iYncmeZ9hvqZ5/y+et8tVxToCOeVVwCuQgUXF3Dmkj4=; b=0CqMK5PUx1fsDBB/jOcqQIpgNM
        M+GiTSC5T9DjE7PhhSZm4YjEavlB1/uKv1I7eZszR4YpuY1jw8YBuurUirKwb5syHvGYMxCrJe8cY
        Q8eEWVLkmNRaX6T7AzYpyowIka4gtGzLam+WF6Gn230uO0fF+FBXrLgji1Z2Qu9EVsmHCu/m6UBbF
        ag6vTEU787J+pfXBjvCy+/2dz/CRbC/LoGiWwaHtldRe5mUpDNHSMzmCfuoZnHzezuzWWl44nBNsx
        lKtE2HPyfOw4deNAiHJmyxm86HofJdLI5pZ/WviNNn9MaM4rkm03gF+rwDktJJi6RZqEQuqID+bHY
        SOEJJG3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcsbU-000191-Md; Wed, 11 Nov 2020 16:04:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B61B301324;
        Wed, 11 Nov 2020 17:04:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47E98203E65AF; Wed, 11 Nov 2020 17:04:11 +0100 (CET)
Date:   Wed, 11 Nov 2020 17:04:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20201111160411.GF2628@hirez.programming.kicks-ass.net>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:56:49AM -0700, Shuah Khan wrote:

> Why would you say no to read and inc?

Because they don't guarantee uniqueness (bar wrapping), which is the
only reason to use an atomic to begin with.

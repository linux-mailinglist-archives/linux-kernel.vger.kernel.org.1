Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05722DC0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgLPNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgLPNB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:01:58 -0500
Date:   Wed, 16 Dec 2020 14:01:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608123677;
        bh=zqEbIloXe4btKRmbyueardo72glBZ0uWgLKJFpwCDSs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=do0P5oLeN1laoDzYVlnpmPTjdeNqXbMDI1T6mYG0uCSxgDToJx0pt/vEZJ7Uygt37
         +qdLh5paVIVAu1C949BO2giJI5SgMP8BvycOqGTSGFMeso+/k3N2NtlfeRqLzSC9jt
         vsPXeQkwOylOOA+WGHWpuW1WCFwSgj4nohXIB1LOccV997CqJjYui3BhYAXM7rPsfw
         5XlHEXiu7jats7o5AogvqgnzS44AAb0mPzvkWZWpAXY1n8Y1QxI8hoFIYYXeLHVETR
         oJyGn5LXADaaeDt4BIPXQzenAFTCbS+uIpHlYc2yRNT8S6QMknDw6nwZmF1DWtiOl7
         rXqHHHgLz2xng==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: TREE01 rcutorture writer stalls?
Message-ID: <20201216130114.GA242489@lothringen>
References: <20201216050407.GA14426@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216050407.GA14426@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:04:07PM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> Are you seeing rcutorture writer stalls?  Please see attached for an
> example from testing, search for "Call Trace".  I am running an overnight
> test, which should get me some idea of frequency.  My thought is to run
> on the same version, but without the rcutorture.nocbs_nthreads=0 and
> rcutorture.nocbs_toggle=1000 kernel boot parameters.
> 
> This sort of error can occur when grace periods are progressing, but
> callback processing is not.  Things do seem to recover.
> 
> Other thoughts?

Ok I'm trying to reproduce that.

Thanks.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFD1E60D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbgE1M2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 08:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389675AbgE1M2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:28:49 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8384C20888;
        Thu, 28 May 2020 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590668929;
        bh=YJHXDrxBQ7egNlQcu8sdaybqWoRD4SjKVsfa1BopeZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xeZ7RBcI5V4Si3IJWFfn09Fb2S58vTt2pusnlRlUfra1SoW88gur2womTM6TIPah+
         YTlBo2UZD8sDGfImspOamNNS7OQjNOdwgjf2Z/4XFdjhH5ticLexjRf3QHZsKmDz61
         XfaE2WrKtm1NV3df9pTneOTFVogiLvhBTAu49qFw=
Date:   Thu, 28 May 2020 14:28:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 2/7] smp: Optimize flush_smp_call_function_queue()
Message-ID: <20200528122845.GA551@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.836818381@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161907.836818381@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:10:59PM +0200, Peter Zijlstra wrote:
> The call_single_queue can contain (two) different callbacks,
> synchronous and asynchronous. The current interrupt handler runs them
> in-order, which means that remote CPUs that are waiting for their
> synchronous call can be delayed by running asynchronous callbacks.
> 
> Rework the interrupt handler to first run the synchonous callbacks.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I hope we are not unlucky enough to have dependencies between
some async and sync callbacks that require the whole execution
in order.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

(Sweet llist dance, I think I need fresh air and coffee now).

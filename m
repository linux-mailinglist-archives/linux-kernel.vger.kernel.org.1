Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE162B8369
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgKRRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKRRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:54:21 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E4E2072C;
        Wed, 18 Nov 2020 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605722060;
        bh=2chfH8EPljoz9qid6xfoiBfanuWdJD9OCp12nXdd7p8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q5GVecmHE3n34e8cX0cTepQdtkvOj6VINeogsdnTvHzOgvTPGXC5cpRJ5wtmKFfUt
         DPlYJh7VWKfvXiC8VmXYi6YOrmpnPZ48Q9DHsdKD2dPJVeK2vV55+oAMjbgyTMC1PS
         xINQ/HCVgEymbLPbWgxQaV0ZZCRlsU27WXbfpE/U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 212253520FE0; Wed, 18 Nov 2020 09:54:20 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:54:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201118175420.GA17381@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175218.GA16039@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:52:18AM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> Here is the last few months' pile of warnings from rcutorture runs.

And this time with scenario names.  ;-)

								Thanx, Paul

------------------------------------------------------------------------

./2020.11.02-12.05.02/TREE02/console.log:[  255.098527] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282!!!
./2020.09.01-17.20.03/LOCK05.3/console.log:[  414.534548] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-17.20.03/LOCK05.3/console.log:[ 3798.654736] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-17.20.03/LOCK05.2/console.log:[ 1718.589367] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-17.20.03/LOCK05.2/console.log:[ 6632.777655] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.29-16.54.07/SRCU-P/console.log:[ 2873.688490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.02-17.25.58/TREE05/console.log:[ 3081.738937] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.46.51/SRCU-N/console.log:[ 2673.597523] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-17.17.02/LOCK05.3/console.log:[ 1467.372887] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-17.17.02/LOCK05/console.log:[   34.371094] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-17.17.02/LOCK05/console.log:[ 1147.260097] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-16.00.39/SRCU-P/console.log:[ 5066.699589] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.12-21.08.28/SRCU-P/console.log:[  816.338843] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-15.27.04/LOCK05/console.log:[   34.338836] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-02.28.14/TREE01/console.log:[ 1234.111394] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE01/console.log:[ 1282.109415] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE07/console.log:[  239.215890] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE07/console.log:[  367.918969] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/TREE07/console.log:[ 1461.037894] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-02.28.14/TREE07/console.log:[ 1503.810903] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE07/console.log:[ 1503.811939] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TRACE01/console.log:[  699.514824] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/SRCU-P/console.log:[  751.681629] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE02/console.log:[  287.770126] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/TREE02/console.log:[  287.771096] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/TREE05/console.log:[  648.009370] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-02.28.14/TREE05/console.log:[  924.733405] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/TREE05/console.log:[  924.734011] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-02.28.14/TREE05/console.log:[ 1743.197353] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.10-02.28.14/TREE04/console.log:[ 1528.161635] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-02.28.14/TREE04/console.log:[ 1528.162313] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.30-11.47.17/TREE08/console.log:[  265.201513] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.30-11.47.17/TREE08/console.log:[  473.137587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.05-11.47.22/TREE08/console.log:[  187.375426] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.02-16.20.12/LOCK05/console.log:[ 1361.544451] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-17.37.06/TREE05/console.log:[   79.519727] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!

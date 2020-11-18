Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954652B8545
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKRUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:04:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgKRUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:04:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F96205F4;
        Wed, 18 Nov 2020 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605729838;
        bh=DzFLSWL3n2HcRMEJEEvD7wudMgYkDmjtT5xE1ByTUg0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mDc2byUmYOga0mOv7B60jDxn4k4REEHDLMcJJXWri5hPOtyZIc07YToCDXxBevVF6
         /JubMGawGOCjI72hsTA1PY6zm2kECEPSdI934UdD84ELRmCvj7jFjkjPWO7fYxgik+
         4X1LEhsJkIaMkBNaHthniqf/iK4g86DQtmBOZnIg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C3B9635225D7; Wed, 18 Nov 2020 12:03:57 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:03:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201118200357.GA9862@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
 <20201118175420.GA17381@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175420.GA17381@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:54:20AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 18, 2020 at 09:52:18AM -0800, Paul E. McKenney wrote:
> > Hello, Frederic,
> > 
> > Here is the last few months' pile of warnings from rcutorture runs.
> 
> And this time with scenario names.  ;-)

And a few more from another test box.  This should be enough for
at least a little bit of statistical analysis.

								Thanx, Paul

------------------------------------------------------------------------

./2020.08.10-06.04.19/TREE05.2/console.log:[ 1360.799589] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.11-14.54.49/TREE01/console.log:[ 1270.286015] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.11-14.54.49/TREE01/console.log:[ 1401.860993] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.11-14.54.49/TREE01.4/console.log:[ 1596.597275] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.12-13.39.56/TREE01.3/console.log:[  297.832615] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.12-13.39.56/TREE01.4/console.log:[ 1724.411202] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.12-13.39.56/SRCU-N.2/console.log:[ 1534.578486] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.08.12-13.39.56/RUDE01.2/console.log:[ 2937.787841] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.08.18-20.34.23/SRCU-P.2/console.log:[28325.140032] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/SRCU-P.3/console.log:[ 7525.924912] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/SRCU-P.3/console.log:[14070.699918] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/SRCU-P.4/console.log:[13647.351120] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/SRCU-P.4/console.log:[31888.757699] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.08.18-20.34.23/TREE01.2/console.log:[  328.882919] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.18-20.34.23/TREE02.4/console.log:[28349.680021] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TREE05/console.log:[16912.551628] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TREE05.3/console.log:[21594.138445] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TREE05.4/console.log:[ 3451.803298] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TREE05.4/console.log:[ 9075.220283] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/SRCU-N.3/console.log:[  467.870927] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TRACE01.2/console.log:[26279.167831] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/RUDE01.3/console.log:[35791.111930] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.08.18-20.34.23/TASKS01.4/console.log:[ 5888.011416] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.18-20.34.23/TASKS01.4/console.log:[19999.115453] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P/console.log:[20908.282702] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P/console.log:[21277.118731] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P/console.log:[22094.205710] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P/console.log:[32384.058712] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P/console.log:[34241.918701] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.2/console.log:[19111.138161] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.2/console.log:[32012.903164] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.3/console.log:[14581.682671] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.3/console.log:[14743.026689] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.3/console.log:[22177.587677] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.3/console.log:[32353.780675] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-P.4/console.log:[19537.404281] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/TREE01/console.log:[ 7422.103682] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.08.19-20.29.52/TREE02.4/console.log:[ 2575.145656] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/TREE05.2/console.log:[33699.324351] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.08.19-20.29.52/TREE05.4/console.log:[ 7615.412789] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/TREE05.4/console.log:[15356.661797] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/SRCU-N.4/console.log:[18480.047395] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/TRACE01.3/console.log:[15827.852422] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/RUDE01/console.log:[26071.041443] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.08.19-20.29.52/TASKS01.2/console.log:[35587.946338] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-10.44.18/SRCU-P/console.log:[ 1051.405359] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-10.44.18/SRCU-P.3/console.log:[ 2057.666938] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-10.44.18/TREE05.4/console.log:[ 3370.670057] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-17.19.08/SRCU-P.4/console.log:[ 1658.501917] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-17.19.08/TRACE02/console.log:[ 4432.418069] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE07.2/console.log:[ 5564.619608] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.01-20.33.47/SRCU-P/console.log:[ 3826.477129] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P/console.log:[17783.984086] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P/console.log:[22801.715114] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P/console.log:[32333.365097] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.2/console.log:[15158.240587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.2/console.log:[35257.454599] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.3/console.log:[26032.696745] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.3/console.log:[34265.274898] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.4/console.log:[10176.979711] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.4/console.log:[24675.411697] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/SRCU-P.4/console.log:[32500.122723] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE01.4/console.log:[21655.260925] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.01-20.33.47/TREE02.3/console.log:[ 7983.493841] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.01-20.33.47/TREE05.2/console.log:[14318.702248] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE05.3/console.log:[ 2440.197843] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE05.3/console.log:[17034.109836] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE05.4/console.log:[ 9260.406463] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TREE05.4/console.log:[20230.836564] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/RUDE01.2/console.log:[18246.776064] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/RUDE01.3/console.log:[22915.726815] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TASKS01/console.log:[ 4163.155346] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TASKS01/console.log:[ 8538.001378] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TASKS01/console.log:[19578.833343] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TASKS01.2/console.log:[15143.959356] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.01-20.33.47/TASKS01.2/console.log:[24769.815437] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.01-20.33.47/TASKS01.3/console.log:[34506.292901] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-14.26.54/LOCK05.8/console.log:[  195.982694] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-14.26.54/LOCK05.12/console.log:[   74.948950] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-14.26.54/LOCK05.12/console.log:[  326.417944] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-14.26.54/LOCK05.13/console.log:[ 1284.941081] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-17.12.10/TRACE01.3/console.log:[  548.264967] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-17.12.10/TASKS01.4/console.log:[  660.235243] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P/console.log:[ 1229.860725] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.3/console.log:[ 5179.636434] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.3/console.log:[11968.057444] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.3/console.log:[14405.173440] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.3/console.log:[27323.309432] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.4/console.log:[ 4274.059108] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.4/console.log:[14581.067109] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/SRCU-P.4/console.log:[23458.698118] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE01/console.log:[13876.153082] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.02-20.34.16/TREE02/console.log:[ 9949.715019] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE02.2/console.log:[12254.674191] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE02.3/console.log:[12759.684464] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE02.4/console.log:[ 1879.826507] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE02.4/console.log:[33834.729504] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE05.4/console.log:[10918.328420] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE05.4/console.log:[15888.870419] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TREE05.4/console.log:[34747.628422] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TRACE01.2/console.log:[ 4416.577269] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TRACE01.4/console.log:[12835.479664] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TRACE01.4/console.log:[22554.405648] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.02-20.34.16/TASKS01/console.log:[29548.301700] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.03-17.06.33/SRCU-P/console.log:[ 8965.448551] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P/console.log:[11327.435566] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P/console.log:[32676.680571] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P/console.log:[32734.469564] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.2/console.log:[ 6263.268842] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.2/console.log:[14528.165860] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.2/console.log:[30476.777865] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.2/console.log:[39640.032858] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.2/console.log:[39945.700895] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.3/console.log:[ 9486.777957] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.3/console.log:[10105.916928] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.3/console.log:[25142.973939] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.3/console.log:[37505.785926] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.4/console.log:[25478.784696] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-P.4/console.log:[26482.302723] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TREE01.3/console.log:[ 1721.039192] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.03-17.06.33/TREE02.2/console.log:[31483.220690] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TREE05/console.log:[19519.125376] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TREE05.3/console.log:[ 3973.895586] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TREE05.4/console.log:[24005.333490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TREE05.4/console.log:[41438.143488] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/SRCU-N.3/console.log:[41297.742465] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TRACE01/console.log:[37295.082087] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TRACE01.3/console.log:[29526.815258] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TRACE01.4/console.log:[27295.418066] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/RUDE01.3/console.log:[ 5665.056657] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282!!!
./2020.09.03-17.06.33/RUDE01.3/console.log:[40077.287065] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TASKS01/console.log:[ 1888.861245] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.03-17.06.33/TASKS01.4/console.log:[25635.231839] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.03-17.06.33/TASKS01.4/console.log:[40619.423740] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P/console.log:[17518.172302] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P/console.log:[25092.183299] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.2/console.log:[26452.461902] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.2/console.log:[31492.396891] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.2/console.log:[35093.356864] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.2/console.log:[40703.666880] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.3/console.log:[  546.747087] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.3/console.log:[ 6084.283102] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.3/console.log:[16767.926086] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.07-19.13.50/SRCU-P.3/console.log:[27433.846091] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.3/console.log:[28873.467100] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.4/console.log:[11728.414209] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.4/console.log:[13508.514304] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-P.4/console.log:[15052.450257] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TREE01/console.log:[16793.583385] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.07-19.13.50/TREE02.3/console.log:[28471.359508] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TREE05/console.log:[10273.780204] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TREE05/console.log:[28083.463185] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TREE05/console.log:[42532.142218] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TREE05.2/console.log:[ 7205.338841] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-N/console.log:[22348.780512] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-N.3/console.log:[30051.167479] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/SRCU-N.4/console.log:[  998.178871] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.07-19.13.50/TASKS01/console.log:[ 1042.506254] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.07-19.13.50/TASKS01.3/console.log:[ 1667.285909] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.07-19.13.50/TASKS01.4/console.log:[19747.777593] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P/console.log:[ 6538.681130] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P/console.log:[19845.118112] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.2/console.log:[13552.882728] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.2/console.log:[24197.684758] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.2/console.log:[27107.256721] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.3/console.log:[ 4591.573742] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.3/console.log:[16937.560710] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.3/console.log:[17924.504684] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/SRCU-P.3/console.log:[24971.227729] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/TREE01/console.log:[26160.170686] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.09-22.32.50/TREE01.4/console.log:[27826.985018] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.09-22.32.50/TREE02.2/console.log:[19814.112142] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/TREE05.4/console.log:[27858.888105] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.09-22.32.50/SRCU-N.4/console.log:[16869.541715] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.09-22.32.50/SRCU-N.4/console.log:[24255.473801] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/TRACE01/console.log:[  858.168900] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/TRACE01.3/console.log:[16898.754067] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.09-22.32.50/TRACE01.4/console.log:[20342.077955] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/SRCU-P.3/console.log:[ 3796.452978] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TREE02/console.log:[ 1131.451014] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TREE02/console.log:[10742.579998] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TREE05/console.log:[ 7700.005307] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TREE05.3/console.log:[ 8542.684048] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TRACE01.2/console.log:[  986.374557] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-13.33.34/TRACE01.4/console.log:[ 8798.691587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-17.28.24/SRCU-P/console.log:[ 2601.953358] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P/console.log:[16670.685642] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P/console.log:[18420.769655] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P/console.log:[22444.509671] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P/console.log:[62463.965667] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[ 3441.272192] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[ 9801.082188] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[12183.739192] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[15572.155194] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[26449.402178] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[52604.677184] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.2/console.log:[68687.478195] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.3/console.log:[11367.290580] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.3/console.log:[25004.542595] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.3/console.log:[61937.092558] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.3/console.log:[63902.015583] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-P.4/console.log:[60450.189931] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE02/console.log:[17798.246817] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/TREE02/console.log:[56462.229766] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE02.2/console.log:[41845.501487] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE02.2/console.log:[57523.356488] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE02.3/console.log:[49735.125028] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE02.4/console.log:[43048.018402] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05/console.log:[15636.079957] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05/console.log:[21940.547979] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05/console.log:[26107.011228] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.2/console.log:[21608.572425] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.2/console.log:[66319.737441] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.3/console.log:[ 7456.171913] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.4/console.log:[ 6617.960602] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.4/console.log:[42801.041596] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.4/console.log:[58271.887606] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TREE05.4/console.log:[69887.199606] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-N/console.log:[22517.089715] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-N.2/console.log:[ 7768.491305] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/SRCU-N.3/console.log:[50534.245943] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TRACE01/console.log:[18981.323079] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/TRACE01/console.log:[57852.361207] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TRACE01.2/console.log:[42431.152466] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TRACE01.3/console.log:[37068.864602] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TRACE02.3/console.log:[12784.450804] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TRACE02.3/console.log:[17180.737859] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/RUDE01/console.log:[ 1920.421916] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.10-21.22.19/RUDE01/console.log:[23337.504022] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/RUDE01/console.log:[24112.995064] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.10-21.22.19/RUDE01.2/console.log:[34142.446190] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/RUDE01.4/console.log:[51139.309304] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/TASKS01/console.log:[27459.589626] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.10-21.22.19/TASKS01.2/console.log:[34283.837163] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TASKS01.3/console.log:[ 5852.019600] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TASKS01.4/console.log:[28342.643587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.10-21.22.19/TASKS01.4/console.log:[30994.995770] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.10-21.22.19/TASKS01.4/console.log:[54865.715586] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P/console.log:[14273.479260] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P/console.log:[17545.349296] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P/console.log:[24443.462289] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P/console.log:[36884.558277] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.2/console.log:[20432.699476] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.2/console.log:[33616.375490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.2/console.log:[43005.758517] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.3/console.log:[ 5763.295084] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.3/console.log:[33508.958073] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-P.4/console.log:[14908.858789] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TREE02/console.log:[15765.004172] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TREE02.4/console.log:[ 7976.814247] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TREE05/console.log:[12024.988060] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TREE05.2/console.log:[41555.751938] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TREE05.3/console.log:[39960.947078] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/SRCU-N.2/console.log:[16018.320974] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TRACE01.2/console.log:[16039.528424] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TRACE01.2/console.log:[17536.402420] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/RUDE01.2/console.log:[24750.994346] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.12-21.31.09/TASKS01/console.log:[13014.221751] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.13-20.42.47/SRCU-P/console.log:[ 7130.385523] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P/console.log:[27270.483494] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P/console.log:[27806.095497] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P.2/console.log:[ 2250.152563] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P.2/console.log:[ 4420.139574] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P.2/console.log:[17723.111559] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P.4/console.log:[ 1606.140825] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-P.4/console.log:[21910.075825] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TREE02/console.log:[11958.806425] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TREE02/console.log:[26782.004426] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TREE05.2/console.log:[33597.647062] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TREE05.3/console.log:[ 3617.168546] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/SRCU-N/console.log:[15047.247440] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TRACE01/console.log:[10625.687092] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TRACE01.4/console.log:[31492.603205] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.13-20.42.47/TRACE02.4/console.log:[24985.460479] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.13-20.42.47/TASKS01.2/console.log:[21956.465517] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.27/console.log:[ 1607.430017] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.27/console.log:[ 3053.317445] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.32/console.log:[ 8119.556860] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.38/console.log:[ 1966.800681] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.38/console.log:[ 5525.714935] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE01.46/console.log:[ 4518.754974] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.14-20.52.20/TRACE02.48/console.log:[ 5253.114602] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.14-20.52.20/TRACE02.56/console.log:[ 2907.722030] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.15-00.51.07/TRACE01.4/console.log:[ 7252.406973] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.5/console.log:[10688.656581] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.11/console.log:[12453.411584] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.13/console.log:[ 4401.351815] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.18/console.log:[ 9749.570375] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.24/console.log:[16390.982709] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.28/console.log:[11262.653395] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.28/console.log:[12501.177662] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.15-00.51.07/TRACE01.30/console.log:[15834.891459] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.39/console.log:[17793.334316] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.40/console.log:[15933.293558] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.47/console.log:[ 1655.379931] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE01.47/console.log:[ 9643.611913] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE02.19/console.log:[21485.574103] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE02.28/console.log:[19780.599577] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-00.51.07/TRACE02.56/console.log:[ 4460.111677] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.15-15.45.30/TRACE02.4/console.log:[  607.605096] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-17.04.11/SRCU-P/console.log:[ 2317.524247] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-17.04.11/TREE01/console.log:[ 3515.732497] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.15-17.04.11/TREE05/console.log:[ 3137.759223] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-17.04.11/TREE05.3/console.log:[ 1449.310610] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P/console.log:[  768.060845] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P/console.log:[42738.366822] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.2/console.log:[18719.530189] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.2/console.log:[21855.339200] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.3/console.log:[ 4709.478511] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.3/console.log:[14364.324460] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.3/console.log:[26771.817470] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.4/console.log:[ 2459.493170] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/SRCU-P.4/console.log:[19983.391176] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05/console.log:[37255.006220] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05.3/console.log:[40142.305200] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05.4/console.log:[21187.742345] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05.4/console.log:[22022.438360] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05.4/console.log:[27268.182336] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TREE05.4/console.log:[35365.423372] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE01.3/console.log:[23534.468456] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE02/console.log:[29674.968432] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.15-18.33.43/TRACE02.2/console.log:[26404.700149] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE02.2/console.log:[39584.153184] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE02.3/console.log:[14321.616047] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE02.3/console.log:[35664.659033] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TRACE02.4/console.log:[33002.684296] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/RUDE01.4/console.log:[ 5353.068865] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.15-18.33.43/TASKS01/console.log:[10749.721954] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TASKS01/console.log:[20942.489954] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TASKS01.2/console.log:[18816.134578] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.15-18.33.43/TASKS01.3/console.log:[29607.472148] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.15-18.33.43/TASKS01.4/console.log:[10071.675758] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.16-09.31.54/SRCU-P/console.log:[ 5492.548610] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-09.31.54/SRCU-P.4/console.log:[ 1123.619376] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-09.31.54/TREE05.3/console.log:[  594.483288] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-09.31.54/TREE05.3/console.log:[ 4815.344299] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-09.31.54/TASKS01.3/console.log:[ 5945.080822] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.16-15.42.49/SRCU-N.2/console.log:[  852.507139] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.16-15.42.49/TRACE02.2/console.log:[  814.208834] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-17.31.37/SRCU-P/console.log:[ 2272.123326] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.16-17.31.37/TRACE02.2/console.log:[ 2126.717510] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-13.15.03/SRCU-P.4/console.log:[ 3492.234874] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-13.15.03/TREE05/console.log:[ 3252.189840] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-13.15.03/TREE05.3/console.log:[  932.953913] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-13.15.03/TREE05.3/console.log:[ 1781.228851] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-13.15.03/TRACE01.4/console.log:[ 2662.592153] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-13.15.03/TASKS01.3/console.log:[ 1300.004087] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.10/console.log:[ 3771.012895] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.18/console.log:[ 5615.454848] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.22/console.log:[ 9004.856101] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.33/console.log:[13497.370097] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.37/console.log:[ 1781.980906] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.46/console.log:[ 1739.356211] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE01.53/console.log:[12253.049395] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02/console.log:[ 3640.150852] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.17-15.41.07/TRACE02.2/console.log:[ 1728.456720] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.13/console.log:[12936.198590] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-15.41.07/TRACE02.17/console.log:[12633.428728] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.32/console.log:[12907.746860] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.35/console.log:[ 4077.919897] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.38/console.log:[ 7944.552995] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.41/console.log:[12150.853057] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.44/console.log:[ 1354.859422] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-15.41.07/TRACE02.50/console.log:[ 1041.321160] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.51/console.log:[ 3692.662692] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-15.41.07/TRACE02.54/console.log:[ 4216.211246] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.4/console.log:[15669.225283] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.5/console.log:[ 1698.133932] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.11/console.log:[29980.403941] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-20.29.23/TRACE01.13/console.log:[16982.319330] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.17-20.29.23/TRACE01.15/console.log:[29072.433176] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.20/console.log:[ 9364.062700] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.21/console.log:[12871.697289] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.21/console.log:[31660.753537] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.30/console.log:[11143.483026] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.35/console.log:[23087.961194] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.17-20.29.23/TRACE01.46/console.log:[26613.054561] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-20.29.23/TRACE01.46/console.log:[28340.979249] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.51/console.log:[14219.361352] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.53/console.log:[ 4253.198257] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE01.56/console.log:[21086.053280] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02/console.log:[15560.058489] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.6/console.log:[12331.595984] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-20.29.23/TRACE02.7/console.log:[23016.593373] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.8/console.log:[27256.744662] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.13/console.log:[30143.014877] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.15/console.log:[28924.734124] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.16/console.log:[23466.740006] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.16/console.log:[35155.176988] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.18/console.log:[ 5612.333821] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-20.29.23/TRACE02.25/console.log:[26065.259534] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.27/console.log:[27220.841819] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.30/console.log:[ 5644.232830] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.36/console.log:[19369.167542] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.17-20.29.23/TRACE02.41/console.log:[14096.269002] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.43/console.log:[ 2762.029112] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.43/console.log:[34849.515127] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.45/console.log:[27059.581697] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.49/console.log:[34165.196900] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.53/console.log:[13522.702977] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.17-20.29.23/TRACE02.54/console.log:[ 8316.573646] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.19-14.38.40/TASKS01/console.log:[ 7030.162900] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.19-14.38.40/TASKS01.2/console.log:[ 1195.682031] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-01.04.01/SRCU-P/console.log:[ 6778.106738] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/SRCU-P.2/console.log:[ 3771.316596] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/SRCU-P.3/console.log:[10072.144697] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/SRCU-P.4/console.log:[10635.777669] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/TREE02.3/console.log:[ 6705.878818] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-01.04.01/TREE05/console.log:[19428.263919] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/TREE05.4/console.log:[11339.448742] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/TREE05.4/console.log:[17464.553733] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-01.04.01/TRACE02.4/console.log:[19743.129868] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-01.04.01/TASKS01.3/console.log:[17116.659128] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-08.21.18/SRCU-P.2/console.log:[  498.343538] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-08.21.18/TREE02/console.log:[ 2509.086647] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P/console.log:[ 6225.680212] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P/console.log:[11773.074199] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P/console.log:[24069.840197] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P/console.log:[35004.307231] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P/console.log:[46540.499368] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-14.53.28/SRCU-P.2/console.log:[32711.338436] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.3/console.log:[ 2062.201250] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.3/console.log:[ 6098.235279] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.3/console.log:[30045.047258] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.3/console.log:[30708.663256] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.3/console.log:[39772.921263] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.4/console.log:[ 8196.941796] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.4/console.log:[18845.904791] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-P.4/console.log:[50961.293779] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE02.2/console.log:[35689.773024] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05/console.log:[29820.039562] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05/console.log:[39440.342564] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.2/console.log:[ 3272.505270] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.2/console.log:[15259.764260] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.2/console.log:[52941.237278] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.3/console.log:[ 7182.511312] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.3/console.log:[10678.897284] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.3/console.log:[35659.863307] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.3/console.log:[38217.272295] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.4/console.log:[ 5228.112195] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TREE05.4/console.log:[38375.973184] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/SRCU-N.3/console.log:[13631.419670] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-14.53.28/SRCU-N.4/console.log:[26015.476742] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.20-14.53.28/TRACE01/console.log:[15809.025879] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TRACE02/console.log:[20573.311707] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TRACE02.2/console.log:[ 5321.187637] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TRACE02.3/console.log:[16958.893718] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.20-14.53.28/TASKS01/console.log:[48327.165565] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.21-17.59.19/SRCU-P/console.log:[ 3209.763592] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P/console.log:[32311.922582] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P/console.log:[35556.009576] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.2/console.log:[ 2241.019742] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.2/console.log:[11417.666736] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.2/console.log:[28459.837747] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.3/console.log:[26883.020403] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.4/console.log:[21223.612240] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.4/console.log:[22811.777237] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.4/console.log:[23421.888252] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-P.4/console.log:[34507.716253] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE02.2/console.log:[ 1357.450149] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE02.2/console.log:[33135.225164] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE02.4/console.log:[ 9240.908206] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE05/console.log:[30624.067565] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE05.2/console.log:[25223.626607] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE05.2/console.log:[41744.483672] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TREE05.3/console.log:[ 6878.742755] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.21-17.59.19/TREE05.3/console.log:[29914.662570] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-N.2/console.log:[13278.137167] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-N.2/console.log:[16782.454895] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/SRCU-N.4/console.log:[15852.413160] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TRACE02.2/console.log:[ 6081.088914] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.21-17.59.19/TASKS01/console.log:[31386.209999] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.21-17.59.19/TASKS01/console.log:[35873.117710] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.21-17.59.19/TASKS01.2/console.log:[33240.768507] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.21-17.59.19/TASKS01.4/console.log:[21442.800996] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-13.21.35/SRCU-P/console.log:[ 1731.611314] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-13.21.35/TREE01.4/console.log:[ 3576.429082] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.22-13.21.35/TREE05.2/console.log:[ 1562.789775] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-13.21.35/TRACE02.4/console.log:[ 3404.641339] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-P/console.log:[ 3453.205909] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-P.3/console.log:[11858.817108] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-P.3/console.log:[29254.406113] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-P.4/console.log:[18347.438314] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-P.4/console.log:[38610.286300] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE02/console.log:[ 7363.201741] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE02.4/console.log:[ 9625.403994] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE05.2/console.log:[ 2522.073254] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE05.2/console.log:[ 4041.237954] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE05.2/console.log:[25951.195926] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TREE05.3/console.log:[39959.260915] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/SRCU-N.4/console.log:[24809.187822] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TRACE01/console.log:[12724.493702] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TRACE01.4/console.log:[26885.035090] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TRACE01.4/console.log:[30876.458096] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TRACE02.3/console.log:[28469.966751] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TRACE02.4/console.log:[35632.953127] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/RUDE01/console.log:[26290.638996] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/RUDE01.2/console.log:[30176.416630] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TASKS01/console.log:[14734.581462] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TASKS01/console.log:[32351.285442] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TASKS01.3/console.log:[22164.409154] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.22-17.25.05/TASKS01.3/console.log:[30324.985309] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.22-17.25.05/TASKS01.4/console.log:[42612.776935] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-14.13.17/SRCU-P/console.log:[ 1995.586820] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-14.13.17/TREE05.4/console.log:[  303.134942] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-P/console.log:[22781.889122] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-P.3/console.log:[ 1326.723130] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-P.4/console.log:[ 5722.746126] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-P.4/console.log:[ 5976.629139] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-P.4/console.log:[15614.972134] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TREE01.4/console.log:[16839.864211] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.23-20.35.36/TREE02.2/console.log:[ 3517.427510] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.23-20.35.36/TREE02.2/console.log:[22500.277453] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TREE02.2/console.log:[31320.189483] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TREE05/console.log:[  880.851120] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TREE05.3/console.log:[ 7033.375215] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/SRCU-N.2/console.log:[28190.610877] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TRACE01.2/console.log:[24249.132827] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TRACE02.4/console.log:[30124.599492] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TASKS01.2/console.log:[28858.050416] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.23-20.35.36/TASKS01.3/console.log:[ 6147.653951] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.23-20.35.36/TASKS01.3/console.log:[20456.704983] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-15.25.18/TREE01.4/console.log:[ 1856.148403] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282!!!
./2020.09.24-20.47.54/SRCU-P/console.log:[18902.558629] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P/console.log:[30069.785623] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P.2/console.log:[12845.660322] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P.3/console.log:[14215.812401] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P.3/console.log:[26096.005398] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P.3/console.log:[35184.068413] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/SRCU-P.4/console.log:[18998.814537] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TREE02.4/console.log:[ 8261.489466] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TREE02.4/console.log:[27299.633463] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TREE05/console.log:[13712.090392] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TREE05.2/console.log:[35364.654069] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TRACE01.3/console.log:[ 3340.463914] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TRACE02/console.log:[ 3080.329847] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TRACE02.3/console.log:[ 9050.352207] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TRACE02.3/console.log:[15462.835209] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/RUDE01.3/console.log:[24970.187615] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.24-20.47.54/RUDE01.4/console.log:[21855.545281] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TASKS01.2/console.log:[26143.922336] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.24-20.47.54/TASKS01.4/console.log:[22880.103348] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.24-20.47.54/TASKS01.4/console.log:[34493.864005] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.25-09.52.31/SRCU-P.2/console.log:[ 1073.499676] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.25-09.52.31/SRCU-P.3/console.log:[  659.153225] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.25-09.52.31/SRCU-N.2/console.log:[ 2717.275455] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.25-09.52.31/SRCU-N.3/console.log:[  516.552349] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.25-09.52.31/TASKS01.3/console.log:[  420.315307] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.25-15.22.49/TREE02.3/console.log:[  164.394635] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/SRCU-P/console.log:[18173.190433] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/SRCU-P.3/console.log:[ 1827.169157] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/SRCU-P.4/console.log:[ 4972.496238] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/SRCU-P.4/console.log:[ 6845.392238] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/SRCU-P.4/console.log:[35945.420235] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE02/console.log:[ 9600.271108] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE02/console.log:[25654.253942] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.09.28-21.12.52/TREE02.2/console.log:[17395.408410] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE02.3/console.log:[10268.402623] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE02.4/console.log:[20660.325102] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE05.4/console.log:[12949.948074] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/TREE05.4/console.log:[25724.735104] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.09.28-21.12.52/TRACE01.2/console.log:[ 4395.571928] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.28-21.12.52/RUDE01/console.log:[ 1835.661495] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.28-21.12.52/TASKS01/console.log:[10626.078567] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.28-21.12.52/TASKS01.4/console.log:[ 7260.391931] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.09.28-21.12.52/TASKS01.4/console.log:[20149.158822] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.29-21.34.09/SRCU-P/console.log:[ 7464.786122] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.29-21.34.09/SRCU-P/console.log:[11220.626131] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.29-21.34.09/TREE05.3/console.log:[ 8705.177321] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.29-21.34.09/TRACE02/console.log:[ 6700.691709] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.09.30-16.43.34/SRCU-P.2/console.log:[ 4382.043349] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.01-09.39.41/SRCU-P/console.log:[ 3148.257899] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.01-09.39.41/TREE02.4/console.log:[ 1697.629388] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.02-13.56.55/TRACE02.3/console.log:[  413.254491] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P/console.log:[17472.937600] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.3/console.log:[13059.767689] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[ 3812.242588] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[21200.399574] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[22765.772571] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[27625.362591] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[32857.938604] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/SRCU-P.4/console.log:[35038.928570] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE02.2/console.log:[ 2799.279921] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE02.3/console.log:[ 8819.511108] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE02.3/console.log:[27600.854068] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE05.3/console.log:[ 1479.660173] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.02-20.50.54/TREE05.3/console.log:[ 8978.637980] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE05.3/console.log:[ 9484.515995] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.02-20.50.54/TREE05.4/console.log:[25878.685446] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TREE05.4/console.log:[30286.668422] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TRACE02/console.log:[31786.713252] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TRACE02.2/console.log:[16492.205930] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TRACE02.2/console.log:[35023.856844] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TRACE02.4/console.log:[26549.280972] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/RUDE01.2/console.log:[26981.107653] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.02-20.50.54/TASKS01.4/console.log:[18966.588191] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-17.37.32/SRCU-P.3/console.log:[ 2527.631499] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-17.37.32/TREE01/console.log:[ 1082.877063] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.10.04-17.37.32/TREE05.2/console.log:[ 3119.391497] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-P.2/console.log:[22017.138520] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-P.2/console.log:[22294.572511] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-P.2/console.log:[25776.179516] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-P.2/console.log:[31770.352534] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-P.3/console.log:[  918.934502] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/TREE01.3/console.log:[ 5726.795641] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.10.04-21.41.06/TREE02/console.log:[23955.621492] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/TREE05/console.log:[15026.563729] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/TREE05/console.log:[19179.218402] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.04-21.41.06/TREE05.2/console.log:[ 7449.396532] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/SRCU-N.3/console.log:[24153.903716] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.04-21.41.06/TRACE01.2/console.log:[ 6776.073817] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.06-09.35.38/TREE05.3/console.log:[ 2612.001882] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.07-14.32.49/TREE05.3/console.log:[ 3398.013348] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.07-16.31.12/SRCU-P/console.log:[ 1593.285632] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.10-09.18.10/SRCU-P.2/console.log:[ 1396.182470] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.10-09.18.10/TREE05.2/console.log:[ 2980.212087] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-13.03.44/SRCU-P/console.log:[ 2599.011917] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-13.03.44/SRCU-P.3/console.log:[ 2101.910061] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P/console.log:[12510.599703] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P/console.log:[12538.959709] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P/console.log:[17422.927702] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P/console.log:[34224.398693] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.2/console.log:[20222.139648] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.2/console.log:[24847.736657] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.2/console.log:[33326.586650] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.3/console.log:[22443.556969] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.3/console.log:[23272.351970] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.4/console.log:[ 9871.340490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.4/console.log:[20990.957500] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-P.4/console.log:[24470.508482] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE02.4/console.log:[20908.639638] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE02.4/console.log:[24066.838645] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05/console.log:[23248.894172] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05/console.log:[23617.892162] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05/console.log:[23694.893169] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05.2/console.log:[20011.345210] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05.2/console.log:[30408.265226] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05.3/console.log:[14727.073151] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.10.13-18.53.26/TREE05.3/console.log:[15528.757711] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05.4/console.log:[14077.557997] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TREE05.4/console.log:[14549.546658] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.13-18.53.26/SRCU-N/console.log:[13754.231303] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/SRCU-N/console.log:[15536.437389] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TRACE02.3/console.log:[27563.963810] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.13-18.53.26/TASKS01.4/console.log:[14801.066164] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-17.25.02/SRCU-P.3/console.log:[ 2000.543155] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-17.25.02/SRCU-P.3/console.log:[ 2876.452143] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-17.25.02/TREE02/console.log:[ 2685.826877] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-17.25.02/TREE05.3/console.log:[ 1046.064613] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.2/console.log:[11060.798791] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.2/console.log:[19584.117759] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.2/console.log:[22580.126762] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.2/console.log:[28537.392771] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.3/console.log:[ 8602.850547] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.3/console.log:[13902.935557] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.3/console.log:[26331.482563] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.4/console.log:[ 3337.735346] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-P.4/console.log:[22481.409368] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE02/console.log:[27700.203620] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE02.4/console.log:[14274.039736] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05/console.log:[14019.067863] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05/console.log:[29503.940890] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05.2/console.log:[17731.556328] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05.2/console.log:[20595.236314] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05.3/console.log:[ 8665.518500] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05.3/console.log:[26861.474480] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/TREE05.3/console.log:[27299.810485] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/SRCU-N/console.log:[ 2233.224920] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.10.14-20.56.29/SRCU-N.3/console.log:[26982.830870] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.14-20.56.29/RUDE01.4/console.log:[17482.165904] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.15-09.23.24/SRCU-P.2/console.log:[ 1315.022675] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.15-09.23.24/SRCU-P.4/console.log:[ 2998.782281] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.15-09.23.24/RUDE01.4/console.log:[ 2413.636405] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.17-08.43.26/SRCU-N.2/console.log:[ 2929.087245] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.17-08.43.26/TRACE02/console.log:[  851.308891] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.26-10.39.37/SRCU-P.2/console.log:[ 1659.519348] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.26-10.39.37/TRACE02.2/console.log:[   90.069774] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.26-14.13.05/SRCU-P.3/console.log:[ 1254.535334] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.10.26-16.33.33/TREE02.3/console.log:[  484.616816] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P/console.log:[21255.775584] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P.2/console.log:[13673.206133] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P.3/console.log:[14086.154354] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P.3/console.log:[20013.766366] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P.3/console.log:[27339.277386] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-P.4/console.log:[15831.064134] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE02.2/console.log:[ 5653.620079] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.03-19.44.14/TREE02.2/console.log:[ 8157.806712] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE02.2/console.log:[23243.200719] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE02.2/console.log:[23645.906740] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE02.2/console.log:[31936.278718] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE02.3/console.log:[ 3441.605938] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TREE05/console.log:[34062.226410] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/SRCU-N.3/console.log:[23045.098409] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.03-19.44.14/TRACE01/console.log:[ 4668.791140] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.03-19.44.14/TRACE01.2/console.log:[33971.812701] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TRACE01.4/console.log:[11476.247524] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TRACE02.2/console.log:[24607.055811] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.03-19.44.14/TASKS01/console.log:[ 6193.076182] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/SRCU-P.2/console.log:[29166.197201] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/SRCU-P.3/console.log:[ 2186.128818] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/SRCU-P.3/console.log:[18322.706836] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/SRCU-P.4/console.log:[ 1148.293034] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TREE01/console.log:[ 1858.887913] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.04-19.24.30/TREE01.4/console.log:[26458.669359] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.04-19.24.30/TREE02.2/console.log:[28585.599165] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TREE02.3/console.log:[ 5805.974658] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TREE02.3/console.log:[10089.487686] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TREE05/console.log:[29198.897851] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TREE05.4/console.log:[33487.149074] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/SRCU-N.2/console.log:[ 3470.036844] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TRACE01.3/console.log:[ 2487.712363] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/TRACE02/console.log:[ 8639.411054] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.04-19.24.30/RUDE01.3/console.log:[  348.161775] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.05-12.56.30/SRCU-P.3/console.log:[ 1728.024271] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-12.56.30/TREE02.4/console.log:[  968.243923] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-17.34.07/TASKS01.3/console.log:[  656.372581] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.05-20.20.24/SRCU-P.4/console.log:[14032.673092] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/SRCU-P.4/console.log:[25486.372071] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/TREE02.2/console.log:[27026.457417] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/SRCU-N/console.log:[27942.221947] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/SRCU-N.3/console.log:[ 8462.471662] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/TRACE02.2/console.log:[ 3649.696029] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.05-20.20.24/RUDE01.2/console.log:[ 8345.702595] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.05-20.20.24/TASKS01.2/console.log:[27312.629182] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE07.3/console.log:[13391.954112] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.06-20.02.45/TREE07.4/console.log:[ 2192.866170] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P/console.log:[ 1031.025363] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P/console.log:[42141.872362] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P.3/console.log:[24591.133410] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P.4/console.log:[18325.336505] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P.4/console.log:[23912.920509] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/SRCU-P.4/console.log:[38532.120479] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE01/console.log:[26627.365185] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.06-20.02.45/TREE01.4/console.log:[31773.378778] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.06-20.02.45/TREE02.2/console.log:[17100.359583] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE02.3/console.log:[38248.380989] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE02.4/console.log:[23995.566664] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE05/console.log:[37940.817099] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE05.2/console.log:[28121.077132] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TREE05.4/console.log:[19982.788967] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TRACE01.2/console.log:[35431.070725] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.06-20.02.45/TASKS01/console.log:[11697.010679] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TASKS01/console.log:[21534.254732] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.06-20.02.45/TASKS01.2/console.log:[29253.943415] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.07-11.25.14/SRCU-P.2/console.log:[   93.489193] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.07-11.25.14/TRACE01.3/console.log:[ 1932.491178] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.07-12.46.39/LOCK05.4/console.log:[ 2406.353975] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.07-12.46.39/LOCK05.14/console.log:[ 1758.722229] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.08-16.51.25/SRCU-P.2/console.log:[  558.491296] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.08-16.51.25/SRCU-P.2/console.log:[ 2826.656301] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.08-16.51.25/SRCU-P.3/console.log:[ 2976.774954] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.08-16.51.25/TREE02.4/console.log:[ 2451.605594] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.08-16.51.25/RUDE01.3/console.log:[  846.866604] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.09-13.13.48/SRCU-P.3/console.log:[  227.973635] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.09-20.07.26/SRCU-P/console.log:[  463.220552] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.09-20.07.26/SRCU-P.4/console.log:[ 1727.476637] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.09-20.07.26/TREE01.3/console.log:[ 3328.849821] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.09-20.07.26/TREE02/console.log:[ 3590.895680] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.09-20.07.26/SRCU-N.2/console.log:[ 2012.369065] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.09-20.07.26/SRCU-N.3/console.log:[ 2342.330820] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.09-23.46.39/TREE01.3/console.log:[  132.525237] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.10-16.38.35/LOCK02.11/console.log:[   64.839345] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.10-16.38.35/LOCK07.5/console.log:[  405.218060] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/SRCU-P.2/console.log:[15023.564334] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/SRCU-P.2/console.log:[15316.496348] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/SRCU-P.3/console.log:[11998.853109] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/TREE02/console.log:[ 9005.683605] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/TREE02.3/console.log:[10732.117113] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/TREE02.4/console.log:[ 4263.804051] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/TREE05.2/console.log:[13442.539379] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.10-19.52.55/SRCU-N/console.log:[ 7950.196279] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.10-19.52.55/RUDE01/console.log:[20284.417344] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.11-02.14.51/LOCK05.6/console.log:[  100.361028] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-02.14.51/LOCK05.12/console.log:[  159.231296] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-02.14.51/LOCK07.7/console.log:[ 3027.677702] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/SRCU-P/console.log:[ 7711.089866] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/SRCU-P/console.log:[ 9601.965831] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/SRCU-P.2/console.log:[ 7391.325244] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/SRCU-P.2/console.log:[ 7484.248226] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/TREE01.3/console.log:[13967.964178] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.11-17.11.45/TREE05.4/console.log:[14197.976850] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/RUDE01.3/console.log:[20325.997348] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.11-17.11.45/TASKS01.4/console.log:[17090.141603] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.11-23.35.22/LOCK05.9/console.log:[  650.268358] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/SRCU-P/console.log:[ 6618.162935] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/SRCU-P/console.log:[18301.621936] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/SRCU-P.2/console.log:[ 8979.292554] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/SRCU-P.2/console.log:[13607.394552] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/SRCU-P.2/console.log:[15449.183547] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/TREE01.2/console.log:[17438.755259] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.12-20.41.54-torture/results-rcutorture/TREE02.4/console.log:[ 3126.074042] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/TRACE01.4/console.log:[16891.618596] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/TRACE01.4/console.log:[21106.339727] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-rcutorture/RUDE01/console.log:[ 7013.086739] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.12-20.41.54-torture/results-locktorture/LOCK05.2/console.log:[  558.810955] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-rcutorture/SRCU-P.3/console.log:[18327.074409] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-rcutorture/TREE05.2/console.log:[10354.851044] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-rcutorture/TREE05.4/console.log:[17455.453052] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-rcutorture/TRACE02.2/console.log:[ 1167.052792] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-rcutorture/TASKS01/console.log:[13330.504141] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.13-20.40.01-torture/results-locktorture/LOCK05.5/console.log:[ 1399.306718] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-09.32.27-torture/results-rcutorture/SRCU-P.4/console.log:[ 1807.655691] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-09.32.27-torture/results-rcutorture/TREE02.2/console.log:[ 6251.997757] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-09.32.27-torture/results-rcutorture/TRACE01.4/console.log:[ 6163.543359] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-P/console.log:[ 7465.502590] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-P.2/console.log:[10409.964431] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-P.2/console.log:[19142.511402] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-P.3/console.log:[17016.367313] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-N.4/console.log:[ 7716.414616] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/SRCU-N.4/console.log:[11602.558520] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/TRACE01.3/console.log:[12407.822175] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/RUDE01.3/console.log:[11544.164084] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.14-20.44.32-torture/results-rcutorture/TASKS01.2/console.log:[11429.056630] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.14-20.44.32-torture/results-rcutorture/TASKS01.4/console.log:[ 9737.544980] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-11.46.25-torture/results-rcutorture/SRCU-P/console.log:[  286.231204] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture/SRCU-P.3/console.log:[ 9054.476682] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture/TREE02/console.log:[ 1056.390591] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture/TREE05.2/console.log:[ 8111.719033] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture/TREE05.4/console.log:[10395.713681] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture/SRCU-N.3/console.log:[ 7254.251013] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.15-20.46.17-torture/results-rcutorture-kasan/SRCU-P.3/console.log:[ 9069.118667] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
./2020.11.15-20.46.17-torture/results-rcutorture-kasan/TREE05.2/console.log:[ 5516.025804] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture-kasan/TREE05.3/console.log:[ 5069.125547] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.15-20.46.17-torture/results-rcutorture-kasan/TREE05.3/console.log:[ 6833.556525] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-12.16.46/TREE05.4/console.log:[ 1032.907370] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE07.4/console.log:[ 9660.227497] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.16-19.48.43/SRCU-P/console.log:[20805.568858] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-P.3/console.log:[14463.574726] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-P.3/console.log:[27232.665724] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-P.3/console.log:[29219.798742] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-P.4/console.log:[ 8985.958598] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE02.2/console.log:[10389.348347] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE02.2/console.log:[19545.256405] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
./2020.11.16-19.48.43/TREE05.2/console.log:[ 6303.839108] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE05.3/console.log:[ 7052.892011] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE05.4/console.log:[ 1809.466436] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/TREE05.4/console.log:[18017.132429] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-N/console.log:[13697.557628] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.16-19.48.43/SRCU-N.3/console.log:[23032.536376] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.7/console.log:[  610.622849] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.27/console.log:[ 1032.771062] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.38/console.log:[  454.100597] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.65/console.log:[  844.943879] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.71/console.log:[  904.997870] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-P.84/console.log:[ 1123.179591] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-06.51.41/SRCU-N.6/console.log:[  610.112259] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
./2020.11.17-12.16.06-torture/results-rcutorture/TREE02.3/console.log:[  528.849818] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
./2020.11.17-17.06.58/SRCU-P/console.log:[ 2132.596064] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!

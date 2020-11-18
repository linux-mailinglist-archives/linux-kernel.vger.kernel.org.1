Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF502B8364
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgKRRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgKRRwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:52:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B0B24903;
        Wed, 18 Nov 2020 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605721938;
        bh=OudCrL0DImNCOLljCY2MpL4a9MUp5Wdo8907Lxh4vM8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Dpj9EA1sUqXRr2vESZF8CnhDgE1ELMoffhAUv9X8+F1HIUZvgsfrzNuN7jeFsmupp
         ELfywpq0x1iCigG3An7ojsmdSwMBQjKtgGfrpzBdckmkYl/jrm4sQck9ymrlEbSWIa
         j5y4VdH9heOFZhHosLQBK9bzBVrax0TALQ7lRpBY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 475D23520FE0; Wed, 18 Nov 2020 09:52:18 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:52:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201118175218.GA16039@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic,

Here is the last few months' pile of warnings from rcutorture runs.

							Thanx, Paul

[  255.098527] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282!!!
[  414.534548] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 3798.654736] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 1718.589367] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 6632.777655] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 2873.688490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 3081.738937] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 2673.597523] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 1467.372887] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[   34.371094] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 1147.260097] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 5066.699589] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[  816.338843] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[   34.338836] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 1234.111394] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[ 1282.109415] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  239.215890] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  367.918969] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[ 1461.037894] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[ 1503.810903] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[ 1503.811939] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  699.514824] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[  751.681629] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  287.770126] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[  287.771096] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[  648.009370] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[  924.733405] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[  924.734011] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[ 1743.197353] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
[ 1528.161635] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[ 1528.162313] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  265.201513] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[  473.137587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
[  187.375426] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
[ 1361.544451] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
[   79.519727] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!

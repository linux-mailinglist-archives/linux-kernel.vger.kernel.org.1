Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406C81D22F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbgEMXXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbgEMXXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:23:16 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 051E6205ED;
        Wed, 13 May 2020 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589412196;
        bh=d2JPD8lU9EQ+vVPEiYvaQkjazwn7BLO7dyk3AcEjM6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mivTHPVQdKC7TPrC9Iw2YTB+5ifb4rAlDvVizZrsC5WTR6yPe7hWbDUbxSNxlSJpK
         jQRdft/SufVEsgANnb4MeYQp1BdgR35aYxgqc9gTgXveP03w4fQkJhfVdQw5M5QtKq
         tMtNHyOg8m34SeBKceoNHUVweekyCsxhPDbmCEiU=
Date:   Thu, 14 May 2020 01:23:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 10/10] rcu: Nocb (de)activate through sysfs
Message-ID: <20200513232312.GD18303@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-11-frederic@kernel.org>
 <20200513184229.GX2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513184229.GX2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:42:29AM -0700, Paul E. McKenney wrote:
> On Wed, May 13, 2020 at 06:47:14PM +0200, Frederic Weisbecker wrote:
> > Not for merge.
> > 
> > Make nocb toggable for a given CPU using:
> > 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> > 
> > This is only intended for those who want to test this patchset. The real
> > interfaces will be cpuset/isolation and rcutorture.
> 
> Makes sense!
> 
> Speaking of rcutorture, what level of testing has this series undergone?

None yet, that first set was to shape up the design. But next
iteration should see rcutorture coverage.

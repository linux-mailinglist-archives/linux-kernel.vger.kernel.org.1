Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EB288635
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgJIJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJIJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:43:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+8KxmFD1hQOjYyhkKZ1N2Ke0gS4K0mbm35E+ed5u0Ag=; b=UuXScQIS6LT+LJ67qrGUHC6zMO
        TzA+nCxI6vZooKeeI4TzBkyrsHqjd+ruIzhnGAXAnrpADgji033hDbjeDe2tTWpthFSZr1G/3F9C6
        gqCznZ9KP72gpBcMJJjOBpYorlf/PG2YasHaVkiHDfpmVuerXAMkkOvMZ4VSYe5p0aep1bE6qdWvv
        cQWC0B4R47Itb40TAcsVPdKqdQ2MUvsXGx/aUVY2ZwGjtlv+/Buas+3qZfZfEJ464UbS+eW9ddtFt
        NHxzXJWM0hgbCFjt/9SqZFcPNRKUORwchUGd5m7aFOoKAKVe8tQJNm0QHSfrtFkuUtSleV9sM8cQ1
        wdU/Fy9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQovJ-0004r8-3o; Fri, 09 Oct 2020 09:42:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93E0F30008D;
        Fri,  9 Oct 2020 11:42:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 339C029E78790; Fri,  9 Oct 2020 11:42:45 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:42:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009094245.GG2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009091218.GF4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> Is there any additional feedback? Should I split up the patch and repost
> for inclusion?

Maybe remove PREEMPT_NONE after that? Since that's then equivalent to
building with VOLUNTARY and booting with preempt=none.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5829C4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823673AbgJ0R7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823204AbgJ0R6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:58:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B867721556;
        Tue, 27 Oct 2020 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603821490;
        bh=+WdREhYOpPlOy7/jYqsbnSwfvnjFHZx6hOjap1wi2fk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=c/C/5297m3QN3xalQSz0+R0cgn41tFT6MisMrH8UDvXSKLoW6FnhzIktmWMA+C4Pv
         IjGo63beACo+3t+HM1u3MQfX9RQcPdp4yAPwJDTnQUOZXZ915WFrXCUM60Q/nkcYmB
         SOP1PGi0iRjD7SJlFqiMqKUcLO761B3yLUa6rUbs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E90C35229CE; Tue, 27 Oct 2020 10:58:10 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:58:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     elver@google.com, dvyukov@google.com
Cc:     linux-kernel@vger.kernel.org, andriin@fb.com
Subject: Recording allocation location for blocks of memory?
Message-ID: <20201027175810.GA26121@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have vague memories of some facility some time some where that recorded
who allocated a given block of memory, but am not seeing anything that
does this at present.  The problem is rare enough and the situation
sufficiently performance-sensitive that things like ftrace need not apply,
and the BPF guys suggest that BPF might not be the best tool for this job.

The problem I am trying to solve is that a generic function that detects
reference count underflow that was passed to call_rcu(), and there are
a lot of places where the underlying problem might lie, and pretty much
no information.  One thing that could help is something that identifies
which use case the underflow corresponds to.

So, is there something out there (including old patches) that, given a
pointer to allocated memory, gives some information about who allocated
it?  Or should I risk further inflaming the MM guys by creating one?  ;-)

							Thanx, Paul

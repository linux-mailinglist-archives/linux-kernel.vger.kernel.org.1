Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9497D226259
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGTOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:41:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:54030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:41:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA16EB82E;
        Mon, 20 Jul 2020 14:41:23 +0000 (UTC)
Date:   Mon, 20 Jul 2020 07:29:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH RFC] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200720142923.mrudcweyttlmnhqp@linux-p48b>
References: <20200719034210.2382053-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200719034210.2382053-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020, Joel Fernandes (Google) wrote:

>+/* Move from's segment length to to's segment. */
>+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
>+{
>+	long len = rcu_segcblist_get_seglen(rsclp, from);
>+
>+	if (!len || from == to)
>+		return;

Nit: You probably wanna do the parameter sanity checks before the
atomic_read.

Thanks,
Davidlohr

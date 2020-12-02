Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C1A2CB251
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgLBB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:27:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgLBB16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:27:58 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0C22220B;
        Wed,  2 Dec 2020 01:27:16 +0000 (UTC)
Date:   Tue, 1 Dec 2020 20:27:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
Message-ID: <20201201202714.04433bc6@oasis.local.home>
In-Reply-To: <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
        <20201130161850.34bcfc8a@gandalf.local.home>
        <20201202083253.9dbc76704149261e131345bf@kernel.org>
        <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 09:23:35 +0800
"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com> wrote:

> Hi steve, Masami,

Hi ShaoBo,

> 
> Thanks for your works, i will check code again and modify properly 
> according to steve's suggestion.

I think you meant "to Masami's suggestion" ;-)

-- Steve

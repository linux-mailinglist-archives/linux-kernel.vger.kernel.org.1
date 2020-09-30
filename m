Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC327EF52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgI3Qfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Qfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:35:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890BC206DC;
        Wed, 30 Sep 2020 16:35:37 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:35:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 23/52] docs: trace-uses.rst: remove bogus c-domain
 tags
Message-ID: <20200930123535.43d7a957@gandalf.local.home>
In-Reply-To: <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
        <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 15:24:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are some c-domain tags that are wrong. While this won't
> cause problems with Sphinx < 3.0, this cause troubles with
> newer versions, as the C parser won't recognize the contents
> of the tag, and will drop it from the output.
> 
> Let's just place them at literal blocks.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CC1D5573
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEOQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 12:02:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOQCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD6A9AC6E;
        Fri, 15 May 2020 16:02:49 +0000 (UTC)
Date:   Fri, 15 May 2020 18:02:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Message-ID: <20200515160245.GW17734@linux-b0ei>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-04-15 20:00:43, Andy Shevchenko wrote:
> It is a logical continuation of previously applied %ptR for struct rtc_time.
> We have few users of time64_t that would like to print it.

It seems that everything was explained and the patches look good to
me. If we allowed %ptR then it makes sense to allow %ptT as well.

For all three patches:

Rewieved-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

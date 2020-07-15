Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8E220577
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGOGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 02:52:33 -0400
Received: from [195.135.220.15] ([195.135.220.15]:57796 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgGOGwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:52:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA55BACF2;
        Wed, 15 Jul 2020 06:52:34 +0000 (UTC)
Date:   Wed, 15 Jul 2020 08:52:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
Message-ID: <20200715065231.GS4751@alley>
References: <20200710094432.19655-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094432.19655-1-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-07-10 11:44:32, Petr Mladek wrote:
> John Ogness has started major rework of the printk code. Add him
> as reviewer so that he is aware of all other coming changes and
> could influence their integration.

The patch is commited in printk/linux.git, branch printk-rework.

Best Regards,
Petr

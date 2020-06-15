Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074761F9BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgFOPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 11:18:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E1F6B019;
        Mon, 15 Jun 2020 15:18:04 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:17:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 14/24] dyndbg: add filter parameter to
 ddebug_parse_flags
Message-ID: <20200615151759.GJ31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-15-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-15-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:28, Jim Cromie wrote:
> Add a new local *filter variable to ddebug_exec_query(), pass it into
> ddebug_parse_flags(), which fills it, communicating optional filter
> flags back to its caller.  Then caller passes same to ddebug_change()
> to effect the changes.
> 
> Also, ddebug_change doesn't alter any of its arguments, including its 2
> new ones; mods, filter.  Say so by adding const modifier to them.

What is the purpose of the filter variable, please?

It is newer set. It is printed in ddebug_parse_flags().
It is passed to ddebug_exec_query() but never used there.

Best Regards,
Petr

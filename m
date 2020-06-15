Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508581F990D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgFONhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 09:37:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbgFONhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:37:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7D86AF31;
        Mon, 15 Jun 2020 13:37:44 +0000 (UTC)
Date:   Mon, 15 Jun 2020 15:37:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 10/24] dyndbg: refactor parse_linerange out of
 ddebug_parse_query
Message-ID: <20200615133740.GG31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-11-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-11-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:24, Jim Cromie wrote:
> make the code-block reusable to later handle "file foo.c:101-200" etc.

> This should be a 90%+ code-move, with minimal adaptations; reindent,
> and scafolding.

This sentence sounds like the author did some hidden
microoptimizations and potentially broke the code.
It made me nervous.

But in fact, I do not see any real change except that the variable
"first" does not longer need to be defined. So, it is just a code move.

In this case, I usually write:

This patch does not change the existing behavior.

Best Regards,
Petr

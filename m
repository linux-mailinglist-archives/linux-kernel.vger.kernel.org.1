Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BB1FAFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgFPL53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 07:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgFPL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:57:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24FCEAD41;
        Tue, 16 Jun 2020 11:57:32 +0000 (UTC)
Date:   Tue, 16 Jun 2020 13:57:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and
 file=bar
Message-ID: <20200616115727.GN31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-20-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-20-jim.cromie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-06-13 09:57:33, Jim Cromie wrote:
> Current code expects "keyword" "arg" as 2 space separated words.
> Change to also accept "keyword:arg" and "keyword=arg" forms as well,
> and drop !(nwords%2) requirement.
> 
> Then in rest of function, use new keyword,arg variables instead of
> word[i],word[i+1]

I like the idea. But please allow only one form. IMHO, parameter=value
is a common way to pass values to commandline parameters.

Note that "keyword" and "arg" is strange naming, especially "arg".

Best Regards,
Petr

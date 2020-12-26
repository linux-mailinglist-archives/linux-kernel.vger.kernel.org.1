Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3890E2E2F57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLZXIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 18:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgLZXIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:08:47 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27FC0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 15:08:06 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktIfL-004N0p-3H; Sat, 26 Dec 2020 23:08:03 +0000
Date:   Sat, 26 Dec 2020 23:08:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Dubois <tblodt@icloud.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: linux.git is broken on a case-insensitive filesystem
Message-ID: <20201226230803.GC3579531@ZenIV.linux.org.uk>
References: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 02:30:13PM -0800, Theodore Dubois wrote:
> I'm currently hacking on Linux trying to run a sort of UML-style thing on macOS (please don't question my sanity :), and I've run into various issues stemming from macOS having a case-insensitive filesystem. 
> 
> The one you run into immediately is: there are a number of files (mostly in netfilter) that have different uppercase and lowercase versions. net/netfilter/xt_DSCP.c and net/netfilter/xt_dscp.c are quite different. Last I checked, git would pseudo-randomly pick one of these to check out, and then show the other one as having unstaged changes making it look like the first one. This causes problems when switching branches. I've worked around this with a sparse checkout that excludes these files, but it's not great.
> 
> The gitignore also contains the pattern *.s, which excludes *.S as well when git is ignoring case.
> 
> Is there any interest in fixing these?

<wry> Just how could we fix a long-standing design flaw in macOS? </wry>

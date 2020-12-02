Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3E2CCAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLBXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:44:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:37022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgLBXoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:44:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9B8EAB63;
        Wed,  2 Dec 2020 23:43:52 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: crediting bug reports and fixes folded into original patch
Message-ID: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
Date:   Thu, 3 Dec 2020 00:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there was a bit of debate on Twitter about this, so I thought I would bring it
here. Imagine a scenario where patch sits as a commit in -next and there's a bug
report or fix, possibly by a bot or with some static analysis. The maintainer
decides to fold it into the original patch, which makes sense for e.g.
bisectability. But there seem to be no clear rules about attribution in this
case, which looks like there should be, probably in
Documentation/maintainer/modifying-patches.rst

The original bug fix might include a From: $author, a Reported-by: (e.g.
syzbot), Fixes: $next-commit, some tag such as Addresses-Coverity: to credit the
static analysis tool, and an SoB. After folding, all that's left might be a line
as "include fix from $author" in the SoB area. This is a loss of
metadata/attribution just due to folding, and might make contributors unhappy.
Had they sent the fix after the original commit was mainline and immutable, all
the info above would "survive" in the form of new commit.

So I think we could decide what the proper format would be, and document it
properly. I personally wouldn't mind just copy/pasting the whole commit message
of the fix (with just a short issue description, no need to include stacktraces
etc if the fix is folded), we could just standardize where, and how to delimit
it from the main commit message. If it's a report (person or bot) of a bug that
the main author then fixed, preserve the Reported-by in the same way (making
clear it's not a Reported-By for the "main thing" addressed by the commit).

In the debate one less verbose alternatve proposed was a SoB with comment
describing it's for a fix and not whole patch, as some see SoB as the main mark
of contribution, that can be easily found and counted etc. I'm not so sure about
it myself, as AFAIK SoB is mainly a DCO thing, and for a maintainer it means
something else ("passed through my tree") than for a patch author. And this
approach would still lose the other tags.

Thoughts?
Vlastimil

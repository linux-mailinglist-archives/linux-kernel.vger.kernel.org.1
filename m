Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3C2B2891
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKMWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgKMWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:33:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D89C0613D1;
        Fri, 13 Nov 2020 14:33:15 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0B0BF734;
        Fri, 13 Nov 2020 22:33:15 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:33:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and
 yet more detailed & helpful
Message-ID: <20201113153313.68ff210c@lwn.net>
In-Reply-To: <cover.1605203187.git.linux@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 18:58:37 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> This series rewrites the "how to report bugs to the Linux kernel
> maintainers" document to make it more straight forward and its essence
> easier to grasp. At the same time make the text provide a lot more details
> about the process in form of a reference section, so users that want or
> need to know them have them at hand.
> 
> The goal of this rewrite: improve the quality of the bug reports and
> reduce the number of reports that get ignored. This was motivated by many
> reports of poor quality the submitter noticed while looking after Linux
> kernel regression tracking many moons ago.

So I've not had a chance to try to read through the whole thing again,
will try to do so in the near future.

As for how to proceed...getting others to review this is going to be a bit
of a challenge.  Perhaps the right approach is to just merge the new
document under a new name - reporting-bugs-the-novel.txt or something -
then try to get a few people to look at specific parts of it?  Once all
seems well we can rename it over the old document and call it done.

Make sense?

Thanks,

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5497D2B890D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 01:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKSAaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 19:30:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:47478 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgKSA37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 19:29:59 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 412B22B2;
        Thu, 19 Nov 2020 00:29:59 +0000 (UTC)
Date:   Wed, 18 Nov 2020 17:29:58 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and
 yet more detailed & helpful
Message-ID: <20201118172958.5b014a44@lwn.net>
In-Reply-To: <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
        <20201113153313.68ff210c@lwn.net>
        <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Nov 2020 11:13:52 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> > So I've not had a chance to try to read through the whole thing again,
> > will try to do so in the near future.  
> 
> Great, thx, looking forward to it.

OK, I have made a *quick* pass through the whole thing and sent a small
number of comments separately. There are things that could be tweaked
(there always will be) but I'm not sure we should worry about those yet.
I would suggest doing this:

 - Collapse the whole thing down to a patch adding reporting-bugs-v2.rst
   (or some suitable name).  I do wonder if it should also move to the
   process manual as part of this; not only admins will report bugs.

 - Add a comment at the top saying it's a proposed replacement and
   soliciting comments.  You could also put some of your other questions
   into the text for now and see if anybody reacts.  

 - In a separate patch you could add a comment to the existing document
   pointing to the new one as the true source of wisdom.

 - Dual licensed CC-SA-4.0 is fine with me.  CC-BY is OK if you really
   want to do it that way.  Either way, though, you'll need to add the
   license itself under LICENSES/preferred before it can go into the SPDX
   tag.

With that, I'd say let's just merge it and bash on it from there.

Thanks,

jon

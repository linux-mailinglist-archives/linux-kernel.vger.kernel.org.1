Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E72BB8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgKTV7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:59:32 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727BC0613CF;
        Fri, 20 Nov 2020 13:59:32 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DFA855A0;
        Fri, 20 Nov 2020 21:59:31 +0000 (UTC)
Date:   Fri, 20 Nov 2020 14:59:30 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/26] Make reporting-bugs easier to grasp and
 yet more detailed & helpful
Message-ID: <20201120145930.5e59cc1b@lwn.net>
In-Reply-To: <ada5d01f-47a9-5734-2fc8-3de2d7aa86e4@leemhuis.info>
References: <cover.1605203187.git.linux@leemhuis.info>
        <20201113153313.68ff210c@lwn.net>
        <458eb542-ff4d-e734-67fd-01e8378d4864@leemhuis.info>
        <20201118172958.5b014a44@lwn.net>
        <ada5d01f-47a9-5734-2fc8-3de2d7aa86e4@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 13:29:51 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> >   - Dual licensed CC-SA-4.0 is fine with me.  CC-BY is OK if you really
> >     want to do it that way.    
> 
> I'm unsure and would appreciate options from others here.
> 
> Here are some of my thoughts about this:
> 
> What do we loose by dual-licensing it under a liberal license like 
> CC-BY? It afaics makes it a lot more attractive for websites or books 
> authors to use this text as a base, as they don't need to fear that 
> "share alike" or the GPL might have consequences on the surroundings. 
> I'd say that's a good thing for the kernel, as it increases the chances 
> the texts built upon ours remain close to what we expect on this topic.
> 
> That's why I currently think using CC-BY is a good idea.

It's a matter of preferences; I like -SA better as a closer match to the
kernel's GPL licensing.  But it's your text, so it's your choice.

jon

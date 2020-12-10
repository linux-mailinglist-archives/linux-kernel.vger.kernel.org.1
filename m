Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662B2D4F68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgLJA0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgLJA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:26:10 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B4C0613CF;
        Wed,  9 Dec 2020 16:25:29 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 10C6C301;
        Thu, 10 Dec 2020 00:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 10C6C301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607559929; bh=ywdfegw7XoJZkcDSTZUNSp0egIOABJ7DZRdiRiF1mog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WpoAYVFDIe90jTqfTKJ+QZIsIIo7C7AXNbDFpeDM0D3lm14dr6GMhRxSw8cYUHMCe
         UPTvDXuzXYWzoG7veDSaU84rE8/pr7cUJwTMhFYTXKqnuDV77qBNeCoa6u72VYH8KA
         drqbeyRvJIt5CFNujoB+h95CzwXaUNUXGTGxqYWX4EHKv3HT06dOVCCj8dc6Suy1HN
         hTE/xxNtigJ1nPkc/qQ94q8HnUKHnDETYkb5PG4Dy8DbMaESR8vBBt7K8U+HFF15Hn
         Wo4GfnMMI4uX7VUSnSHsdni6Wv+FNLdLRYAZ34g0bkB6w/G0yKAxjTvpK/mCuSRXrF
         DxSBoxDmWdHWA==
Date:   Wed, 9 Dec 2020 17:25:27 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: reporting-issues: move 'outdated, need help' note
 to proper place
Message-ID: <20201209172527.3fb293f5@lwn.net>
In-Reply-To: <d3894ba4a302beed661304cbcdc062c6dcfe3e58.1607489877.git.linux@leemhuis.info>
References: <d3894ba4a302beed661304cbcdc062c6dcfe3e58.1607489877.git.linux@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Dec 2020 06:19:14 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Move the 'this section is a placeholder for now and needs help by
> someone with domain knowledge' note one section upwards to the place
> where it belongs: the 'Decode failure messages' section.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> Brown paper bag fixup :-/

Hey, if it's the only one we're in fine shape :)

Applied, thanks.

jon

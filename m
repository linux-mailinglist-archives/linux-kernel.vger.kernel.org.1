Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102B2FB36F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbhASHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbhASHod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:44:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E49CA2312D;
        Tue, 19 Jan 2021 07:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611042232;
        bh=LwmCI6DkrJei1b8r1Zp6vrx7jK2blz6c0T5Ie2QRjYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8mdbWIH6Mm9kZKrfjaf5AYt1NelNyK/1tKwW5rJxD0gHKOqtlseU80MBHK+P+VvW
         42HS0bz6vYgt5fgAWtuORqmeFSnEYrTk35s6SOX7dDyTeSLMuiMSKWTgskB4zIp5cN
         XyqtA5fIqPXAQb+139dn+hxqU8ko6wufC3qlxR0yc5nEd1tdeWsFkSCjDBBPZ+tg/W
         dFwCPLosNR4YbenWnjbXaw2fidiuEdIDTFz8GsEMzdGgjv69wXZgsD46baPCWwQtuG
         8tX6Q6QmiAKw2tVV8lW6fGd2wUoHOfM9Rn1MvDmqobz8eRoZvUZPJFYhkjDPT99Cnx
         A4ccrXEod5OnA==
Date:   Tue, 19 Jan 2021 08:43:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/16] scripts: kernel-doc: validate kernel-doc
 markup with the actual names
Message-ID: <20210119084328.749e415f@coco.lan>
In-Reply-To: <20210118133545.05af2277@lwn.net>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
        <081546f141a496d6cabb99a4adc140444c705e93.1610610937.git.mchehab+huawei@kernel.org>
        <20210118133545.05af2277@lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 18 Jan 2021 13:35:45 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Thu, 14 Jan 2021 09:04:47 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Kernel-doc currently expects that the kernel-doc markup to come
> > just before the function/enum/struct/union/typedef prototype.
> > 
> > Yet, if it find things like:
> > 
> > 	/**
> > 	 * refcount_add - add a value to a refcount
> > 	 * @i: the value to add to the refcount
> > 	 * @r: the refcount
> > 	 */
> > 	static inline void __refcount_add(int i, refcount_t *r, int *oldp);
> > 	static inline void refcount_add(int i, refcount_t *r);
> > 
> > Kernel-doc will do the wrong thing:
> > 
> > 	foobar.h:6: warning: Function parameter or member 'oldp' not described in '__refcount_add'
> > 	.. c:function:: void __refcount_add (int i, refcount_t *r, int *oldp)
> > 
> > 	   add a value to a refcount
> > 
> > 	**Parameters**
> > 
> > 	``int i``
> > 	  the value to add to the refcount
> > 
> > 	``refcount_t *r``
> > 	  the refcount
> > 
> > 	``int *oldp``
> > 	  *undescribed*
> > 
> > Basically, it will document "__refcount_add" with the kernel-doc
> > markup for refcount_add.
> > 
> > If both functions have the same arguments, this won't even
> > produce any warning!
> > 
> > Add a logic to check if the kernel-doc identifier matches the actual
> > name of the C function or data structure that will be documented.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> I've applied this one; 

Thanks!

> it seems useful to have even if it creates more
> warnings that Stephen will duly email me about tomorrow...:)  I have parts
> 1-10 set aside and will apply any that don't get picked up directly by the
> maintainers involved.

Yeah, new warnings are unavoidable, as new patches may be introducing
extra issues. Hopefully, the new warning will help people to detect
the issue earlier before submitting upstream.


Thanks,
Mauro

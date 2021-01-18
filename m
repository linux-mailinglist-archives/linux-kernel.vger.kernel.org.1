Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C52FABA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394312AbhARUhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389038AbhARUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:36:29 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01531C061573;
        Mon, 18 Jan 2021 12:35:47 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A99C08B2;
        Mon, 18 Jan 2021 20:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A99C08B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611002146; bh=tJkzUZut+qC+Ma8BsoQlSQtj8cSJrHkUmQyEUz94aCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=knhRbhC+LlOw5hKrPn8rLqFMelvFxci6qYtpQqcvdtav8+vXOCWb4isZnRwbV6J50
         FThB6vOOfOwT387Aw9/5JqST6Wo6/c1c9kTgY3JTMdgEgUQjjiPB/ar/3El+Dy24hs
         AIR2YCSVefyVCudeG1Qan2rzEHKOEGWqOQ3/Qeg+zua3K6+sOlKiMH1IQ0qkutuTuJ
         rDrHjar7q8mxaw+abQn3nu5u/k85+CPnc+hFzBi6O/WJBbvve38SF7FFRGOh09Gjdc
         Arkp3woFUaJbWvSoz5WyPw/4KAUuGz4d4JuFVOPlB5ZiQJRdtX77ySXqbDmXnLsncE
         rzak7oci2MB+A==
Date:   Mon, 18 Jan 2021 13:35:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/16] scripts: kernel-doc: validate kernel-doc
 markup with the actual names
Message-ID: <20210118133545.05af2277@lwn.net>
In-Reply-To: <081546f141a496d6cabb99a4adc140444c705e93.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
        <081546f141a496d6cabb99a4adc140444c705e93.1610610937.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 09:04:47 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Kernel-doc currently expects that the kernel-doc markup to come
> just before the function/enum/struct/union/typedef prototype.
> 
> Yet, if it find things like:
> 
> 	/**
> 	 * refcount_add - add a value to a refcount
> 	 * @i: the value to add to the refcount
> 	 * @r: the refcount
> 	 */
> 	static inline void __refcount_add(int i, refcount_t *r, int *oldp);
> 	static inline void refcount_add(int i, refcount_t *r);
> 
> Kernel-doc will do the wrong thing:
> 
> 	foobar.h:6: warning: Function parameter or member 'oldp' not described in '__refcount_add'
> 	.. c:function:: void __refcount_add (int i, refcount_t *r, int *oldp)
> 
> 	   add a value to a refcount
> 
> 	**Parameters**
> 
> 	``int i``
> 	  the value to add to the refcount
> 
> 	``refcount_t *r``
> 	  the refcount
> 
> 	``int *oldp``
> 	  *undescribed*
> 
> Basically, it will document "__refcount_add" with the kernel-doc
> markup for refcount_add.
> 
> If both functions have the same arguments, this won't even
> produce any warning!
> 
> Add a logic to check if the kernel-doc identifier matches the actual
> name of the C function or data structure that will be documented.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I've applied this one; it seems useful to have even if it creates more
warnings that Stephen will duly email me about tomorrow...:)  I have parts
1-10 set aside and will apply any that don't get picked up directly by the
maintainers involved.

Thanks,

jon

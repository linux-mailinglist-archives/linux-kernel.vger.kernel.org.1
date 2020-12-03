Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC822CCB00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgLCAbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCAbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:31:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C9C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0SSqcxm0FWGTbqyn65xwt2DGf+gbc4EKOLLNAirjEjA=; b=s5VwOacs4ltLX1wQo0i1eMDRLJ
        KFIWNpXWnUqbr1bz9kOlm/hK2J9bAXkH/IrSBdNv944Q04P/wfAzhwyOZVd0ZnL8tUWSpxmxgSIgL
        INvoiJxcFTI8xn/zQ9kbo27e3m0EQ+T7NdUjgzxqYCYEvIsYyaxUP9vyU+UMO1/WIfiYM5uxksjh4
        ywAP93QNlIAEystcq0JhpjGQ6OOUiulyPI6kLRHTMtTsmmn70fke1fDGkLXnkEvZW+jgpaktKH1Lz
        I36mrB4tYELHyEBYgILuq8b6sgwRYnjP49rOepJqht/Y2S+fw1RIhym2KZHlWGItzSkPGhbcXU/K/
        MwONPI2A==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkcVr-00006J-7z; Thu, 03 Dec 2020 00:30:23 +0000
Subject: Re: [PATCH] Documentation: fix typos found in admin-guide
 subdirectory
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
References: <20201202084400.GA38345@spblnx124.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f1cc1c8-9e8e-893c-b1e4-509f042caca2@infradead.org>
Date:   Wed, 2 Dec 2020 16:30:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202084400.GA38345@spblnx124.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 12:44 AM, Andrew Klychkov wrote:
> diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
> index 7a86413..287d54c 100644
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst
> @@ -43,7 +43,7 @@ Here is what the fields mean:
>  - ``mask``
>     is an (optional, defaults to all 0xff) mask. You can mask out some
>     bits from matching by supplying a string like magic and as long as magic.
> -   The mask is anded with the byte sequence of the file. Note that you must
> +   The mask is ended with the byte sequence of the file. Note that you must

	"anded" is correct here, unless it would be better as "and-ed".

(see fs/binfmt_misc.c for details)

>     escape any NUL bytes; parsing halts at the first one. Ignored when using
>     filename extension matching.
>  - ``interpreter``


The rest of them look good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy


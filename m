Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49642283C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgJEQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgJEQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:35:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D07C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:35:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d500f39533324043f5fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:f395:3332:4043:f5fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4072D1EC02FC;
        Mon,  5 Oct 2020 18:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601915707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wY2WCDO/97x9Dd0KpvIDIOeYdJiQ3SNJO6GVxtLZR80=;
        b=hIRQgNyFpbCK2OZGGoZXSGQcFOamz9G5sCKSHGmstSxGrdwDwvuwGJVrWWX/XT9xuFPaQj
        siKBSAcRHbkrCSAFD7fGhu4Jx5wraVj9F8MixQt7wiKzo8v/AW4QNIEJf3ToERD/4kq+fL
        EmoP8fgoueddR2rI7SSLml6/DYIe8HY=
Date:   Mon, 5 Oct 2020 18:35:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] x86/mce: Provide method to find out the type of
 exception handle
Message-ID: <20201005163503.GH21151@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232611.15355-3-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:06PM -0700, Tony Luck wrote:
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 1d6cb07f4f86..de869665309e 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL(ex_handler_clear_fs);
>  
> -__visible bool ex_has_fault_handler(unsigned long ip)
> +enum handler_type ex_fault_handler_type(unsigned long ip)

Function name needs a verb:

s!ex_fault_handler_type!ex_get_fault_handler_type!g

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

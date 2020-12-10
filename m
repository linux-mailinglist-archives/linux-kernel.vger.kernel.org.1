Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC62D6580
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbgLJSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390719AbgLJSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:50:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:49:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d410017205789a0fcbfc3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:1720:5789:a0fc:bfc3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C7101EC053F;
        Thu, 10 Dec 2020 19:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607626173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HFr+TQgbbExoWWMpfs9I3dTG+qLNghUL3XyB58LJ2m4=;
        b=ShaQwqkcSioMUaC4Dq6TZQvQ58XjBAVKMuxAQoin6zglvxzS51Oa+LcvoIihMN48mVYsKj
        gxq9QdryDbhZzikGFAlTi+cZg22gBNFP9uMIwRm9DCH6V1cyK7esmPaM/Urk43ctPAOzk1
        RMFk1qdGgjpw2xo7vUsBsYxdTvIm3Fg=
Date:   Thu, 10 Dec 2020 19:49:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Chiu <chiu@endlessos.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Dan Nicholson <nicholson@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH v2] x86/reboot/quirks: Add GIGABYTE BRIX BXBT-2807 reboot
 quirk
Message-ID: <20201210184930.GF26529@zn.tnic>
References: <20201210041946.8961-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210041946.8961-1-chiu@endlessos.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:19:46PM +0800, Chris Chiu wrote:
> From: Dan Nicholson <nicholson@endlessos.org>
> 
> The GIGABYTE BRIX BXBT-2807 always hangs with the normal acpi
> reboot.

Is that what the "hard disk crash" in the comment below, refers to?

> It works without problem after adding the parameter
> reboot=bios.
> 
> Signed-off-by: Dan Nicholson <nicholson@endlessos.org>
> Signed-off-by: Chris Chiu <chiu@endlessos.org>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

What's Jian's S-o-b tag supposed to mean?

> ---
> 
> v2:
>   - fix typo in the commit message.
> 
>  arch/x86/kernel/reboot.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index db115943e8bd..a03344616cd9 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -467,6 +467,16 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
>  		},
>  	},
>  
> +	/* GIGABYTE */
> +	{	/* Workaround hard disk crash on ACPI reboot */
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

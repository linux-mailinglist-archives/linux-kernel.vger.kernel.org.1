Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7F2A8828
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgKEUhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:37:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C909C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:37:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ee500bbd1d94fdeb76199.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:e500:bbd1:d94f:deb7:6199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21C531EC03EA;
        Thu,  5 Nov 2020 21:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604608618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E43a+/LGReUezKBi34puQlxiCAI6gtWFiueLxvGy7Lc=;
        b=ZmBWOk2Fg/V1QXWK/FGtc2hw0aDVqBD57RboVSWy2gI1RRlv2lVsPOlEN3cwGLHf55BliC
        lWinsX88j9CJn17bfviWKaIkhlI+F7yTanVNY+ORb4lKvFkKx8rfz9hUXdq4/TjkXJF84x
        p+GolHfAkn73jwBP87Zu/MKSH/eMOYc=
Date:   Thu, 5 Nov 2020 21:36:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Anand K Mistry <amistry@google.com>, x86@kernel.org,
        asteinhauser@google.com, tglx@linutronix.de, joelaf@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
Message-ID: <20201105203645.GL25636@zn.tnic>
References: <20201105163246.v2.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
 <23d2bdb5-ebe6-b943-5c07-6e3087710651@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23d2bdb5-ebe6-b943-5c07-6e3087710651@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 02:32:10PM -0600, Tom Lendacky wrote:
> Does it need a Fixes: tag?

Yah, this one:

Fixes: 21998a351512 ("x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced IBRS.")

because it set mode to SPECTRE_V2_USER_STRICT_PREFERRED, leading to the
inability to set the TIF_SPEC_IB bit later.
> 
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Added, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

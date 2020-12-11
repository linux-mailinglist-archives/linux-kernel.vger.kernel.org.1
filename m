Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418C62D7E88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406202AbgLKSsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:48:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389463AbgLKSsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:48:03 -0500
Received: from zn.tnic (p200300ec2f124300da799288a8bc7530.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:da79:9288:a8bc:7530])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C1EE1EC038E;
        Fri, 11 Dec 2020 19:47:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607712441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n+nVQjIL9a/TTwRThg50YCcK8aGzmm3tICUXOfYFAAk=;
        b=i2FZ88Dj215UkdDZvbDavPDGDyaVGSKstBVZZP0uaXADOQYrNVgkWOEq7MRtYJ9+z606Tk
        n/R6E2+xUNstUyVLkUZI6LlQwqtT8Gv6oQf6oe5bwM8xxrUfvWiK6cgyMaddzyHfiqDlrG
        CXf9LvV0VW6d8e5I0EQqY24hu/Zr2iI=
Date:   Fri, 11 Dec 2020 19:47:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: ia32_setup_rt_frame(): propagate __user annotations
 properly
Message-ID: <20201211184715.GE25974@zn.tnic>
References: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207124141.21859-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:41:41PM +0100, Lukas Bulwahn wrote:
> Thomas, Ingo, Boris, please pick this minor non-urgent clean-up patch.

Why?

Isn't it obvious that when you send a patch to us, the final goal is for
it to be applied. Eventually.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

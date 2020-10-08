Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82EB287A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgJHQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgJHQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:40:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B59C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 09:40:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a90005296687463b5d995.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9000:5296:6874:63b5:d995])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C1241EC026E;
        Thu,  8 Oct 2020 18:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602175253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WAW/8JS2d7+2AncJGT2XwPHgun5v4p5JAJ8o7kGFtnc=;
        b=cKsHpOyt8bOEP/H93R9p4sOrBoO6XhPGzA/+VVuFpCEHED+7OkiPgn1ioIrByKT37Qo90z
        fSDlZ078dCt1fExk3Eu15oTwAZ2kniS3mDzrHgZk4Koq6+RwrYB4ubiar/5C9ksBHCClJU
        gCclpMfWcfK0xWEvvzz2CVF21yv3qk8=
Date:   Thu, 8 Oct 2020 18:40:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
Message-ID: <20201008164044.GE5505@zn.tnic>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008162206.862203-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 06:22:06PM +0200, Enric Balletbo i Serra wrote:
> As part of KernelCI, we added a bunch of different x86 based Chromebooks
> to do test booting and runtime testing. It will be useful have serial
> support for these platforms in the default defconfig, as this, is the
> defconfig used by default for the different maintainer's tree.
> 
> SERIAL_8250_DW is the actual support for the console, but to have
> support we need to enable X86_AMD_PLATFORM_DEVICE for specific AMD
> boards and MFD_INTEL for specific Intel boards.
> 
> While here, also enable USB_RTL8152 config which enables a common
> USB-Ethernet adapter used very commonly in the KernelCI labs.

To me defconfig sounds like the config which contains items which are
needed on the majority of x86 hardware out there.

Are those which you enable that common and if not, why can't your build
supply a custom .config instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A002A6004
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKDJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgKDJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:02:38 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC7C0613D3;
        Wed,  4 Nov 2020 01:02:38 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 141so26135234lfn.5;
        Wed, 04 Nov 2020 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cUfqmk4CS+f0MkoXlQUbUwaniISb0nfd1xI3bjYQruE=;
        b=r3rL2JTFlXYhTBb+MVUgBXn7F05AIlcOzdjKcGAX51JLWJo285Gp8AGwKdb2pmyQ4W
         T87cjxMDq4ETiJJjub3xI/zmbBarCKI3/y2WV3KHlNTZpiQDkyy6dBzvJl+BRdckoyOa
         6/QgtfC4icr20ZJkpymjgIY254pLlNx3RlbeCUBf0fgcVz75lTcEVO3YIIzROC/ywQNo
         7I6REbAONEQrMeoi6GSVLazLawcFAFai2eGZORNJ3YSc6bE5Hxar8EgbGf3/TCS9wEPK
         J9tWU/53KOLYNYGBC9U2NvgsAumAhgsEtRb8FX9C/cO08cFQeH+djmG365tfMG72T3eW
         rjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUfqmk4CS+f0MkoXlQUbUwaniISb0nfd1xI3bjYQruE=;
        b=bmfw0/NbJUYm7eqBeXnvUGwgqtg6Y33tGtxZ31IrI7eDXB8fbdmJcTlhB5+Va8rXLR
         Wlf8+ZqN53MTk8pLYW3NUU25BMEEz1hbbOIkDlJQm3YzLGRIkIc38VbRVmbpnHMiCrle
         X4+okui8vivRI4PgC9XTELw/4xzWwwf5Nny+5aI/YLBwBbB3brPHs/zOMrBFEihWnsis
         aU1C5+pqWfZs/ZxP0Ow3Ic1Tpyj8xrWk0zGGuV3L/xUo5G6cV4/4kaVZluebm2EZSasn
         n8DMJD9tTbSyMQg7FhEhc2xusOnF3bMGm/VwQWHTAObs9rZpIqvM9Jgh3dUkobGCA7pn
         fAWQ==
X-Gm-Message-State: AOAM5309zwGYkvv595Q5V0eieRhA/u1LAd34jHFlcRqgHEEMjAV3fTsw
        ClyQme9Og9jk7G4Q5UdZdMH72JIvPdyjmA==
X-Google-Smtp-Source: ABdhPJyhcqd4yRgKGAJDY0HD2ZbWObiFhbBhAkTQ+PRtTbuTm/eKn39jhR+ek9tM2v2eK3mBpnHB9A==
X-Received: by 2002:a19:c013:: with SMTP id q19mr842930lff.96.1604480556236;
        Wed, 04 Nov 2020 01:02:36 -0800 (PST)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id x15sm450586ljd.106.2020.11.04.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 01:02:35 -0800 (PST)
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
To:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <060292c1-5ce5-0183-8500-c92063351a69@gmail.com>
Date:   Wed, 4 Nov 2020 11:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103173438.GD5545@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.11.2020 19.34, Mark Brown wrote:
> On Tue, Nov 03, 2020 at 10:25:37AM +0000, Szabolcs Nagy wrote:
> 
>> Re-mmap executable segments instead of mprotecting them in
>> case mprotect is seccomp filtered.
> 
>> For the kernel mapped main executable we don't have the fd
>> for re-mmap so linux needs to be updated to add BTI. (In the
>> presence of seccomp filters for mprotect(PROT_EXEC) the libc
>> cannot change BTI protection at runtime based on user space
>> policy so it is better if the kernel maps BTI compatible
>> binaries with PROT_BTI by default.)
> 
> Given that there were still some ongoing discussions on a more robust
> kernel interface here and there seem to be a few concerns with this
> series should we perhaps just take a step back and disable this seccomp
> filter in systemd on arm64, at least for the time being?

Filtering mprotect() and mmap() with seccomp also protects BTI, since 
without it the attacker could remove PROT_BTI from existing pages, or 
map new pages without BTI. This would be possible even with SARA or 
SELinux execmem protections enabled, since they don't care about PROT_BTI.

-Topi

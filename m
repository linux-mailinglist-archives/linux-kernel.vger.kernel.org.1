Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6902D68C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbgLJUdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393719AbgLJUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:33:20 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209AC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:32:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so5793040wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=g2mbhgNBK+MRjARsIY8DRoXQU0GP8ah1DIQ0gH/bghU=;
        b=K4ReS5yp5fqibQa7GbCu+nMO6USs87kIdRhge3XtnwoZebw6mrNYUYgkTl3+XGMFD4
         TKzrl1+NkrRTFf8DOLpLc8uzJlezHmfRd8iLcsAnj2p8gIoV6tu+3CbuBKoltDFLzCEg
         KBwzZj2hf1cxLdnk/U+DgnQTSJKd12pFsPcnrcNmunCOM7tj1o3NC1XQW2nWet43tJUL
         9hJ9VRQ9bnh8koC/oYz3sLBnlt/gF8MoeHNk2yB5CSHXmmNMnFUEYb2iCNpERZXyCgLr
         Wc4S8w7qzfvgsQ1OMrTUQZZ7QydRrN2YyECdCqhFuOi5r5tlaPr5kqlBak4aFTsEBAy9
         /nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=g2mbhgNBK+MRjARsIY8DRoXQU0GP8ah1DIQ0gH/bghU=;
        b=nBmtznnNjuCGJHY4peSSO55qLZT4EmDdjf5J9+Yw1Y97Ocs4Xh0P6K4SwYr6auEnCm
         MVsNgISlhpODzIspkq+axhpM/jLdbV7FHKdF5SNk0beE6mAgueKyvIqyxCO6tG0FUOVd
         f2fdi5bOx/HdK0fy4Gc5jBMGxo8sFXC8Wb9wbjwWnrHc74IVe09pAr9Kr4Gl2AV1/wyB
         LoNgk38TK7/YTQQfzyRZUPzt/j7hDXaeAykm/AE3kSM3QOaI2W2qfyd58toNcBwGgenF
         Eu6i7Rq89ycIDvU2zCGG2IV9Hxgz9H7wYE3O8IFGE4maO0OzJtqNjGxhPKOnIgx0Rfpj
         mpPg==
X-Gm-Message-State: AOAM5307Tmr/ez8KJRxHh7ctz6aWDMkqS04xluepj37ODFTidZboPTA8
        kuXGUTjA8EWqbedb3yNkRAjS8fOzFvt+JA==
X-Google-Smtp-Source: ABdhPJwStHbgoCvdDiy8quQ6LaET7uDYhwVG1pEBRJojc4BrTybhWBBj//k1qOwuDP811k8KLoqcCw==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr9893197wmf.95.1607632358964;
        Thu, 10 Dec 2020 12:32:38 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:915a:a543:6cb0:cf21? (p200300ea8f065500915aa5436cb0cf21.dip0.t-ipconnect.de. [2003:ea:8f06:5500:915a:a543:6cb0:cf21])
        by smtp.googlemail.com with ESMTPSA id c2sm11644059wrf.68.2020.12.10.12.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:32:38 -0800 (PST)
Subject: Re: [PATCH] x86/reboot/quirks: Add Zotac ZBOX CI327 nano PCI reboot
 quirk
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
 <20201210190418.GG26529@zn.tnic>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <706c9de3-57de-9a82-737f-842f972ec596@gmail.com>
Date:   Thu, 10 Dec 2020 21:32:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210190418.GG26529@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.12.2020 um 20:04 schrieb Borislav Petkov:
> On Tue, Dec 01, 2020 at 12:39:57PM +0100, Heiner Kallweit wrote:
>> On this system the M.2 PCIe WiFi card isn't detected after reboot,
>> only after cold boot. reboot=pci fixes this behavior.
>> In [0] the same issue is described, although on another system and
>> with another Intel WiFi card. In case it's relevant, both systems
>> have Celeron CPU's.
>> The dicussion in [0] involved the PCI maintainer, and proposal was
>> to go with the PCI reboot quirk on affected systems until a more
>> generic fix is available.
>>
>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=202399
> 
> But this quirk is for your system only - the one in the bugzilla entry
> would need another one? Or?
> 
Right, as Bjorn wrote in comment 14:
".., and there may be many systems with this issue and we may be adding
such quirks frequently.  But maybe that's the only option, since we
don't know any other way to fix this."

I'd prefer that the autor of a quirk also has the hw to test it on.
Therefore I just added the quirk for my system as a template to the
bug report.

> Thx.
> 

Heiner

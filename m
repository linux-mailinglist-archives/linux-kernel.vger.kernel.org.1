Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB1A2C7EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgK3Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgK3Hox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606722206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCxrKQgKWaomcz1R6EnYBYk4nw48KMWwjloNms5mrbw=;
        b=BhHCO2ucQG4E/c9dQ3lHayvwvmDmPomJTHsA18yAZL8bPX5JaF4PMQwAnbbrOU/gxlR0Vt
        AUjAJjJ8/46YeONFMfbZpaCJKobNCgTJTtPkXqnim9zVhftwsWDqs58LhdHgJoYHqPzO9S
        ZfrGELWGq+ng3cFr4EIYHlWGeKV2d1M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-pANJJMDjP-iLTIIZl_SOwQ-1; Mon, 30 Nov 2020 02:43:24 -0500
X-MC-Unique: pANJJMDjP-iLTIIZl_SOwQ-1
Received: by mail-ej1-f71.google.com with SMTP id y10so5361245ejg.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 23:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCxrKQgKWaomcz1R6EnYBYk4nw48KMWwjloNms5mrbw=;
        b=Pr+ExT/KTJCbe5zuQ7PpnFvq62GaljZFiuWimcoEiK2Cocy9jp9Z5PELT6Iw5W6UWJ
         lqHdxyS8uPU5ljXsfN7J5kbfxCzyTzrBybaWPLyIdYEnufZdmK7oW1NOPQypevRBpni5
         Yn5zGdK2dpkbMvbxAgmQ1Z8qhzkDYRcpPPQNZ9UPM9/T8aFNgVNTHhnxf8aOPhdjiU+M
         ARlutDY4XHhE6PyBRldGkPEpvV1uwFzZFjekdC6dA7nu56Yjts7hQX6VgvxLOYiYebQK
         jqEKo0YyO+SoW2KfaqgELrJB/iRZbk/4KSpPex6Qb/8SxQ23522lu4As4BW0MMSIbhAc
         C3YQ==
X-Gm-Message-State: AOAM530HOo8ouL+Xw+aDD935R+vIayAwv7MCs8IV468idzyfeCKzc1V7
        lNfTXWEF4ucbSmhbRTbZ3C8fkpGZg1f9gl97Ur1kx5qPKhxLCC1ZL61sAVCioG6W4rtJM/GxTM2
        BbYceZU5/zKrm+6dJwgs0TQ+Q
X-Received: by 2002:a50:e715:: with SMTP id a21mr20384608edn.285.1606722203149;
        Sun, 29 Nov 2020 23:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdLbND8D4t/lHAwTW2/Hfo6cgLDGhelhwR/5DnlD4aaxnvHJOCvXp/vDjEV6qQQxUOJLkYXA==
X-Received: by 2002:a50:e715:: with SMTP id a21mr20384596edn.285.1606722203000;
        Sun, 29 Nov 2020 23:43:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p4sm6203746ejx.64.2020.11.29.23.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 23:43:22 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <mark.gross@intel.com>
Cc:     Vadim Pasternak <vadimp@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201130044331.4abf7b91@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ae231b40-e1c8-6995-d45b-ddab6a04810e@redhat.com>
Date:   Mon, 30 Nov 2020 08:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130044331.4abf7b91@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/29/20 6:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   912b341585e3 ("platform/x86: mlx-platform: Remove PSU EEPROM from MSN274x platform configuration")
> 
> Fixes tag
> 
>   Fixes: ef08e14a3 ("platform/x86: mlx-platform: Add support for new msn274x system type")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
> 
> In commit
> 
>   2bf5046bdb64 ("platform/x86: mlx-platform: Remove PSU EEPROM from default platform configuration")
> 
> Fixes tags
> 
>   Fixes: c6acad68e ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
>   Fixes: ba814fdd0 ("platform/x86: mlx-platform: Use defines for bus assignment")
> 
> have these problem(s):
> 
>   - SHA1 should be at least 12 digits long

Hmm, for some reason checkpatch did not catch these, while AFAIK it will complain
about short hashes in the normal part of the commit msg.

Question, how important is it to fix these ? I normally never do forced pushes
to the for-next branch. But if this is considered important to fix I guess I
can make an exception.

> These can be fixed in the future by setting core.abbrev to 12 (or more)
> or (for git v2.11 or later) just making sure it is not set (or set to
> "auto").

Will git rewrite the commit msg when this is set ?  I'm at 2.28 and don't
have core.abbrev set. But I guess this needs to be set in the gitconfig
of the creator of the patch; and this has no impact on "git am" ?

Regards,

Hans


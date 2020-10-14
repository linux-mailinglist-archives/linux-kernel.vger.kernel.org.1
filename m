Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5028DFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgJNLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:21:14 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:44076 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgJNLVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:21:13 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4CB92r2KlfzTh4d;
        Wed, 14 Oct 2020 12:21:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1602674471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqppSAJ/nKG+OEqXPwbLp9Euk/mEALvMk5IqKFtZ9Dc=;
        b=SoIXu9CcbxRZbIoWljtTLLF7r6Hwv/U4wiLon3QYSgZkjewBy2B551U/Exi2YfnlkLIIPD
        IYShJpl0yZEWqlZL5yeWnsxSvQD7UzVcbe/Cid9NTg9z+GFpe+3FR3X7VvB8uBYbejBCBp
        hW0a4u6DtJYtiZF61KHdnPT226OubuM=
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
From:   Ed W <lists@wildgooses.com>
Message-ID: <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
Date:   Wed, 14 Oct 2020 12:21:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 09:41, Hans de Goede wrote:
>
> So I have a suggested compromise:
>
> Keep the current LED/gpio setup code, but make executing it conditional
> on the BIOS version and skip the LED/gpio setup when the new BIOS is
> present to avoid having duplicate LED entries, etc. in that case.
>
> I guess this would still break userspace because if I understand things
> correctly the new ACPI based setup uses different LED names ? That
> seems unfortunate, but I guess that from the kernel pov we can just
> blame the BIOS for this, and since we definitely do not want duplicate
> LED entries for the same LED, this seems the least bad choice.
>
> Enrico, would that work for you ? 


I'm cool with this. Enrico?

I may have some time imminently to have a stab at a new patch. Obviously any help structuring this
would be appreciated - it feels clumsy using the existing detection mechanism, I think whatever I
come up with you should kick back and recommend a new board detection structure, but perhaps we can
shortcut that step with a few comments up front?

Cheers

Ed W


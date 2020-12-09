Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12792D38B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLICUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLICUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:20:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B5C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 18:19:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607480367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUH66b3p4Oyy+uNSwHV80Yg+yPnJEhaFd3JUf97juIg=;
        b=MG6Scaxeoqz69Qn4x3PdnM7MabfU2oDcXXPYp4jAu3d3yUFNebEX9VoVBXuRo4gOeAmdZ0
        DQGUXdZmxROhNn3GlsDqbiY32dfkBsdfSf3QKD44F+DgvtYgF2ULhSxaCfJNRl8iGSl1vF
        /FJQ32kPfCmuScS9aNUKWzRqiZD/ShWv3D8/FSmHv1NRSKrk+i4WC3VNlv+JvhULvnVv5s
        jicsYmqAn8ED10JU+B3ph/zfY42oQwARqKeKXMHbkedx8Nzey2zC5pnADHY0vUGKbmcfrq
        6E1k0l2TDXSjg5+zDG/sFdxEIGwKNo6YUe7yS3wDROwKP6n3Fpwvp6hRx9jWgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607480367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUH66b3p4Oyy+uNSwHV80Yg+yPnJEhaFd3JUf97juIg=;
        b=Ja0k+2FW4/VJMak0FEfc/yVdXVvgjKl/DfWvmnytbFuRnvQ9yXdc1Q3FuwKLJqsYYg06DV
        ANdOo6+eMGSOaSAA==
To:     Johan Hovold <johan@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] x86/apic: Fix CPU devicetree-node lookups
In-Reply-To: <X89P7Bnw4x9i0y4Q@localhost>
References: <20201124134247.2668-1-johan@kernel.org> <X89P7Bnw4x9i0y4Q@localhost>
Date:   Wed, 09 Dec 2020 03:19:26 +0100
Message-ID: <87o8j32029.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08 2020 at 11:05, Johan Hovold wrote:

> On Tue, Nov 24, 2020 at 02:42:47PM +0100, Johan Hovold wrote:
>> Fix CPU devicetree-node lookups by implementing
>> arch_match_cpu_phys_id().
>> 
>> This allows using of_get_cpu_node() and of_cpu_device_node_get() to look
>> up CPU devicetree nodes and specifically makes sure that CPU struct
>> devices are linked to the correct devicetree nodes.
>> 
>> Note that CPUs are described in devicetree using their APIC ids and
>> that those do not generally coincide with the logical ids (e.g. used by
>> the default arch_match_cpu_phys_id() implementation).

Can you please explain why this is relevant for any of the existing few
x86 DT users?

The above is incoherent word salad TBH:

    1) Fix .....

       without any information what is broken

    2) This allows ...

       It allows. Cool. Is it mandatory, desired or whatever?

    3) Note ...

       That might be an actual problem decsription, but I can't say for
       sure.

Changelog structure should be:

   Set context if necessary

   Describe the problem and the possible impact

   Describe the solution

and not:

    Claim to fix something unspecified

    Give some explanation how cool it is

    Add random notes what might or might not be solved by that.

I still have no idea what this 'Fix' is fixing if it is fixing anything
at all. Is is a fix which needs to be backported or is it a 'fix' which
fixes something which got changed elsewhere and forgotten.

Sorry, my crystalball got lost.

Thanks,

        tglx

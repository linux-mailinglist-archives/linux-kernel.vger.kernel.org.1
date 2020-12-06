Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D22D0777
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgLFVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbgLFVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607291190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pt7TdFB7ulKa/lV+VvFZnu9g+M0yRQxxm6d6lfJIcJQ=;
        b=Bc1k0w3mAb/A529LBkRbxp8qD59LX5epU0jFi/6rK+NDUoGTQVPH06vl1rD6QLXwzMTt08
        7fsao2LbwcmFzB2PLDnirYEK+9TnT1XIw6U+Dwok+TS24Epm/jaQqSAbPmKckQJ/Cw6QYW
        CPehOwvAdquEeM2Oau/alQpRWy2mMYA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-zc1NN15mN1SvDNh4JqypCA-1; Sun, 06 Dec 2020 16:46:29 -0500
X-MC-Unique: zc1NN15mN1SvDNh4JqypCA-1
Received: by mail-qk1-f197.google.com with SMTP id 198so10716208qkj.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 13:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Pt7TdFB7ulKa/lV+VvFZnu9g+M0yRQxxm6d6lfJIcJQ=;
        b=dBg5ftbZPBs5ZkmdptpX+1+Hc90ivt1XGMJmoqyJb70pxys9acmgLUTdphmIAraHNM
         g9lBrb9qaqzbyK5KlrcV6NWl6jJPZfN5iYpTCiGDaa9FAF0ieczL0j+9cfHOQAYicN9l
         eAEB1maMxYI32HEthqnV9xA8PEtvaGUpeRWikLa9iST/J/tzAJNe8JgE1LIYRw9sZ2e4
         is0MPNA+r2glnZexxYVQW+fT5KZCltuwiHbAiXEYgj6ypaHn1HwLU3z3zHHHBcSGURgA
         mQ5sihoZuqtH7E/5INKxQKJGoBnWuMQ6W3s1BblR8q6aoQsoV14+Ln8X1PUWBLEwV8YF
         M+IQ==
X-Gm-Message-State: AOAM532YU98paGdwntJrkxM82nAzl2UdvUhhECKCePVXBBWJXy5F11Iw
        //+8+v/Fh1AibTP00LlXwL3vVN6+wUiwCH1kvRnmGD9XDiMebrHAtSmU2KyvzIpFkfX5J9FV/UW
        n0uC8F8YsjeUG7mtCcPEY6sdi
X-Received: by 2002:a37:7143:: with SMTP id m64mr21643204qkc.280.1607291188963;
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdJmpyy0faO+c7dz32lK3lca+T2SB1F3DXtNcksxPbw00LbiUdsAxUQYUXlLzAVtknWfl5ZQ==
X-Received: by 2002:a37:7143:: with SMTP id m64mr21643187qkc.280.1607291188745;
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a28sm46494qtm.80.2020.12.06.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-2-jsnitsel@redhat.com>
 <87y2ia7rbv.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
In-reply-to: <87y2ia7rbv.fsf@nanos.tec.linutronix.de>
Date:   Sun, 06 Dec 2020 14:46:26 -0700
Message-ID: <87lfeahakt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner @ 2020-12-06 10:54 MST:

> Jerry,
>
> On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
>
> The proper prefix is 'genirq:' git log kernel/irq/irqdesc.c would have
> told you. 
>
>> To try and detect potential interrupt storms that
>> have been occurring with tpm_tis devices it was suggested
>> to use kstat_irqs() to get the number of interrupts.
>> Since tpm_tis can be built as a module it needs kstat_irqs
>> exported.
>
> I'm not really enthused about exporting this without making it at least
> safe. Using it from an interrupt handler is obviously safe vs. concurrent
> removal, but the next driver writer who thinks this is cool is going to
> get it wrong for sure.
>
> Though I still have to figure out what the advantage of invoking a
> function which needs to do a radix tree lookup over a device local
> counter is just to keep track of this.
>
> I'll reply on the TPM part of this as well.
>
> Thanks,
>
>         tglx

I can rework it to use a device local counter.


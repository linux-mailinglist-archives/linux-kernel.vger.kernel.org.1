Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC52CEF6B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLDOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgLDOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:09:03 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345BC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:08:22 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 62so2759978qva.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqXEsirEh9eW1VieGHrEu+QlOdgfjHIxDQpQJ3ZI1GQ=;
        b=DPaWF+yuM+abHWkSEYzIkGbG1X9C5nWRMqwqGsjVNKBOJ5Mev2u4CyIsRihFZaouda
         Xshhb+mFTlVQS+EZJT7mTRyRcMy5eGQLGYJT/txdBMgiSlL3t2F1G4DmPneafNsuCgkt
         QKtR/RClMRZDqiOHJd5qW74+iYZ1MQvjVJtJpNjMEvtpO4+9/GQrTTNFB+D+OfEG+2mQ
         xK6Q5JWuu9NzOhFZWJELZ7FYaJqiZpkuWwtL4ICswr6IRW+AuPWpuV2GykIwQHF2SueD
         TtnBa860pGMhACWpqHCwKgezk4pEPUAGKvhQVTz3baGPTTErwjY+fvjG4rEukkZIr1hN
         drLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqXEsirEh9eW1VieGHrEu+QlOdgfjHIxDQpQJ3ZI1GQ=;
        b=BufzeddWjvYaoJUlOK3Y1mKSbgAx1G9KEw9swd0A7dtJ6CBjm1xX0n7DmVqbeZo2GW
         u62rU8hvGGnEteUL+edxbACIdcpRuqYK57J7mnQcmCxGNerGkIm50ctedg58zXQf8qeR
         uhCX6JOYq/MUrLaVFXTIzVVTza8QlwzPMpNoUg+A2tvEVpqbX07XkUkyZbWx/harDnKs
         EUZ5hzi3PLEoMJiCivcqku5ow0uAjH4GRt4muSFIO9HOyl9DMeynYzG70obPuc0eFvqz
         ltCkmD8qmvi7vToqTfcY3KY7ZC+8yP9h86PfXRw/ouYgTAd6XXAa1mqHCjn6ye89qCau
         ROWA==
X-Gm-Message-State: AOAM5332ji0u5+okKm+N1OYJ/YUN9F6WrWVOctrS1E/rWiTj0qEoFVyL
        NHOb5r729V4qSh5tg/3WAMrULLOfs1fR6Q==
X-Google-Smtp-Source: ABdhPJwNYN3wZEVkLRcCz859RCC5SVfMWP4iSwbgNtFU+yM6gv1YTpTw/ichnblG5iK5AJgxJ9fd0w==
X-Received: by 2002:a0c:e0c9:: with SMTP id x9mr5318505qvk.56.1607090902137;
        Fri, 04 Dec 2020 06:08:22 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q28sm5022865qkn.39.2020.12.04.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:08:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1klBkx-005s5c-Kz; Fri, 04 Dec 2020 10:08:19 -0400
Date:   Fri, 4 Dec 2020 10:08:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201204140819.GX5487@ziepe.ca>
References: <20201202205418.GN5487@ziepe.ca>
 <874kl3eu8p.fsf@nanos.tec.linutronix.de>
 <87zh2vd72z.fsf@nanos.tec.linutronix.de>
 <20201203021047.GG3544@piout.net>
 <87pn3qdhli.fsf@nanos.tec.linutronix.de>
 <20201203161622.GA1317829@ziepe.ca>
 <87zh2ubny2.fsf@nanos.tec.linutronix.de>
 <87wnxybmqx.fsf@nanos.tec.linutronix.de>
 <20201203223646.GA1335797@ziepe.ca>
 <877dpxbu66.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dpxbu66.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 02:02:57PM +0100, Thomas Gleixner wrote:

> No magic sign calculation required if you look at it from the actual
> timeline and account the time between write and next second increment
> correctly.

Yes, it is equivalent to break things into two values, and does look
to be more understandable as one can read at least one of the values
from a datasheet and the other could be estimated by timing a read
clock

Jason

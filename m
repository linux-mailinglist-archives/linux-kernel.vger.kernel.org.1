Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AB2974D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372965AbgJWQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462852AbgJWQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:48:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662ECC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:48:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so2787978wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=memsql.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZC2Dh9koWunjCaFQ0yegSpVnhZcJzrp1WPeUxVV9K1U=;
        b=ei2DFm6ifLWtvvqfEDL51CwiGCAXkhvcCTRMhU48M7dErj6QHje58qXOACqG03RsEZ
         u8NPenEqnD/YVLi1uOVbKVI8kyA/FLShuD+KMQqCzlnBaGv+F4uFNV+c3DFU4pUsHMMc
         bZa21diwQJgBd5vDZc8g15TCn0s26O/kxQpTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZC2Dh9koWunjCaFQ0yegSpVnhZcJzrp1WPeUxVV9K1U=;
        b=QGH3TActMxHs4ert715PWR6nYYq3c9o75b1eF+PJbRFmrfVeBDO36Es6X61OKm++TQ
         wAxw7ZR3zYYmSDP4pabQn+9NRviUcuT6jSr/aAHZK4X1V7da1E7gYdNH3eKM6c258ve3
         /qQnl6ezGRddRh7FzhAJAvIKLgSKfdv0gHpP1Z9zqF+lX47mhz2HT0VgO19g1LJdzcUR
         cF+jVbnAF7nynkzUxeSH+eCcPcGcgE4oB/IIFqdhZva8bM5tXgxfisW/0hMc13ouAoBz
         pGVkJRFAu7VIcRhLPpD4ldHfuSBffOz/rdSHOqie1TTikRt/FiJD6/Ff5pn5doSHJTXf
         PZGg==
X-Gm-Message-State: AOAM5333/UtAkr63JJJgRAM00K1IB8oAKcY/QcQj1wge4YQl6kcMM60O
        azoyJYfz123DPk3levQpRv3axQ==
X-Google-Smtp-Source: ABdhPJwpEgf9jzJ4lH1LeQe5HX73reEjlkdFwZ3NHT2X1w0fwY+VwRvl3p55TC0ZnWN0ZsSok77bvA==
X-Received: by 2002:adf:8362:: with SMTP id 89mr3738705wrd.280.1603471708004;
        Fri, 23 Oct 2020 09:48:28 -0700 (PDT)
Received: from rdias-suse-pc.lan (bl13-26-148.dsl.telepac.pt. [85.246.26.148])
        by smtp.gmail.com with ESMTPSA id m14sm4508047wro.43.2020.10.23.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:48:27 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:48:25 +0100
From:   Ricardo Dias <rdias@memsql.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp: fix race condition when creating child sockets from
 syncookies
Message-ID: <20201023164825.GA321826@rdias-suse-pc.lan>
References: <20201023111352.GA289522@rdias-suse-pc.lan>
 <CANn89iJDt=XpUZA_uYK98cK8tctW6M=f4RFtGQpTxRaqwnnqSQ@mail.gmail.com>
 <20201023155145.GA316015@rdias-suse-pc.lan>
 <CANn89iL2VOH+Mg9-U7pkpMkKykDfhoX-GMRnF-oBmZmCGohDtA@mail.gmail.com>
 <20201023160628.GA316690@rdias-suse-pc.lan>
 <CANn89i+OZF2HJQYT0FGtzyFeZMdof9RAfGXQRKUVY6Hg9ZPpcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+OZF2HJQYT0FGtzyFeZMdof9RAfGXQRKUVY6Hg9ZPpcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:36:29PM +0200, Eric Dumazet wrote:
> On Fri, Oct 23, 2020 at 6:06 PM Ricardo Dias <rdias@memsql.com> wrote:
> 
> > And what about the loopback interface? Why couldn't the loopback
> > interface also use a single RX queue?
> >
> 
> Loopback is using a per-cpu queue, with no crossing, for efficiency.
> 
> That means : whenever a packet is sent on lo interface from CPU X, it
> is put on CPU X backlog queue.
> 
> If the connect() and sendmsg() are run from different cpus, then the
> ACK (from last packet of 3WH) and the data packet might land on
> different queues.

In that case, I can change the patch to only iterate the ehash bucket
only when the listening socket is using the loopback interface, correct?



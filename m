Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4274920D319
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgF2Szp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:55:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56524 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729913AbgF2SzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRNIV4x43P6HErryarebd5FQz8VopUKzf076Ub4cEhw=;
        b=X8x6aysVFVe8YFVhCEmUfJRQ0p8IteM8r0KfEtdIzRJXebemoPOpgVk9PmFw5+q1RAqeiE
        dlMu7KrzsZ4zc4fdXbNYAnrQuME4wPHLgFAbnxqe/rXB7sTU6CZKGfqYUivNX0byQ3+V6a
        vntnh5Ohk0wTgsLP66a1K4lHuNxKu08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-um4uu1F4PoCkq658zZ3pxg-1; Mon, 29 Jun 2020 08:54:00 -0400
X-MC-Unique: um4uu1F4PoCkq658zZ3pxg-1
Received: by mail-wm1-f69.google.com with SMTP id v6so16151905wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRNIV4x43P6HErryarebd5FQz8VopUKzf076Ub4cEhw=;
        b=P9u/mZg4grv2BZpGy6gmnrIurUD2sBX+C3GJ02eyjG4cgVO4qGPAnY/jbN2yHtTG7g
         rxNO+Q0aHlet4vo8UUn/qlFDowC94sUCuBrYkwzSzetKzI6Qhp0aGYAq8CjFUH/CCFzW
         0k36sVr8/8PH1CFj1aC/5PcqklFZ/GbnfUNYIwNPIm6z5XtUb4WIQ6JFJQOLDo/wTERX
         6Kclqz6okEl8/dc1AX5ZApGAZnZADKB57Mqgv+3GQSPlhh0eeKMdzsdT+rnnZshTXWML
         XpZ/Qjb9kXuUVLpPcn6kNloxe3kTwcdBGBX8DoHXd8isc3gdrhXszP71POr2aeJXkrA5
         tmEQ==
X-Gm-Message-State: AOAM531o4yRACR0YCgkRR0hmnQ7v+E2Oh3NfqHGKTsVYXUTAuoXEa9dR
        9DMFt+51vBP+lncE2mlP7bOONMPjMlUk3Hvo/vrhU0Faes89C9Cd8UhwPKxepNNxWQPHP3qQf/P
        Yj9zcm4IU8PO8mW1vRNc6HjUA
X-Received: by 2002:a1c:5418:: with SMTP id i24mr16011211wmb.47.1593435239275;
        Mon, 29 Jun 2020 05:53:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCGDvr+eGI0QiQBdG3VZDI0bqn2iCa/GHXZRlpJW0cXI/cAOmdxZFkRYH9FPz3OcQeGVb3lA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr16011199wmb.47.1593435239033;
        Mon, 29 Jun 2020 05:53:59 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id x13sm50975152wre.83.2020.06.29.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:53:58 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:53:56 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200629125356.GB9670@localhost.localdomain>
References: <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
 <20200616204649.GA4914@lenoir>
 <20200629123651.GA9670@localhost.localdomain>
 <20200629124207.GA6088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629124207.GA6088@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/20 14:42, Frederic Weisbecker wrote:
> On Mon, Jun 29, 2020 at 02:36:51PM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 16/06/20 22:46, Frederic Weisbecker wrote:
> > > On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> > > > Sure. Let me know if you find anything.
> > > 
> > > I managed to reproduce. With "threadirqs" and without
> > > "tsc=reliable". I see tons of spurious TIMER softirqs.
> > > Investigation begins! I'll let you know.
> > 
> > Gentle ping. Any new findings about this issue?
> 
> Yep, I'm working on a series to reduce timer softirqs. I'm almost
> done, should post it soon.

Great!

Looking forward to it.

Best,

Juri


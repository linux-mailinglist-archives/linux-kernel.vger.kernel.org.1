Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64BF2CCBF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLCCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgLCCFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:05:10 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E9C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 18:04:30 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so766406qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJSHYFhSwoD2+U2HGs2pBzQX94ySYSBm9WeKvp7LU9Q=;
        b=Xfc0106QDTS/pUhEUqG2CmZ4pbR6T4q6Izexc6iu740GtWpd84xwMo0hC//7Lgej3k
         DII12b1lW/n8mvxgg5ZdI4nwxm8Ur3rAKsSw4pj1/1v+lHT77Wp7pZcHqSDfrzuxXiwj
         DR5BBcRd+hLuBjeX4/i1fo3duTpORVP30r133t75t5Hgp1PtaUTZ+StRo36NUvQjRFRx
         ckY4bZiOrsqWZtIwbQ3dniXym5gwq4jDFYObu1ENeWsNsLcLlfA7Ad/qew4YRU+t1t/c
         1sdqenAVHV+cl+VoSEFu+NTmpzUX9mQP3P52+qnWRorBZPTBKamiGrznF4YsO1IGmVOh
         9UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJSHYFhSwoD2+U2HGs2pBzQX94ySYSBm9WeKvp7LU9Q=;
        b=VKYM1z8UFeJRF2BVO/RJu7rbL/CM/rlZezQopboZvEdgJzUMGs5DAxfjxVgSEEigr1
         YwRnX6nEtfTkyFmHEDDhrMMY+MbZyrXbH0g3H80JPwiOcGFj38WDzuZL+73zDaftbHjx
         mACudsy6uXg63NIwgfqFD/2eB3BITmWizL4bdP5ShK0qG1ideyDpjzshGnO60h9W8xJu
         sCRn/uzwiLnnc8xOMzbn9EX+inXy6Do8CmQDqT9pQMH+BG5pQqDnYa1WNW8HZ/zwvEhj
         n1YRZUo1QmnPJsU6UOpbruw973ejYK3Q+WvrTrNt+4IMgeA7M8idheUmJ+l5A5EtGQEy
         paRw==
X-Gm-Message-State: AOAM531vFBpPMbV6uX/zUEhUTBuAfa4VqAzQp/pB0OYim90BXcEwcmwJ
        jttUIelKtFlX8fivbYB76wlERw==
X-Google-Smtp-Source: ABdhPJxeOW7Q0ae8iOkjWtoCj7xlGAAs8tHbcxFgIKVPpgu8xQBnAf60tQtyyMM0guEBxCp3KjxYZw==
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr805479qki.338.1606961069387;
        Wed, 02 Dec 2020 18:04:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c7sm781106qtw.70.2020.12.02.18.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 18:04:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkdyt-005ISu-Nz; Wed, 02 Dec 2020 22:04:27 -0400
Date:   Wed, 2 Dec 2020 22:04:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201203020427.GR5487@ziepe.ca>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
 <20201202162723.GJ5487@ziepe.ca>
 <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
 <20201202205418.GN5487@ziepe.ca>
 <874kl3eu8p.fsf@nanos.tec.linutronix.de>
 <87zh2vd72z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh2vd72z.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:14:12AM +0100, Thomas Gleixner wrote:

> If anyone involved seriously believes that any of this solves a real
> world problem, then please come forth an make your case.

The original commit 0f295b0650c9 ("rtc: Allow rtc drivers to specify
the tv_nsec value for ntp") was tested by myself and RMK on various
ARM systems and did work as advertised. Here is the giant thread,
RMK's post explains the problem and gives his measurements of several
different RTCs:

https://lore.kernel.org/linux-arm-kernel/20170920112152.GL20805@n2100.armlinux.org.uk/

And the patch that resulted:

https://lore.kernel.org/linux-arm-kernel/20171013175433.GA22062@obsidianresearch.com/

There is a lot of detail in there.. Keep in mind none of this was for
the mc146818 style RTCs.

I can't recall any more why no drivers use the set_offset_nsec. I'm
surprised, maybe I forgot to send the patch for the RTCs I tested or
maybe it got dropped someplace.. It certainly was needed for some
maxim I2C chips.

The thread shows rmk had even written a hrtimer patch to go with this,
but it also got lost for some reason. Maybe all the arguing killed
further effort?

Jason

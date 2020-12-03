Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5FC2CDA69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgLCPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLCPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:53:32 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EBC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:52:51 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g19so1153484qvy.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sza1dnpdO/xRy/URAk8vbDczQ7tTlrJ7/tYshaI+Ua4=;
        b=hF8ouXjHXZqJp61av+QLd2XwK8d0cLF9jIOk7ianNFJeR0UjYKxMwX59VX43vhHmTc
         jlNF6uUnkKdDdQXma1bBEMVkSXz+AbXX2me+VSEg4D7CMzllqWgIS4GHBcAae5b9yyrm
         CYyiQEhg9cOgRRW1PKZzW+5iMUUcXUBqK7kvCMICnbzMviockO55k0BF4lSPgssdipfH
         4+THgwN89siTKIGheN4Q9RgyGfjqBV1tNhowV+DzQ8IjKOXix4jrOvrtfBMy8w1b2Zbh
         L6nyaud1Ki3ou9dv88UzwzdQ2Nxunpc6m1rnqL4YX6wD1AjlTE4tNSb0vFSsHskwUNM4
         /PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sza1dnpdO/xRy/URAk8vbDczQ7tTlrJ7/tYshaI+Ua4=;
        b=KV3jAMmxDx+k0UAl30I1qVISPKhXKErKKEo3YzJGIqhVC1GIjefCPHjaq8Yz7Fu+Yq
         w5YaRPluxCWUHr2ZeXT92NRHdIuxHB/1IqD5TMqXa//Gu4XbFzReZn3G+1N/1CL7UiOG
         U3MXXxb4WoIrqqCP2VXhSH0EFbEyCBKlgBRmguplLTt1VPeZeHbGRelel+yzvoeLXyFO
         F0PcQTOgL3dWI0fhByIf3159q1SUXlJIofHEevFj8PNa1IoCBykZm60uYFcbEE9k6uOt
         8ACOZo6m7Z52Z3rW218ivphJeU4TX/92EpCM90GNOGNkLY98V12UPViRgRcGaBHvSknp
         BNdQ==
X-Gm-Message-State: AOAM5326fZdGX+mgezn75WOE/Zq6s57VUSN/0ml4qbJw2NQF+L/tCKR6
        nO1vItA9ILY4kgsTuFKUzY3+Ew==
X-Google-Smtp-Source: ABdhPJzJSxMOiKtmp2ZXDGAlZTTKX9jGhy1e+IEpOS4JKBgqHVEZdu2Kh8BIG0+AUiKpZkMVWuNIZw==
X-Received: by 2002:a0c:fb07:: with SMTP id c7mr3690951qvp.52.1607010770946;
        Thu, 03 Dec 2020 07:52:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k27sm1686039qkj.79.2020.12.03.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:52:50 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkquX-005Wrn-O4; Thu, 03 Dec 2020 11:52:49 -0400
Date:   Thu, 3 Dec 2020 11:52:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201203155249.GT5487@ziepe.ca>
References: <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
 <20201202162723.GJ5487@ziepe.ca>
 <87a6uwdnfn.fsf@nanos.tec.linutronix.de>
 <20201202205418.GN5487@ziepe.ca>
 <874kl3eu8p.fsf@nanos.tec.linutronix.de>
 <87zh2vd72z.fsf@nanos.tec.linutronix.de>
 <20201203021047.GG3544@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203021047.GG3544@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:10:47AM +0100, Alexandre Belloni wrote:

> IIRC, used in conjunction with rtc_hctosys which also adds
> inconditionnaly 500ms this can ends up with the system time
> being one second away from the wall clock time which NTP will take quite
> some time to remove.

I can't remember the details, but this was not the intention. 

As long as systohc and hctosys exist then the design goal of rtclib
should be to provide sub-second accuracy on the round trip of time
through the RTC.

Otherwise what is the point?

Jason

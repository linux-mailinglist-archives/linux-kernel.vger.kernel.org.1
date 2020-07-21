Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C169C22792E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGUHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgGUHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:06:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C881C061794;
        Tue, 21 Jul 2020 00:06:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so9845682plm.10;
        Tue, 21 Jul 2020 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQAVZqdCDGXaSgKJO4tHAULnO6o8IgHcxHvcFrASXJM=;
        b=o1nHLbnyC76cTBkZ8o02WGza5nv95DmFPmE6Kv/2qtedmnUgrkutnnB7W5dDKaHXn7
         gsbzIzAVg2SXSaHepfx67ZVvQCbn75pEENAb5buco7ZGoXgEH5L+uaTMq8p9PIntP5/9
         Pg6P/Hiz4k3Qe/JUKHeOwPly1AeyA2gPYhUbcMPcW5NNyVVLVCDhq3oomjJkRrujZLKp
         mh2Gj1QxVxhYq9UCMU6FxXhwixv6ANQQ9a+Gqio4OhFPKQesVf1ybjnN32OPj2409y29
         J4TVfgKPj+wYb6uGzT0lf5Mzm8JBN2G0rMVLHhWBAy+UMJem0dyM2AFBb7Hw6qIgVeQF
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQAVZqdCDGXaSgKJO4tHAULnO6o8IgHcxHvcFrASXJM=;
        b=G+ljNrJy3F8DMqLlT6UvxzdOsHSYWxrvP9cYe1udgN5sdBa1c0sfzfaAeCNiBidBPy
         fdfHzDqbMq/7LfUZQge50pWJyj2e5S8dfEtJuF1t3R8vMiBb8oDKxsslUR9/GoyudpL1
         TUSrXczWB5SAAH2FnM06FpHqygfUNmxDLDhwzeuv61iiH2tFZjyMd2D0LyNr9TcWQj2M
         SLc25svcBY8G2Erz9aLYxE3eM6Pmt68uUftruXb/frKXLPxEGc9LKyygTGFTumKzOL9s
         fw1MfScoClfJGkSnusfKWen5Gje7eX7obZR3ECKZ4KIyY1KcStQ8kzkLbF2cdJPEKDbE
         +dbA==
X-Gm-Message-State: AOAM530tD8+qB1ifGZk20qZ9hcIPXej5BkMbzUhkrBarhinc+UE5wLn0
        28KUq9v4dJKQl79trFqGLYY=
X-Google-Smtp-Source: ABdhPJzf3truDWDxS9RbTZomnBgsQrj7q4dk+RFuooF81G1rrHqrSeIGTHAI2483Gk4mGi0I+frPZA==
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr3303694pjb.91.1595315166748;
        Tue, 21 Jul 2020 00:06:06 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id h2sm16144431pfk.93.2020.07.21.00.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:06:05 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:34:40 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] skd: use generic power management
Message-ID: <20200721070440.GA51743@gmail.com>
References: <20200717080910.342741-1-vaibhavgupta40@gmail.com>
 <20200717080910.342741-4-vaibhavgupta40@gmail.com>
 <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720131627.GA447599@gmail.com>
 <CY4PR04MB3751EB3DA357A6856B3337D0E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751EB3DA357A6856B3337D0E7780@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:49:06AM +0000, Damien Le Moal wrote:
> On 2020/07/20 22:18, Vaibhav Gupta wrote:
> > On Mon, Jul 20, 2020 at 12:52:14PM +0000, Damien Le Moal wrote:
> >> On 2020/07/17 17:10, Vaibhav Gupta wrote:
> >>> Change function parameter in both .suspend() and .resume() to
> >>> "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.
> >>>
> >>> Compile-tested only.
> >>
> >> I do not think this belongs into the commit message. This was mentioned in the
> >> cover letter.
> >>
> > The messages in cover letter and commit message are bit similar. But the commit
> > message has patch specific changes mentioned in it.
> 
> My point was about the "compile-tested only" mention in the commit message. That
> should be mentioned in the cover letter only. The goal of the patch review
> process is also to get these patches tested by others if you do not have access
> to the hardware. That is fine, and I can test for the skd driver. But a patch
> mentioning that it is untested cannot be applied, for obvious reasons :)
> 
> So I only requested that you remove the "compiled tested only" note. The commit
> message could be simpler too, see followup comment.
>
Oh okay. Thanks for clarification and pointing this out :) . From now on, I
will put "Compile-tested only." message only in cover letters.

Thanks.
--Vaibhav Gupta
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

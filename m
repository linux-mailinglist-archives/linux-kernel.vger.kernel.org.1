Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B42D196A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLGTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLGTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:25:36 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59631C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:24:56 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so21196026ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IVD1p2kuvVXrBfr0DQp8uX8UYpU8DuPwPA/j+U9iw7o=;
        b=BT+NDgyuc4B9FYRdUmCPvz8gjOkn6+mHA6vCDn6QzeHfUUeVlC9fv9qefVr60Fi4o8
         N+o33ru5BmuDsrganRp9xPYlw9T4COKiKzJVIiibRWtkGYUeWzfA+vwEjIThXkXCM/Ob
         v+IduKCrHlR2/fbICCriKjUrIp3nu1m1Yjdr6Q9zzZw8wQ+/MzIoQ+PIjpI2AHX08tNF
         o79x236sD+eQzaNCTTmeXMydo7bCcfYZv2T91v+5zWh9xA1eXU1ksRhuj/YKDJDQ4LB1
         0EJPtboMkRXu+WFzXkzP01egTvP5VfJha5u1lyfPXyF4vmUc1wpvHu9UBb6KiowaNlCa
         iHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVD1p2kuvVXrBfr0DQp8uX8UYpU8DuPwPA/j+U9iw7o=;
        b=EhBXXRl4UHe/ZLVWj6WE1Nt6kQTw/IeIrj5eTJw3Wxaa03lnSLqfzB2MfraeeUQFXT
         jhgxXXWJpX9weaCdGlxh3TjJ0sxHUmavZeFoWodyYZ8n1GIrDVrhe431POCMnrsx7BNT
         74E5gq1lSxLeLym4jNMOVLH9om+iZHc96+UjoJ/DwGrNJ/sXg01y2Z7pG/o8et/V0qS8
         3ZINPXMyZ/YJwJ7vytN8nOrhO2TiAN/I22PPG3Tosynik//aYdoyhzvgDy1ayG2BGvpf
         n6VZgA5vGFX6Th3kuvPyeo5LKo6i+rv0EyR8Pvrudhamc0mCG+0xmTWamUW/3l/Ci/9J
         Yd7w==
X-Gm-Message-State: AOAM530gSVghdMyIH0gzZ4uEga5z7rsB47TXh2iWX+oEk6p5mNtJrC+U
        hUvALXBwXclwwcGAwOnKgaTyFw==
X-Google-Smtp-Source: ABdhPJz9bYSQy3NHjmWx84lzpD6uTWLsBYmyjEhdoYT4EzGm+iefSEkI4OwWBZ212/zNmk1iIBD9rw==
X-Received: by 2002:a17:906:b08b:: with SMTP id x11mr20225762ejy.302.1607369095020;
        Mon, 07 Dec 2020 11:24:55 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id b17sm13218700eju.76.2020.12.07.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:24:54 -0800 (PST)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Mon, 7 Dec 2020 20:24:53 +0100
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, snitzer@redhat.com, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207192453.vc6clbdhz73hzs7l@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.2020 15:56, Hannes Reinecke wrote:
>On 12/7/20 3:11 PM, Christoph Hellwig wrote:
>>So, I'm really worried about:
>>
>>  a) a good use case.  GC in f2fs or btrfs seem like good use cases, as
>>     does accelating dm-kcopyd.  I agree with Damien that lifting dm-kcopyd
>>     to common code would also be really nice.  I'm not 100% sure it should
>>     be a requirement, but it sure would be nice to have
>>     I don't think just adding an ioctl is enough of a use case for complex
>>     kernel infrastructure.
>>  b) We had a bunch of different attempts at SCSI XCOPY support form IIRC
>>     Martin, Bart and Mikulas.  I think we need to pull them into this
>>     discussion, and make sure whatever we do covers the SCSI needs.
>>
>And we shouldn't forget that the main issue which killed all previous 
>implementations was a missing QoS guarantee.
>It's nice to have simply copy, but if the implementation is _slower_ 
>than doing it by hand from the OS there is very little point in even 
>attempting to do so.
>I can't see any provisions for that in the TPAR, leading me to the 
>assumption that NVMe simple copy will suffer from the same issue.
>
>So if we can't address this I guess this attempt will fail, too.

Good point. We can share some performance data on how Simple Copy scales
in terms of bw / latency and the CPU usage. Do you have anything else in
mind?

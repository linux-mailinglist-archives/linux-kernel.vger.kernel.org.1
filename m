Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC95F1C92BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEGO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgEGO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:57:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D254C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:57:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z2so4657000iol.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b5LGB9U5mr0ssbQpTapfFOTOTVm3j7jCi0JK44bqEyw=;
        b=WrN8B/FhVmqT7+rHqd9W58bKtQYTI02+ycf8FUg/7vrUtF87HaMP/IE6eiI80zAxh6
         sSjLlHhf7rlZkQx8+nTUVrSu+WO+bt7ci87LoHw2F7ZggtxNr+C1WnSFGqN0jL8zEcHC
         qxzkr6SlGFQiPlKTHENPwbr6kj6BLbzBaLdSl0+eynrrA0vKj4ybsgELTISuEnfW42Yv
         dQok9g3ruMJ/rCKZ8pk4s++xxyjTo5Qc/jouz356inWtvxr0sPBd+y7q8U8gREY0yHtR
         i9tDU6K8xUYh8/k9swuBk8t2ji6cxGJgOCx244/tZwrzVKIn/zpxfVxsGi02lUa+sThP
         nBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b5LGB9U5mr0ssbQpTapfFOTOTVm3j7jCi0JK44bqEyw=;
        b=k3QdC9EnJINyHyZBuxPhMOEuBFxNCxw2bQjJcP2hGjZyFBA5DNlVuS8H1+HrJ8peNR
         IUsVNX/QxxCUTyHf/HRILGnhnricnmzu1/NB08O2TG/dg1pS4iYNYwo1XUVOzh0ZTGxM
         eKldHnlarx1QBk500HcUcBFlmLDMS60JAnwM8fM7++wNX3d+XOBNz8Bz21x+WODnQPpc
         JUqt6KO03nCq1j/K0wi3yFOmh7mqevYBeH3UFdLOAYyuVGOM/n9WdKFSO/Ps3rARY4Ug
         l5rL+o+5yj2KDwL88Xn3T7fWP/dIRqhgEkzJ+4fPu/aV+yf5roh9iA2rfhCSt8ZLKba2
         +/8w==
X-Gm-Message-State: AGi0PuZZWHitcQWhK7uf2fnLrmzH3v7dH9PC7lmoU0nI4rC2Utu3QpDl
        d1ahbfxgsxL9Gldx2t+EyQDkriNNS3s=
X-Google-Smtp-Source: APiQypJ2pfnQ5mtWTdwxdgb+WT1d5T3KXYSjVr1M6UMi0PTH+3ibjDMAUvwZW7JwXzLLFSk/FGvg9g==
X-Received: by 2002:a05:6638:155:: with SMTP id y21mr14505534jao.79.1588863459503;
        Thu, 07 May 2020 07:57:39 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r18sm2662960ioj.15.2020.05.07.07.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 07:57:38 -0700 (PDT)
Subject: Re: PING for Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
 (resend)
To:     Christoph Hellwig <hch@lst.de>
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200504124801.2832087-1-hch@lst.de>
 <20200507062743.GA5814@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1753814d-377a-f98e-e670-161b3f17cc43@kernel.dk>
Date:   Thu, 7 May 2020 08:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507062743.GA5814@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 12:27 AM, Christoph Hellwig wrote:
> On Mon, May 04, 2020 at 02:47:52PM +0200, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> can you pick up this series?
> 
> ping?  Especially as 1-4 fix a kernel crash and should probably be
> 5.7 material.

I've added 1-4 for 5.7, and the rest for 5.8.

-- 
Jens Axboe


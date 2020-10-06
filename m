Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3E28448A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgJFEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJFEPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:15:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B27C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 21:15:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so580135pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UZGuShxycYInQqhv5KwPc/O3+tO3i7WXmjI5ivwEdQI=;
        b=NLus8vkaGavoeEmG7ahMWOTifjBST+PXDxa37jPnpuR5hGzpjcZFPcuFrhgQCvA8c4
         y7tFZJwovMcsqi6VH9P98piFTLvmBXGijANAWP8bmNA8osgDSZd4516DKWtIQKsgoUHr
         LQ1v4VUqC69K1ZSV7J30bRJG05pLmVbEYk30v0LsCKQ4A1lAGoG8tYHH0+NddHhGcpPt
         wcm1fDyfIFhBsfHbv5EGOFIZWoti+GiUMWShf6J1aitKeNGm3akXlVE4koZurEZgHguT
         gEjiWh/8Qhtyxzgu+s9Z/8C6sLBidAIh4k8RxM+o828s9cp7CZxA+xlO7w54A53k2NDG
         +iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZGuShxycYInQqhv5KwPc/O3+tO3i7WXmjI5ivwEdQI=;
        b=Nj+QazDdxnBOoHMnvVcuqg6O9hnNXnhMTfA2MZ1rZm/yHX3E3o4f7xG8RdXUDpMjZy
         p0Us6Pt20XVDtLCv1EXtnF61GWHiVOrdXG76DXW2vjv87GvFl/ZWZWXzgBNEl/ieOW3w
         62ZFDaH9jrvYtKPnsiNH+qbVEneuRIsVDaJVHJhnW+T/9NPu5b2S3rMXRL0gNB9f9x5t
         EZyqxKhkrD2gPuwzAMGiRE+SdI+H6ez/PqIT2OndhATSUdP41s+YjN0ZRhxN6+TM9cQ3
         enA/N13dlxtQnT9JKQN4WWCbRy80nlCRNNgTV2ypM6+bR4c3r7SmfCB/GmiBXxjEVjVk
         0XNQ==
X-Gm-Message-State: AOAM531gr8DyPO/mYNYJtEV3wFSKyiEXF8a+J1lzpLFfRP5xkkW+TADn
        /6mZWWysxBrgBV5xOr95omY=
X-Google-Smtp-Source: ABdhPJypJQ9n/Ykh1g87xPta8WbknUV3pehGEaP5DFjZNKOowa5Hc4h0XNe+9GqGM2JpqKlDb82WGQ==
X-Received: by 2002:a17:902:368:b029:d3:8b4e:e54c with SMTP id 95-20020a1709020368b02900d38b4ee54cmr1591463pld.56.1601957698970;
        Mon, 05 Oct 2020 21:14:58 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id g3sm1106187pjl.6.2020.10.05.21.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 21:14:58 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Tue, 6 Oct 2020 12:14:53 +0800
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Elder <elder@linaro.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] staging: greybus: fix warnings about endianness
 detected by sparse
Message-ID: <20201006041453.d7rhdiny33ioaegu@Rk>
References: <20201002233057.74462-1-coiby.xu@gmail.com>
 <CAAs364_NiSJ-mH+v938Mz-qLgDjUsO=7V7FLPo9=Tne63bUxXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAs364_NiSJ-mH+v938Mz-qLgDjUsO=7V7FLPo9=Tne63bUxXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:47:37AM +0530, Vaibhav Agarwal wrote:
>On Sat, Oct 3, 2020 at 5:01 AM Coiby Xu <coiby.xu@gmail.com> wrote:
>>
>> This patch fix the following warnings from sparse,
>>
>> $ make C=2 drivers/staging/greybus/
>> drivers/staging/greybus/audio_module.c:222:25: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_module.c:222:25:    expected restricted __le16 [usertype] data_cport
>> drivers/staging/greybus/audio_module.c:222:25:    got unsigned short [usertype] intf_cport_id
>> drivers/staging/greybus/audio_topology.c:460:40: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:691:41: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:691:41:    expected unsigned int access
>> drivers/staging/greybus/audio_topology.c:691:41:    got restricted __le32 [usertype] access
>> drivers/staging/greybus/audio_topology.c:746:44: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:746:44:    expected unsigned int
>> drivers/staging/greybus/audio_topology.c:746:44:    got restricted __le32
>> drivers/staging/greybus/audio_topology.c:748:52: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:748:52:    expected unsigned int
>> drivers/staging/greybus/audio_topology.c:748:52:    got restricted __le32
>> drivers/staging/greybus/audio_topology.c:802:42: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:805:50: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:805:50:    expected restricted __le32
>> drivers/staging/greybus/audio_topology.c:805:50:    got unsigned int
>> drivers/staging/greybus/audio_topology.c:814:50: warning: restricted __le32 degrades to integer
>> drivers/staging/greybus/audio_topology.c:817:58: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:817:58:    expected restricted __le32
>> drivers/staging/greybus/audio_topology.c:817:58:    got unsigned int
>> drivers/staging/greybus/audio_topology.c:889:25: warning: incorrect type in assignment (different base types)
>> drivers/staging/greybus/audio_topology.c:889:25:    expected unsigned int access
>> drivers/staging/greybus/audio_topology.c:889:25:    got restricted __le32 [usertype] access
>>
>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Reviewed-by: Alex Elder <elder@linaro.org>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>Hi Coiby,
>
>Thanks for sharing the patch. Sorry, I could not reply to the v1 series.
>Now, I have gone through the patches. Looks good (all 3 patches).
>
>Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
>
>--
>Thanks,

Hi Vaibhav,

Thank you for reviewing these patches and giving the credit!

--
Best regards,
Coiby

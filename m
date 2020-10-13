Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F828C7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgJMEHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgJMEHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602562055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JirT+4vZS4Wlh/KjRG5Gnr9Co+Ss0bLSO4bv8e9Yukw=;
        b=AwUnEnewv4OYfvSdmNs7J84zgR8lexaTO+f2t0utztkFRS9oz7SfXe2ALBjmFK2Qo43C4U
        UDAqwVdDqEpJ7iFpXQyJVpQ2f878qL5vDciox5krtZrIRSkuY27LL/A3/l4lcqFqrlkeCb
        l7G6Wfh56dsP4s22pkWoBbqBxliRTXw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-T4f5x0FpPviGJSe0T_GQkA-1; Tue, 13 Oct 2020 00:07:33 -0400
X-MC-Unique: T4f5x0FpPviGJSe0T_GQkA-1
Received: by mail-qk1-f197.google.com with SMTP id n125so14148977qke.19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 21:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JirT+4vZS4Wlh/KjRG5Gnr9Co+Ss0bLSO4bv8e9Yukw=;
        b=DsYJr5KeQtfTEwogU75dpBM+Bis+6hX7UdmV47Cb+Pak6MkfPeOZkePAUwgglQVbM0
         blUwPb5TbD/oOJP5sW9hF7bSu8SgePkQYRb1LxrV3B2KWJd9Iu8Wh5edx/WbXr88B01z
         zruaMlFChF7PDFbEmxTiPmeyoo1lehc4nfmJG5hKlS4gN1VTqptsw6vq5ZhANPBfvLnP
         7159J/yilehJgTuya7zyDQi6GSpR42jr8c2/GlfNCYfAcQXMLBUPisQcIEndkp+R3r9p
         ddGyBl6g7YOpr8H2xnyTaVZkOX6Iil9I+KTeqo9v3b125FFYhukK9pUYDy9p4LntGkex
         PEsA==
X-Gm-Message-State: AOAM530bVmwbrjXgKAT2PW+3dfUGEor8Y9/4xfIuhfFPs5MDOihe6m2r
        6DRSqHSa6KOH1h/KntfksMNTGSmJK2VGbp5LAYKaT0wn4g47BzTnYAxO9OufyafWyFdekUcyBrd
        GX6djeYFW6vo2grXCdErqqEw8
X-Received: by 2002:ac8:31b4:: with SMTP id h49mr13612797qte.258.1602562053508;
        Mon, 12 Oct 2020 21:07:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym1jOUYWeI7Zbb7O6jtxusBRzdyOWNTK23Knln/KjzDTmGZDXeBS3EfPjk5zslnyZ6dHPQ0g==
X-Received: by 2002:ac8:31b4:: with SMTP id h49mr13612782qte.258.1602562053198;
        Mon, 12 Oct 2020 21:07:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm13274100qta.26.2020.10.12.21.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 21:07:32 -0700 (PDT)
Subject: Re: [PATCH] ptp: ptp_clockmatrix: initialize variables
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     natechancellor@gmail.com, ndesaulniers@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20201011200955.29992-1-trix@redhat.com>
 <20201012220126.GB1310@hoboy>
From:   Tom Rix <trix@redhat.com>
Message-ID: <05da63b8-f1f5-9195-d156-0f2e7f3ea116@redhat.com>
Date:   Mon, 12 Oct 2020 21:07:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201012220126.GB1310@hoboy>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/20 3:01 PM, Richard Cochran wrote:
> On Sun, Oct 11, 2020 at 01:09:55PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this representative problem
>>
>> ptp_clockmatrix.c:1852:2: warning: 5th function call argument
>>   is an uninitialized value
>>         snprintf(idtcm->version, sizeof(idtcm->version), "%u.%u.%u",
>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> idtcm_display_version_info() calls several idtcm_read_*'s without
>> checking a return status.
> So why not check the return status?

calling function is a print information only function that returns void.

I do think not adding error handling is worth it.

I could change the return and then the calls if if you like.

Tom

>
> Your patch papers over the issue.
>
> Thanks,
> Richard
>


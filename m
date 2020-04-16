Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1C1ACA03
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395286AbgDPPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395276AbgDPPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:30:09 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584AFC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:30:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id w20so21461512iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgLKTDMc966pLZePK7Gy4v5POGBi54ywnFTq5rJSgzs=;
        b=xig6g/WfEF6trkg+0bcPLBXurHgj5BTteF/0bBs3S1SiPTI9eFkmsiah/l6oXRYuc4
         zkslZZdVvLAWgF0iEVZIyTeaxPgYk0LncDabFx/Kt7CGJC0/Wcztp1H/XH7BCabWb2Li
         +3iteA8k8S4RTWplvYBrO8hJ9kQIVhFywXE3gVg2U9sjyHWhwQTswfZut7DE1JL3jYzF
         okcX8eMj9A7MTPleU1A+uVJD+E8ajXhwpEK/djVcnI5BC9ciULzrr8zoBF6Qi2bWBJLC
         J92SSWGu9sUk3rF/7qe+Hw+ct6OCLF373Xl5/deOMRiBil0k4xNutPCfd0ZT0SBfF5QU
         PT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgLKTDMc966pLZePK7Gy4v5POGBi54ywnFTq5rJSgzs=;
        b=EC5R7zqFD/uoObUahDScOo70RaDSP4ykH7MzNqmQwlPK/xwKA2gj3FwgmnCjrLgsP2
         6iC+Ap175qbHxMcHwuesM6gyBWc6MHX0bCCgQLpx0yHQeQqSokYtTimwtqiLwFJPu7QE
         HV9QyHP5XHFAVFsuBmJGmq6V/4p+NEQ0BgOMAgxbQkNQWkSkvv7hXlTDsQnH22yKjtli
         E4h/jKMvo3JOo3si9vM2nw+NTVPakFYrBT071JfguY+EgrXtRg2hIXejBzAvu+LeY2oC
         /zboMVJ3PIxnrVZ1Ws6B7nIJkVcl1ZOQjaUj74xBPr7zV90DBUZ/78nRl3ln5tJLZ/ET
         swWQ==
X-Gm-Message-State: AGi0PubA62JAuG/EdWZ4gWoySzuRO0t3pxpFA1jkjHpDWBNC21d8ByZc
        yrba+e3qpMml6nwgugq4o6QHaq6qjmbczA==
X-Google-Smtp-Source: APiQypJ3ogc/LftQFKCcQO/enKyIUEms8Z22MlRj0HPuqyykMQA7qtclm9/YE48pZzjgb3iq7VFBJw==
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr2254689iof.55.1587051008389;
        Thu, 16 Apr 2020 08:30:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a19sm5725806ilk.34.2020.04.16.08.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:30:07 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev)
To:     Christoph Hellwig <hch@lst.de>
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416071519.807660-1-hch@lst.de>
 <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
 <20200416152946.GA10845@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca7973dc-3be5-e482-900a-1018a0762b93@kernel.dk>
Date:   Thu, 16 Apr 2020 09:30:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416152946.GA10845@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 9:29 AM, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 09:29:13AM -0600, Jens Axboe wrote:
>> On 4/16/20 1:15 AM, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> the first three patches are my take on the proposal from Yufen Yu
>>> to fix the use after free of the device name of the bdi device.
>>>
>>> The rest is vaguely related cleanups.
>>
>> Applied, thanks.
> 
> Please hold back, we still have a major issues with it.  I will resend
> a fixed version tomorrow.

OK, will do.

-- 
Jens Axboe


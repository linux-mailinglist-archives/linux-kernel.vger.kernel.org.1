Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E431B5122
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 02:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDWAHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 20:07:04 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40823 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:07:04 -0400
Received: by mail-pg1-f182.google.com with SMTP id n16so1942123pgb.7;
        Wed, 22 Apr 2020 17:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XN5Qa+fH8eY+1o/rOoaxua89YSt7GiBoktgAB1yAGQg=;
        b=tuFeyBAQ6Slm4sOREzvskvRHgQ1OA3cAgi4ufkVR4CHRdmbLJe4BZwyiRX83KSFRdx
         n1wybnm28OggCldf4MQLX4XcKMVoiIMmOvQ1B+aJvSr4tX15+hRSU53RkPatk33lbgyw
         umEjC9oMljhHVDAJCqnWxelC3M0l79wc4m0PUGQltA75NExFbeUNmrwasqqcrC2UaL6O
         ZW3XgljV40FteEOCCdxX2pJIE2B2yFsTSBKw+0/Dbuyitnfsi1rK+PlBDnLuqifJ+g/Q
         MbLmtEyXmxrvrgg/635GvsWUwtakZwoqeBKR7wuAKK2vtDuNbH6iEvZN58W7IkQG5KYX
         T2+g==
X-Gm-Message-State: AGi0PuZbWFj8dmBlDZ/SOskrCcIjFBZ7AQVJlOaQsRrZIYWna/F+GM3E
        +hs3xIpHVqiBi69EpkdzKpvAnNACt1A=
X-Google-Smtp-Source: APiQypLIl7HO/VWGaXLuLeu+hduJ2XqK16EKHt6fNxBavCo1mKyvylK3Nye+5JRghFaG6OGmcZfzuA==
X-Received: by 2002:a63:41c2:: with SMTP id o185mr1448747pga.139.1587600423020;
        Wed, 22 Apr 2020 17:07:03 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id x193sm688039pfd.54.2020.04.22.17.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:07:02 -0700 (PDT)
Subject: Re: [PATCH 2/9] bdi: move bdi_dev_name out of line
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ac629ce1-dde6-1d58-f46d-be29366efe34@acm.org>
Date:   Wed, 22 Apr 2020 17:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> bdi_dev_name is not a fast path function, move it out of line.  This
> prepares for using it from modular callers without having to export
> an implementation detail like bdi_unknown_name.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

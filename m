Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47C31B5133
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDWAOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 20:14:02 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:44882 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDWAOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:14:01 -0400
Received: by mail-pg1-f176.google.com with SMTP id q18so1946451pgm.11;
        Wed, 22 Apr 2020 17:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiECgUfb3L986hdiFSUMG4DSOlz+s8HowwcIppxOS1Y=;
        b=qpd7hqhyHzhT/MWqXbZiGC7zahwkXglUMiTpaIPPElsBdfKi4C377bjXFCqCo1crO4
         A89jqm9UfYZJZyPlAzf4UYLx8L8Q03AL/qiAp8ilQbyFnphWciNQhtEl54IHeQuvCthz
         /rQB9tycP2RAa71OYsh6oQseK3gaMDBLbqOhk1vKvUSCU/Q5H7X9L29Ih9tK4lPpzYeH
         19ER5ULb43X5ZB8QDuWxuf+Wq8z18Va5h0/k5fOmk1IUpajORzkjWcCAdVb3rQmy/V+c
         PjlU0qMIKbCYKsyBirWDLR3WzISoyfD4M/zs7T4JZrsp8+os+ck8ZkZjowR49Eq1PKl7
         DjhA==
X-Gm-Message-State: AGi0PuYwSAkdgi3M9xunqjDIZ1BxDXfKPh5osjC4c1asix+d419bQhqJ
        rd31lrt8pfrGOwU0vCQ3rXEaw5zco7I=
X-Google-Smtp-Source: APiQypJWZzzvFjrrCdDEzqaw8UaxJ7kL3gtrEvu704G+YEX8gYmCJGcAe2Ivbtr8hJ3WZByajL31aw==
X-Received: by 2002:aa7:9575:: with SMTP id x21mr1131437pfq.324.1587600840994;
        Wed, 22 Apr 2020 17:14:00 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id i25sm629442pfo.196.2020.04.22.17.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:14:00 -0700 (PDT)
Subject: Re: [PATCH 8/9] bdi: simplify bdi_alloc
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-9-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cf00e509-92c4-f86f-df8f-94909acc47cb@acm.org>
Date:   Wed, 22 Apr 2020 17:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> Merge the _node vs normal version and drop the superflous gfp_t argument.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


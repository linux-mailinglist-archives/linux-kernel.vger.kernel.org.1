Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB628622C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgJGPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJGPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:34:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9644C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:34:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n6so2752306ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ya7VWW85tr07dUTeRZTezqwQZIwntrhwkmNOB9LGjRw=;
        b=y1it3yQwwu+6/Q7iVX+3YIAgjmbQvFbL8X5O/fMg0DJ9tn6j9aI42HIpH/ufPPwLm2
         1C2qBNhTyjnvWbFbI7Xw3//PQSOrZjeMdrhap3y0GY+WMupRqKYYIIP1DZfqajopN9Id
         TQRqpOukGXGpYSkrjNpCgV2ic5YVS1Nu0VNUmxKqczot6ucPPfoEFpP1MBwKxjcMnt1F
         dbDoxMevsRqI6bJ32DsNUwHQRCBhcIyW1MoTPBBOi+pup8ED46YkDA3bMn3RRpgm8oSo
         7Luiqqejczur58QZgL/QJSZUKSQHQNfGjMO0AgzXMdVIqU0CO/dH1nsCVXDC3UMGWaXy
         irNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ya7VWW85tr07dUTeRZTezqwQZIwntrhwkmNOB9LGjRw=;
        b=t4hir3O+1AILPKDYSpCqeDWV5jlDvd0j/IkYPFU+Hk+v4hwg7cv/59IiEdRnbScmFN
         CZt/HZ09XEOs4ZQScGoKflsccbWNPu6nExS5a0IuPHHNOm8DnfQcBRZaLJQLEJoV93Nn
         TQlVKesSftwt8ytU8fEb97tw5ZcAjo7cwpda8qoZVb8CcbD/hewAVfIyVv72OpD0wVub
         iEZpye08kNzkbanAJXMpby/a3vMtGQWcGiP45gJP4dPcnf9Nm4E48wLVEv2nsmPZ0FMI
         2lMSkT8qoDi+U5AmALrRS1mX0FT2zXTUQTT2ec2MTAToNeOhu97h1yNM4Zn0S+Vh9LvW
         3AKQ==
X-Gm-Message-State: AOAM531RzCv/ORQ62dXTdvbkf1hPeFXB8lDaBGMGVUlAwjQDNJTxCwGD
        ZbyWkRktMdtEZ5Y4Z00MTV6aXA==
X-Google-Smtp-Source: ABdhPJyKFvzczFsef+5fwv+Ry0OVFkulUT/UILsWQHUOH/WuZS4OS4UdGvRuqGf2GscMXJAr4Mw3nA==
X-Received: by 2002:a6b:610c:: with SMTP id v12mr2788528iob.101.1602084880944;
        Wed, 07 Oct 2020 08:34:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm1012910iox.31.2020.10.07.08.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 08:34:40 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
References: <20201007031635.65295-1-songmuchun@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3333abd-6e06-60ee-a8f9-7b7c586484f0@kernel.dk>
Date:   Wed, 7 Oct 2020 09:34:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/20 9:16 PM, Muchun Song wrote:
> We should make sure that async workqueue is canceled on exit, but on
> some corner case, we found that the async workqueue is not canceled
> on exit in the linux-5.4. So we started an in-depth investigation.
> Fortunately, we finally found the problem. The commit:
> 
>   1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
> 
> did not completely solve this problem. This patch series to solve this
> problem completely. And there's no upstream variant of this commit, so
> this patch series is just fix the linux-5.4.y stable branch.

Thanks, I'll review/test these and pass them on if good.

-- 
Jens Axboe


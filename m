Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C902FDFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbhAUCj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404041AbhATXxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:53:23 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58DDC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:52:38 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d13so560784ioy.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 15:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BQ+C6cxMr+NFXAiwMQZbpz+U43nbXJpB0nxvOmHbDDk=;
        b=GBSSYqKse4GktCQQv1dhwdvucvIBHv6a/8vYcZZzt8CglYaJuMkWvupsAJ2XJDpCRX
         sBWqCBvysBMQEml1P36301Da/reVbbo3/GOvU0v0FYphlDUpsy3UvS4H78YcWJLmbkmu
         E1xXCOfh1iCVA0orsq5z+fa5LtZnuv+0AIF5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BQ+C6cxMr+NFXAiwMQZbpz+U43nbXJpB0nxvOmHbDDk=;
        b=g8RagtQ2304XwYrVrgWka4hmem9mN/Pe80CnaEAEM1+ncMV/Xah5zWONelaZkJnJnx
         eMLYGgO3XBxxZisvEdsqebZ63/c0Yfz3c7TeC7a9o805qgj8s0Lr2WgMEI/ZvrQyTEaH
         Bh4Qp/dg0SQSe/nTfBg+6hqy9bT1rgcEixzppD+7s/nFblagKeCEe5H2cq1V6JV4ZoOo
         jvxJkG8k1Jv6D/Ki9swg3jI+egtaW/NsOOb1RcpAyxTLEjSSuAiRvvn45z9sPwTACmK6
         FWm0y9NTIb92ui3/xd/zAvEC46t/6sk3+uSesjpaGC/bouNyohc7fmJKbzVRV4JTDdxe
         425w==
X-Gm-Message-State: AOAM5335Ud2emKOD2p4hQEGVFeYfOZwdKXP2/xFmsDcIcWFScurSnLMf
        1V8UB4lF+bLte7SN7ase4/qu9V+PQD9wNw==
X-Google-Smtp-Source: ABdhPJyIFhoU6bCVbtrka/8a6fUyKb0QF3oP0zoYmAU7UKS8RIO3TiE/RmGDIOcZPkwKTc1P34hU4Q==
X-Received: by 2002:a6b:7f45:: with SMTP id m5mr8559311ioq.180.1611186757822;
        Wed, 20 Jan 2021 15:52:37 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a5sm1819555ilq.60.2021.01.20.15.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 15:52:37 -0800 (PST)
To:     Anna.Schumaker@netapp.com, trond.myklebust@hammerspace.com
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, chuck.lever@oracle.com,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        linux-nfs@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rpc_xprt_debugfs_register() - atomic_inc_return() usage
Message-ID: <06c8f6ff-f821-e909-d40c-9de98657729f@linuxfoundation.org>
Date:   Wed, 20 Jan 2021 16:52:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anna and Trond,

I came across the following while reviewing atomic_inc_return() usages
that cast return value to unsigned

rpc_xprt_debugfs_register()'s atomic_inc_return() usage looks a bit odd.

- cur_id isn't initialized
- id = (unsigned int)atomic_inc_return(&cur_id);

Please note that id is int. Is it expected that cur_id could overflow?
Is there a maximum limit for this value?

thanks,
-- Shuah


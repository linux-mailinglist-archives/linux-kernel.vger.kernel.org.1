Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976CD2AC33B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgKISIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgKISIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:08:46 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD6BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:08:46 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y9so2051620ilb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j47aCS29776hDsXzBL5Yato2CFnib/+OBUg4G/BADhg=;
        b=OaLO5QPX4GFQhPXneAkdIQLvlkZ6S/SqSMH5aC6AKlbOb8oEh23O047VONbDWDo4vm
         7DaanMHctyjub7jt3JnIUY0m7MXYHx13U+Zj4cUn4qyMR7YBqBCBV9tsoSMMdShUFvTZ
         UpzIPsvJjjQwsArjfnOitmP3EPzpzHZXPq2+WLzE1xJnC5OngZ0pE9LU0OXtv7ahXLxT
         yrFq6DFO+zOj3C64NqKYprcDi9vNOS6bveANJsfX7TZETmko76lP/O/eWPHukDo+IAIA
         PutdVIfcTKYzGdGKWN5KQJflVlB5VheL7tvr1MMWx3KM6xPK65H1+agvbjBgjm2JtP4S
         AzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j47aCS29776hDsXzBL5Yato2CFnib/+OBUg4G/BADhg=;
        b=Yn4L+IaoEffsaTyLFj+dH1vKCijQwbgIfyvl1zmfJJc7tdqDYuuy0ZIKAP/XKHEr9B
         kExPVatjq0fcVYJNUIR0AGv3K8n5qCAmkr7mzH5OCJ2tfekwtjKKCRihGShPEGfrDxfR
         zEbFgIjwP4RNt9etWtCcS6dzWJlY6/Sfi4ecNIsfQqLasr7miitPVfABnwLllfq4A796
         wgSRUKYjm7Q/HUhU9Hay+jpobOzZNurZ9L1JrO9vy+ddo9fMY1dQlwOQ5bwuNayv0+dU
         k5nWmUeKLcsK6LCWvS8NSFwXR5YTFPsHygygNso7CFUsBUjTJzhoroXEMILHYCIJkDg7
         h/2g==
X-Gm-Message-State: AOAM533nRxl0tSSca62lvNma8C30nBm1xU47CVN/Tjtkod9YHPgodvzz
        BI21JD6BO9ZZ4wIqIFkUgKb0sQ==
X-Google-Smtp-Source: ABdhPJy5w6MmOQcsBjeteqExZt3kI6+IfQSGLHX68AfxXahU++pOfbmyfo3sEuMDpf2Vc0iZr5zK9g==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr11449523ilh.271.1604945325477;
        Mon, 09 Nov 2020 10:08:45 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a13sm4036704ilh.0.2020.11.09.10.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:08:44 -0800 (PST)
Subject: Re: KASAN: slab-out-of-bounds Read in io_uring_show_cred
To:     syzbot <syzbot+46061b9b42fecc6e7d6d@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000028115c05b3b06bbd@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3f69180-187b-6801-b74c-a22231323049@kernel.dk>
Date:   Mon, 9 Nov 2020 11:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000028115c05b3b06bbd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: general protection fault in io_uring_show_cred

-- 
Jens Axboe


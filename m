Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE62A288C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbgJIPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbgJIPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:06:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B946C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:06:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w21so7105280pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A4XLS9Sjb0ikJRP/ak6wlSN7JYLZDRt38oqZQ2jJOjA=;
        b=ZQ9oaMITG9omPFizmclPGoPCPuXbLk2d/ORRMFXeNE0/QT6egL2gMaCM4LeFjX8Zww
         lDMpImKE0EfQ5JsVDFcbn7ANWtSNGI+OvjKcqDgI3wl1WrewhTysMD65Mx9cyBRlSrh6
         bYq6VsNL3hF8Y2HAMLca3xgkkpZqIRv9Xyyj6hvtoOP/gd/VBull1kxw+haEkag1u8Z7
         rt3zteJuytSg7APNPVIRYgBYqpnZ2cJi3eEwjX/mHaYedJfW/9vrk7nFLVhv72If39jS
         Isd2PFli6inxukMCaR9YKJzg//S6dEycwkER8H8dUnW8coPYCyR+ByKPycNLCWe5k14j
         E4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4XLS9Sjb0ikJRP/ak6wlSN7JYLZDRt38oqZQ2jJOjA=;
        b=SSgP7LQoHUwFQKJIw2o1z7VuiYx5rE6/znSmVNXV4Xurdv72us0dOkOSPtR0UzvpY8
         +r84S9rRM8auEayl7sgny2WRcB4EiGOVvYGLY+KQZsA5V6I/Wit0AlwUQ44L2E9fpYJk
         wdx5SJUNQPnpnp/hju76zkkg+eTDC0yfB4NZnfArNg9Dq/fiSi5HP7md1fdr3pnFvYYZ
         uH2pwyx4Jx3Qxl3Y5/CrSfhiuuroeqgStku+eUvXoMOjfPYJL/gHmgepVEQOQlEZZq2Q
         NUW5ChqJcIUzDW+J3DrDjAmuKoe8rNuB4T5BQtSunD1ePi2Fi+cePXhWW/nKkPAsCbVt
         R9nA==
X-Gm-Message-State: AOAM533w42CMnoMTWieZzMy36JyNn7KZ+LowW5YFl55Tyc6Kq5ZIn78q
        YW7GCxKTUVJuMKCY9ELYeLkd3OcR8zCvBDDo
X-Google-Smtp-Source: ABdhPJzGUj5KeKjBc2Qgt2BN1KwvpMRzspLOSifYIVUG7Bw8O2BUe8bxhTK94Ag06rFZrDfGNRgVTw==
X-Received: by 2002:a62:dd02:0:b029:142:2501:398c with SMTP id w2-20020a62dd020000b02901422501398cmr12263183pff.81.1602255963045;
        Fri, 09 Oct 2020 08:06:03 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v3sm12779295pjk.23.2020.10.09.08.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:06:02 -0700 (PDT)
Subject: Re: inconsistent lock state in io_uring_add_task_file
To:     syzbot <syzbot+27c12725d8ff0bfe1a13@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000358ba805b1385785@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d16d920c-b617-1586-5781-a4a79a80d9ad@kernel.dk>
Date:   Fri, 9 Oct 2020 09:06:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000358ba805b1385785@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: io_uring: no need to call xa_destroy() on empty xarray

-- 
Jens Axboe


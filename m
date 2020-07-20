Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C048226A78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbgGTQe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbgGTQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:34:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508C0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:34:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so13835833ili.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FNFbiBPENBEfe71XEJ6gFCWMcE5oolIikIpymSXLtU8=;
        b=ymSphsWOGHRzYUqQryxfK6qsfrnfujA5wee3Do2OlMVkDKr0Gp5K3Y38NOoKGre2GR
         O1ajgs627gAJuTjFk+29V6vz9GtS1aGP33HNVJTZZeMYNhSOzoecUXvrRrVUGgRiVntF
         HimAl7avf1aE8KrJcJv9Q/5M6VbjdMoiigl6Lu0Xx+fGsClPF8ycOP9KoOC3mGHFlXUt
         X/5UAvigI8KnzOSKq4s6EpQ0fmO9/Tj+3Sr32irPtVPRy+By0RG4h9a8xkHIx3GE7VV6
         4EAOcZAlOycxB+PZm0VsCikFb0OInGLzplxcj8yVySgNRXLBLqplmzWZUduyqc1BrWWy
         RdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FNFbiBPENBEfe71XEJ6gFCWMcE5oolIikIpymSXLtU8=;
        b=DM4o98M7h5hnslB7cJ42DeopwoTYZIH2tykLLiuoSvmcoHWJiQZYGWjCKDLYAF4nVv
         F5tV4FPOvZQpqQfaZx1fA88UNM5s9FgnQZP3O5Qj187Lkge0ledFi/js+VOMtGraC1LS
         7TlxhrtpEYsfCCYIWt6mt/IJNQ/lqxo/4Iy2sboY0X+Qd606b80hbSa1uhzKaJQ3dhtb
         lr4sQaU1rz9O7clJvc6JewpXsEU7lVmUOsTcCkC8nNERRKhhNrgzA4/114suL+fjgeKR
         ZF50bTxRmLnkyb8qCHGTsIr/YimoM1y9f2Koj1i1LdDGL3jVLGblriz5W1WctvGFMioc
         Stqw==
X-Gm-Message-State: AOAM531NGtlzsfNuWnXDw85EreTS8SJ3NpBfUkfug6hRhnSA8hMvJiCA
        5vxFSiYPCwxNbfT/ezAuJObmMA==
X-Google-Smtp-Source: ABdhPJyLSJytAUyvX8Jkdr+jZtHT7F9J3vtjWOjjFtSrZozAtQghAhoiEHYrlZwSGDKekTH3AuDhGw==
X-Received: by 2002:a92:8982:: with SMTP id w2mr24108525ilk.163.1595262852660;
        Mon, 20 Jul 2020 09:34:12 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n1sm9046568ilo.68.2020.07.20.09.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:34:12 -0700 (PDT)
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage
To:     Dmitry Monakhov <dmonakhov@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
References: <20200702105751.20482-1-dmonakhov@gmail.com>
 <429E50C6-83BA-4A3F-BE9C-06C7C762AF33@linaro.org>
 <87k0zdrj7s.fsf@dmws.yandex.net>
 <545F1ABF-B2B2-4523-9259-D3F93A9BB330@linaro.org>
 <87h7uhqewn.fsf@dmws.yandex.net>
 <22087F19-BC93-447E-848A-109392E0622D@linaro.org>
 <87tuy2ml9j.fsf@dmws.yandex.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4561a09-f00f-568b-9d55-0a2893de4be5@kernel.dk>
Date:   Mon, 20 Jul 2020 10:34:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuy2ml9j.fsf@dmws.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 6:19 AM, Dmitry Monakhov wrote:
> Ok you right, we should drop the group reference inside
> __bfq_bfqd_reset_in_service() as we do for queue's entities. Please
> see updated patch version.

Can you please send that out as a proper v2?

-- 
Jens Axboe


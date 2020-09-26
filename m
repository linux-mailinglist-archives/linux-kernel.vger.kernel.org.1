Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E42798CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgIZMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgIZMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:22:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ECEC0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 05:22:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 7so4614732pgm.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=yWd0yq3YHHskIvoMRtbQ+LLAOZIcKE988hjYIBBtj5ujteIZQBkaNMz/0OsbdtRcmO
         pN2KizU1b2bryab8cf67QfV69YIxkuEMPMh1TUzgn775BqS3W6LZpB1x+9CZMhjYk4W6
         sPSAKx0/iOQ7ofh7377FEjBJL68tXAjnbiNFHE5DgoIklvA5Swpw7LkkVMhEWhM0K+bg
         ylTt8IJ58qrBp/cC2SpkhTmQ3IGS9l1Si2eUUhIZBThh+EP2DAyRCw0p83NiPO8mwh1Q
         zd6Xp1j7KSjHLY5hJ4OVqE02X063t0JvqAZ/GayAyMT70nvUeP3miTr/s+OUyw/sjEmR
         AVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F34DFOadLWUrYUexx9pZf+zYffic8Ay3o02O0h/KIN0=;
        b=gbAC8+VQJyaJK5jN7Y4o/iM+i1sTlL4j+jf2QXXaYyg9OrCTBRg6F8m2sVRfBibaPj
         MclG3AVyWjhS/kR2M2cxMBigYuwp4MVH7t++k3ZQyajGW6eXkn6xbB87B6dw8VSnFXNC
         FBQZ88v5sGzHTZuK1YeJ9c3EXPvvIRFaMt7fwEn0uJ7fS4xxRP2k/61zLQODnGEzRVpX
         MzArmkKzio+tL+Y2K1BYioN5wYO2X2TWUbqA+pS9sfYhuY+iX453hstY8d46ui+4xtgR
         rPDeqM7+18WqD8oYe4xU+6+UdbEb3b+h+Qot0LZ88OrylkvDUaJ7armQFxsgYAaUmQhv
         8llg==
X-Gm-Message-State: AOAM531nKe6qIAXnfA5mirFgQr3hJXAT6yNZNFZxOmfWoHkFETjzrVZI
        wDe7bUhjMKCRSSKWaZurAWSvrQ==
X-Google-Smtp-Source: ABdhPJyqyDXGRY3HHGNq4L/5hAyvnwhoGU6nwNkDk05eIVRflSVQyikoXVsN792SpquRU5XtVXDy/w==
X-Received: by 2002:aa7:8051:0:b029:13e:d13d:a04e with SMTP id y17-20020aa780510000b029013ed13da04emr3413139pfm.20.1601122963787;
        Sat, 26 Sep 2020 05:22:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a18sm4682471pgw.50.2020.09.26.05.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 05:22:43 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in io_wqe_worker
To:     syzbot <syzbot+9af99580130003da82b1@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000007e88ec05b0354fdd@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa342b42-8bbc-059d-46bf-0ee694c3f67d@kernel.dk>
Date:   Sat, 26 Sep 2020 06:22:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000007e88ec05b0354fdd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.dk/linux-block io_uring-5.9

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51B3018EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbhAWXeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhAWXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:34:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A3C061786
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:33:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so5368006plh.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cZSjZ1gWlL041uFW/1i9ltjoZrL1VhC51p2h42FCoWs=;
        b=wqjRxvWDXSOXa4u0cPIKuxpGfZnfoQofsTeIqY3GBU3H20Ouu06BeGsM/cUKieNeg+
         LmxH2PDFQ0RMulHva9w0puXRGhqdfiQbPMxDcAJcwT8xI4hn/LuKbj3nGY1OyBrT/och
         H5vyKm1MOOKlNMexECHrbIyP8UwWKyR3Qd8gc9+4SRx3pWsajahJfFtCudvpdGbuOgAn
         5VM7Amj/PB0dYZdOeq3YMz4sXMC4EGAVl5j3sU0NNHYS8VTW7nDBn1POObze1A2CYn5b
         sHvOuOsslvu7UM4VQUJIIJIza2CHijCDSYZcpLwNtiQNapmf9898J/hcIGJ/iVvkNLAl
         rtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cZSjZ1gWlL041uFW/1i9ltjoZrL1VhC51p2h42FCoWs=;
        b=TPMitNURCPRwCLlAWBeNKgsEhKCCjaWt1JuMzORVlNR/bXhiOeqisojr8oAms24QD9
         HEljUja7VrIwF3sbI3o9waOJj3XFVm0YB5Ddva6WMNw6s4y7Qx17/0eKsDNNCrjYva9C
         m2DYUnZpb8OheLZ5XORuHR6p5n80987n3U6tlbK5QswshQdU8SGlCdYV4SYyH72yanZP
         bzxngmERMomwaf1BrStiXaphh36vv3D+wlN7qw1wxQlLB+09SJjWf2NgPej6qH1l0mBI
         Ru5j+V1z6HItk2QEIzfhCsT5Qclx1ZBeukgKSz/h5ppAkUVbPcEyu0GjWnhHOTy8F+SP
         GFRA==
X-Gm-Message-State: AOAM531br56UNrw3cTpnP1qeej2LKqgj32e1PEsbQiCR4jhjQ5YCyrSf
        Q/PwbpxIN20SoUrRDGss7OABHg==
X-Google-Smtp-Source: ABdhPJwCuduVl6ChCtvQUWbdWIg0nuNpqd3VITA6h3x1iChRUwtmEe3RTcsP2YLvfEf1S86o06nw3A==
X-Received: by 2002:a17:90a:5911:: with SMTP id k17mr13620918pji.152.1611444817711;
        Sat, 23 Jan 2021 15:33:37 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id g22sm9010746pfu.200.2021.01.23.15.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 15:33:37 -0800 (PST)
Subject: Re: [RFC PATCH] io_uring: add support for IORING_OP_GETDENTS64
To:     Matthew Wilcox <willy@infradead.org>,
        Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210123114152.GA120281@wantstofly.org>
 <20210123232754.GA308988@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39a9b1da-bbcc-daa0-12e9-3eb776658564@kernel.dk>
Date:   Sat, 23 Jan 2021 16:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123232754.GA308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 4:27 PM, Matthew Wilcox wrote:
> On Sat, Jan 23, 2021 at 01:41:52PM +0200, Lennert Buytenhek wrote:
>> IORING_OP_GETDENTS64 behaves like getdents64(2) and takes the same
> 
> Could we drop the '64'?  We don't, for example, have IOURING_OP_FADVISE64
> even though that's the name of the syscall.

Agreed, only case we do mimic the names are for things like
IORING_OP_OPENAT2 where it does carry meaning. For this one, it should
just be IORING_OP_GETDENTS.

-- 
Jens Axboe


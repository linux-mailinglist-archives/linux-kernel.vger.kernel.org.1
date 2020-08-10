Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED12411F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHJUyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:54:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:54:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h22so8389295otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gJ5Ifo9W+baBISOLBMEfsvj/GFxqg72b+nHkl5xjrC8=;
        b=RMHtZPwgQw7bUNKOsJdHaFVguO6zz6Zxv4freNKCfxNTJ5pVLlNUnZ54AKnsyBzCBV
         bemCZLn7auoKtGxttUUzhCY/Zlhm8dPgL/iKNJ6+R35Us34VVKdwrazswXXhViXLsrT1
         gwviorivkbSvJGE70i+HEWCOSR4OaMF3jo+TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gJ5Ifo9W+baBISOLBMEfsvj/GFxqg72b+nHkl5xjrC8=;
        b=dLOLqjB0gQ8hf2WXRJ084DFkVqeBbeWYoIe2tE0eeT6VXm+4u1oWI42bopN10Cg+TM
         FuF+aIs46IYo1SQTP0FS13zfgGVMUL5rtfMM0e43kpUZSBiUAvNT8SHzfLbQ0GKTcJhC
         oySMd09Qd90BV3DtvwnGTsKgiJINXCqmHD176klnXjQSFODGd/Z+v/wtfkIPSHSDoc0A
         /xFUJS1l0P7ZgpsoKs/Zy4UOJm93qH3xKNQ8f77I4Sy1aSYcCWsucUax1VaI+dsvDkbX
         Yx8RFHX0VZux5nWuknhD622CVIzg4wMvihEnJxiysFXD6JUhp1c8kHbYGw8y4EbBw1Q1
         zWdw==
X-Gm-Message-State: AOAM531KhsfKL8M7dnsyeo+e691Br7ysPY9tfVIBvY1FZIoo+WZeMYTQ
        9bpIk5GTGbaKTvEb/nylOIxu6PKikvs=
X-Google-Smtp-Source: ABdhPJxJ4ojzYQX6InHDcDzmiiNyt20mTG9ve8m1VMTn2N550HzrEDcNdqFfN2ZrhFNY/Ax8sL9Hjw==
X-Received: by 2002:a9d:6d08:: with SMTP id o8mr2197292otp.257.1597092871383;
        Mon, 10 Aug 2020 13:54:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d19sm3853895otl.63.2020.08.10.13.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:54:30 -0700 (PDT)
To:     Sasha Levin <alexander.levin@microsoft.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Please pick this kunit fix for stables (5.8 & 5.7)
Message-ID: <59f75dc7-3fe4-d61f-4cf1-4b922f596818@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 14:54:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

Please pick the following commit for stables Linux 5.8 and 5.7

kunit: capture stderr on all make subprocess calls

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a9fcad71caa970f30aef99134a1cd19bc4b8eea

thanks,
-- Shuah

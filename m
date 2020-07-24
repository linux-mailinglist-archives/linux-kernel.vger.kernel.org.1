Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6063C22D258
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 01:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGXXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 19:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:43:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:43:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q3so8580357ilt.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1fir2Ti2vt4whQ7PfuONH4brXyBlFuZOiejdcjiZKP0=;
        b=TPrVIO1v++AChz4Bqi+RZcJGPZjnLyuwOFy5wr7UXmIl6+8cixWsmtRvpbClRNRyqF
         /dD3PyhMQemSRiMGdb7vCZRr7PkkVFypzKaDJ7lNgKmQOTQGEBpKDup9+nrpekm9AosR
         8c0ZmZg02o/3hhCf8AGCaWXK42gF/2hqYczHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fir2Ti2vt4whQ7PfuONH4brXyBlFuZOiejdcjiZKP0=;
        b=mnXeBpBJNJ3Y5/cxTpp9kU046DaoWmsYLo8xcuafSpS7ISEQdD0cf2w6p0I2qgY9s7
         /uC6SSdOIj7XXuHdWvJItgz8G8HYZI1im4VpSqjzgcnLs17jKrgyxct55b22tC6WY4hz
         oDzrtx68/Z2N/PFS5eh1HvHkYqIBW6CE69c5ZtQwUSnqIdb5/MJaQla47rRJ4Od41mXJ
         Xkr8N3TbxW+y/vycmM2be6SUshNZDybKlRncpFWXLdrcCa9JWvJ2POEJwZ+2a4Yhofac
         Wqb3DyFd1IF2pgxR2Af+oMFaH4zBpzLX3Vy+z2feSY84n9myaO0t6KD80xj4fgNokcVS
         bbIw==
X-Gm-Message-State: AOAM5310KsfWlRQ/97nqE7cBtE8QC/o7PsoIgcEa2wpYeGxIK2S/XKH9
        ndPqVZsEdgg7qLWr+WEYcQz1Mw==
X-Google-Smtp-Source: ABdhPJwjWL78P+pBkbmROVcLBBLCbM5S7VGXisEEDMSKQJdGuhaMmSnHQaEqYio2dRLZciYoWMe4PA==
X-Received: by 2002:a05:6e02:e89:: with SMTP id t9mr9076460ilj.292.1595634236821;
        Fri, 24 Jul 2020 16:43:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l17sm3924984ilm.70.2020.07.24.16.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 16:43:56 -0700 (PDT)
Subject: Re: [RFC, WIP, v7 0/4] media: vidtv: implement a virtual DVB driver
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        mchehab+huawei@kernel.org, sean@mess.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de
Cc:     linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200608191333.1784963-1-dwlsalmeida@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1cd01ac5-55f7-68f5-791b-ae4955d916d7@linuxfoundation.org>
Date:   Fri, 24 Jul 2020 17:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200608191333.1784963-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 6/8/20 1:13 PM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> This series is work in progress. It represents the current work done on a
> virtual DVB driver for the Linux media subsystem. I am new to the media
> subsystem and to kernel development in general.
> 
> This driver aims to:
> 	- Serve as template for new DVB driver writers
> 	- Help userspace application writers in general
> 	- Push fake audio/video to userspace for testing
> 		purposes
> 	- Push debug information to userspace via debugfs
> The Virtual Digital TV Driver (vidtv)

Any feedback on this patch series for Daniel. He has been waiting for
reviews and feedback from media developers for a while now.

Please review the patches and give him feedback and help him with
next steps.

thanks,
-- Shuah

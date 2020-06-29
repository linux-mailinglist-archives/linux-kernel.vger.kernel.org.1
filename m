Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF90520DE06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgF2UVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbgF2UVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:21:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4204C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y2so18617992ioy.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xe0Kngev5V0/2bx10GzAMBFnMV/HG+Kp7x1mqRPLtn8=;
        b=Qe0B4hN6JKmXDAhczq2oH+LohHCdr7IKU3Oc+5OvaVsLeMY/Gfq8E693dAwZeXvtYB
         9UxlCIgHPxx8vAzPeOflNYyNQnfyo3uUyg2WSWgfB+HBYIdbc6DtlTd1wL737VZ5e3BK
         IrlSrC/99WWot+aPQgwRMpRDEuf+8IY0FSfYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xe0Kngev5V0/2bx10GzAMBFnMV/HG+Kp7x1mqRPLtn8=;
        b=FPMZyjNA0JcX27Hy3DmDftOQ2cn7m5Wyv/Zr+U1SI7pyME3uM/gbEXHmOpqeh65Tbs
         7thjPpeyOQWTd8dWW9CJnog+r0c5oC8ylbF4hDbWAF32B6cw9QHXEkeYuJhx2BTq2NJa
         9RIjTtsCHMe3LlcxNDySPdyD8kzq76AtI+AFQJqaLDKSQkuVqIPHcXaU4Q5fFoAh6wzN
         DiwQiQBEsvLIe19RRv8P0R//8bvR92anTPvC2kj7n3lMybhzXo5Uug6hUKo7UeSLSse5
         ZGy9wYT56LHXAKXx6SoiHSq1TqcBYqWUpPRS+zqxVJS5+VEL7J7AUP+tEl9kgkTwnGuN
         r6SA==
X-Gm-Message-State: AOAM533fluZqXRFB0l7EBe+IgqDtitVMkNVUqYQtZz2lyc9sB5tdcL7B
        WIpPsE+bKAVzFgKJVkN9I5Nc2Q==
X-Google-Smtp-Source: ABdhPJx8iE1nRfHXfDv7Z/LjcCPE31AEKBsPiln2NpPL29NMT2q2L7llun+8++o8/dahYOJ1YsK5Mg==
X-Received: by 2002:a02:1a06:: with SMTP id 6mr20182590jai.8.1593462109366;
        Mon, 29 Jun 2020 13:21:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c9sm471009ilm.57.2020.06.29.13.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 13:21:48 -0700 (PDT)
Subject: Re: [PATCH 0/3] selftests: tpm: fixes
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     pengfei.xu@intel.com, Joey Pabalinas <joeypabalinas@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ddf50129-5fe0-ab84-1bae-90a06ba017a3@linuxfoundation.org>
Date:   Mon, 29 Jun 2020 14:21:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622212034.20624-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 3:20 PM, Jarkko Sakkinen wrote:
> A few fixes for tools/testing/selftests/tpm.
> 
> Jarkko Sakkinen (3):
>    Revert "tpm: selftest: cleanup after unseal with wrong auth/policy
>      test"
>    selftests: tpm: Use 'test -e' instead of 'test -f'
>    selftests: tpm: Use /bin/sh instead of /bin/bash
> 
>   tools/testing/selftests/tpm2/test_smoke.sh | 9 ++-------
>   tools/testing/selftests/tpm2/test_space.sh | 4 ++--
>   2 files changed, 4 insertions(+), 9 deletions(-)
> 

Applied to linux-kselftest fixes for Linux 5.8-rc4

thanks,
-- Shuah

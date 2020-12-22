Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541C2E043C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLVCFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLVCFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:05:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD4C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:05:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w1so645560pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BjqP2DWMzUgVSuoBJUlFTOQoE6yKTPo48L3QchtjvGY=;
        b=FllSVdllnmuF7BkcPxpDztCU09IJNw8v0WbJN7gP+0L46GkBR9DmWxvyrQE+eQyhHN
         qRAHjdRdaT1+IVfB8wmlA/4BZ1unmNARTAL18i8EdbzhDZ9CvKEWqBXVNa5bh4cECpP5
         PvHvFIg1GMtq4jPrKbpbKe4Fdkm7l97U6r6O+24xy+jN/wE1hjW6i5E8oDQShBRsUqXg
         64PYpAfK9877iLBrCHJgvQXwI9i99rC+9fq1oi881dXDCqKc/hhV1tGjh0dmM7XyN58f
         siC4T8KqswTOS7yDSPG5npWMbyp9SOT6l8jfyLBOybvWkd6KEXdlyADxEXBdWq/Yttnk
         GcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjqP2DWMzUgVSuoBJUlFTOQoE6yKTPo48L3QchtjvGY=;
        b=FhMiKldKsvGNUVB/j6rkhkTWHxddZ8pcr0/GJ/p1Vdvy+jQ2VuYpki+hGtjxpiM+Rz
         ycCyGIpCf2XaEJyq3dnXjjhxMd6clN+L1p+Is15qbucfFdP/BuvTb3C1WDGqtArOtLN+
         ol+Uf2WRq58kZWv5W9ch5ekqU00j2SAEEkTxu5wjpSvaAQR29/iq2Fe2TCoixS/F3oxS
         IH34StTu+GCjpE42FCdLac/a4uw5VchXgY20sj2Gx+Unjx9DYjg7d2bI2tPa6RoTAqKq
         iy8v6Yt91BuPSAEGTRgdQkkaI0wf7XunJ3jwI1wBzXEmLCU/C4HMMvENYF8Qa05W1K3m
         yVBQ==
X-Gm-Message-State: AOAM532H+VM9Y0ziWuLdKoGNUQdAvAqoN4wPlMi9JIuSKd6kQP/b5RqR
        xzwG3faI32HiWvGDo6mJWGW3N02lfCak1g==
X-Google-Smtp-Source: ABdhPJznY1ha1OFR7/m/5ybjAlNrIP/LyKhWd6iBeuUozlVL7tx1JQmei4BDY/Z7S9gJ0ryzVmTaJQ==
X-Received: by 2002:a17:90a:1782:: with SMTP id q2mr19688250pja.189.1608602704017;
        Mon, 21 Dec 2020 18:05:04 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k125sm14833904pga.57.2020.12.21.18.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 18:05:03 -0800 (PST)
Subject: Re: [PATCH] Smack: Handle io_uring kernel thread privileges.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <dacfb329-de66-d0cf-dcf9-f030ea1370de.ref@schaufler-ca.com>
 <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b76a1405-10ae-b8ef-2f08-f84d5cd66fb9@kernel.dk>
Date:   Mon, 21 Dec 2020 19:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 6:12 PM, Casey Schaufler wrote:
> Smack assumes that kernel threads are privileged for smackfs
> operations. This was necessary because the credential of the
> kernel thread was not related to a user operation. With io_uring
> the credential does reflect a user's rights and can be used.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


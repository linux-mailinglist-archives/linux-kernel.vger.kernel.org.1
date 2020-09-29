Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4827CF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgI2Nje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgI2NjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:39:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B4AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so4557224pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0b0l8ZUG3zwXWMxWGQR/zxHkfGwj6nS7mjqC10ksX4g=;
        b=fsG52lO+3Ej3Fej/RMLsGa8ytZSz2un10lwsZjlazPSe9cOsSJJ/ucPvOM6RC4cud/
         mWwbPOSMxV3O8oivM4J4Z8QAfFfe6hWF90oPluVDZVeyXHrnCXR20nYTbPEUUY24Sslr
         W5ZeELra4wcZtNLo9SNgHC8ExdGtelocjgPgg+pGAa/O4Ex3dSbfGo85uI3osUgYzCzc
         WTaf4V7+dhflVxq5y4neiLJcxkrGkT+Ig2Igokh4k+lZyIVeuxZeNvNjMAcS5ov7s0Mg
         5PBIakqZFmwXAgVn7FbsGMsLdPZbFWqTP81fu9ytG473dreLn5wvjVdh8M27Xv2ijOUc
         ojsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0b0l8ZUG3zwXWMxWGQR/zxHkfGwj6nS7mjqC10ksX4g=;
        b=lxrRH9tVLSKRhRGNRELLjxI1W/xAk2OOmxF2QF8xyFvkgtK/jf51/CvIkI6JiuDhYW
         aR4/Yk8EVeAx9sUQqNY/tt8sUYjNsu6JHbxOfqsauqUyLVGte6/7vw8jhK0sSzwDcMPd
         TBLXmFw0GbKeZDNXMhaz+AEZ2qPjJvPJE+tfPVF45i3O6X+2dolDUX0vEoadeIsnSTid
         +TLTQuZRyHEz80jEyl90u/5DyEkObas2wCon35g13N76JQHkV8JS9EwfYIasNnW+Y8Bm
         kcdUx5IPM6I2jxUYMyHZ4Xfx4D+yp6BelK9tx2dN5fwLgwAGirDfvvjm0RX3dhd6RPee
         jjUw==
X-Gm-Message-State: AOAM53371f99hzROez+3IteQaqLjXm3NbIKSKxr8vqUfK6xZomd+CEkX
        r7fLMC5N+kk8EaLXHTJJNkobNg==
X-Google-Smtp-Source: ABdhPJzWSHlUls723LLvd6jzpzhXgoAF/nY//8yL3Er8Ogb7M09BTqnoLSsgJ+32tZfmlCe3Zau8PQ==
X-Received: by 2002:a63:801:: with SMTP id 1mr3396344pgi.48.1601386763471;
        Tue, 29 Sep 2020 06:39:23 -0700 (PDT)
Received: from debian ([122.164.218.24])
        by smtp.gmail.com with ESMTPSA id g23sm5625895pfh.133.2020.09.29.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:39:22 -0700 (PDT)
Message-ID: <666487600b77a8e59c737c33ac7acbbfff96a25c.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.8 00/99] 5.8.13-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        pavel@denx.de, stable@vger.kernel.org
Date:   Tue, 29 Sep 2020 19:09:18 +0530
In-Reply-To: <20200929105929.719230296@linuxfoundation.org>
References: <20200929105929.719230296@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-29 at 13:00 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.13 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.


Compiled and booted 5.8.13-rc1+ .
"dmesg -l err" did not report any error or errors.

Tested-by: Jeffrin Jose T  <jeffrin@rajagiritech.edu.in>


-- 
software engineer
rajagiri school of engineering and technology


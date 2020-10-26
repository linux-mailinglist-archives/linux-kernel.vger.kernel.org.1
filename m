Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA6298917
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772576AbgJZJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:07:05 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54357 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1747015AbgJZJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:06:59 -0400
Received: by mail-wm1-f46.google.com with SMTP id w23so9714992wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2H9Y4JmiHcK3j+qZ0aFUfBDG3AKu1KtGzluos1f8AIA=;
        b=MZcJ0J/fr058lVbFMWmXM92OuD9yOOuBGnXm3mH9s+Q+qvXuLJ1AMk++0cJYjL8/8O
         O3IJehgooJ4RrhhzQO+E0kIuBzm4OwHBdxA8UbvcYVkZ7U2D4ZBSnEu9yGWalJ0k4cnx
         UvsrfG5qIj0S9cjO324WDWRqyW/EdovKxkL9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2H9Y4JmiHcK3j+qZ0aFUfBDG3AKu1KtGzluos1f8AIA=;
        b=ZJPgMrUE5PN3Pl5rBD3sD1FFV8FJVeh3rEh4bnTxABKpiRm9RjazBICxahURDJqphQ
         psG4hOsAnc3yMbDB9yAZpOzL+6IXSJJWdCLvOtmGiD51VA4rgWWADSMA6W3Obi8Rv+Z1
         6bY1Z6lfioYmaHGvrbbkzRz5spe9bds9mAW/XdsAKNKfK+i6DpDn/MivqXD2ZD7756Eo
         rcofQDrQUVmJzdiU3yYyz+GGgmOvUna7MDiZYO32bcnNwAe6oMwxNcNJlRnFCUO/cTol
         rrU9IkZK4OBc6vVZybCXkZYROL3vVo7m6XAwR1X5lgludZxofJEYOHOQX18Q0f4kKlga
         VMtA==
X-Gm-Message-State: AOAM531FSvyaipKPyV2nRaQq/AeR/3WjmnGjAOu/GYEe/aPfINaXLP1O
        au2oRWGv2FH/NqEhDxgPu+M7Cg==
X-Google-Smtp-Source: ABdhPJz/dSh4WYOhOiSM/B+RWa4o7p1CXRC3GSQeuPYc6Si2kr9wemYErENZN/vvuGa/ZdX08vCt1g==
X-Received: by 2002:a1c:417:: with SMTP id 23mr14851965wme.1.1603703216102;
        Mon, 26 Oct 2020 02:06:56 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f5sm19077441wmh.16.2020.10.26.02.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 02:06:55 -0700 (PDT)
Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
To:     Marc Zyngier <maz@kernel.org>, Biwen Li <biwen.li@oss.nxp.com>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        xiaobo.xie@nxp.com, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
 <31d8971374c261003aee9f4807c8ac8c@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
Date:   Mon, 26 Oct 2020 10:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31d8971374c261003aee9f4807c8ac8c@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 09.44, Marc Zyngier wrote:
> On 2020-10-26 08:01, Biwen Li wrote:
>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>
>> Add an new IRQ chip declaration for LS1043A and LS1088A
>> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
>> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> 
> Three things:
> - This commit message doesn't describe the bit_reverse change

Yeah, please elaborate on that, as the RM for 1043 or 1046 doesn't
mention anything about bit reversal for the scfg registers - they don't
seem to have the utter nonsense that is SCFG_SCFGREVCR, but perhaps,
instead of removing it, that has just become a hard-coded part of the IP.

Also, IANAL etc., but

>> +// Copyright 2019-2020 NXP

really? Seems to be a bit of a stretch.

At the very least, cc'ing the original author and only person to ever
touch that file would have been appreciated.

Rasmus

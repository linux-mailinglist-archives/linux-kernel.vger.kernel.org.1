Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8029A820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409525AbgJ0JqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:46:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36126 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408836AbgJ0JqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:46:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id x7so1123393wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VYa/0M9CM+BFisp0qH8kfuZ9SqVMtB0gZkYPNI1LHUU=;
        b=LhwMfe8w6zLfJePcO71XK8ee5zI6g7hCE/+/Iv80FqeoYy8S9+GElomDGzzytfo39Q
         2bJ1yAOuAmnVikJKD/7z19CmjhO4va2e6Rlp4ZTxhjWpV0uvTy3AO3G9LYuDTMF26lmg
         UKJPPgs1OEadT8weo63Ekv/JXNjO8jym8S7zYRkmRr24jFhOQhQTlWa5KzhLt+e5KN2a
         PK645FT3m5ueILODfTBsE3KC3zhymiuHpIksxb7uVQfo/eiC+nn+ZM2TkCZXX5x2Q+BD
         Ciged51VnfWoZRt+kfav00GdfBjjZYrUT13fBnMonVnqBF+VUuzocc9x2NxJyrBbLPrG
         Umgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYa/0M9CM+BFisp0qH8kfuZ9SqVMtB0gZkYPNI1LHUU=;
        b=uj9Wp+/IVcdySvW9qEhkP7mG8OUFzr+DDwPO+PwDJEAiMYKh4mQTYTHSKyP9vTPHfa
         LfYzhcz2NDVtOtBwGomUyRzJJlomoVbwncFCZvx1vyuiyp5rI3TC8nQ4Xb5fkXFhMgYP
         dqb/cwquRPUw16TAqt+TbOKJwopvXR0LHcrF5F5Bfy2+KzXS+Q3EqqxLp3BSh6wGwxTt
         ghzPs/diLHBou0aO8oVFhJV9hWahkdsHL4UGH5JG8vkBkLh06cUrSbbPG7RpS4mJMEeK
         FT1zElx7uqjd4rLoVPK3npUNP8POD/xdShya2jBBCkiDwbzSPGtnXQYwmzjXK/WmUMJE
         VR2A==
X-Gm-Message-State: AOAM5321xdj0shBS2/qhsIOk/lMW7hm+CFrXbiB2LeqSDh6LUsg1Iooj
        bWwdZ8jCCAENbJ7xtDp5RGlKwcaBKrwFbw==
X-Google-Smtp-Source: ABdhPJwi1n98cnvdQ4wWt7HHvJ6RTxLPMC9CSUIOBLuZQdN6syw6ubyoZ6lhMUyNR1z5RFzQ5I/kyw==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr1671184wro.291.1603791958130;
        Tue, 27 Oct 2020 02:45:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id o3sm1321735wru.15.2020.10.27.02.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 02:45:57 -0700 (PDT)
Subject: Re: [PATCH] thermal: rcar: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>, niklas.soderlund@ragnatech.se,
        rui.zhang@intel.com, amitk@kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <72412b5a-fd9a-a23e-aaf8-1a7b6eaa16c5@linaro.org>
Date:   Tue, 27 Oct 2020 10:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 02:06, Tian Tao wrote:
> On RT or even on mainline with 'threadirqs' on the command line all
> interrupts which are not explicitly requested with IRQF_NO_THREAD
> run their handlers in thread context. The same applies to soft interrupts.
> That means they are subject to the normal scheduler rules and no other
> code is going to acquire that lock from hard interrupt context either,
> so the irqsave() here is pointless in all cases.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

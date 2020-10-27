Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1F29A517
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgJ0G7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:59:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbgJ0G67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:58:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id f38so242929pgm.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrqVVfhctAm90TmcSmxrbQen+I/TiJgHQEw5zqTYzUM=;
        b=oxs0t45VQpTxF3zF0JLqE61T9LBcIIeNsb28no8PHnv+MpIG/QuDMic4kfwt9wzdMn
         dI/m5QM9e6mMAFS1k55q4LLi0qF4d7Zdis4jVPb57BVR/kFufzJ/JWjCDK/8CNGPQsDf
         6gqpfHTCl9fFMrmfYxq4ho48y4IM+0AY1C4jaFS0nZXyHvgV1rW8SALAfBB3V5o6JqJI
         z8q0mxZxz+9Cbd9/MKb++3uW+i3TXyRuEZya5QvpbXSmGY3dE04MhQl0XR8Ti8LVRWQL
         n4kAzRko4DhgF2pnP4P54ZnSPiSlobxcl6RLqqpm5+R5IDueppkcBQP5JSqWhdUF/lzr
         5OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrqVVfhctAm90TmcSmxrbQen+I/TiJgHQEw5zqTYzUM=;
        b=tRaqfTyYqotRhTFihCPe6BOJ6XZRniCWsmSMgeEwKCPCgbBuuNxZRLcZo1CNMALM48
         6Mp2mlLeWvqzwBSJLa7nGUOGhhqd68xrmFr213SGIgXEYICb4rihOBWiADcUT/k4IF57
         XCQsCvcx3xy4Se70cD7e5BGDZf640qFOUyfMbj/lBXJfJvSA8gdeoVhqx28mfXFf+fmG
         k1fT8NHpa8WjHIDdBGzyrEPWa9EZiMuLRxymLI4el4J8fLOySzd7c0o//r1z5RcQsWW4
         1C0zTynhXHU8IQlr63t9+wHqMgbYh3BNfQLpyT8AIbI0SKZGhe/LYKH+xi4RTIIo8QVI
         FoPg==
X-Gm-Message-State: AOAM533CgSGONDpiyJ8SCi0ZWWhf1Um5+qxCtF3aRE1lOF6g5e3njTDV
        F/MAD69bMHjmmxORKy6rdbbyjQ==
X-Google-Smtp-Source: ABdhPJybhTDt9uRrv0v3mYRBmPTY3jLttubPj+vxstZi1cEO1D3AugaGrgff+OxFDIwkCrX8wrcRNA==
X-Received: by 2002:a62:7657:0:b029:152:4d66:dcb with SMTP id r84-20020a6276570000b02901524d660dcbmr733122pfc.74.1603781939046;
        Mon, 26 Oct 2020 23:58:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c12sm924917pgi.14.2020.10.26.23.58.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 23:58:58 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:28:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        ksitaraman@nvidia.com
Subject: Re: [PATCH v3] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Message-ID: <20201027065855.ghekpybjwtaufwgy@vireshk-i7>
References: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
 <c56983dc-dc45-3e8c-a67c-14d7d09464ae@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56983dc-dc45-3e8c-a67c-14d7d09464ae@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-10-20, 11:46, Sumit Gupta wrote:
> Ping.

I was waiting for 5.10-rc1 to be released before I can start applying stuff for
5.11. Now that it is released, I will apply this.

-- 
viresh

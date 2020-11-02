Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F72A2C17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgKBNvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKBNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:51:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B86C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:51:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so14718649wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRGtZ+ldHh215Tg4pikME8cERQKkPWSxRhHrWuaGqTM=;
        b=j4jcRG9GIsPic5QtNLfiguS60+zJTyfEFr+iiKo8yHMrJBgguaatXO3I913opTRfce
         9YRmMYfQ8jKRXmyz/Q9otp80BG++sA6sl5m8QVGjcqWUy/097KN48z7bSIItlCvcW38w
         jd/WnLJG8LVKDBFvN91IVitrEij7qzS+sUhVLWA938/10lu9t34EjoiklA93Wh6/2dj0
         xgvtZQrB6o8lzcv/bfSLrEXJXh3MFmaJ62kxek0Tu70k8OW0CQnZck6tN85TCA5ljZym
         aJBwlrwGWB4tizGNjl5+v61ywkvy8XPTtdloZAV5N3uqlTm3BxXAPkjt9uLAfn3Ggf9L
         nP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRGtZ+ldHh215Tg4pikME8cERQKkPWSxRhHrWuaGqTM=;
        b=m8upMqrqa9TS6P3RHDZC3EMyMCU9nOwRppDX5kK1P6/sdt4xQmNhxgtRqfHgL0Go+2
         QOoVb1+lIAOoDZPn5jkDHnj3xCTORtf9XQM2A5u9cbIcVB01ZXVJd58131m0H9nZNmuZ
         nS06XU778O8RrBx3vF265qgJcxecowTOloIZQ/Ff2M/+2EX4FulCVBO9i7JZCieHIMIU
         LUeL/htpXMWxHO1X7MCliMh9ILwKpkieHalt6X6TbhvgyPkfe805c5/nNGmShile2ZfC
         E4iColiU+ZUhQpRdDmvFtUljTc6SLMqM3YYeozaxbW6kObhgq890GFTt3rtHVReh98Oi
         s3dQ==
X-Gm-Message-State: AOAM532kj9lkxJKt8zWKqh6M7rdnFXhUux1zkTzF+mU94fdN2hNW30L8
        87a6H2+UDUuV8DnJJNgmr485ig==
X-Google-Smtp-Source: ABdhPJybi5bHjDdIxQjPD1+62vLcJE+5DYmEix/kJMd5ZE6D7rqwTgjS1pA0lsKK+itNnlXT3/cVEg==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr19869994wrw.194.1604325093403;
        Mon, 02 Nov 2020 05:51:33 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id y187sm3744456wmg.33.2020.11.02.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:51:32 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:51:29 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        amitk@kernel.org, corbet@lwn.net, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
Subject: Re: [PATCH v3 4/4] docs: power: Update Energy Model with new flag
 indicating power scale
Message-ID: <20201102135129.GD2221764@google.com>
References: <20201019140601.3047-1-lukasz.luba@arm.com>
 <20201019140601.3047-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019140601.3047-5-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 Oct 2020 at 15:06:01 (+0100), Lukasz Luba wrote:
> Update description and meaning of a new flag, which indicates the type of
> power scale used for a registered Energy Model (EM) device.

Reviewed-by: Quentin Perret <qperret@google.com>

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks,
Quentin

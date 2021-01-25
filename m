Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8F3026D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbhAYPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbhAYO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:56:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1144C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:56:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id p15so6227889wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LMT8I108IgwH+pDf3Xg1LrGxGawVZhIINlR7TedTzQU=;
        b=L07uWIbonvyLtIx0nIGJ7Ng60gDk8h6eMOVOrA3mPsUjtKK8ee903o7/NwP5uKhnsZ
         j7dtLX3Pd+8m/qPKEIen+RJY0Hgs4GGdIPXeopuTEggTcO1lJzu9JI5XB7E+5e9TTqJc
         sRGLhG4+GCbcMj3LRQEBc7Ya0bOY1t/NdSZgQhxsalL6fDT2PD0awS19UG7Gb7LalQjf
         uN6VvkyZmJX+aPmEIyYNPd1Ins66XkcXbTsGoJ1Bazpm2qhOlFj3pVa27URYXJqwYw2H
         NF3lYEa/wvQcvNH+rHnL09m9f/xlsZOd9mTyrHbCgu4U7bzxhz0JaqRacxe47ZkzDRLy
         scPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LMT8I108IgwH+pDf3Xg1LrGxGawVZhIINlR7TedTzQU=;
        b=bEPbJpvUYmOvc5wXc9MIb+jaXrQzmt/lDXPSmciXGAwRON3XYscyYFjm/fpWZp30tu
         kHAgPZ3/s3lDaw0QHQMfQa+HWu/11Zgrt+dpj3jnPhTbEOVz0usFyMUwKy2zZbW9fl7X
         2TmaluvS+7qL74wqsy+jd7JsRSBpmGYaAi5vekBZvyjKomi/JwyDjjbFrUi547kZWoIr
         n+saYycch5h9vCJB8s7RapZ+qap7yS9kdndgG+/t7F19PR6vP4sZI7e3RX+s3F7/n7S4
         xGzV/bYfPlvn5qYXJ4EHzSZQBzpQ0PCZPyHhsXzLrJu1gpuviMoC8Mxu3tpDH55ppPOn
         nYHw==
X-Gm-Message-State: AOAM530D56S62ieKMkYZHa+17ut9q0rfIEtFIyjcnqkpVJz/Kqz+u0Wg
        Ia153UTK194Gf/laLv2ZNO8EIQ==
X-Google-Smtp-Source: ABdhPJzoDrF+chyqhLGsmCzHbP6XVmzRrhjBlB2SM6Jzo/xfuq/tFeXCPvjIZIP+ljHXQdZe7JUWDQ==
X-Received: by 2002:a5d:6752:: with SMTP id l18mr1403020wrw.209.1611586575549;
        Mon, 25 Jan 2021 06:56:15 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t25sm20862971wmj.39.2021.01.25.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:56:15 -0800 (PST)
Date:   Mon, 25 Jan 2021 15:56:14 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc:     Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@idosch.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jiri@nvidia.com" <jiri@nvidia.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: core: devlink: add new trap action
 HARD_DROP
Message-ID: <20210125145614.GM3565223@nanopsycho.orion>
References: <20210121112937.30989-1-oleksandr.mazur@plvision.eu>
 <20210121122152.GA2647590@shredder.lan>
 <20210121093605.49ba26ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210125121234.GJ3565223@nanopsycho.orion>
 <AM0P190MB07387522928B6730DBE1BB77E4BD0@AM0P190MB0738.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0P190MB07387522928B6730DBE1BB77E4BD0@AM0P190MB0738.EURP190.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 25, 2021 at 01:24:27PM CET, oleksandr.mazur@plvision.eu wrote:
>Thu, Jan 21, 2021 at 06:36:05PM CET, kuba@kernel.org wrote:
>>On Thu, 21 Jan 2021 14:21:52 +0200 Ido Schimmel wrote:
>>> On Thu, Jan 21, 2021 at 01:29:37PM +0200, Oleksandr Mazur wrote:
>>> > Add new trap action HARD_DROP, which can be used by the
>>> > drivers to register traps, where it's impossible to get
>>> > packet reported to the devlink subsystem by the device
>>> > driver, because it's impossible to retrieve dropped packet
>>> > from the device itself.
>>> > In order to use this action, driver must also register
>>> > additional devlink operation - callback that is used
>>> > to retrieve number of packets that have been dropped by
>>> > the device.  
>>> 
>>> Are these global statistics about number of packets the hardware dropped
>>> for a specific reason or are these per-port statistics?
>>> 
>>> It's a creative use of devlink-trap interface, but I think it makes
>>> sense. Better to re-use an existing interface than creating yet another
>>> one.
>>
>>Not sure if I agree, if we can't trap why is it a trap?
>>It's just a counter.
>
>>+1
>Device might be unable to trap only the 'DROP' packets, and this information should be transparent for the user.
>
>I agree on the statement, that new action might be an overhead.
>I could continue on with the solution Ido Schimmel proposed: since no new action would be needed and no UAPI changes are required, i could simply do the dropped statistics (additional field) output added upon trap stats queiring.
>(In case if driver registerd callback, of course; and do so only for DROP actions)

It is not "a trap". You just need to count dropped packet. You don't
trap anything. That is why I don't think this has anything to do with
"trap" infra.

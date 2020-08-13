Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311D243B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 10:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:35:43 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B50C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:35:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s23so4468669qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lQt/KK7RT37IrSgEa18imoxvr9tlPUAJNuDDhRvQ5SI=;
        b=nl7SX9v7zkGfMpMrUeibIPpRP5LWNEeWEw45GPwxVg4EYOC+JtaVgJH9qDlJpvXu4v
         XfvMt9GKh9fRncAvqDYk1tMUu1eZLB9906lACOb/BUNqsJuezw/tPhkxED004P2P2xQf
         Sh9hK5XTRg82tD689UUn2VlWT0CZ4yR6ePUyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQt/KK7RT37IrSgEa18imoxvr9tlPUAJNuDDhRvQ5SI=;
        b=TL+s/9m4tQJmFkvNTMl9eL3+VJ7nJqEmS/UrfOp54BNKVQaerSmfYXg0/WARerEoJp
         ah2IMWawB6vUn6clLKmKhAnYluZ2vv446Ohiu2vEUb4mNybxUOO1TpScfH6qxIJCD/Zs
         DsLS+DeAau2UqAR+1GhHMEcotSni0Rh/C4cbhgQMDAtm0lwUGUmtdWxCGVfMnFkBAMgI
         TGdIVvkjLGVCog07C1ZPdH+7zJPp7Vk8bjaV5CPVzFz6yiy0FEOjfAjdMsX09c+hDGX3
         BxxZPtzZB84cS7BBdnpjjl0AIBf9MXZJxeF6+QmUVD37wmv/dkL77eSvuAt+qTwhTS20
         zU6A==
X-Gm-Message-State: AOAM533y7iTOupP4APD/XHGF7UDY2QpjiXkx7XyLCzsbRC3uR5ZPAUKZ
        oZuFSOY+lDZeOMrCYVCAVPD54b8yIsXOgQ==
X-Google-Smtp-Source: ABdhPJx3DznpNuE75T0GJs1km/z5AcwrxG7exOyNYbLfmR6GRmxwYYKuHztEOTxB+3tXXUmTf0LfJA==
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr5694906qte.78.1597329342146;
        Thu, 13 Aug 2020 07:35:42 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id p34sm7577331qte.79.2020.08.13.07.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:35:41 -0700 (PDT)
Subject: Re: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- voting procedures
To:     Johannes Berg <johannes@sipsolutions.net>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
 <fdee2bf96e207a45d0e88e4a5f05044a112d6ba5.camel@sipsolutions.net>
From:   Laura Abbott <laura@labbott.name>
Message-ID: <2ad7e1c5-ed68-a93e-62fe-bf9100557f41@labbott.name>
Date:   Thu, 13 Aug 2020 10:35:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fdee2bf96e207a45d0e88e4a5f05044a112d6ba5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/20 10:31 AM, Johannes Berg wrote:
> Hi Laura,
> 
> Seeing your reminder reminded me :)
> 
>> We will be using the electronic voting method that we used in 2019. All
>> Linux Plumbers Attendees will automatically receive a ballot. Anyone
>> who is otherwise eligible to vote should e-mail
>> tab-elections@lists.linuxfoundation.org to request a ballot. The deadline
>> for requesting a ballot is August 17, 00:00 UTC (one week before
>> Linux Plumbers)
> 
> Will you be sending out some kind of voting tokens for the ballot? And
> if so, when is that supposed to happen? I (believe I) have requested a
> ballot, but didn't get a response so far.
> 
> Thanks,
> Johannes
> 

The voting itself will be taking place during the week of Linux
Plumbers/Kernel summit, August 24-28. Keep an eye out for the
ballot during that time period. We'll send out another e-mail
when the ballots go out.

Thanks,
Laura
